Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F2C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D5E21841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gU+U/zF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGXHbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:31:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53470 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rK6nQW5CxubGjo+KYKz34q25ReCu2Bwr2lGkque7Bz8=; b=gU+U/zF+i2GFZYvOAUrXovQiK
        3RNuvInAoa0BGHx7V/s8n0jnQQ7DmfMZDdnAuF0b29eLlfM3LSf+AYoZxmmMboy3Fx+Clniios6fp
        vk1fquZ5c26VdMn2cbnInDnrzPa9E1iPSwdNdvi+fvwlS4hJk/JTDmnxZKbp9Qny5J8s3G94mBXi1
        yENc/Kq7FAqXDIeFz2XPv/7YsTFbwztJSqETaIhoW3ZCmVjyePuJH4yzAiTuWxSS/raSvKLBD+Dw0
        32FcEhSx6VQOdPQD2N2uISYrwE3kOWDnsLXOgLfxYUcPcCv2q0MbuBATeCezWaNpan7Hk9TxT7wCm
        eoXE3DHfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqBkK-0001Tn-Tk; Wed, 24 Jul 2019 07:31:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C2F8201A93D3; Wed, 24 Jul 2019 09:31:30 +0200 (CEST)
Date:   Wed, 24 Jul 2019 09:31:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] [v2] waitqueue: shut up clang -Wuninitialized warnings
Message-ID: <20190724073130.GH3402@hirez.programming.kicks-ass.net>
References: <20190719113638.4189771-1-arnd@arndb.de>
 <20190723105046.GD3402@hirez.programming.kicks-ass.net>
 <CAK8P3a3_sRmHVsEh=+83zR_Q3+Bh9fd+-iiCxt4PU4gkx0HZ7Q@mail.gmail.com>
 <20190723202159.GA79273@archlinux-threadripper>
 <CAKwvOdnbDFkDhCz3VMM_A8D7VZQH5FubJpS0OTHBJJdS-WKPww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnbDFkDhCz3VMM_A8D7VZQH5FubJpS0OTHBJJdS-WKPww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:54:03PM -0700, Nick Desaulniers wrote:
> Note that pre-clang-9 can be used for LTS x86_64; I don't think
> CONFIG_JUMP_LABEL was made mandatory for x86 until 4.20 release, IIRC.
> There's only a small window of non LTS kernels and only for x86 where
> clang-9+ is really necessary.

Given all the code-gen issues we've been finding, I wouldn't want to
touch a pre-9 clang. Irrespective of wether it builds or not, it's
absolutely unreliable crap.
