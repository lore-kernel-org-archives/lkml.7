Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A477CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609AC20652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ydtdaNM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfCGIfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:35:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50737 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfCGIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:35:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so8392250wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4XqHCoi5JggUdG0hVxEIbh3ilXAPVgBeyrSdkB4j67U=;
        b=ydtdaNM3iz+UhJpkvzfPtBrJ2GFVZNvqqALm9nxzR+c5qv6kTfRNMItoVtIv/PD4rc
         ITlQqDPbv1chhRx8byLvyoR7vn618elSD48PhLbUyLOUBTCbqXI7pHDf7dS0OVYnxBnF
         29PuQPTpxNjeuxzqr2d8AAtZfGJWznUg74+ArPLXcbWe4ta1GV+YAddd/7mWJ/34T5g9
         BiMtd2yoSxeJF/Wu8hJvOuTf9lNP4Uh2poBOeCMCSx4ffI/W8fb+D+w2BKJmEbkCPnfS
         zH5PfU2ajdpjZbfTg7hN4opfxWetrbzPdzBRP5pmfi/nSG2yQ/SgsH9yOJaGCZnCvzRy
         0UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4XqHCoi5JggUdG0hVxEIbh3ilXAPVgBeyrSdkB4j67U=;
        b=NpSi47uBvDkx0L3ersre1KhVOHd3jSEl3G25wYnH8CWnRzKz0ScyR7N6JYPdeUC/Bt
         JhRdCYzycjOhA8qr9wuHgIleFGncrHTGuy4UiKUqV0IvmwLafGFkwtxatJe9fVEmlmW/
         zimIJZcykqNCN8YH7cp01oqOLMSxabJ+LG9LVDoDtU+6HIfKirppq0E4F1AwgjSS7SDe
         vbk8acxo39atSZLWoL/BcG8M9rDpDaLXxnVUhLLRPhJckRKpabKt6OLuTh+kas6pYQ/G
         g+JZy1HGjldbmE3avTDzKBqVYXCLehDanFDezsuTIjwc/ISIXOmZAGmEYFqfgSeDC07u
         /CIA==
X-Gm-Message-State: APjAAAWq63bGGZOwln4wUCMec4QCJevCz+wAV9fICJRtec1Xr00ku6nO
        RX7fWPWju1UVBER2pdgNYYEZTrkVp4T+Eg==
X-Google-Smtp-Source: APXvYqxrZlo3DDnWMWKvpwb6WXhyZUdg9uyElMCs1S8dd3vg/wU06S3oZIyrNpZqCrNlMGIb5hovuw==
X-Received: by 2002:a1c:2097:: with SMTP id g145mr4736230wmg.81.1551947709312;
        Thu, 07 Mar 2019 00:35:09 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i74sm6337187wmg.48.2019.03.07.00.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 00:35:08 -0800 (PST)
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo
 PHY Bindings
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190304103846.2060-1-narmstrong@baylibre.com>
 <20190304103846.2060-3-narmstrong@baylibre.com>
 <CAFBinCCp+bME0fnWRJx0L1E5aazUh1Hw-svsP7+D_QU4dP08nw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <77d8681b-d270-5928-ff67-b58b4813f100@baylibre.com>
Date:   Thu, 7 Mar 2019 09:35:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCp+bME0fnWRJx0L1E5aazUh1Hw-svsP7+D_QU4dP08nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 22:42, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, Mar 4, 2019 at 11:38 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add the Amlogic G12A Family USB3 + PCIE Combo PHY Bindings.
>>
>> This PHY can provide exclusively USB3 or PCIE support on shared I/Os.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 22 +++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
>> new file mode 100644
>> index 000000000000..7cfc17e2df31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
>> @@ -0,0 +1,22 @@
>> +* Amlogic G12A USB3 + PCIE Combo PHY binding
>> +
>> +Required properties:
>> +- compatible:  Should be "amlogic,meson-g12a-usb3-pcie-phy"
>> +- #phys-cells: must be 1. The cell number is used to select the phy mode
>> +  as defined in <dt-bindings/phy/phy.h> between PHY_TYPE_USB3 and PHY_TYPE_PCIE
>> +- reg:         The base address and length of the registers
>> +- clocks:      a phandle to the 100MHz reference clock of this PHY
>> +- clock-names: must be "ref_clk"
>> +- resets:      phandle to the reset lines for the PHY control
>> +- reset-names: must be "phy"
> one question on the resets:
> - in v1 you had three reset lines: RESET_PCIE_CTRL_A, RESET_PCIE_PHY,
> RESET_PCIE_APB
> - in v2 you only have the "phy" reset line.
> is this because the other two are connected to the PCIe controller
> (Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt) instead
> of the PHY?

Indeed, it was wrong, only the RESET_PCIE_PHY is needed for the PHY

Neil

> 
> 
> Regards
> Martin
> 

