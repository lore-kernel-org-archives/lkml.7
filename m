Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70177C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514CF20873
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbfJCTmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:42:07 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49973 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbfJCTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:42:07 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B8B852010D;
        Thu,  3 Oct 2019 19:42:03 +0000 (UTC)
Date:   Thu, 3 Oct 2019 21:42:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen.Hristev@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, Nicolas.Ferre@microchip.com,
        ulf.hansson@linaro.org
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Message-ID: <20191003194203.GI575@piout.net>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
 <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
 <04fd74c3-a828-1064-b77b-f3de07a26190@intel.com>
 <20190809062322.syuieymdqjs4e7lh@M43218.corp.atmel.com>
 <fa0debbb-b84c-1f74-f8b8-8fdd7812aaee@microchip.com>
 <20190813065306.tqz57hqeiofofbnz@M43218.corp.atmel.com>
 <c2c355cd-b798-02de-0606-0f6442f6fdca@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c355cd-b798-02de-0606-0f6442f6fdca@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2019 10:24:52+0000, Eugen.Hristev@microchip.com wrote:
> 
> 
> On 13.08.2019 09:53, Ludovic Desroches wrote:
> > On Mon, Aug 12, 2019 at 03:38:34PM +0000, Eugen.Hristev@microchip.com wrote:
> >> On 09.08.2019 09:23, Ludovic Desroches wrote:
> >>> On Thu, Aug 08, 2019 at 03:57:30PM +0300, Adrian Hunter wrote:
> >>>> On 8/08/19 3:42 PM, Ludovic Desroches wrote:
> >>>>> On Thu, Aug 08, 2019 at 10:35:43AM +0200, Eugen Hristev - M18282 wrote:
> >>>>>> From: Eugen Hristev <eugen.hristev@microchip.com>
> >>>>>>
> >>>>>> Add mmc capabilities for SDMMC0 for this board.
> >>>>>> With this enabled, eMMC connected card is detected as:
> >>>>>>
> >>>>>> mmc0: new DDR MMC card at address 0001
> >>>>>>
> >>>>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >>>>> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> >>>>>
> >>>>> I am interested to have the some insights about the use of sd-uhs-*
> >>>>> properties.
> >>>>>
> >>>>> Our IP can't deal with 1V8 by itself. It has a 1V8SEL signal which can
> >>>>> be used as the logic control input of a mux. So even if the IP claims
> >>>>> to support UHS modes, it depends on the board.
> >>>>>
> >>>>> Are the sd-uhs-* properties a way to deal with this? I tend to think no
> >>>>> as sdhci_setup_host() will set the caps depending on the content of the
> >>>>> capabilities register. Do we have to use the SDHCI_QUIRK_MISSING_CAPS
> >>>>> quirk or sdhci-caps/sdhci-caps-mask?
> >>>>
> >>>> There is "no-1-8-v" which it looks like sdhci-of-at91.c already supports:
> >>>>
> >>>>     sdhci_at91_probe() -> sdhci_get_of_property() -> sdhci_get_property()
> >>>>
> >>>>       	if (device_property_present(dev, "no-1-8-v"))
> >>>> 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> >>>>
> >>>
> >>> Right, I forgot this property. Thanks.
> >>>
> >>> Eugen, do you see cases we can't cover with this property?
> >>
> >> Hi,
> >>
> >> For current requirements and driver support, this should be enough.
> >>
> >> I noticed one thing regarding SD-Cards, if I add property sd-uhs-sdr104
> >> the class 10 uhs1 cards are detected as SDR104 . Without this property
> >> they are detected as DDR50. Any idea why the difference ? The controller
> >> does not claim to have SDR104 support ?  We should add it ?
> > 
> > With the mainline, our tree or both? In our tree, SDR104 is removed from
> > the capabilities.
> > 
> > Ludovic
> > 
> 
> 
> Hello Alexandre,
> 
> Anything more needed regarding this patch ?
> 

I was not sure it was applicable, seeing the discussion. I'll apply it
now.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
