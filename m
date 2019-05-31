Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C82C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627026690
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QGXqZNaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfEaJMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:12:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59030 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfEaJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1zywXp4XVtGKirLjahUxV+mvxxARlKH6na7zNEvRC/c=; b=QGXqZNaaODNHqXNHqcWSnYqrQ
        CDiLuz1ZjVY7p9nkDYfiEmUFGtdVloKFAfRuJeFFf48bImuHqC/sxp6fkA3TCPKFGHRGymXvcs8Qz
        le4S9bFaNxRQzDqfMv4mdchODYuFYoP8abeI959yyNJjdiIupeQ0X/KcCfxuk+D942w+U63/aX0g7
        gYEFf74sweAS6xpi9qa+rXHlkTXdhA9YUGeXb5m6Mgg8uZ6eyqYiAUpSn06dNPSVQJJZwhsT6RJow
        F9DXgltFOoZN5Oag5n4ofZjrvEZAipqsQsl66wUbKUHmiHzbQWDuzIirzhuVE1YDsXXEM7DFCA51F
        P91GS1R+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWdah-0003F0-7P; Fri, 31 May 2019 09:12:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00C50201B8CFE; Fri, 31 May 2019 11:12:45 +0200 (CEST)
Date:   Fri, 31 May 2019 11:12:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <20190531091245.GN2677@hirez.programming.kicks-ass.net>
References: <20190529113157.227380-1-jannh@google.com>
 <20190529162120.GB27659@redhat.com>
 <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
 <20190530120531.GE22536@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530120531.GE22536@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 02:05:31PM +0200, Oleg Nesterov wrote:
> > Anyway, looking at it, I think smp_acquire__after_ctrl_dep() doesn't
> > make sense here;
> 
> Well I still _think_ it should work, it provides the LOAD-LOAD ordering
> and this is what we need.

So it hard relies on being part of a control dependency, note how the
comment says that architectures that do not do load speculation can
override the smp_rmb() default with barrier() (and we used have an
architecture that made use of that, although it's been since removed).

IOW, it is an error to use smp_acquire__after_ctrl_dep() without an
(immediate) preceding branch.
