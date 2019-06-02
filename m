Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A587FC28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8981D27957
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFBPEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:04:15 -0400
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:43768 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726229AbfFBPEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:04:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C570D100E86C9;
        Sun,  2 Jun 2019 15:04:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: house36_7c1320b646819
X-Filterd-Recvd-Size: 2610
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Jun 2019 15:04:12 +0000 (UTC)
Message-ID: <2870be25585850e8968ed0e1237ac381a85b878c.camel@perches.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 2
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Date:   Sun, 02 Jun 2019 08:04:11 -0700
In-Reply-To: <20190602063905.GA14513@kroah.com>
References: <20190602063905.GA14513@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 08:39 +0200, Greg KH wrote:
> The second patch fixes up a number of places in the tree where people
> mistyped the string "SPDX-License-Identifier".  Given that people can
> not even type their own name all the time without mistakes, this was
> bound to happen, and odds are, we will have to add some type of check
> for this to checkpatch.pl to catch this happening in the future.
[]
>  arch/arm/kernel/bugs.c                | 2 +-
>  drivers/crypto/ux500/cryp/Makefile    | 2 +-
>  drivers/phy/st/phy-stm32-usbphyc.c    | 2 +-
>  drivers/pinctrl/sh-pfc/pfc-r8a77980.c | 2 +-
>  lib/test_stackinit.c                  | 2 +-
>  sound/soc/codecs/max9759.c            | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

checkpatch already gives a warning for each of these files
except the Makefile as it has no filename extension.
Filenames without extensions are not checked.

$ ./scripts/checkpatch.pl -f --types=SPDX_LICENSE_TAG --nosummary --terse \
	arch/arm/kernel/bugs.c \
	drivers/crypto/ux500/cryp/Makefile \
	drivers/phy/st/phy-stm32-usbphyc.c \
	drivers/pinctrl/sh-pfc/pfc-r8a77980.c \
	lib/test_stackinit.c \
	sound/soc/codecs/max9759.c
arch/arm/kernel/bugs.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
drivers/phy/st/phy-stm32-usbphyc.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
drivers/pinctrl/sh-pfc/pfc-r8a77980.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
lib/test_stackinit.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
sound/soc/codecs/max9759.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1


