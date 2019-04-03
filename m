Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453FDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67152075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OVc1Fu1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDCRFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:05:12 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:53210 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:05:12 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x33H50Nu029239
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 02:05:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x33H50Nu029239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554311100;
        bh=E+d50jsKWfjuxl+BieswwvwbvKL+Ncihl7I9ZIF0/Ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OVc1Fu1RcRlyASgCE0ka/fLR6vXYux5y6ujk6lsIx6vjG0G5Y7SvRWJrraYH9EtHV
         9TGeyqP+faiDiZz8lVOeQRScs1U+4gBgjv0FHzbhrJocnY3hh/73q8EvwA3NCJml+i
         XMwKw3aH2XVTCMj8KEmksyW/tMTLQTJbNgqXVwJyl9vBe/9axOvwnpOsBRs6svvhuB
         38TPTBIAJf84VGoyDoOnOd4OBo6YjSRwG52nKgcGUH9Z6oo3TuwDUZTqe1sLJows/Y
         ogOSIy6LuK/dsO20mspwqyWeEU0ItkHZiyPdReIh8jryVnAtGVcVe7G+k+vUI7CPGa
         W1JuTsZvqzf7A==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id j184so10422169vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:05:00 -0700 (PDT)
X-Gm-Message-State: APjAAAW4LMo7t2xPrOglj8tl4wS79N/pMGoPmLuaUHNOIUj6Ma26yews
        2L/ZAi5PZzEuGxGHlsJYmI+JkAh80gNb0yj+Z6w=
X-Google-Smtp-Source: APXvYqzSkyn3gBjfQeEUztTSpPpcu/ZPt7xYrTmapYIkN6xjbWYHxUIq5lbsPJkzbdCdO+/OYRt8MwOTMcZl9qqpM50=
X-Received: by 2002:a67:ea0a:: with SMTP id g10mr957360vso.77.1554311099612;
 Wed, 03 Apr 2019 10:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <1554281302-21105-1-git-send-email-yamada.masahiro@socionext.com> <20190403124438.GH16362@fuggles.cambridge.arm.com>
In-Reply-To: <20190403124438.GH16362@fuggles.cambridge.arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 4 Apr 2019 02:04:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4aabQoMwWZNUEACPC3_SQPdmq+5cAOQD-d+yvXE7Qzg@mail.gmail.com>
Message-ID: <CAK7LNAQ4aabQoMwWZNUEACPC3_SQPdmq+5cAOQD-d+yvXE7Qzg@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: fix and clean-up Makefile
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Apr 3, 2019 at 9:45 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Masahiro,
>
> On Wed, Apr 03, 2019 at 05:48:22PM +0900, Masahiro Yamada wrote:
> > - $(call if_changed,...) must have FORCE as a prerequisite
> >
> > - vdso.lds is a generated file, so it should be prefixed with
> >   $(obj)/ instead of $(src)/.
>
> Hmm, this sounds quite alarming! How come out of tree builds seem to work
> ok without this patch?

No, I do not mean like that.
This is just cosmetic (at least for now).
Kbuild conventionally use both $(obj) and $(src), but
they are the same in most places.
If you see the top of scripts/Makefile.build,
$(src) is the same as $(obj).


I fixed this x86 in commit 1742ed2088.
VDSO Makefiles are copied from arch to arch.

-- 
Best Regards
Masahiro Yamada
