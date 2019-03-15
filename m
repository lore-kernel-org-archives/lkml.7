Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC86C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0B021872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vK1D3AZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfCOPyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:54:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32798 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfCOPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:54:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id i7so3546529pgq.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdqcDWXkpQ28Nb7+p+7S50j4iA+Z3tTQHBWP9JJnlKI=;
        b=vK1D3AZsbmOsc1xEzacb4OVMoof67BXA99tAXZm6TihSKgSRjYsL+ELcU5MIvqod1u
         wrECo66SarjooBzfwYJh7d3qTKUBQ/3CDpNVCHNqJ+oki/v/GiI1eAJQ+ZrnVLrU6Zt0
         U5KdbmCHTaHEj5dF1p8IBaOTOMuMYeXWApFCUpXqKapqgZs7tMsjxlY8fqwPZuaZoEQf
         caNrlFzLlRO7JkdcBZfBBhaidABub9fu4ZNVdmM36WPZn1FC6jCaXD1Bm3dBLTwGc4Ec
         JEv76aWLQmfD+5X8PtblYlge1a+lr/Nflt9RPpmCOZAyM6fMUb/Ie+sYzvkMSnA499eR
         Hijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdqcDWXkpQ28Nb7+p+7S50j4iA+Z3tTQHBWP9JJnlKI=;
        b=DNNFCbCrUVdywbMBiHasxRogUynqcLdTOVaQIJIkymwfg/84YdiJJB9JbqpHqwnsDt
         mh37KS83f65WW165P02W3FaVpm+Yz0G+CdUfExIXuF0WJ+WhN9S1EZozMxA2dB/HKl1x
         EER68xIh6f1B6tC2gk6iM80k9d2oGOY54LWfVkARnmC4erzazpUUFJA0L5GgS0g1xIk4
         OgBfWsil34URtRYCCfwm6rgJd/NFetvGNh/bqCFtKYsn+3szYkM/WDALHo3BZ01b0MB5
         26sA38PqV5Kk5tSYorV5nWgSy6bNuQfJymRi9tmPcS5FIujlS9cdManKWvxLsbf0wMPY
         YFGg==
X-Gm-Message-State: APjAAAV52M3aviZaoApSUzO02B8IgjJgOEb0GfUCx6BarxwTPqCuD6s0
        XUkTIJQ+itibZMJFuit++ko=
X-Google-Smtp-Source: APXvYqxCqnGEugiKOEL8VQQ2sSPVBnRSKp3tYGop2UjHWBlmZftZHnCRvFlay68Ba9hNUmadjeoqBA==
X-Received: by 2002:a63:e801:: with SMTP id s1mr4114039pgh.378.1552665238967;
        Fri, 15 Mar 2019 08:53:58 -0700 (PDT)
Received: from localhost ([2607:fb90:6d5:a4be:c057:734:2567:9ba6])
        by smtp.gmail.com with ESMTPSA id c130sm4807194pfb.145.2019.03.15.08.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 08:53:57 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date:   Fri, 15 Mar 2019 18:53:51 +0300
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] lib: rework bitmap_parselist and tests
Message-ID: <20190315155351.GA26426@yury-thinkpad>
References: <20190220083705.14050-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220083705.14050-1-ynorov@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Wed, Feb 20, 2019 at 11:36:59AM +0300, Yury Norov wrote:
> bitmap_parselist has been evolved from a pretty simple idea for long and
> now lacks for refactoring. It is not structured, has nested loops and a
> set of opaque-named variables. All this leads to extremely hard
> understanding of the code. Once during the optimization of it I missed a
> scenario which leads to kernel hangup. Tetsuo Handa spotted this and found
> it simpler to rewrite the code instead fixing it. (Though, that attempt
> had some flaws.)
> https://lkml.org/lkml/2018/4/1/93 
> 
> Things are more complicated than they may be because bitmap_parselist()
> is part of user interface, and its behavior should not change.
> 
> In this patchset 
>  - __bitmap_parselist() is reworked (patches 2 and 3);
>  - time measurement in test_bitmap_parselist switched to ktime_get
>    (patch 4);
>  - new tests introduced (patch 5), and
>  - bitmap_parselist_user() testing enabled with the same testset as
>    bitmap_parselist() (patch 6).
> 
> Patch 1 is a fix and may be applied separately.
> 
> V1: https://lkml.org/lkml/2018/12/23/50
> v2: - use PTR_ERR() and ERR_PTR() where appropriate;
>     - fix parser logic (last byte of string handling);
>     - tests for bitmap_parselist_user() in patch 5.
> 
> Yury Norov (4):
>   bitmap_parselist: don't calculate length of the input string
>   bitmap_parselist: move non-parser logic to helpers
>   bitmap_parselist: rework input string parser
>   lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
>   lib/test_bitmap: add testcases for bitmap_parselist
>   lib/test_bitmap: add tests for bitmap_parselist_user
> 
>  lib/bitmap.c      | 293 ++++++++++++++++++++++++++++++----------------
>  lib/test_bitmap.c |  67 +++++++++--
>  2 files changed, 245 insertions(+), 115 deletions(-)
> 
> -- 
> 2.17.1
