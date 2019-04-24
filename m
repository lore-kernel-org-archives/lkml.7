Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB964C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C472089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kTNUJUb1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mc+sMI++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfDXGTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:19:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57800 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDXGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:19:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF596604B4; Wed, 24 Apr 2019 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556086749;
        bh=jeU9IxH3FAZ0KXhH8CGQ3BhzHo2QVEmwt3E/zlUZB8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kTNUJUb17ubl+nY8uHcZM3iRs96L/mlCaX7OsEbpAnBWDTv2zcF2uLOvWFx2rV/ro
         QLTxSJ+LxTdfQOU/gFK/kjnfbwk8JOcau50zBBM1PF/IKI1qdbkPuRyt6w4dDXQM4/
         ukIeDTwvrtpr3aD6E1q00NHQIluN4Csh5oFij4as=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AE85A60712;
        Wed, 24 Apr 2019 06:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556086748;
        bh=jeU9IxH3FAZ0KXhH8CGQ3BhzHo2QVEmwt3E/zlUZB8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mc+sMI++KPhxUL2ihq+x9v/iu6KaDrAVw8I4gja5JS0gKc1cI7PpLCdEGDPla7f/N
         CMU4+IC38eEglXkH+Merf1vLTJLgvFcYyZkbCNoszO8sGp0AHpZEvwN4jcjiO2otv3
         fjaWDfrKio+tA/UkBp+Nq8FfDFtGVHz0fKxot8K8=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 24 Apr 2019 14:19:08 +0800
From:   Rocky Liao <rjliao@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        thierry.escande@linaro.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device property
 firmware-name for QCA6174
In-Reply-To: <A85D7982-E000-4A5F-9927-CA36E0BA60F2@holtmann.org>
References: <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
 <1554888476-17560-1-git-send-email-rjliao@codeaurora.org>
 <A85D7982-E000-4A5F-9927-CA36E0BA60F2@holtmann.org>
Message-ID: <7e0cf9ba98260309c43d9d6e63dead6c@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-24 01:06, Marcel Holtmann wrote:
> Hi Rocky,
> 
>> This patch adds an optional device property "firmware-name" to allow 
>> the
>> driver to load customized nvm firmware file based on this property.
>> 
>> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
>> ---
>> Changes in v3:
>>  * added firmware-name instead of nvm-postfix to specify full firmware 
>> name
>> ---
>> Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 824c0e2..2bcea50 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -16,6 +16,7 @@ Optional properties for compatible string 
>> qcom,qca6174-bt:
>> 
>>  - enable-gpios: gpio specifier used to enable chip
>>  - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> + - firmware-name: specify the name of nvm firmware to load
>> 
>> Required properties for compatible string qcom,wcn3990-bt:
>> 
>> @@ -39,6 +40,7 @@ serial@7570000 {
>> 
>> 		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>> 		clocks = <&divclk4>;
>> +		firmware-name = "nvm_00440302.bin";
>> 	};
> 
> and how is this a firmware-name property. Wouldn’t this be more like
> nvm-file or something along these lines. This really needs to be
> cleared with Rob to pick the right property name.
> 
> Regards
> 
> Marcel

Hi Rob,

Are you OK to use a property name "nvm-file" or "firmware-nvm-file"? 
Actually we have two firmware files, one is the patch file which is 
common to all of the products, the other is the nvm file which is 
customized. Using a "nvm-file" or "firmware-nvm-file" property name 
would be more clear.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
