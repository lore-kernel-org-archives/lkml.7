Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99858C47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 02:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67982214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570847283;
	bh=seaszAaAddmvc00sV2sX3tVDfOb0Du0i+L79O1U8l44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NVdBzGAmjNoykMguoQh+KhFmV5F6/ksepkWseTEIbW3k5YdximyCa0YHrAnp+AJPd
	 mf0PETcEuik+D+kjPomxkGfnpbsY2W731SSqkVMylswGXfhZFH/nOOUmKXkcwIgVoR
	 zkbHYQWGQ5pLEExtt0Kb4XdoPL2kK0ZgM7/z1n4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfJLC1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 22:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfJLC1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 22:27:40 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D924D2084C;
        Sat, 12 Oct 2019 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570847258;
        bh=seaszAaAddmvc00sV2sX3tVDfOb0Du0i+L79O1U8l44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RwCaHgKckq+rkFDWeriV0y6xirRR4PSoBpP2M5sL8Hqbg0lmQVapG/zwQ2SJyU9pH
         K+9QjbKZrJkHRkvIkIc4CHfx2FMLQUvRKagQ9hE2SVPlg0NQGa4ChyTaRZ0C+5RCaJ
         jCqfq8TcVduKfvf94T062qWslRFTgXoWhHOLfEvw=
Date:   Fri, 11 Oct 2019 19:27:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     bp@alien8.de, joe@perches.com, johannes@sipsolutions.net,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        yamada.masahiro@socionext.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Haren Myneni <haren@us.ibm.com>
Subject: Re: [Patch v4 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
Message-Id: <20191011192737.c0e69db9ca49cd7622efdae5@linux-foundation.org>
In-Reply-To: <20191009214502.637875-3-rikard.falkeborn@gmail.com>
References: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
        <20191009214502.637875-1-rikard.falkeborn@gmail.com>
        <20191009214502.637875-3-rikard.falkeborn@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Oct 2019 23:45:02 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> as the first argument and the low bit as the second argument. Mixing
> them will return a mask with zero bits set.
> 
> Recent commits show getting this wrong is not uncommon, see e.g.
> commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> macro").
> 
> To prevent such mistakes from appearing again, add compile time sanity
> checking to the arguments of GENMASK() and GENMASK_ULL(). If both
> arguments are known at compile time, and the low bit is higher than the
> high bit, break the build to detect the mistake immediately.
> 
> Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> used instead of BUILD_BUG_ON().
> 
> __builtin_constant_p does not evaluate is argument, it only checks if it
> is a constant or not at compile time, and __builtin_choose_expr does not
> evaluate the expression that is not chosen. Therefore, GENMASK(x++, 0)
> does only evaluate x++ once.
> 
> Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> available in assembly") made the macros in linux/bits.h available in
> assembly. Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
> checks if the file is included in an asm file.
> 
> Due to bugs in GCC versions before 4.9 [0], disable the check if
> building with a too old GCC compiler.
> 
> [0]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

I'm seeing some breakage in code which is newly added in linux-next:

sound/soc/codecs/tas2562.c: In function tas2562_set_dai_tdm_slot:
./include/linux/build_bug.h:16:51: error: negative width in bit-field <anonymous>
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                   ^
./include/linux/bits.h:25:3: note: in expansion of macro BUILD_BUG_ON_ZERO
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
   ^~~~~~~~~~~~~~~~~
./include/linux/bits.h:39:3: note: in expansion of macro GENMASK_INPUT_CHECK
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tas2562.h:65:37: note: in expansion of macro GENMASK
 #define TAS2562_TDM_CFG2_RXLEN_MASK GENMASK(0, 1)
                                     ^~~~~~~
sound/soc/codecs/tas2562.c:160:11: note: in expansion of macro TAS2562_TDM_CFG2_RXLEN_MASK
           TAS2562_TDM_CFG2_RXLEN_MASK,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:16:51: error: negative width in bit-field <anonymous>
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                   ^
./include/linux/bits.h:25:3: note: in expansion of macro BUILD_BUG_ON_ZERO
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \


and

In file included from ./include/linux/bits.h:23:0,
                 from ./include/linux/ioport.h:15,
                 from ./include/linux/acpi.h:12,
                 from drivers/crypto/hisilicon/hpre/hpre_main.c:3:
./include/linux/build_bug.h:16:51: error: negative width in bit-field ‘<anonymous>’
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                   ^
./include/linux/bits.h:25:3: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
   ^~~~~~~~~~~~~~~~~
./include/linux/bits.h:39:3: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^~~~~~~~~~~~~~~~~~~
drivers/crypto/hisilicon/hpre/hpre_main.c:119:15: note: in expansion of macro ‘GENMASK’
  { .int_msk = GENMASK(10, 15), .msg = "hpre_ooo_rdrsp_err" },
               ^~~~~~~
./include/linux/build_bug.h:16:51: error: negative width in bit-field ‘<anonymous>’
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                   ^
./include/linux/bits.h:25:3: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
   ^~~~~~~~~~~~~~~~~
./include/linux/bits.h:39:3: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^~~~~~~~~~~~~~~~~~~
drivers/crypto/hisilicon/hpre/hpre_main.c:120:15: note: in expansion of macro ‘GENMASK’
  { .int_msk = GENMASK(16, 21), .msg = "hpre_ooo_wrrsp_err" },
               ^~~~~~~

