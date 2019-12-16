Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7A2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F5C206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0kyRLtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLPR2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:28:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48141 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbfLPR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576517333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UR5CZgArpnQ0KTZw5vKjrnTKa8Ehpqd+MbgqstFeosw=;
        b=B0kyRLtbL1ompsE/uSLqFpCRh71PrfvfqyW5pqDLp0iMN9/vBM8JZD+MEW5a2GbAP6jjFP
        7IcLY3Yz96V4zUtgq4T3TC0gcWipWaVtVY7V/FvfyRAagSF/BpE8Kuye4VRskDBmh7LDL0
        zCZT9kmOGt81R2tlFe1xAKQeuLzslGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-Q_rZRP1NPriT__-Tkj8LOw-1; Mon, 16 Dec 2019 12:28:50 -0500
X-MC-Unique: Q_rZRP1NPriT__-Tkj8LOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7537418B6457;
        Mon, 16 Dec 2019 17:28:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id E8B125C28D;
        Mon, 16 Dec 2019 17:28:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 16 Dec 2019 18:28:44 +0100 (CET)
Date:   Mon, 16 Dec 2019 18:28:41 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qiwuchen55@gmail.com
Cc:     christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191216172841.GA10466@redhat.com>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16, qiwuchen55@gmail.com wrote:
>
> +	 * If all threads of global init have exited, do panic imeddiately
> +	 * to get the coredump to find any clue for init task in userspace.
> +	 */
> +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> +	if (unlikely(is_global_init(tsk) && group_dead))
> +		panic("Attempted to kill init! exitcode=0x%08lx\n", code);
                                                                    ^^^^

No, we should not throw out the useful info, please use

	signal->group_exit_code ?: code

as the current code does.

And I am worried atomic_dec_and_test() is called too early...

Say, acct_process() can report the exit while some sub-thread sleeps
in PTRACE_EVENT_EXIT? I'd prefer to not move it up too much, at least
before exit_signals().

Oleg.

