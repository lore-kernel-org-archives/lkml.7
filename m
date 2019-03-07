Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C83C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C962720835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dt24YF4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCGIoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:44:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39515 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:44:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so8374735wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 00:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B7f9yC2nBilh9QazUpPkdvFmlmnBG2olseACgV5S6uM=;
        b=dt24YF4wSzfRuL19Z9DbyQsBphJD3FCepYs2gZMh9jBiVEaKUyVzL4xGtMiwkFFbV2
         pkGmNKd4ObgeV81Tol62I8ZZNQiudCkUxEpJxrAGYR1NkUS0Gs425KPOQX8y3kmu5K81
         VXRs+EngxqjqprpqkXFlaWa3QhR7aGQNsttUg8cHrhFa4vLCDLUVOMzZYgxfzYDMSmQg
         szywE1m8EZf4X45JtAchBydI21ezcOZT0qwKVSexKloiuYneUN23U0JCxkbPcAlpsKiK
         K081WtjCXf+lABcMpiKsO+iXwxJlVCGaa5O73rVbQmWcKzU9aduO6WNI8kMehWt8LrWg
         +9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B7f9yC2nBilh9QazUpPkdvFmlmnBG2olseACgV5S6uM=;
        b=Bdhe+InoZVsKd4mtd0ZPGNLJjs0FSgNTRxHwGG7Uhe4T1DhU4ANZRcOXfKaDYasICC
         57cliGnenI1n53DRjsQ41qJWqhgozzGZMv1eYEsWfDjVY68XuOE0Xf1I0eZB3GYx9yjf
         FHIEn+jPxke6FbQD7XvWllIYTmpxQnOSDJBK/Qh4+JcgFGNE7PPN5PEgXM0i294OUA+K
         7+hhuU/gsejYWRDxRpbfB3BwxpU32k/WSvKLIrONiwoHCwT0xudgn3D+CXcSHvVHAPZf
         U1WpF9g1yWHCF5bvqIlWjiaJY844r4YTUnrbEanryokH2ObYrhd7NzXb8RkGqf+D5Bli
         7UMw==
X-Gm-Message-State: APjAAAXPt8FanbtDVQS1AXrxYB4V+nw+1ousjMKYVIe1tnqzJYIhkPgT
        im9q6EG5o82Z6MZpesVOeKdDAA==
X-Google-Smtp-Source: APXvYqxzlYFDPqM2mlOLrgZauhmHRAXCZXIGTkiSNhD7z7qBQBk2yboSqfnm11ISkX2sQoBh6QIt0Q==
X-Received: by 2002:a7b:cc18:: with SMTP id f24mr5256231wmh.42.1551948281979;
        Thu, 07 Mar 2019 00:44:41 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 65sm6617313wrb.62.2019.03.07.00.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 00:44:41 -0800 (PST)
Subject: Re: [PATCH v2 6/8] phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo
 PHY Driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190304103846.2060-1-narmstrong@baylibre.com>
 <20190304103846.2060-7-narmstrong@baylibre.com>
 <CAFBinCBnDPcHpOQ1vW1gL6FxgLSxMv-f-qMm_TTCvXfDaFr3zA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <6e8b1935-ba91-d06e-be63-cb2632a19654@baylibre.com>
Date:   Thu, 7 Mar 2019 09:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBnDPcHpOQ1vW1gL6FxgLSxMv-f-qMm_TTCvXfDaFr3zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2019 22:04, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, Mar 4, 2019 at 11:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +static int phy_g12a_usb3_init(struct phy *phy)
>> +{
>> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
>> +       int data, ret;
>> +
>> +       /* Switch PHY to USB3 */
>> +       regmap_update_bits(priv->regmap, PHY_R0,
>> +                          PHY_R0_PCIE_USB3_SWITCH,
>> +                          PHY_R0_PCIE_USB3_SWITCH);
> does this automatically clear PHY_R0_PCIE_POWER_STATE (in case the
> bootloader incorrectly set that)?

Don't forget it's a static configuration, on the board, only USB3 XOR PCIE
will be available, if the bootloader sets this and the kernel uses USB3,
or the reverse, one of them is wrong.

> 
> [...]
>> +static int phy_g12a_usb3_pcie_init(struct phy *phy)
>> +{
>> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
>> +       int ret;
>> +
>> +       ret = reset_control_reset(priv->reset);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (priv->mode == PHY_TYPE_USB3)
>> +               return phy_g12a_usb3_init(phy);
>> +
>> +       /* Power UP PCIE */
>> +       regmap_update_bits(priv->regmap, PHY_R0,
>> +                          PHY_R0_PCIE_POWER_STATE,
>> +                          FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
> similar to my question above: does this automatically clear
> PHY_R0_PCIE_USB3_SWITCH (in case the bootloader incorrectly set that)?

Same answer, but I'll investigate to have more details on this register.

It's more an implementation issue, we can change it when PCIe is enabled
on this platform.

> 
> Apart from these two questions this looks good to me!

Thanks for the review !

Neil

> 
> 
> Regards
> Martin
> 

