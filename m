Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8171C282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 03:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2E2173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 03:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="UzTyy/fB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r8m7Pdzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDFD0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 23:26:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56205 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbfDFD0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 23:26:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 58D232235B;
        Fri,  5 Apr 2019 23:26:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 05 Apr 2019 23:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=h
        LKi3ydf9q48vHRhDDM9IMS7TABn0TxD5EUZsVSGxCA=; b=UzTyy/fBJr+LGc2X3
        q7S2oxQxj/7ZyaGoknx8tPVch2frBHaBL/wSYPDN+6K+EL5bUzTXREVgzMIh/o9v
        ahurxbfyOe6cPZqx/Da+0JxDux6JusEkbQlEx7I/45R0Y6Wb5Kr2dDlV1wfZ0MEL
        HSVzYuwzXNBWPv/4hcMYNcPKBT3ValAWustiADReyUd9pF+eL9Bf58/FiecBDWZt
        WbfgRM8upxQCTZUv4Dpl7tvW2/XbKdYHe3u/nR0U+8KUp7pMjbogTpywhQ3vcBil
        s2Apx90mFLSAOkJdt80CZ2qZ7lJCyeaJx9eHALqlO4E8kWzzbXfEumqkCnjvHaXu
        QhrmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=hLKi3ydf9q48vHRhDDM9IMS7TABn0TxD5EUZsVSGx
        CA=; b=r8m7PdznX/9YBBonkmNRXM6FzrnMGaNX4th+t94VGTaF62j0FpRVnJYkw
        XVBRov/DW7SNw5MQfc7vV4Rw6NXQhEhRlOeBSyYZelYsqjcHHkexnYIb9uatDI4w
        xpV7OErBsy/MDZEvk62weosDTPq9PcresvBXBRO+z9VNtfoux+Q2i9d8G38GHVw5
        KRnQ7GGqFhpAtl5/k2DF7ID1Y4Nn2Ltdf13cxM7MJ1dXJMBheA5BPnDMMMoblXag
        3DQUAabavkCbWcDpG2wtedvsh456PX0CnhXvPKTYyWdnSmYNnADmfwlTbjkie74D
        PWfmJ1oZhyp28hXzU6Esvl/RNp1hA==
X-ME-Sender: <xms:XhyoXFIM7wMHBtvuiJPP4HpsH18_WumcepKffzUJODcM_S66vx2tmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdekgdejjeculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeej
    necuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllh
    grnhgurdhorhhgqeenucfkphepjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptd
X-ME-Proxy: <xmx:XhyoXGDewuu9dW919-sBCr1zU1O96ZNKEHvfJtkt5W9uw_sJas8g3A>
    <xmx:XhyoXLT_bg6dTg1VfPBqwSc5gv2dqRIAW6eJpkdKivaau4PIWTAvrA>
    <xmx:XhyoXIdnkb1G9TkHomjBmm6aFoI1nGEd9h613rUIVi8-X_-eFu-2pA>
    <xmx:XxyoXFwPS5mjO0s63V65a3SDkEqsBjEaZ-DaKEUZIsP_UQmo6cQmnA>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0436010319;
        Fri,  5 Apr 2019 23:26:20 -0400 (EDT)
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190405102455.15311-1-tiny.windzz@gmail.com>
 <20190405102455.15311-3-tiny.windzz@gmail.com>
 <20190405145532.cstvbv3mxbzrmpxp@flea>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <5721bddc-4995-c38f-3f45-7a4589a1ccb5@sholland.org>
Date:   Fri, 5 Apr 2019 22:26:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190405145532.cstvbv3mxbzrmpxp@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 9:55 AM, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Apr 05, 2019 at 06:24:55AM -0400, Yangtao Li wrote:
>> Allwinner Process Voltage Scaling Tables defines the voltage and
>> frequency value  based on the speedbin blown in the efuse combination.
>> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
>> provide the OPP framework with required information.
>> This is used to determine the voltage and frequency value for each
>> OPP of operating-points-v2 table when it is parsed by the OPP framework.
>>
>> This change adds documentation for the DT bindings.
>> The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
>> with following parameters:
>> - nvmem-cells (NVMEM area containig the speedbin information)
>> - opp-supported-hw: A single 32 bit bitmap value,
>>   representing compatible HW:
>> 			0:      speedbin 0
>> 			1:      speedbin 1
>> 			2:      speedbin 2
>> 			3-31:   unused
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>> ---
>>  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 235 ++++++++++++++++++
>>  1 file changed, 235 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
>> new file mode 100644
>> index 000000000000..80201d4e5147
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
>> @@ -0,0 +1,235 @@
>> +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
>> +===================================
>> +
>> +For some SoCs, the CPU frequency subset and voltage value of each OPP
>> +varies based on the silicon variant in use. Allwinner Process Voltage
>> +Scaling Tables defines the voltage and frequency value  based on the
>> +speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
>> +reads the efuse value from the SoC to provide the OPP framework with
>> +required information.
>> +
>> +Required properties:
>> +--------------------
>> +In 'cpus' nodes:
>> +- operating-points-v2: Phandle to the operating-points-v2 table to use.
>> +
>> +In 'operating-points-v2' table:
>> +- compatible: Should be
>> +	- 'operating-points-v2-sunxi-cpu'.
>> +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>> +		efuse registers that has information about the
>> +		speedbin that is used to select the right frequency/voltage
>> +		value pair.
>> +		Please refer the for nvmem-cells
>> +		bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
>> +		and also examples below.
>> +
>> +In every OPP node:
>> +- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
>> +		    Bitmap:
>> +			0:	speedbin 0
>> +			1:	speedbin 1
>> +			2:	speedbin 2
>> +			3-31:	unused
> 
> I'm wondering if that's the right approach.
> 
> I guess we could also have three different OPP tables, and pass them
> all three through a phandle array, and have the kernel code select
> which one is relevant based on the SID content
> 
> Another option would be to use the OF_DYNAMIC code to fill
> operating-points-v2 at kernel boot, before (or when) cpufreq kicks in.
> 
> ATF could also do that work.

While ATF has code to read and parse the DTB (which it uses to set up the PMIC),
it's not really in a position to modify the DTB. For one thing, it only has
access to the DTB appended to u-boot, not any DTB loaded from disk. And for two,
that would add a significant amount of code, when ATF is already reaching its
size limits.

Cheers,
Samuel
