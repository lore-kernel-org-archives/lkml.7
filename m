Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB20CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823AD20640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTeLh8M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392073AbfJWNj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:39:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50344 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391615AbfJWNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:39:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id q13so11239629wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5T/MoSeXRvOkVox5hp0mSxwsnPbBwGiugOsPGPiVrU8=;
        b=WTeLh8M3lxNhpkfwYwFMHlcPhKIXYRT0p9/eP9nI54LGkFxOxk8DhkIGWl2q4NFVHl
         2EA7zM0yapmyaIetbOq2dc+BjjnvfxL7amqvYonpgiDt710d/mKF1L9uh5llf2Xh7rkf
         A/ErZoT5sPtCN32j+1ScJ1VEWQP6Top+BG8t/WSLVuz5qoKI6S3wodXQ23DNW/13PhOS
         xWu74+92vmUXgvyZQOGWtqJ887kZh+v27wvQBDhdBSXH5s4vmkQNt//dTxba6fU3beq3
         gkUqqRwzx11uv0fudpX/lrYtz17W3mVa76N7wLtRmXGjUD86E43D8Ji0wkD6ZLiOhUwY
         YWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5T/MoSeXRvOkVox5hp0mSxwsnPbBwGiugOsPGPiVrU8=;
        b=ELXh89ZWYyC90deRHq1sr40her/kQxMx23OfiCwjttS5XplKrlg/725/2w1ognlj0n
         H3lAkvKk7ep/4uayLQb4NmmuH0af6oPork3oSfk/45p55urednrRDGHIurYV7Nw5PGUZ
         ZjaJit/2lUu9SHtrlOId0hyBocRwD+BtmAqPwTkPP3fZaIUf9lZil/4dmPmSVpkQx2vA
         QZwLnOpHs+Z1hSTHdYsbmnoM5C1UifDw70ZvVMBhTl/9WVXpdGN6JV0ePlcr0llItjRD
         AkvH3XhqOOlY7M4+8CPqSDMWtsr8G6F/pMw2iVukCmfzWPZf04s7im6+tR/CNC+lyDp1
         TebA==
X-Gm-Message-State: APjAAAWsm0X/OIumqaF34aZnfjOZrWxNoz0xFjVAGXGv/RuOmSTt6e0z
        vBcrRvV5/M50DtFD0XcrzH03dw==
X-Google-Smtp-Source: APXvYqyuEJaMFICfXNABHTPXz7GkIecaJLIiU1WeYhAN+gYZFSeibrU2kiSo91fXlKup1iWBQ4gD9A==
X-Received: by 2002:a1c:9c0c:: with SMTP id f12mr7972419wme.133.1571837963549;
        Wed, 23 Oct 2019 06:39:23 -0700 (PDT)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id b5sm19095690wmj.18.2019.10.23.06.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 06:39:22 -0700 (PDT)
Subject: Re: [PATCH 5/5] ARM: dts: qcom: msm8974: add interconnect nodes
To:     Brian Masney <masneyb@onstation.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191013080804.10231-1-masneyb@onstation.org>
 <20191013080804.10231-6-masneyb@onstation.org>
 <d154b0c6-fc39-bebc-d1b5-cc179fb6055d@linaro.org>
 <20191023124753.GA14218@onstation.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c26159f5-e6fe-07f1-51b3-50b72b258846@linaro.org>
Date:   Wed, 23 Oct 2019 16:39:21 +0300
MIME-Version: 1.0
In-Reply-To: <20191023124753.GA14218@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.19 г. 15:47 ч., Brian Masney wrote:
> On Wed, Oct 23, 2019 at 02:50:19PM +0300, Georgi Djakov wrote:
>> On 13.10.19 г. 11:08 ч., Brian Masney wrote:
>>> Add interconnect nodes that's needed to support bus scaling.
>>>
>>> Signed-off-by: Brian Masney <masneyb@onstation.org>
>>> ---
>>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 60 +++++++++++++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
>>> @@ -1152,6 +1207,11 @@
>>>  				              "core",
>>>  				              "vsync";
>>>  
>>> +				interconnects = <&mmssnoc MNOC_MAS_GRAPHICS_3D &bimc BIMC_SLV_EBI_CH0>,
>>> +				                <&ocmemnoc OCMEM_VNOC_MAS_GFX3D &ocmemnoc OCMEM_SLV_OCMEM>;
>>
>> Who will be the requesting bandwidth to DDR and ocmem? Is it the display or GPU
>> or both? The above seem like GPU-related interconnects, so maybe these
>> properties should be in the GPU DT node.
> 
> The display is what currently requests the interconnect path,
> specifically mdp5_setup_interconnect() in
> drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c. The Freedreno GPU bindings
> currently don't have interconnect support. Maybe this is something that
> I should add to that driver as well?

The "mdp0-mem" and "mdp1-mem" paths mentioned in the mdp5_kms.c are the two
interconnects between the display and DDR memory. There is actually a patch [1]
to add to GPU bindings, but it seems that we missed to pick it up.

> 
>>> +				interconnect-names = "mdp0-mem",
>>> +				                     "mdp1-mem";
>>
>> As the second path is not to DDR, but to ocmem, it might be better to call it
>> something like "gpu-ocmem".
> 
> I used what mdp5_kms.c expected.

This is for the display and here [2] are some patches for the GPU. Not sure how
the NoCs are configured on 8974 by default, but if you notice any blue/black
screens, you may need to request bandwidth for display too.

Thanks,
Georgi

[1]
https://lore.kernel.org/r/1555703787-10897-1-git-send-email-jcrouse@codeaurora.org
[2] https://lore.kernel.org/r/20181220173026.3857-1-jcrouse@codeaurora.org

