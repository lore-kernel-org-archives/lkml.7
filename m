Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19A5C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DB7206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+NrfTvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgACKGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:06:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42723 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgACKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578045997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZgNCvHnH6fEsEKaBVmrvYkgbCQvWwHoRKudXkBxEyBQ=;
        b=b+NrfTvwAWzv+hJ8CVUkVPAcq7k5y5LCQEfzvfMBe9Je9hw0kV+3Oj5deMhcOAoUW1TMV4
        nfMQnR2uYvT3iAsBh4xPKZR1cQj++RXp8y5kvBa3Romqc4y6AhJ5L9bl5eh4tbTC4z3Nrx
        2I2IsL5FX58sze/XpBmNGQLst96YLqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-GF823iyCOMSqBMIrpUoZrg-1; Fri, 03 Jan 2020 05:06:34 -0500
X-MC-Unique: GF823iyCOMSqBMIrpUoZrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4691800EB8;
        Fri,  3 Jan 2020 10:06:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2D89E60BF7;
        Fri,  3 Jan 2020 10:06:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  3 Jan 2020 11:06:31 +0100 (CET)
Date:   Fri, 3 Jan 2020 11:06:28 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, christian.brauner@ubuntu.com,
        deepa.kernel@gmail.com, ebiederm@xmission.com, guro@fb.com,
        linux-kernel@vger.kernel.org, trix@redhat.com
Subject: Re: + signal-move-print_dropped_signal.patch added to -mm tree
Message-ID: <20200103100628.GA16577@redhat.com>
References: <20200102215029.PWaCMXI_O%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102215029.PWaCMXI_O%akpm@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tom Rix <trix@redhat.com>
> Subject: kernel/signal.c: move print_dropped_signal
>
> If the allocation of 'q' fails, the signal will be dropped.

Well, not necessarily... See the comment above TRACE_SIGNAL_LOSE_INFO
in __send_signal().

> To ensure
> that this is reported, move print_dropped_signal to be inside the '(q ==
> NULL)' if-check.

OK, but print_dropped_signal() says "reached RLIMIT_SIGPENDING", this
is misleading if kmem_cache_alloc() fails.

> Link: http://lkml.kernel.org/r/20191203180221.7038-1-trix@redhat.com
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  kernel/signal.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/kernel/signal.c~signal-move-print_dropped_signal
> +++ a/kernel/signal.c
> @@ -427,11 +427,10 @@ __sigqueue_alloc(int sig, struct task_st
>  	    atomic_read(&user->sigpending) <=
>  			task_rlimit(t, RLIMIT_SIGPENDING)) {
>  		q = kmem_cache_alloc(sigqueue_cachep, flags);
> -	} else {
> -		print_dropped_signal(sig);
>  	}
>  
>  	if (unlikely(q == NULL)) {
> +		print_dropped_signal(sig);
>  		atomic_dec(&user->sigpending);
>  		free_uid(user);
>  	} else {
> _
> 
> Patches currently in -mm which might be from trix@redhat.com are
> 
> signal-move-print_dropped_signal.patch
> 

