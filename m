Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D128EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A8D20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qa3UtHEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCSIRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:17:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36162 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfCSIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:17:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so15414471wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SHrWyYLYrv7k6Lapi873A51TrQxbXxIs5hfEjJXIA04=;
        b=Qa3UtHEgBJeV+RsdMJ+0YYbC/r0P/NbFgj1GKP3N+iYBdCbmFqrKTP2buDoFCwaFKJ
         /BwXFIDp3YfqeYjZyS7g/imXBXh04uf+pKz+lRoBYWL4mOG5d9piLNXwZUv1lEFevtvw
         uxY3qKpjP84w/zcONmLF05BW40PbDoFbAB+VDeJ25mL41axCz2C3nDxLeoatnMgF+MW7
         pma4cO3MLZUXpaI8Tjj189b2qf9twlcjfM+W7CSj1GN7XNSreLTdMXRH2Ju71mrCnjzN
         Y/rgrAX4K2/lg2bysbrGgrDR8ZpKPEV9PCaKtiX3xOfIg7eCKwY2XKbTAh3GoXhlSQOC
         oskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SHrWyYLYrv7k6Lapi873A51TrQxbXxIs5hfEjJXIA04=;
        b=S3tE0wONDjf1bEXA9X76N+dnwsabnqE/EcUL6MHs32+s6EU7RoCc7R3J/F7kx72+Tf
         eVh4l3d5ygFXHw0aOffxbmAxeNBuSM4sZbPTu2uu1psSoYgP0llllhCrd/dSLU7UUU1V
         uVYFVgtKa5Stmzdhb/INr0n+kaLmFRCnzhKTWta2RFKMlrpj5n9dmzwGiGy/lBqHJDRo
         ry5HpFu4GuOAiP+jc1WJOBSC7m0vv6KG7XA/kYk/NnWwJ1kXXeNa2Vx50npcoeEOBKGw
         n/qcMtT32G0mGm7OHx2tOy5zpjMHlCtNYloMO1T2w0AayY95K963GJr6KXVwwl4WjYhO
         FymA==
X-Gm-Message-State: APjAAAUGWmrNQf/BLo7x0NpfnJ57TUU/mpZ3Iv3GirzRu356h765w+qX
        wnetpih9lhkjQVJgfi3MXJeRyA==
X-Google-Smtp-Source: APXvYqxhxtNnHX52Xi02+WcKBKyAuvwF4pIUw5PRc0WGPfLyDa0cRYDi9J1TdfPcJf/uqXrahtbHhA==
X-Received: by 2002:adf:eac9:: with SMTP id o9mr4389341wrn.85.1552983457407;
        Tue, 19 Mar 2019 01:17:37 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id h131sm5380782wmh.1.2019.03.19.01.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 01:17:36 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190318132655.30040-1-narmstrong@baylibre.com>
 <20190318132655.30040-9-narmstrong@baylibre.com>
 <CAFBinCCLrL3p=h2pXrbAnyLPiDt_3mfK4pkUhprghzbj826p6w@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <38dcd3f4-d1bf-8f69-eb29-771ff4dec062@baylibre.com>
Date:   Tue, 19 Mar 2019 09:17:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCCLrL3p=h2pXrbAnyLPiDt_3mfK4pkUhprghzbj826p6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/03/2019 20:57, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, Mar 18, 2019 at 2:29 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Adds support for Amlogic G12A USB Control Glue HW.
>>
>> The Amlogic G12A SoC Family embeds 2 USB Controllers :
>> - a DWC3 IP configured as Host for USB2 and USB3
>> - a DWC2 IP configured as Peripheral USB2 Only
>>
>> A glue connects these both controllers to 2 USB2 PHYs, and optionnally
>> to an USB3+PCIE Combo PHY shared with the PCIE controller.
>>
>> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
>> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
>> setups the on-chip OTG mode selection for this PHY.
>>
>> This drivers supports the on-probe setup of the OTG mode, and manually
>> via a debugfs interface. The IRQ mode change detect is yet to be added
>> in a future patchset, mainly due to lack of hardware to validate on.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> with the small issue fixed (see below) you can add my:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> my opinion is that the whole driver is looking great now!
> I hope that it will be queued for v5.2 soon because there's no NACK
> from the USB / dwc3 maintainers yet.

Thanks ! I will add this tag for v5 with these fixes

> 
> [...]
>> +       ret = of_platform_populate(np, NULL, NULL, dev);
>> +       if (ret) {
>> +               clk_disable_unprepare(priv->clk);
>> +               clk_put(priv->clk);
> clk_disable_unprepare is called automatically since there's now an
> devm_add_action_or_reset for that a few lines above
> clk_put is also unnecessary because priv->clk is obtained with devm_clk_get()

Chunfeng Yun also reported thos on v3...

I will fix on v4 next week to give a little more time

> 
> 
> Regards
> Martin
> 

Neil
