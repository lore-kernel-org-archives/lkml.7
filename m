Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9FDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AA82084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L6HV+2kf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LncSy2D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDIKPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:15:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDIKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:15:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 425A9612F1; Tue,  9 Apr 2019 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554804928;
        bh=/cIFa/hgUk6c6jyP+25E9qw2fXeohkvjUQSHAa7DePg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L6HV+2kfMO7b6sU4xDzYfOED5svsu4Oka9DHwCgn4xMHznWDOmmA7cnM/Cmo8DKm+
         FH+TC70XCdBj9TkvbawV9GajSNodMWIubBfHlQaTABU6QtXctxf6+L5/l5qZuHy8X8
         XtrS4A8grLZxY5+Pue8cL+WMPmYAIf1OOh29iteQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 71ADB60E5A;
        Tue,  9 Apr 2019 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554804925;
        bh=/cIFa/hgUk6c6jyP+25E9qw2fXeohkvjUQSHAa7DePg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LncSy2D/D7LFWiecijohyGoYpARqc9BQwXKEpgTub1XJRwBDuRpHLDkg9krZQgCRZ
         wMTofTmXT1QHsJt91IvDc9AOtxbpK5mgn1/FbnWxWI5rKVnABq6Q8v2Y2vRqEMYusB
         MyRqGoIs+d2xEKJx+cGQLvUwhAOcSkB/UmPva9YM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Apr 2019 18:15:25 +0800
From:   Rocky Liao <rjliao@codeaurora.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        MSM <linux-arm-msm@vger.kernel.org>, bgodavar@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: bluetooth: Add device property
 nvm-postfix for QCA6174
In-Reply-To: <535c74d4-00b1-eef2-578a-8807f4b9f640@free.fr>
References: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
 <535c74d4-00b1-eef2-578a-8807f4b9f640@free.fr>
Message-ID: <319cbb5f23ed3d9f1ae77c697001378d@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-04 20:32, Marc Gonzalez wrote:
> +robh
> 
> On 04/04/2019 11:08, Rocky Liao wrote:
> 
>> This patchs patch adds an optional device property nvm-postfix to 
>> allow the
>> driver to load customized nvm file based on this property
> 
> While text /before/ is indeed called a "prefix", text /after/ is not a
> "postfix",
> but a "suffix".
> 
> 
>>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 824c0e2..70cda4b 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -16,6 +16,7 @@ Optional properties for compatible string 
>> qcom,qca6174-bt:
>> 
>>   - enable-gpios: gpio specifier used to enable chip
>>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> + - nvm-postfix: nvm file postfix to load customized nvm file
> 
> The device tree is supposed to describe hardware.
> 
> The name of which file to load can hardly be considered part of the HW.
> 
> Possible solutions:
> 1) derive the file name from the compatible string
> 2) pass the name as a module parameter
> 3) something else
> 
> 
>> @@ -39,6 +40,7 @@ serial@7570000 {
>> 
>>  		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>>  		clocks = <&divclk4>;
>> +		nvm-postfix = "i2s";
>>  	};
>>  };
> 
> If one provides the entire suffix, including the underscore, then you 
> can
> simplify the code:
> 
> 	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x%s.bin",
> soc_ver, suffix ? suffix : "");
> 
> Regards
.
Hi Marc,

The major purpose for that property is about the BT audio bus type, can 
it be considered as part of the HW? If yes maybe we can use a property 
name "audio-bus" to reflect that.

If not then I will adopt the solution 1 to add a new compatible string 
"{ .compatible = "qcom,qca6174-bt-i2s" }" and load specific nvm for this 
compatible string, please feel free to let me know if any other 
concerns.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
