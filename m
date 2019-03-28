Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10837C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93E02075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfC1Hax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:30:53 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:40361 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfC1Hax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:30:53 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3F22F2800B3E2;
        Thu, 28 Mar 2019 08:30:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E530757552; Thu, 28 Mar 2019 08:30:49 +0100 (CET)
Date:   Thu, 28 Mar 2019 08:30:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v13 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190328073049.jpizz6uio7er2sjv@wunner.de>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
 <20190327064254.lwj7ew37mxphieco@wunner.de>
 <20190328043013.GA3251@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328043013.GA3251@icarus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:30:13PM +0900, William Breathitt Gray wrote:
> On Wed, Mar 27, 2019 at 07:42:54AM +0100, Lukas Wunner wrote:
> > On Wed, Mar 27, 2019 at 01:58:45PM +0900, William Breathitt Gray wrote:
> > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > within a bitmap memory region. For each iteration, "start" is set to the
> > > bit offset of the found clump, while the respective clump value is
> > > stored to the location pointed by "clump". Additionally, the
> > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > respectively get and set an 8-bit value in a bitmap memory region.
> > 
> > I would have preferred static inlines for bitmap_get_value8(),
> > bitmap_set_value8() and find_next_clump8() to make this as fast
> > as possible in the callers because I've personally worked with
> > an industrial application where the GPIO pins of a 74x164 are
> > written every 250 usec.
> 
> I'm not sure these can be static inline since the symbols are exported
> for use outside this file.

By static inlines I meant that the functions are moved to the appropriate
header file in include/linux/.  You don't need to worry about exporting
in that case as the code is local to each module.  For smallish functions
like these, static inlines are usually fine.  See drivers/dma/virt-dma.h
for an extreme case of static inlines (as compared to the much smaller
virt-dma.c).

Thanks,

Lukas
