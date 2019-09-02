Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 06:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D72820820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 06:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBwnMP+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfIBGXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 02:23:10 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:35526 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbfIBGXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 02:23:09 -0400
Received: by mail-wr1-f43.google.com with SMTP id g7so12703319wrx.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 23:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GXDQLzey5eVaH3nv6gKWbG5J2SJ2qpME5x9rf2oPD3I=;
        b=kBwnMP+ONhB7ElGFyoORX2b0oURt0/dKqqr5+U+YBZKHjonzdLnbHm5hB/r+nB8nPM
         mgKOtNkOPeBc7haAzOJ+KK6MVAL3VO6Og4lQlDxaLLC/3J0D/ZgVqG/YKchBpAmu+Ps6
         8Jox4PJ5bKlMX8eb9KZpzVcGnZ3plNbKC98oVZffGGvfzQ6tWYcgIXljghLah31oLmKp
         rcqSKRhMz4YOoUKyfr0ZkE8wuDZqdZNdsYsj9NXw2IvmpwTLa6GqZqAucdhvH6kqYMYZ
         auNFCTZ3bCNq2oZEtUTlraGoIMz2ILzrYnLWduc3RUgKbIOkuHSDmZobeQzVMNpfd9eT
         YjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXDQLzey5eVaH3nv6gKWbG5J2SJ2qpME5x9rf2oPD3I=;
        b=n0BNfVfQMybkBEE+Gi6AjSC10BKcjNjr77OXuZO9oBZMR4VzXc3uAfClLqwjCaPjfW
         hM3gZUZeXeXi2V3smzCyFPUqD/St7K2SLhYvGfgP6minYCToSNhAIb3sSFqXHHCZMR8Q
         g4zTbE3FmvRm9S5Rdu3k8QDVzcX+ql2lLfgYTXj0V0yBS4WBS4xIW8qyZympmWVO8eYD
         7yKgvtmIx2g4kMa7kwIpEYmi76TKRyBatlGbO04QLf5nLOoDKpoD0pl19MpJVKYLqZrD
         ah8yrH6ufFj3zasPMWr/CBWYGQHxkCctZTTXumsGH6ftqxHcyrvxia5PlacS1N4cvi8h
         kJGQ==
X-Gm-Message-State: APjAAAXe1X1J5OkduDj+/XdYXWHnAirtshtE+CbuZji+kmdYOSbNLeex
        uZI22BYaWRknHnIS/jn7tH92oA==
X-Google-Smtp-Source: APXvYqwd5B1+mNZiCUdsAOpexzFqYG8beIuRWZhpUTVmnR2EtR8Ns3q0MBNTR/7EMMBAtVeoAOgVLQ==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr8643502wrr.55.1567405386975;
        Sun, 01 Sep 2019 23:23:06 -0700 (PDT)
Received: from [192.168.1.6] (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id w13sm32060900wre.44.2019.09.01.23.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 23:23:06 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY
 bindings
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robh@kernel.org, andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
 <20190223165218.GB572@tuxbook-pro>
 <6dc0957d-5806-7643-4454-966015865d38@linaro.org>
 <5d694878.1c69fb81.5f13b.ec4f@mx.google.com>
 <20190830164520.GK26807@tuxbook-pro>
 <5d696ad2.1c69fb81.977ea.39e5@mx.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <f3584f38-dabc-7e7a-d1cb-84c80ed26215@linaro.org>
Date:   Mon, 2 Sep 2019 08:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5d696ad2.1c69fb81.977ea.39e5@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/19 20:28, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2019-08-30 09:45:20)
>> On Fri 30 Aug 09:01 PDT 2019, Stephen Boyd wrote:
>>
>>> Quoting Jorge Ramirez (2019-08-29 00:03:48)
>>>> On 2/23/19 17:52, Bjorn Andersson wrote:
>>>>> On Thu 07 Feb 03:17 PST 2019, Jorge Ramirez-Ortiz wrote:
>>>>>> +
>>>>>> +Required child nodes:
>>>>>> +
>>>>>> +- usb connector node as defined in bindings/connector/usb-connector.txt
>>>>>> +  containing the property vbus-supply.
>>>>>> +
>>>>>> +Example:
>>>>>> +
>>>>>> +usb3_phy: usb3-phy@78000 {
>>>>>> +    compatible = "qcom,snps-usb-ssphy";
>>>>>> +    reg = <0x78000 0x400>;
>>>>>> +    #phy-cells = <0>;
>>>>>> +    clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
>>>>>> +             <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>>>>>> +             <&gcc GCC_USB3_PHY_PIPE_CLK>;
>>>>>> +    clock-names = "ref", "phy", "pipe";
>>>>>> +    resets = <&gcc GCC_USB3_PHY_BCR>,
>>>>>> +             <&gcc GCC_USB3PHY_PHY_BCR>;
>>>>>> +    reset-names = "com", "phy";
>>>>>> +    vdd-supply = <&vreg_l3_1p05>;
>>>>>> +    vdda1p8-supply = <&vreg_l5_1p8>;
>>>>>> +    usb3_c_connector: usb3-c-connector {
>>>
>>> Node name should be 'connector', not usb3-c-connector.
>>>
>>
>> It probably has to be usb-c-connector, because we have a
>> micro-usb-connector on the same board.
> 
> Ok. Or connector@1 and connector@2? Our toplevel node container story is
> sort of sad because we have to play tricks with node names. But in the
> example, just connector I presume? 
> 
>>
>>>>>
>>>>> The USB-C connector is attached both to the HS and SS PHYs, so I think
>>>>> you should represent this external to this node and use of_graph to
>>>>> query it.
>>>>
>>>> but AFAICS we wont be able to retrieve the vbux-supply from an external
>>>> node (that interface does not exist).
>>>>
>>>> rob, do you have a suggestion?
>>>
>>> Shouldn't the vbus supply be in the phy? Or is this a situation where
>>> the phy itself doesn't have the vbus supply going to it because the PMIC
>>> gets in the way and handles the vbus for the connector by having the SoC
>>> communicate with the PMIC about when to turn the vbus on and off, etc?
>>>
>>
>> That's correct, the VBUS comes out of the PMIC and goes directly to the
>> connector.
>>
>> The additional complicating factor here is that the connector is wired
>> to a USB2 phy as well, so we need to wire up detection and vbus control
>> to both of them - but I think this will be fine, if we can only figure
>> out a sane way of getting hold of the vbus-supply.
>>
> 
> Does it really matter to describe this situation though? Maybe it's
> simpler to throw the vbus supply into the phy and control it from the
> phy driver, even if it never really goes there. Or put it into the
> toplevel usb controller?
> 
that would work for me - the connector definition seemed a better way to
explain the connectivity but since we cant retrieve the supply from the
external node is not of much functional use.

but please let me know how to proceed. shall I add the supply back to
the phy?
