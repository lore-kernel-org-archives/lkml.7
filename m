Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B080ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7338121848
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa4QMDbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbfJVTxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:53:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37209 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbfJVTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:53:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id g21so12988478lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9AbDypl4/gHx2grPLXEaExBcrubVWc4bf13vvLK5aZo=;
        b=Sa4QMDbqFjLShMmToI4jOidmVMnX0V7q00yYJkRBmoVJMAQkigdfYQwWIXM+8oWAvA
         J3IPtUFucvAvqQi/PDqBi3X95WgxFL7OD3rJN2KNoZB/fDi532rgwz2LJAO8nUIMVC8B
         ye17WMAmsz8ZtHCO99bnxsI2oB6bqP1jLeEtZaWJ/8ym2DfGefpMg5tqYL1vkcSIm1ga
         aPbhQOz8YdeQlT/qJfmj/06AIttsziXaNrye55UJcy/3re69NtlbJyl8LOwKh3G9jlat
         RvGAJuWMBhXPPGNdyvIjW4CUJx2Vu3x0kp13+bj6jDCMGV6Lik+EzUzjoFQ8umFZ8ss/
         eDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9AbDypl4/gHx2grPLXEaExBcrubVWc4bf13vvLK5aZo=;
        b=pUTuHKaVl+9eLgmcSX67P2A1Y6RMt3FVzULLUxFc5YytRpGtUsTs3BafCNskCG3LKT
         KRtVMtT9DuW2vYJPYaTK7XGDIQ3yNVzHE+zo6zjJQZSTmdLwHm20XWTJLHltVYaS6cOG
         O2Ea4wNhqoGH/APFRPsvmg/hJxLSTJL08DBd+V5RI57L3j17EogApleQmkXGfOIOTdu6
         71eqRpIEZQ+djOypeRUaZLW/mhZlxsLz/Ne43xx09lRGp33O8KQ/PjrXfWwAHlvtN8y+
         BU5QGqXTbl7A0Lr1ETi+bBUKvVmacMOZjc+PWUA9qTPROj9mRMWVPYdGsczgUGtThcYV
         TB/w==
X-Gm-Message-State: APjAAAXU4AauzfsWzl6OfZrjfORkj42cZtsGSmM304vrgBVyLUzFaZ2r
        SYk8I1gCwCtSHF2iZD8yTE8=
X-Google-Smtp-Source: APXvYqztnAkqHwdFCgxAiecsSQvRsF5i77SntZUOBpLr61nMZ4D2M3cslg1rZUWcFP4/G73nGgVIrg==
X-Received: by 2002:a19:ac48:: with SMTP id r8mr4510696lfc.181.1571773992197;
        Tue, 22 Oct 2019 12:53:12 -0700 (PDT)
