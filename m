Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C48C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F6420652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GuHH2NYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfD3GiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:38:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45783 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfD3GiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:38:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so19536086wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 23:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mBIgwbzYmkgbhsO4N+I7kDrPR3sJoh79fVIbgSnCeDQ=;
        b=GuHH2NYJhfjGJwyv3eKUmddbs+NwlVoPBUQ6g4XbNyTIfA7LV44lPasCoVmrbOc1lA
         o0CP5Gg1GPuDRv1Kyt0PwgLvzmDt17MGVfznJfK2JgfG/EdNOkfqIMzvsdxdu6OfV4Ul
         H4jvi7EXAeTor5vxhMQ/DXmNZftZ1+n6Nm2VhMIpeBQx5reXVXjdSFIjZniX8mydQjjc
         q0FSCtLlqLaxg11dtdXIb+9IG8zKXRS/bTgZ7bSqrgAZWzQvczK0mXKWtFiJYV5UO6jh
         B0Ka2xDx/iBeit8A+aB8qkC5uBfJ3mqD5Whu8znjK2JBTHbY1e6XEO+GD0Y/BDlvESoK
         x+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mBIgwbzYmkgbhsO4N+I7kDrPR3sJoh79fVIbgSnCeDQ=;
        b=J+/rAZFdqaVvpdM9KmfxBDqkGnbRxHIMxXxGpoYvZF+QrtkXjy7v/TWQyB3kgrfboN
         ePk9FPxz6fjMLheyi2GWxP5V5SLB7MVd7yXzZnm/XSE7uz7rm2yt9Et949sINj2x6erA
         LfLfMK2QwJUPjnpxPtjuNnfIMxiAtjP50N7kOiRDJIMjluPOAk19l5KYu4BNIgmAcLRH
         TwJLlCr7uuSCxY7NIcZzjHvvxnP+SLtV3Srx36dicQs/zM+py85sUNAi9EyFnu6XXqW/
         UT0nqvS6/tF1kymEBlE2Gu39BP330vn1rwKrlHLBoSzbsCJ5Dc/uC0EMCRq8YKr6FKge
         eWbQ==
X-Gm-Message-State: APjAAAVvfuK0wqU8ksV+mhKFVVu6gm6GDFkDwi8iBorneXYJaKavMp+w
        MfwdRE8OQ12Y1SRcRhls1+91ew==
X-Google-Smtp-Source: APXvYqymYeEIEuBhAecoonvSwahyY44dv52RVC/Ac3Z8WNPqSu59fUyK/xQvi6hQJ1QB9v2pITNduQ==
X-Received: by 2002:adf:db0c:: with SMTP id s12mr4222632wri.184.1556606287158;
        Mon, 29 Apr 2019 23:38:07 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:379:8b00:1910:6694:7019:d3a? ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id j13sm30419810wrd.88.2019.04.29.23.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 23:38:06 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] dt-bindings: pinctrl: meson: Add drive-strength-uA
 property
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190418124758.24022-1-glaroque@baylibre.com>
 <20190418124758.24022-4-glaroque@baylibre.com>
 <CAFBinCD_qJw6-_zsnKFhsVHUHd2K2wJ3S9EsXGrPPxZ1SWn=uA@mail.gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <7608f385-d412-f8be-d11b-9023f9702ec3@baylibre.com>
Date:   Tue, 30 Apr 2019 08:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCD_qJw6-_zsnKFhsVHUHd2K2wJ3S9EsXGrPPxZ1SWn=uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 4/27/19 9:21 PM, Martin Blumenstingl wrote:
> Hi Guillaume,
>
> On Thu, Apr 18, 2019 at 2:48 PM Guillaume La Roque
> <glaroque@baylibre.com> wrote:
>> Add optional drive-strength-uA property
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
>> index a47dd990a8d3..b3e4be696ddc 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
>> @@ -51,6 +51,9 @@ Configuration nodes support the generic properties "bias-disable",
>>  "bias-pull-up" and "bias-pull-down", described in file
>>  pinctrl-bindings.txt
>>
>> +Optional properties :
>> + - drive-strength-uA: Drive strength for the specified pins in uA.
> if you have to re-send this series for whatever reason then please
> mention that drive-strength-uA is only valid for G12A and newer

thanks for your review, i will do if i send new series.


> otherwise:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
