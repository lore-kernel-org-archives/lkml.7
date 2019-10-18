Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38497CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3A52089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502528AbfJRVBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:01:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:40170 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbfJRVBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:01:52 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9IK2BmA030151;
        Fri, 18 Oct 2019 15:02:11 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x9IK2AiY030150;
        Fri, 18 Oct 2019 15:02:10 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 18 Oct 2019 15:02:10 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] powerpc/prom_init: Use -ffreestanding to avoid a reference to bcmp
Message-ID: <20191018200210.GR28442@gate.crashing.org>
References: <20190911182049.77853-1-natechancellor@gmail.com> <20191014025101.18567-1-natechancellor@gmail.com> <20191014025101.18567-4-natechancellor@gmail.com> <20191014093501.GE28442@gate.crashing.org> <CAKwvOdmcUT2A9FG0JD9jd0s=gAavRc_h+RLG6O3mBz4P1FfF8w@mail.gmail.com> <20191014191141.GK28442@gate.crashing.org> <20191018190022.GA1292@ubuntu-m2-xlarge-x86>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018190022.GA1292@ubuntu-m2-xlarge-x86>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:00:22PM -0700, Nathan Chancellor wrote:
> Just as an FYI, there was some more discussion around the availablity
> and use of bcmp in this LLVM bug which spawned
> commit 5f074f3e192f ("lib/string.c: implement a basic bcmp").
> 
> https://bugs.llvm.org/show_bug.cgi?id=41035#c13
> 
> I believe this is the proper solution but I am fine with whatever works,
> I just want our CI to be green without any out of tree patches again...

I think the proper solution is for the kernel to *do* use -ffreestanding,
and then somehow tell the kernel that memcpy etc. are the standard
functions.  A freestanding GCC already requires memcpy, memmove, memset,
memcmp, and sometimes abort to exist and do the standard thing; why cannot
programs then also rely on it to be the standard functions.

What exact functions are the reason the kernel does not use -ffreestanding?
Is it just memcpy?  Is more wanted?


Segher