Received: from rikard (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id b67sm18406860ljf.5.2019.10.22.12.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 12:53:10 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 22 Oct 2019 21:53:06 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>, bp@alien8.de,
        joe@perches.com, johannes@sipsolutions.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        yamada.masahiro@socionext.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Haren Myneni <haren@us.ibm.com>
Subject: Re: [Patch v4 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
Message-ID: <20191022195306.GA479880@rikard>
References: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
 <20191009214502.637875-1-rikard.falkeborn@gmail.com>
 <20191009214502.637875-3-rikard.falkeborn@gmail.com>
 <20191011192737.c0e69db9ca49cd7622efdae5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191011192737.c0e69db9ca49cd7622efdae5@linux-foundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 07:27:37PM -0700, Andrew Morton wrote:
> On Wed,  9 Oct 2019 23:45:02 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:
> 
> > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > as the first argument and the low bit as the second argument. Mixing
> > them will return a mask with zero bits set.
> > 
> > Recent commits show getting this wrong is not uncommon, see e.g.
> > commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> > commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> > macro").
> > 
> > To prevent such mistakes from appearing again, add compile time sanity
> > checking to the arguments of GENMASK() and GENMASK_ULL(). If both
> > arguments are known at compile time, and the low bit is higher than the
> > high bit, break the build to detect the mistake immediately.
> > 
> > Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> > used instead of BUILD_BUG_ON().
> > 
> > __builtin_constant_p does not evaluate is argument, it only checks if it
> > is a constant or not at compile time, and __builtin_choose_expr does not
> > evaluate the expression that is not chosen. Therefore, GENMASK(x++, 0)
> > does only evaluate x++ once.
> > 
> > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > available in assembly") made the macros in linux/bits.h available in
> > assembly. Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
> > checks if the file is included in an asm file.
> > 
> > Due to bugs in GCC versions before 4.9 [0], disable the check if
> > building with a too old GCC compiler.
> > 
> > [0]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
> 
> I'm seeing some breakage in code which is newly added in linux-next:
> 
> sound/soc/codecs/tas2562.c: In function tas2562_set_dai_tdm_slot:
> ./include/linux/build_bug.h:16:51: error: negative width in bit-field <anonymous>
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                    ^
> ./include/linux/bits.h:25:3: note: in expansion of macro BUILD_BUG_ON_ZERO
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:39:3: note: in expansion of macro GENMASK_INPUT_CHECK
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^~~~~~~~~~~~~~~~~~~
> sound/soc/codecs/tas2562.h:65:37: note: in expansion of macro GENMASK
>  #define TAS2562_TDM_CFG2_RXLEN_MASK GENMASK(0, 1)
>                                      ^~~~~~~
> sound/soc/codecs/tas2562.c:160:11: note: in expansion of macro TAS2562_TDM_CFG2_RXLEN_MASK
>            TAS2562_TDM_CFG2_RXLEN_MASK,
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:16:51: error: negative width in bit-field <anonymous>
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                    ^
> ./include/linux/bits.h:25:3: note: in expansion of macro BUILD_BUG_ON_ZERO
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> 
> 
> and
> 
> In file included from ./include/linux/bits.h:23:0,
>                  from ./include/linux/ioport.h:15,
>                  from ./include/linux/acpi.h:12,
>                  from drivers/crypto/hisilicon/hpre/hpre_main.c:3:
> ./include/linux/build_bug.h:16:51: error: negative width in bit-field ‘<anonymous>’
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                    ^
> ./include/linux/bits.h:25:3: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:39:3: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^~~~~~~~~~~~~~~~~~~
> drivers/crypto/hisilicon/hpre/hpre_main.c:119:15: note: in expansion of macro ‘GENMASK’
>   { .int_msk = GENMASK(10, 15), .msg = "hpre_ooo_rdrsp_err" },
>                ^~~~~~~
> ./include/linux/build_bug.h:16:51: error: negative width in bit-field ‘<anonymous>’
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                    ^
> ./include/linux/bits.h:25:3: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:39:3: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^~~~~~~~~~~~~~~~~~~
> drivers/crypto/hisilicon/hpre/hpre_main.c:120:15: note: in expansion of macro ‘GENMASK’
>   { .int_msk = GENMASK(16, 21), .msg = "hpre_ooo_wrrsp_err" },
>                ^~~~~~~
> 

As of next-20191021, those breakages are fixed ([0], [1]). next-20191021
now builds (at least for x86-64) with the GENMASK compile checks added.

I also stumbled upon [2], which is a fix for an unused macro in a header
in mips/include/asm. next-201008 contained both v3 of this patch and the
mips header with the bad GENMASK in without build regressions, so it
*should* be ok to include v4 (but given the track record of this patch,
I totally understand if you want to wait until [2] lands in mips-next and
linux-next).

Rikard

[0]: https://lore.kernel.org/patchwork/patch/1139777/
[1]: https://lore.kernel.org/patchwork/patch/1139778/
[2]: https://lore.kernel.org/linux-mips/20191022192547.480095-1-rikard.falkeborn@gmail.com/T/#u
