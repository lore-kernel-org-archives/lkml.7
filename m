Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2234C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A993D21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfGDFs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:48:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16614 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725861AbfGDFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:48:27 -0400
X-UUID: 86e90e4136a24fdc803c254df76da0ab-20190704
X-UUID: 86e90e4136a24fdc803c254df76da0ab-20190704
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 531091066; Thu, 04 Jul 2019 13:48:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 4 Jul 2019 13:48:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 4 Jul 2019 13:48:03 +0800
Message-ID: <1562219283.6549.2.camel@mtkswgap22>
Subject: Re: [PATCH] checkpatch: avoid default n
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joe Perches <joe@perches.com>
CC:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Andy Whitcroft <apw@canonical.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 4 Jul 2019 13:48:03 +0800
In-Reply-To: <c8d5cc6171d2cff131e8600ac57e2eb441812617.camel@perches.com>
References: <20190703083031.2950-1-miles.chen@mediatek.com>
         <be8a97c15249ff8a613910db5792c5bcdc75333c.camel@perches.com>
         <1562144624.3550.1.camel@mtksdaap41>
         <c8d5cc6171d2cff131e8600ac57e2eb441812617.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 08:37 -0700, Joe Perches wrote:
> On Wed, 2019-07-03 at 17:03 +0800, Yingjoe Chen wrote:
> > On Wed, 2019-07-03 at 01:42 -0700, Joe Perches wrote:
> > > On Wed, 2019-07-03 at 16:30 +0800, Miles Chen wrote:
> > > > This change reports a warning when "default n" is used.
> > > > 
> > > > I have seen several "remove default n" patches, so I think
> > > > it might be helpful to add this test in checkpatch.
> > > > DEFAULT_VALUE_STYLE
> > > > tested:
> > > > WARNING: 'default n' is the default value, no need to write it explicitly.
> > > > +       default n
> > > 
> > > I don't think this is reasonable as there are
> > > several uses like:
> > > 
> > > 		default y
> > > 		default n if <foo>
> > > 
> > > For instance:
> > > 
> > > arch/alpha/Kconfig-config ALPHA_WTINT
> > > arch/alpha/Kconfig-     bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
> > > arch/alpha/Kconfig-     default y if ALPHA_QEMU
> > > arch/alpha/Kconfig:     default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
> > > arch/alpha/Kconfig:     default n if !ALPHA_SRM && !ALPHA_GENERIC
> > 
> > Hi,
> > 
> > 
> > I've sent similar patch in 2016, my version won't complain about these.
> > 
> > https://lkml.org/lkml/2016/4/22/580
> 
> Hi again.
> 
> https://lore.kernel.org/lkml/1461259011.1918.23.camel@perches.com/
> 
> I would prefer a generic solution that also handles the
> quoted use.
> 
> $ git grep -P 'default\s*\"[ynm]"' -- '*/Kconfig*'
> arch/mips/Kconfig:      default "y"
> arch/mips/Kconfig:      default "y"
> arch/mips/Kconfig:      default "y"
> arch/mips/Kconfig:      default "y"
> arch/mips/cavium-octeon/Kconfig:        default "n"
> arch/mips/cavium-octeon/Kconfig:        default "y"
> arch/mips/cavium-octeon/Kconfig:        default "y"
> arch/mips/cavium-octeon/Kconfig:        default "y"
> arch/mips/cavium-octeon/Kconfig:        default "y"
> arch/mips/cavium-octeon/Kconfig:        default "y"
> arch/mips/cavium-octeon/Kconfig:        default "y"
> arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
> arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
> arch/powerpc/Kconfig:   default "n"
> drivers/auxdisplay/Kconfig:     default "n"
> drivers/crypto/Kconfig: default "m"
> drivers/rapidio/devices/Kconfig:        default "n"
> 
> or maybe 2 separate patches.
> 
> And the "default y" case and probably the
> "default \!?EXPERT" is or should be generally
> discouraged.  Especially for drivers.
> 
> https://lore.kernel.org/lkml/CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com/
> 
> 
Thanks for your comment, I'll send another patch for these cases:
1. default "[ynm]"
2. default \!?EXPERT
3. default n$


