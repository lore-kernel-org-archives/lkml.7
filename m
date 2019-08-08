Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66328C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43731217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbfHHAHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:07:45 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:33977 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388425AbfHHAHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E4A74180A76CC;
        Thu,  8 Aug 2019 00:07:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cloth02_7d18cabf61225
X-Filterd-Recvd-Size: 3653
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 00:07:39 +0000 (UTC)
Message-ID: <099e07d4b4ecca9798404b95dc78c89bc3dd9f7f.camel@perches.com>
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Aug 2019 17:07:38 -0700
In-Reply-To: <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-2-rikard.falkeborn@gmail.com>
         <20190807142728.GA16360@roeck-us.net>
         <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-07 at 23:55 +0900, Masahiro Yamada wrote:
> On Wed, Aug 7, 2019 at 11:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
[]
> > Who is going to fix the fallout ? For example, arm64:defconfig no longer
> > compiles with this patch applied.
> > 
> > It seems to me that the benefit of catching misuses of GENMASK is much
> > less than the fallout from no longer compiling kernels, since those
> > kernels won't get any test coverage at all anymore.
> 
> We cannot apply this until we fix all errors.
> I do not understand why Andrew picked up this so soon.

I think it makes complete sense to break -next (not mainline)
and force
people to fix defects.  Especially these types of
defects that are
trivial to fix.

I already sent patches a month ago for all decimal only
defective uses of GENMASK

https://lore.kernel.org/lkml/cover.1562734889.git.joe@perches.com/

A couple of which have _still_ not been picked up.

These have been applied in -next:

     1	9e037bdf743cc081858423ad4123824e846b2358 media: staging: media: cedrus: Fix misuse of GENMASK macro
     2	5ff29d836d1beb347080bd96e6321c811a8e3f62 rtw88: Fix misuse of GENMASK macro
     3	665e985c2f41bebc3e6cee7e04c36a44afbc58f7 mmc: meson-mx-sdio: Fix misuse of GENMASK macro
     4	f7408a3d5b5fd10571a653d1a81ce9167c62727f ASoC: wcd9335: Fix misuse of GENMASK macro
     5	ae8cc91a7d85e018c0c267f580820b2bb558cd48 iio: adc: max9611: Fix misuse of GENMASK macro
     6	aa4c0c9091b0bb4cb261bbe0718d17c2834c4690 net: stmmac: Fix misuses of GENMASK macro
     7	937a944090cca2f19458fd037a8aff61c546f0cd net: ethernet: mediatek: Fix misuses of GENMASK macro
     8	9bdd7bb3a8447fe841cd37ddd9e0a6974b06a0bb clocksource/drivers/npcm: Fix misuse of GENMASK macro
     9	20faba848752901de23a4d45a1174d64d2069dde irqchip/gic-v3-its: Fix misuse of GENMASK macro

These have not:
(and that's a rather sad indictment of lk process defects)

[PATCH 03/12] drm: aspeed_gfx: Fix misuse of GENMASK macro
https://lore.kernel.org/lkml/cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com/

[PATCH 10/12] phy: amlogic: G12A: Fix misuse of GENMASK macro
https://lore.kernel.org/lkml/d149d2851f9aa2425c927cb8e311e20c4b83e186.1562734889.git.joe@perches.com/

At least these last two do not seem to have actual uses.


