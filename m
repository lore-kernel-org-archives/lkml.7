Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C871CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A1B20828
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfGCPiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:38:00 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:43057 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726490AbfGCPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:37:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5BD2518224946;
        Wed,  3 Jul 2019 15:37:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: party68_285374932a22c
X-Filterd-Recvd-Size: 3405
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Jul 2019 15:37:56 +0000 (UTC)
Message-ID: <c8d5cc6171d2cff131e8600ac57e2eb441812617.camel@perches.com>
Subject: Re: [PATCH] checkpatch: avoid default n
From:   Joe Perches <joe@perches.com>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Date:   Wed, 03 Jul 2019 08:37:55 -0700
In-Reply-To: <1562144624.3550.1.camel@mtksdaap41>
References: <20190703083031.2950-1-miles.chen@mediatek.com>
         <be8a97c15249ff8a613910db5792c5bcdc75333c.camel@perches.com>
         <1562144624.3550.1.camel@mtksdaap41>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 17:03 +0800, Yingjoe Chen wrote:
> On Wed, 2019-07-03 at 01:42 -0700, Joe Perches wrote:
> > On Wed, 2019-07-03 at 16:30 +0800, Miles Chen wrote:
> > > This change reports a warning when "default n" is used.
> > > 
> > > I have seen several "remove default n" patches, so I think
> > > it might be helpful to add this test in checkpatch.
> > > 
> > > tested:
> > > WARNING: 'default n' is the default value, no need to write it explicitly.
> > > +       default n
> > 
> > I don't think this is reasonable as there are
> > several uses like:
> > 
> > 		default y
> > 		default n if <foo>
> > 
> > For instance:
> > 
> > arch/alpha/Kconfig-config ALPHA_WTINT
> > arch/alpha/Kconfig-     bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
> > arch/alpha/Kconfig-     default y if ALPHA_QEMU
> > arch/alpha/Kconfig:     default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
> > arch/alpha/Kconfig:     default n if !ALPHA_SRM && !ALPHA_GENERIC
> 
> Hi,
> 
> 
> I've sent similar patch in 2016, my version won't complain about these.
> 
> https://lkml.org/lkml/2016/4/22/580

Hi again.

https://lore.kernel.org/lkml/1461259011.1918.23.camel@perches.com/

I would prefer a generic solution that also handles the
quoted use.

$ git grep -P 'default\s*\"[ynm]"' -- '*/Kconfig*'
arch/mips/Kconfig:      default "y"
arch/mips/Kconfig:      default "y"
arch/mips/Kconfig:      default "y"
arch/mips/Kconfig:      default "y"
arch/mips/cavium-octeon/Kconfig:        default "n"
arch/mips/cavium-octeon/Kconfig:        default "y"
arch/mips/cavium-octeon/Kconfig:        default "y"
arch/mips/cavium-octeon/Kconfig:        default "y"
arch/mips/cavium-octeon/Kconfig:        default "y"
arch/mips/cavium-octeon/Kconfig:        default "y"
arch/mips/cavium-octeon/Kconfig:        default "y"
arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
arch/powerpc/Kconfig:   default "n"
drivers/auxdisplay/Kconfig:     default "n"
drivers/crypto/Kconfig: default "m"
drivers/rapidio/devices/Kconfig:        default "n"

or maybe 2 separate patches.

And the "default y" case and probably the
"default \!?EXPERT" is or should be generally
discouraged.  Especially for drivers.

https://lore.kernel.org/lkml/CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com/


