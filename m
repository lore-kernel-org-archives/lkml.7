Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECD9C80D4D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16A92477D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3xjo6Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfLMTZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:25:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44675 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbfLMTZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:25:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id cm12so366578edb.11;
        Fri, 13 Dec 2019 11:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/+Pf3FRJ46P/YXMaPoPohv4rWPl/O0X724GzNKVLDoA=;
        b=T3xjo6GgOBEJ8cCXdXzw13znTZYWGMvXQTW9T+APXTH4KwqJaaBg+vqAAC7uY0Krcf
         I7R32HPw+jtg8o/o89oUO2vvgfV6BHvealku/PApTdWhrW29Df0H54NsLpPVfGx8db3m
         jbDkG/QdomAK6S2woZqktrmiTYuZjaG0mtR/q78H/sa3AmEvpvYrI29EPefUkf26nedk
         mmb9IwP9v6dstjQ06tT3KVmVbNPFmsytpZ41mn0M/AUtPEZOQpv79Hc3CxWFWINxsbRi
         0jrNni2Ts66uissiF05qyUcs0JGjj0VVpjQTxOz0fCLfmKzS/y+bGLCpRCvnXpQVpSwy
         q/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/+Pf3FRJ46P/YXMaPoPohv4rWPl/O0X724GzNKVLDoA=;
        b=uZTbPsr3qGA5jfyZbGAapg6Xxe75IfvEKl5CuFJW/NsbXRZjci6FYc01tKxnbcsWA3
         s/01bOF5J1aHKc8QYM8dbT6wbQtLOo6RGBbEr8KTIZfaFXu7s8oR/INpibNP+Fp3llbW
         /oCkB2nxFv3SBtHrP+1yjCUhDEa833v7YjHgLY3VlWZeryTcGZYry8YcyVe93BPVuSW+
         TK4P8PNpeC8mGihu9kLIGqWGT1Zuy5KLLfx2XFSQZMpONETduJifhtxPbw7CqB52yfc7
         2o44Jux1y7I6EDw9eT31YFqSKz0ZdiQ0zKPZdcjp+m4igSttq6Zgew1TJZ+oNYsIC8ZT
         7FDg==
X-Gm-Message-State: APjAAAVCKcUkAgj9A6X93qilQF/IKTS9aEZ/uK8IOr+UTWdsYHFACdpr
        4jO47PBNithfZo73Q3IcRqs=
X-Google-Smtp-Source: APXvYqwc7UsERW/A+zk+KNr2UyXjWePGW7FY5XO/Or9UNo5GoVQxod85WFoRW87nJ14J9300Ag3Dkg==
X-Received: by 2002:a17:906:d8a4:: with SMTP id qc4mr18082362ejb.264.1576265153949;
        Fri, 13 Dec 2019 11:25:53 -0800 (PST)
Received: from [10.67.50.53] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ot12sm636447ejb.72.2019.12.13.11.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 11:25:53 -0800 (PST)
Subject: Re: [PATCH v3 00/13] phy: usb: Updates to Broadcom STB USB PHY driver
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
References: <20191210132132.41509-1-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <ec0e50c6-b226-70b4-0f1b-51d5cb0a71c5@gmail.com>
Date:   Fri, 13 Dec 2019 11:25:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210132132.41509-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 5:21 AM, Al Cooper wrote:
> This patchset contains various updates to the Broadcom STB USB Driver.
> The updates include:
> - Add support for 7216 and 7211 Broadcom SoCs which use the new
>   Synopsis USB Controller.
> - Add support for USB Wake
> - Add various bug fixes.
> 
> v3 - Rebase to v5.5-rc1
> 
> v2 - Changes based on review feedback
> - Add vendor prefix to DT property "syscon-piarbctl"
> - Use standard "wakeup" instead of "wake" for DT "interrupt-names"

This entire series:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> Al Cooper (13):
>   phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
>   phy: usb: Get all drivers that use USB clks using correct
>     enable/disable
>   phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
>   phy: usb: Add "wake on" functionality
>   phy: usb: Restructure in preparation for adding 7216 USB support
>   dt-bindings: Add Broadcom STB USB PHY binding document
>   phy: usb: Add support for new Synopsis USB controller on the 7216
>   phy: usb: Add support for new Synopsis USB controller on the 7211b0
>   phy: usb: fix driver to defer on clk_get defer
>   phy: usb: PHY's MDIO registers not accessible without device installed
>   phy: usb: bdc: Fix occasional failure with BDC on 7211
>   phy: usb: USB driver is crashing during S3 resume on 7216
>   phy: usb: Add support for wake and USB low power mode for 7211 S2/S5
> 
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  69 ++-
>  drivers/phy/broadcom/Makefile                 |   2 +-
>  .../phy/broadcom/phy-brcm-usb-init-synopsis.c | 414 ++++++++++++++++++
>  drivers/phy/broadcom/phy-brcm-usb-init.c      | 226 +++++-----
>  drivers/phy/broadcom/phy-brcm-usb-init.h      | 148 ++++++-
>  drivers/phy/broadcom/phy-brcm-usb.c           | 269 ++++++++++--
>  6 files changed, 943 insertions(+), 185 deletions(-)
>  create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
> 


-- 
Florian
