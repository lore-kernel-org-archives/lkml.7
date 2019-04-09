Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3E6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFA8218EA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxYqx189"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDIK15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:27:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35185 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfDIK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:27:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id u21so11925473lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VMrK8jUpoqwWSX9soRdD0cY7VS6A2f28uwVwtbpC+og=;
        b=rxYqx189cdsCWpQTRBHyApiyztz8ZJSDLLwGP/VYH/od7HTtxQ0CjMW4ZI0Cz/LUWf
         S8UvgLMKyJS4IPwcwTrqOfhx+tvsRQihqEW2le67wF2TmzSXPzbN25GT9qj703akmV+B
         X0geAV8+3lBtegvYZsBNyef3DxZixtQN/gt204CujXeEUWrgRDQa5p1ZMN9SyCylb7br
         wLwmCiZAKN9GxewNUdZtzqtOYux2bOrP7NmDpFh/Y3kbE2VbjaEcyMuu5Xx8bJvMEW0Y
         Y1V6DSVuXQW11MVHwyOozCkpvP52OHq7+aO4DU4s97DZWhYvVUtiEg2VouKA0trOQFeZ
         7LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VMrK8jUpoqwWSX9soRdD0cY7VS6A2f28uwVwtbpC+og=;
        b=M0NSURH4uv2DHLaxsFmvezO4/23DG87HUlxdGWoTrqWlO1EXa4Leip3fXpVebQHASk
         gj2BDjl3ATdAxdT/4HrtC0FsY1KTy0zdls2tqLN8DCBSQE1ncHnb2rPlfJtTSgzbAH4l
         P5sm0fiLJYbE0AsymmPKfjXEN8S1tusbVsHRnOjtV1lvqssueKWc9uSPkDy0PFG8tMsi
         /m2QODDs+z9vgUaNrryFxKBz6zAhzeVuQj5H1+dSBU3TWnJ+0o86S5KwfmL70dMqwxp0
         ZHzSln3zHvlTwI/Yca7O/MlNidoJ/LQ4w1fTyXwfM2WahAkGY9s8TiendVhOKWn9GUc3
         TM2Q==
X-Gm-Message-State: APjAAAVw29SkjWWqy57afb2ws4C/tt+ji67YExWD2juXZ4F0Jp1pJt2F
        rqjfRIlvsr70Nsz7cYJRjKd3pQ==
X-Google-Smtp-Source: APXvYqxroleK7cwH/l2guE/zR8S2tOVO1lQGmLWVbUFKICGW9dpnvmiWBFim89AtxWcKzes3oxqPEA==
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr19432360lfn.147.1554805673797;
        Tue, 09 Apr 2019 03:27:53 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y7sm6723919ljy.65.2019.04.09.03.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 03:27:52 -0700 (PDT)
Subject: Re: [PATCH 2/3] interconnect: qcom: Add QCS404 interconnect provider
 driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-3-georgi.djakov@linaro.org>
 <20190405145756.GN1843@tuxbook-pro>
 <0ca7862f-31ba-748a-945d-a925a40a16de@linaro.org>
 <20190409032714.GT1843@tuxbook-pro>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 mQINBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABtChHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+iQI+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH7kCDQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AYkCJQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <63aaf5f5-4750-f1e9-f82c-9fff3e6c9214@linaro.org>
Date:   Tue, 9 Apr 2019 13:27:49 +0300
MIME-Version: 1.0
In-Reply-To: <20190409032714.GT1843@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 4/9/19 06:27, Bjorn Andersson wrote:
> On Mon 08 Apr 07:33 PDT 2019, Georgi Djakov wrote:
>> On 4/5/19 17:57, Bjorn Andersson wrote:
>>> On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
>>> [..]
> [..]
>>>> diff --git a/drivers/interconnect/qcom/qcs404_ids.h b/drivers/interconnect/qcom/qcs404_ids.h
>>>
>>> You use these defines in the driver, so I think this file should be the
>>> one in include/dt-bindings...
>>
>> The ids in this header are in a single global namespace in order to
>> build the internal topology and could be used for drivers that support
>> only platform data (although not sure if there would be any).
>>
> 
> As you say these numbers could be used by drivers on non-DT enabled
> platforms, but for that this include file should be in
> include/linux/interconnect. That said, there are no such Qualcomm
> platforms, so these numbers will only ever be used internally in the
> qcs404.c provider, so it would be better to just define them in that
> file - to remove the risk of confusion.

Agreed, will put them in the same file.

>>>
>>> [..]
>>>> diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h
>>>
>>
>> These header is using per NoC local ids and should be used on DT enabled
>> platforms.
>>
> 
> I had missed that you implemented support for xlating NoC-specific ids,
> so this makes sense now, nice. I presume we won't ever include files in
> a way where these defines collide - so this looks good.
Thanks for the review!
Georgi
