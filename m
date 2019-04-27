Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9325FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 05:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69902208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 05:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfD0F7Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 01:59:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42081 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfD0F7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 01:59:24 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id CA519CEEB7;
        Sat, 27 Apr 2019 08:07:33 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device property
 firmware-name for QCA6174
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL_JsqLnM4XqQTCT7VTUSmukujz0VHJoCbXMF2--RmTEx_LZww@mail.gmail.com>
Date:   Sat, 27 Apr 2019 07:59:21 +0200
Cc:     Rocky Liao <rjliao@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Thierry Escande <thierry.escande@linaro.org>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <60C7AC89-37B6-441C-9349-BCB15717EB2C@holtmann.org>
References: <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
 <1554888476-17560-1-git-send-email-rjliao@codeaurora.org>
 <A85D7982-E000-4A5F-9927-CA36E0BA60F2@holtmann.org>
 <7e0cf9ba98260309c43d9d6e63dead6c@codeaurora.org>
 <CAL_JsqLnM4XqQTCT7VTUSmukujz0VHJoCbXMF2--RmTEx_LZww@mail.gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>>>> This patch adds an optional device property "firmware-name" to allow
>>>> the
>>>> driver to load customized nvm firmware file based on this property.
>>>> 
>>>> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
>>>> ---
>>>> Changes in v3:
>>>> * added firmware-name instead of nvm-postfix to specify full firmware
>>>> name
>>>> ---
>>>> Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>> 
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>>>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>>>> index 824c0e2..2bcea50 100644
>>>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>>>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>>>> @@ -16,6 +16,7 @@ Optional properties for compatible string
>>>> qcom,qca6174-bt:
>>>> 
>>>> - enable-gpios: gpio specifier used to enable chip
>>>> - clocks: clock provided to the controller (SUSCLK_32KHZ)
>>>> + - firmware-name: specify the name of nvm firmware to load
>>>> 
>>>> Required properties for compatible string qcom,wcn3990-bt:
>>>> 
>>>> @@ -39,6 +40,7 @@ serial@7570000 {
>>>> 
>>>>             enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>>>>             clocks = <&divclk4>;
>>>> +            firmware-name = "nvm_00440302.bin";
>>>>     };
>>> 
>>> and how is this a firmware-name property. Wouldn’t this be more like
>>> nvm-file or something along these lines. This really needs to be
>>> cleared with Rob to pick the right property name.
>>> 
>>> Regards
>>> 
>>> Marcel
>> 
>> Hi Rob,
>> 
>> Are you OK to use a property name "nvm-file" or "firmware-nvm-file"?
>> Actually we have two firmware files, one is the patch file which is
>> common to all of the products, the other is the nvm file which is
>> customized. Using a "nvm-file" or "firmware-nvm-file" property name
>> would be more clear.
> 
> 'firmware-name' is the standard name for specifying firmware file names.

but it is not a firmware file, it is a NVM file. What happens if in the future they need a firmware file and a NVM file?

Regards

Marcel

