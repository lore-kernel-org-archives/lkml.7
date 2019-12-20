Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75616C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B59A206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVQ9YD1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfLTTiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:38:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23076 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727411AbfLTTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576870696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4m6n6WhNnkhWj/1eh4TjxNNa0kMOTtKQHD7FO350FJI=;
        b=RVQ9YD1hM/FsUA/UqpriiUzBXODGadIrqwEbznP1pU8PchNj+wnL7WT7EPXKmCOBDFSiBQ
        mzAMf7DWnrGhJajjGCbtXiqJDZdfFCCFSvZ0drYywaDeBH2VssayQh9NMnDJ/bBK3cQ8+P
        vDFR6P+JaQW/eLRu53WErI7lIozoVRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-7zglLuqNMLGl7y7DsyH7EA-1; Fri, 20 Dec 2019 14:38:10 -0500
X-MC-Unique: 7zglLuqNMLGl7y7DsyH7EA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A700385EE8C;
        Fri, 20 Dec 2019 19:38:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-70.brq.redhat.com [10.40.204.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD7F377644;
        Fri, 20 Dec 2019 19:38:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 20 Dec 2019 20:38:08 +0100 (CET)
Date:   Fri, 20 Dec 2019 20:38:00 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qiwuchen55@gmail.com
Cc:     christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, prsood@codeaurora.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu@xiaomi.com
Subject: Re: [PATCH v3] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191220193758.GE13464@redhat.com>
References: <1576736993-10121-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576736993-10121-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, qiwuchen55@gmail.com wrote:
>
> @@ -517,10 +517,6 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
>  	}
>  
>  	write_unlock_irq(&tasklist_lock);
> -	if (unlikely(pid_ns == &init_pid_ns)) {
> -		panic("Attempted to kill init! exitcode=0x%08x\n",
> -			father->signal->group_exit_code ?: father->exit_code);
> -	}
>  
>  	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
>  		list_del_init(&p->ptrace_entry);
> @@ -766,6 +762,15 @@ void __noreturn do_exit(long code)
>  	acct_update_integrals(tsk);
>  	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	if (group_dead) {
> +		/*
> +		 * If the last thread of global init exit, do panic
> +		 * immeddiately to get the coredump to find any clue
> +		 * for init task in userspace.
> +		 */
> +		if (unlikely(is_global_init(tsk)))
> +			panic("Attempted to kill init! exitcode=0x%08x\n",
> +				tsk->signal->group_exit_code ?: (int)code);
> +

Acked-by: Oleg Nesterov <oleg@redhat.com>

