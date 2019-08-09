Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358ECC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE29C2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405629AbfHIGYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:24:33 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27684 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405510AbfHIGYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:24:32 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 4WJWT/wn23UaX1GruXfR9JWONyV8gpdACAqNbsaU56BfyDoKB9oqw0TBvKTRWDSJtM45HNXvmR
 PCny3sTrieA/QzIbhiw9MNXvBxe+Q3d6fZ9F9ztirfIQNviUe2I8d+9+zwFdZqiWwqzUZTvgVO
 SOunDtl8u4x9hkFsVFCpplWx/2NHJqeigh8IaT0yHgODbEkhJ7dQHglbndmI9BcsoLP/equ0+t
 ZCbCvESXz5Pb6xcRGdrbuxWk8mqpkmBvWCOVGS0MjunxqdHRfA4q/himzCT8vJtHhl/2XoKovZ
 HMw=
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="43015337"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Aug 2019 23:24:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Aug 2019 23:24:27 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 8 Aug 2019 23:24:27 -0700
Date:   Fri, 9 Aug 2019 08:23:22 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>,
        "Nicolas Ferre - M43238" <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Message-ID: <20190809062322.syuieymdqjs4e7lh@M43218.corp.atmel.com>
Mail-Followup-To: Adrian Hunter <adrian.hunter@intel.com>,
        Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
 <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
 <04fd74c3-a828-1064-b77b-f3de07a26190@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <04fd74c3-a828-1064-b77b-f3de07a26190@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:57:30PM +0300, Adrian Hunter wrote:
> On 8/08/19 3:42 PM, Ludovic Desroches wrote:
> > On Thu, Aug 08, 2019 at 10:35:43AM +0200, Eugen Hristev - M18282 wrote:
> >> From: Eugen Hristev <eugen.hristev@microchip.com>
> >>
> >> Add mmc capabilities for SDMMC0 for this board.
> >> With this enabled, eMMC connected card is detected as:
> >>
> >> mmc0: new DDR MMC card at address 0001
> >>
> >> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > 
> > I am interested to have the some insights about the use of sd-uhs-*
> > properties.
> > 
> > Our IP can't deal with 1V8 by itself. It has a 1V8SEL signal which can
> > be used as the logic control input of a mux. So even if the IP claims
> > to support UHS modes, it depends on the board.
> > 
> > Are the sd-uhs-* properties a way to deal with this? I tend to think no
> > as sdhci_setup_host() will set the caps depending on the content of the
> > capabilities register. Do we have to use the SDHCI_QUIRK_MISSING_CAPS
> > quirk or sdhci-caps/sdhci-caps-mask?
> 
> There is "no-1-8-v" which it looks like sdhci-of-at91.c already supports:
> 
>   sdhci_at91_probe() -> sdhci_get_of_property() -> sdhci_get_property()
> 
>     	if (device_property_present(dev, "no-1-8-v"))
> 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> 

Right, I forgot this property. Thanks.

Eugen, do you see cases we can't cover with this property?

Regards

Ludovic

> 
> > 
> > Regards
> > 
> > Ludovic
> > 
> >> ---
> >>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> >> index 149e539..194b3a3 100644
> >> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> >> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> >> @@ -54,6 +54,7 @@
> >>  
> >>  		sdmmc0: sdio-host@a0000000 {
> >>  			bus-width = <8>;
> >> +			mmc-ddr-3_3v;
> >>  			pinctrl-names = "default";
> >>  			pinctrl-0 = <&pinctrl_sdmmc0_default>;
> >>  			status = "okay";
> >> -- 
> >> 2.7.4
> >>
> > 
> 
