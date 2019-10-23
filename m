Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD09CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B62214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGAgcBjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbfJWCl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:41:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39278 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfJWCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:41:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so18421862qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q4raC0KDrg0Y3VOU96/cM0m4sT0Xq+RiWIVVbLsEG3o=;
        b=cGAgcBjNZ7OGStncxmS8AdWRHM1wBepX2aAZNEflgKnz6qUeoCLayiPuMzY7TIH8lb
         fZl60JgJSx6k4Y8w4Zru4lh2M1HrwdAVcQCLPDcNsvA+8EGfEQQeWdBIeN1Tlpn256u/
         h/84gUCUmLt2Zuy+lNfIEbDxqGKfn2u1zs5d6Ji4wzGjwioKo5QGUaVcRWFbZ8aFtRgy
         R+b5lFW1NAbamEvfz3/gsg2ZsZebWuE7hQg/GGI2hmU0wQ8LkFc090kkopPJf9XaiH+z
         NNuH3qT0o4Bca3w3Gy3SI5mkPZ728mqz8U7gmltkcZJOlbyxMidEHAe4/hlR/v6YZslS
         /8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4raC0KDrg0Y3VOU96/cM0m4sT0Xq+RiWIVVbLsEG3o=;
        b=Ry6eb1fwTvv9beFXDui2AEzwoeBerNpeZW/gXVY9VJsvUoYDcymn0Tuq3TL2LTGY0r
         BIxQj8zvWjJ9ZLhH3UcbeSDBHgKrSb5WKfbRNoFeauTPihhVtqIBXkZUJ7F1jPD0BC0v
         rgL8wWJi79ZE1roXVV83aOuF3rsS5l2VpEhVKRwrOWtJZgKIcLCgwHU1isqJQuhAhFS7
         4xkxX+xptTk15jnCDnqoa1M0uro57vN0K4jfEBJh5PjnOiutsYXPKlqDy55FA/SuhyxY
         o6XdQ6zU2cVEB7ZirfxPAT1geZc/oniSX1t38wIkqcUXHJGy5FYdFYdZhJFZJWRr1+vL
         lDQw==
X-Gm-Message-State: APjAAAX7bDIzFg/uvHwuoTLnCGOZCC1h2nI5sApXh4noFGVpIuDE7o1o
        blPFryDl/HiZ7Qj1/mHABTwuiQ==
X-Google-Smtp-Source: APXvYqxujctKv2HySWW6Y07W2SuJ8MZUeMGfRnect8SenIwk0zEEAi1cnR2+yCc96rV6CT1PWC8OfQ==
X-Received: by 2002:a37:7b44:: with SMTP id w65mr6367539qkc.409.1571798516742;
        Tue, 22 Oct 2019 19:41:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id 76sm12508050qke.111.2019.10.22.19.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 19:41:55 -0700 (PDT)
Date:   Wed, 23 Oct 2019 10:41:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        acme@kernel.org, open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkft-triage@lists.linaro.org
Subject: Re: Linux-next: 20191022: perf: bpf_helpers_doc.py: not found
Message-ID: <20191023024149.GA29009@leoy-ThinkPad-X240s>
References: <CA+G9fYvWdkmmkrq7hvADZ-1qnUNEwRULoTPfOQDnu1aZW8cDEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvWdkmmkrq7hvADZ-1qnUNEwRULoTPfOQDnu1aZW8cDEA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Tue, Oct 22, 2019 at 09:04:04PM +0530, Naresh Kamboju wrote:
> We have noticed perf (OE recipe) build failure on linux next 20191022.
> do you see this failure ?
> 
> /bin/sh: 1: perf/1.0-r9/perf-1.0/scripts/bpf_helpers_doc.py: not found
> Makefile:184: recipe for target 'bpf_helper_defs.h' failed
> make[3]: *** [bpf_helper_defs.h] Error 127
> make[3]: *** Deleting file 'bpf_helper_defs.h'
> Makefile.perf:765: recipe for target 'perf/1.0-r9/perf-1.0/libbpf.a' failed
> make[2]: *** [perf/1.0-r9/perf-1.0/libbpf.a] Error 2

I tested for two methods with linux-next, one is native building mode
for Arm64 building on DB410c board, another is cross compiling Arm64
binary on my x86 laptop.  Both cannot reproduce this failure.

After read your shared build log and I think the building process is
expected: Perf tool tries to build libbpf, so it changes to the
building folder 'BPF_DIR' (which is under $(srctree)/tools/lib/bpf/),
then failed to find file $(srctree)/scripts/bpf_helpers_doc.py.

Here $(srctree) means the kernel's root folder.

Seems to me, this failure is caused by missing to sync kernel files
$linux_src/scripts to the OE folder 'perf/1.0-r9/perf-1.0/scripts'?

Thanks,
Leo Yan

> Metadata:
> ------------------------------------------------------------------------
> kernel: 5.4.0-rc4
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: a722f75b2923b4fd44c17e7255e822ac48fe85f0
> git describe: next-20191022
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191022
> 
> Full build log:
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/631/consoleText
> 
> - Naresh
