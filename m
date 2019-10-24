Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E472CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4B20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FM2nQuhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438207AbfJXI1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:27:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34732 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfJXI1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:27:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so19869001wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mm17BkOc25h13Mby6hFCXW3PUeV4hyrd6orfDcJCo64=;
        b=FM2nQuhqEHC5AtVx/Atcs/KmjN9GidOdQUdWc0fquAJ4AIkE9OhBpZfBhwmt+L62d9
         5kjVegAA6W3iU7uZJd+XQIh/YNIWVenayIvbvVgMUiybaDvLhFEtgQgNpWbnTDnGuNkN
         jhVNzvREJ+tiPEfyTyDF2GiVdv3xk4jKbp4v+l3o8oAPvEnOzrOisaO+pPFQM9FsXOSS
         BKs58eHhZv11IhkDZQx2wQ974lIf8sPQOUb/Rj2XMR6C7c6taCX9tJ7tmib8KNplJy+a
         yvNBUtxCN8e74fS6UOFPdIlmAHdVLU80gWta+FQx77WAqsCaJihm96bstIRVHOzm5COF
         yjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mm17BkOc25h13Mby6hFCXW3PUeV4hyrd6orfDcJCo64=;
        b=XUnyPn9bknC/N6VYzjrrVW3l38dfSKv3wbyd6lyW82hf7SdlXz9EcfkWobWnhAdt/U
         S8s/iVFh/0gUx4VK/4filxJLB+ANZO+XEb4Qk8LSPa+iWig4+ddh7VCZW02eurHuFrrp
         HJJDmq3pA2g/HPjd3Wn2rT1Ccj81i2YCeOzk6dI0kaWMo2VLR/sRWtqHQKnV0ur3md5i
         FSAGrf61Bvr2VqZxhCpEzhH+T3+NorsaEqI5BqscO4MiIb7f7uesPDCiuivMt/P3mUtE
         CbZBRVYQlxj3rqCZDpVKYvmA0a4jcTKAW5A1m/ulKD/kA1udn2XKClT92S1YMaaV8dtZ
         T4cA==
X-Gm-Message-State: APjAAAXTGTw93qpg/D3YyWnb0+idOjk06b+G0Dh/ckha2UbrgjTFiTBe
        wD/zYBcJJSIb7vEVr4avZqGbow==
X-Google-Smtp-Source: APXvYqxJjkvfXJJpszKYABlj+Cxk0Xu169hSNKRrK3KCT1UvqEPCoE4AIymOmMJ+q88rM3pV+SFBJw==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr2639402wrs.366.1571905641248;
        Thu, 24 Oct 2019 01:27:21 -0700 (PDT)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id u187sm704735wme.15.2019.10.24.01.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 01:27:20 -0700 (PDT)
Subject: Re: [PATCH 5/5] ARM: dts: qcom: msm8974: add interconnect nodes
To:     Brian Masney <masneyb@onstation.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org
References: <20191013080804.10231-1-masneyb@onstation.org>
 <20191013080804.10231-6-masneyb@onstation.org>
 <d154b0c6-fc39-bebc-d1b5-cc179fb6055d@linaro.org>
 <20191023124753.GA14218@onstation.org>
 <c26159f5-e6fe-07f1-51b3-50b72b258846@linaro.org>
 <20191024070730.GA19974@onstation.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5e1149ae-9539-ec8b-6371-50c87575057a@linaro.org>
Date:   Thu, 24 Oct 2019 11:27:18 +0300
MIME-Version: 1.0
In-Reply-To: <20191024070730.GA19974@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.19 г. 10:07 ч., Brian Masney wrote:
> On Wed, Oct 23, 2019 at 04:39:21PM +0300, Georgi Djakov wrote:
>> On 23.10.19 г. 15:47 ч., Brian Masney wrote:
>>> On Wed, Oct 23, 2019 at 02:50:19PM +0300, Georgi Djakov wrote:
>>>> On 13.10.19 г. 11:08 ч., Brian Masney wrote:
>>>>> Add interconnect nodes that's needed to support bus scaling.
>>>>>
>>>>> Signed-off-by: Brian Masney <masneyb@onstation.org>
>>>>> ---
>>>>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 60 +++++++++++++++++++++++++++++
>>>>>  1 file changed, 60 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
>>>>> @@ -1152,6 +1207,11 @@
>>>>>  				              "core",
>>>>>  				              "vsync";
>>>>>  
>>>>> +				interconnects = <&mmssnoc MNOC_MAS_GRAPHICS_3D &bimc BIMC_SLV_EBI_CH0>,
>>>>> +				                <&ocmemnoc OCMEM_VNOC_MAS_GFX3D &ocmemnoc OCMEM_SLV_OCMEM>;
>>>>
>>>> Who will be the requesting bandwidth to DDR and ocmem? Is it the display or GPU
>>>> or both? The above seem like GPU-related interconnects, so maybe these
>>>> properties should be in the GPU DT node.
>>>
>>> The display is what currently requests the interconnect path,
>>> specifically mdp5_setup_interconnect() in
>>> drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c. The Freedreno GPU bindings
>>> currently don't have interconnect support. Maybe this is something that
>>> I should add to that driver as well?
>>
>> The "mdp0-mem" and "mdp1-mem" paths mentioned in the mdp5_kms.c are the two
>> interconnects between the display and DDR memory.
> 
> OK, I see. Most of the interconnect paths in the downstream MSM 3.4
> sources are configured in device tree using the
> qcom,msm-bus,vectors-KBps property, which is what I was only looking at
> before. The interconnect path for the display is configured directly in
> code (drivers/video/msm/mdss/mdss_mdp.c) to setup a path between
> MSM_BUS_MASTER_MDP_PORT0 and MSM_BUS_SLAVE_EBI_CH0.

Correct!

> 
> In the upstream kernel, it looks like I'll need to
> 
>   1) add support for an optional second interconnect path for ocmem to
>      drivers/gpu/drm/msm/adreno/adreno_gpu.c.

Yes, just check if there is a "gpu-ocmem" path in DT and scale it when needed.

> 
>   2) add implementations of gpu_get_freq and gpu_get_freq to the
>      adreno_gpu_funcs struct in drivers/gpu/drm/msm/adreno/a3xx_gpu.c.
> 

Maybe, i am not very familiar with adreno stuff. It might be good to CC the
freedreno guys.

Thanks,
Georgi
