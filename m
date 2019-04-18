Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4625EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147BA206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlY0oAkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbfDRR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:57:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37215 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388301AbfDRR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:57:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so1541158pgc.4;
        Thu, 18 Apr 2019 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M84pVHi7QUoGbkpTQqGc/KjlrR1jeH2e5lPBKjhZDPk=;
        b=mlY0oAkzq0+MVQFSgkGQhAjwKSgeRsRSBghWqkCn1MtnC+Gvl4FKgHzfJ0Ie8Lo5kP
         rPjKirrf8OAaFomqCOXoFB1SjHNxJo5v27Ko0zEBQ8OqkV5vjFqHIcup/8w2IQvSLUqn
         KHgVtebB3PtHkOVZFZEP3IftK2Wn44fDFA63pm5Ss4wW8Pv/GjoF/OxsQFsT1pGXiWsJ
         VMab1ep0K4joWPdH/G8y0JmGiAE9h0d9+/36HXg1DQN3I1wtIjBiEA0UuN2PRwpAycKX
         Qz4xy6SiipLbGR0vbAsd8jIPvL8JzGFe8rI6SbwvYUTyVjrFnDzfizzP7Jhv/ZZ7huZn
         LJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=M84pVHi7QUoGbkpTQqGc/KjlrR1jeH2e5lPBKjhZDPk=;
        b=CS9TCXp3O2g2F3UVKt1ZFT4InQ3Phh7HYH3IQwnL4BsaAK/U+m7OHPKkXHnxH4EBTk
         osc/nKOJ6H2I0qfB7t04hExw6yoaHUOOxqdJ0UGAx2lI8/ltHzlFwurOgYC04ak+GlNn
         2nL5i9umemtQ5BBGwS2nXmS7OEQJRDSWeQB4Yy2thp3ZoxeqJPN/ihm/G9RiaxoCT7Mt
         1ntB4Yyfz9SSJvAmKcLPPF7L2la0RYT70RWBj8+roHIvJYISpSb+DnwmTRqoGwDZQ8JV
         Xn1KbRYMbtar0t/u98DP4vx/GW5LAaEKCY7YuzyYIWVPE8jOH4TdLBgLy/g1o3Ifx6Ff
         fOQg==
X-Gm-Message-State: APjAAAUrjjafwPa2m8LYNn9u+29XDM62+X2EOkOroohccHIl8QYCPl4A
        BDy00AxcUgFVXRdL9sK7rv4EQmE8
X-Google-Smtp-Source: APXvYqzeX/oOZWVYA+z9tKNjjftxnjlJD/UWK52ceDxL28IGA8FFrHsxtJyzT3Z1MizQ3goeKOPU5Q==
X-Received: by 2002:a63:30c5:: with SMTP id w188mr89134996pgw.76.1555610239907;
        Thu, 18 Apr 2019 10:57:19 -0700 (PDT)
Received: from udknight.localhost ([59.57.228.71])
        by smtp.gmail.com with ESMTPSA id l19sm3502465pff.1.2019.04.18.10.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:57:19 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id x3IHxla1004504;
        Fri, 19 Apr 2019 01:59:47 +0800
Received: (from root@localhost)
        by localhost.localdomain (8.14.9/8.14.9/Submit) id x3IHBjrL020471;
        Fri, 19 Apr 2019 01:11:45 +0800
Date:   Fri, 19 Apr 2019 01:11:44 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: fix compile errors with older glibc
Message-ID: <20190418171144.GA4210@udknight-ThinkPad-E550>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Yonghong Song <yhs@fb.com>, "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190417174839.GA16679@udknight>
 <ecd56ebd-d19f-8834-9373-088ad7c9a725@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd56ebd-d19f-8834-9373-088ad7c9a725@fb.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 05:09:53AM +0000, Yonghong Song wrote:
> 
> 
> On 4/17/19 10:48 AM, Wang YanQing wrote:
> > The older glibc (for example, 2.23) doesn't handle __UAPI_DEF_*
> > in libc-compat.h properly, and it bring below compile errors:
> 
> I have an even old glibc 2.17 and it still works. Not sure
> why it failed here. Could you explain more?

We will meet these errors with the combination of some versions of kernel headers and
some versions of glibc headers.

After some research on the git history of glibc and kernel, I find the reason behind
the scene is a little complex:
There are some same definitions between glibc's netinet/in.h and kernel's linux/in6.h,
IPPROTO_HOPOPTS, etc.
These same definitions willn't bring trouble when we include both of them if kernel and
glibc coordinates with each other well, but the reality is the coordination is poor and
unsynchronous in history.

Kernel and glibc uses guard macros to detect whether need to export their definitions,
linux/in6.h includes libc-compat.h which will check the guard macro, _NETINET_IN_H, and
netinet/in.h includes bits/in.h which will check the guard macro, _UAPI_LINUX_IN6_H
(glibc-2.19~821 6c82a2f8d7c8e21e39237225c819f182ae438db3 "Coordinate IPv6 definitions for Linux and glibc"),

the problem is in the installation process of kernel headers, the "_UAPI" in _UAPI_LINUX_IN6_H
in linux/in6.h will be stripped due to commit 56c176c9cac9
("UAPI: strip the _UAPI prefix from header guards during header installation").

The good news is the glibc fix this the trouble by checking the guard macro, _LINUX_IN6_H, too.
(glibc c9bd40daaee18cf1d9824e4a7ebaebe321e0a5a8 "Bug 20214: Fix linux/in6.h and netinet/in.h sync.").

My environment still have this trouble:
lsb_release -a:
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.6 LTS
Release:	16.04
Codename:	xenial

dpkg -l | grep libc-dev:
ii  libc-dev-bin              2.23-0ubuntu11           amd64        GNU C Library: Development binaries
ii  linux-libc-dev:amd64      4.4.0-145.171            amd64        Linux Kernel Headers for development.


I will send out the v2 which I will change some words in changelog.

Thanks for review.
