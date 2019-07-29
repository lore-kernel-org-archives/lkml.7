Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA7AC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAAC2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430273;
	bh=Aa2gIj8xdhHIpCrPfiCJxrfbEsiESRZUaNjO6jjdaio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dn4qrbAJGX0/vBNxz5WYYpqwV2BBVQJ6RNlbZJDWfiuhq3EPkLN3qKmIHQdk78QGm
	 +gog5OMMJmCLj6G9cPW6y41N+iHN1ew596HDKfFjpxMuiKZGcHtnnJdy8reYiyW0J5
	 9KKDhvvEjywtOnvLM12sw4Oxuo/HrdBBzixv53MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbfG2T5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403935AbfG2T5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:57:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392A6217D7;
        Mon, 29 Jul 2019 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564430268;
        bh=Aa2gIj8xdhHIpCrPfiCJxrfbEsiESRZUaNjO6jjdaio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brvTLQ3dY465JfO+z3L0iZVh2jqQkRCPWznTlE+jMyhKrcO3KaEjw561toHX4MuuS
         vOs82SEdhwHpVHQ5ViPY4p7n8mlObyBgwqHHO8TZubFFr1iHGYQ+uU31vMm4mgvmDu
         MS1Tqlc+RIcebF09im977FUSFOeAwGQb10JDUIaQ=
Date:   Mon, 29 Jul 2019 21:56:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, axboe@kernel.dk,
        dennis@kernel.org, dennisszhou@gmail.com, mingo@redhat.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Nick Kralevich <nnk@google.com>
Subject: Re: [PATCH 1/1] psi: do not require setsched permission from the
 trigger creator
Message-ID: <20190729195614.GA31529@kroah.com>
References: <20190729194205.212846-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729194205.212846-1-surenb@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:42:05PM -0700, Suren Baghdasaryan wrote:
> When a process creates a new trigger by writing into /proc/pressure/*
> files, permissions to write such a file should be used to determine whether
> the process is allowed to do so or not. Current implementation would also
> require such a process to have setsched capability. Setting of psi trigger
> thread's scheduling policy is an implementation detail and should not be
> exposed to the user level. Remove the permission check by using _nocheck
> version of the function.
> 
> Suggested-by: Nick Kralevich <nnk@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

$ ./scripts/get_maintainer.pl --file kernel/sched/psi.c
Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER)
Peter Zijlstra <peterz@infradead.org> (maintainer:SCHEDULER)
linux-kernel@vger.kernel.org (open list:SCHEDULER)


No where am I listed there, so why did you send this "To:" me?

please fix up and resend.

greg k-h
