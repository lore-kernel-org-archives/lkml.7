Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5377C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BAE2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980760;
	bh=SJvClPpEgTWbtc10+qAbATQ9/hZ0btwPqCQNyxe73ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NUn0QhT4/9a8b3VV78Rdt81GcZpucs4IlxyemWxWyBKSzjtC6rvso47AeEGMS9oW8
	 jB00j+Zk5PzxOPyOnGHRzBQb+1a8s5M0Zg/AHFSKMmZV3I5YGnC8GfWHWeIDU3cxX8
	 pr15RY6WNEmhCdtsi+oaEpD8wsq8qs3gGdzD1/r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfCGRp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40497 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCGRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so12333148lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9J2Fo6N6KyGEmau4uxMb3UNQVHxN5eNj0Xa06QqRZxs=;
        b=MmuAJD3U97Z83DdymKWDdbbWfbcEvOnaHoe6yyjernK8Xr477BcU3EcMjrxtBSYrxr
         hTehdQ6a7MDJMGmr7Pf4yzw5bVVwaHt6N3W4luWzQLQ6LrVsb/X8Q1nuDo5w1f9RZ8da
         HkZcFn3WAfv4cSP0ntxDHdeh2GUWDjE9iJrwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9J2Fo6N6KyGEmau4uxMb3UNQVHxN5eNj0Xa06QqRZxs=;
        b=hUJyUbfpDiruWUcLeLumAIWcFpxqc2051xRiZpG7YkGiRbuKGt7RXfnvE3WB4jgTxQ
         p+7IPITYU1l3tklYGOY2ub2Nv40ey1GgiBA+lfpz2az8Apgg2swyqk09Gi3fY4z/WMKQ
         sy44MWKHBYggz+qlIt8wuKH4/R0jDsrdirDI3dQJ3aBPlEa4GdpFswdBe/VkTl35QZ1f
         d25Elt8Sy3ob/u6VLkbNE9NOG1ArVkwew5GysHIhkr/ZEeejHO0oi70yXXZDctjtVaC0
         qfBBKFRAb68kNZLUG3CUmoyJY5esEo626qY4N4CvR8OMdeVgeABZoSvHUISAzMPh4rd7
         s68Q==
X-Gm-Message-State: APjAAAWXDLllt/fFdjratRffF9yK2Rv8gkS+S9Lhf46TFO7f27oFlxs/
        hzZ9bn5T6MhtWnJJGPnyJOETkY6PkCA=
X-Google-Smtp-Source: APXvYqw4XV6yMhh/K0pP7vveNDIV6GySdROCvmUwysiehGkEARvtIgkx6CRsNMlHq+PjT6uvsupfxw==
X-Received: by 2002:ac2:41c4:: with SMTP id d4mr4440699lfi.104.1551980753506;
        Thu, 07 Mar 2019 09:45:53 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b64sm941341ljf.82.2019.03.07.09.45.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:45:51 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id v16so14966922ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:45:51 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr6469940lji.125.1551980751101;
 Thu, 07 Mar 2019 09:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20190307114511.870090179@infradead.org> <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net> <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble> <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
 <20190307171709.dap5hfeof4yo3nsc@treble> <20190307173810.GI32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190307173810.GI32477@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Mar 2019 09:45:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_vuD9fKk36=_DNG9=+S9rbTRu2FTFe9tECunC8oOtfg@mail.gmail.com>
Message-ID: <CAHk-=wi_vuD9fKk36=_DNG9=+S9rbTRu2FTFe9tECunC8oOtfg@mail.gmail.com>
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Also; it seems to me that something PT, or maybe even simply:
>
>   perf -e branches -e branch-misses
>
> would get you similar or sufficient information.

Yeah, I'm not really seeing a lot of upside to PROFILE_ALL_BRANCHES.

Particularly since it doesn't actually profile all branches at all. It
only basically profiles "if ()" statements, which obviously misses
loops etc, but then also _does_ hit things where people turned loops
into "if (unlikely()) loop()", which happens in (for example)
low-level locking code etc that often has a fast-case "first try"
thing followed by a slow-case "ok, let's loop for it" thing.

So I think PROFILE_ALL_BRANCHES tends to have very random coverage.
I'd love to get rid of it, because it seems so random.

               Linus
