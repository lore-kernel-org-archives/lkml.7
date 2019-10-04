Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCD5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02C3222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zUQo7FHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbfJDU3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:29:31 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34606 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJDU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:29:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x94KSbHr006459;
        Fri, 4 Oct 2019 15:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570220917;
        bh=32Jj9WZLpQ09yNXSnafvUQE3mxWhvizY9PFIVb96fhg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zUQo7FHd4gpuCGepeufrFeQc4CCNgSI9NX1m9RRQefLoCM4NuofDhU0NifGLixzxp
         iqx2NTERXFg4P83jvcJKClGBPuMyGuZgoSYZn+Tmvs5E/BkBY9UDPjNyZ56XsF3j0p
         N9KWzHYWJiaNNzeEVslZyXPgWE2l5aCOZaFMbBcg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x94KSbd7044686
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Oct 2019 15:28:37 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 4 Oct
 2019 15:28:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 4 Oct 2019 15:28:36 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94KSaSp069852;
        Fri, 4 Oct 2019 15:28:36 -0500
Subject: Re: [PATCH] ASoC: tas2770: Fix snd_soc_update_bits error handling
To:     Mark Brown <broonie@kernel.org>
CC:     <shifu0704@thundersoft.com>, <alsa-devel@alsa-project.org>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <navada@ti.com>, <perex@perex.cz>, <tiwai@suse.com>
References: <20191004202245.22855-1-dmurphy@ti.com>
 <20191004202651.GH4866@sirena.co.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bbfb63bb-890f-9dc6-5bd1-1a0c18136306@ti.com>
Date:   Fri, 4 Oct 2019 15:30:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004202651.GH4866@sirena.co.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 10/4/19 3:26 PM, Mark Brown wrote:
> On Fri, Oct 04, 2019 at 03:22:45PM -0500, Dan Murphy wrote:
>
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -395,6 +395,7 @@ CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
>>   CONFIG_SND_SOC_OMAP_HDMI=m
>>   CONFIG_SND_SOC_CPCAP=m
>>   CONFIG_SND_SOC_TLV320AIC23_I2C=m
>> +CONFIG_SND_SOC_TAS2770=m
>>   CONFIG_SND_SIMPLE_CARD=m
>>   CONFIG_SND_AUDIO_GRAPH_CARD=m
>>   CONFIG_HID_GENERIC=m
> This is unrelated and shouldn't be here.

This is true I added it for test.  I also found another instance I missed.

Dan

