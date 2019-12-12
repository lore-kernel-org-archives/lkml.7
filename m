Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD499C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90005206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEB/cJ9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfLLKIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:08:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23106 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728436AbfLLKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576145327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1+8eRAxKG6Ud2RGfhC7VbF42zHlNF5b6S5RY/ZXaPk=;
        b=aEB/cJ9c0D1KxuTP5DWNSKMYqYMk/pmr1jBgXuFFpkVDOb1Yx/mljAHplLRdoEBT3J2gRj
        0G5yeiG5qgwaXuaDWfG336OzrcNkNBhOepmuxUylfwMJWerYEBcSbo7nsDt0PATCu9Z4FS
        cMAUQtSnswoCtvOlmTrcQwzyO6PcN+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-tr6-AnJ9MJ-8rOvF7nI1Mw-1; Thu, 12 Dec 2019 05:08:43 -0500
X-MC-Unique: tr6-AnJ9MJ-8rOvF7nI1Mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F373812A7E5C;
        Thu, 12 Dec 2019 10:08:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-22.brq.redhat.com [10.40.204.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id C909560BC9;
        Thu, 12 Dec 2019 10:08:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 12 Dec 2019 11:08:41 +0100 (CET)
Date:   Thu, 12 Dec 2019 11:08:38 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qiwuchen55@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] kernel/exit: do panic earlier to get coredump if global
 init task exit
Message-ID: <20191212100838.GB5460@redhat.com>
References: <1576131255-3433-1-git-send-email-qiwuchen55@gmail.com>
 <20191212095127.GA5460@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212095127.GA5460@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

can't you use is_global_init() && group_dead ?

On 12/12, Oleg Nesterov wrote:
>
> On 12/12, qiwuchen55@gmail.com wrote:
> >
> > Of course testing signal_group_exit() is not sufficient. It is still
> > possible that this is someone calling exit(2)
> 
> Or execve(), so
> 
> > @@ -785,6 +781,9 @@ void __noreturn do_exit(long code)
> >  		panic("Aiee, killing interrupt handler!");
> >  	if (unlikely(!tsk->pid))
> >  		panic("Attempted to kill the idle task!");
> > +	if (unlikely(is_global_init(tsk) &&
> > +		(signal_group_exit(tsk->signal) || thread_group_empty(tsk))))
> > +		panic("Attempted to kill init! exitcode=0x%08lx\n", code);
> 
> so this can panic() if one of init's threads does does exec.
> 
> Oleg.

