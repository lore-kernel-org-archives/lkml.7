Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA9C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E99C2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfHHM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:58:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:47543 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfHHM6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:58:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 05:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="182585442"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2019 05:58:36 -0700
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
To:     Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
 <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <04fd74c3-a828-1064-b77b-f3de07a26190@intel.com>
Date:   Thu, 8 Aug 2019 15:57:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/08/19 3:42 PM, Ludovic Desroches wrote:
> On Thu, Aug 08, 2019 at 10:35:43AM +0200, Eugen Hristev - M18282 wrote:
>> From: Eugen Hristev <eugen.hristev@microchip.com>
>>
>> Add mmc capabilities for SDMMC0 for this board.
>> With this enabled, eMMC connected card is detected as:
>>
>> mmc0: new DDR MMC card at address 0001
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> I am interested to have the some insights about the use of sd-uhs-*
> properties.
> 
> Our IP can't deal with 1V8 by itself. It has a 1V8SEL signal which can
> be used as the logic control input of a mux. So even if the IP claims
> to support UHS modes, it depends on the board.
> 
> Are the sd-uhs-* properties a way to deal with this? I tend to think no
> as sdhci_setup_host() will set the caps depending on the content of the
> capabilities register. Do we have to use the SDHCI_QUIRK_MISSING_CAPS
> quirk or sdhci-caps/sdhci-caps-mask?

There is "no-1-8-v" which it looks like sdhci-of-at91.c already supports:

  sdhci_at91_probe() -> sdhci_get_of_property() -> sdhci_get_property()

    	if (device_property_present(dev, "no-1-8-v"))
		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;


> 
> Regards
> 
> Ludovic
> 
>> ---
>>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
>> index 149e539..194b3a3 100644
>> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
>> @@ -54,6 +54,7 @@
>>  
>>  		sdmmc0: sdio-host@a0000000 {
>>  			bus-width = <8>;
>> +			mmc-ddr-3_3v;
>>  			pinctrl-names = "default";
>>  			pinctrl-0 = <&pinctrl_sdmmc0_default>;
>>  			status = "okay";
>> -- 
>> 2.7.4
>>
> 

