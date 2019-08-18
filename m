Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C63C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194692146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uttML3RC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfHRJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:34:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfHRJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so5623109wrq.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+t3LQMBsSqNtOgurGKhZ9wHHLkH0/0oqZfvSxZFI7Kc=;
        b=uttML3RCJoDZnRkarpGajlROiOjlCgdBRarQ0F5FMFCaZ0D2ZSDeoe6m89e45/9Cd3
         M3wPcFpgIvwV3Y/fuC9wfjXctxXie2swARrs+EXYcJhI8rcpY4H0QlqaTdzkwf4KnHP+
         eQ0AFmJLrnT3WXl4twdhFDNubbJfvJVg/vY0WASgHxqLAmtPtB4xbBqQHJmHYsWXg8nU
         3jghdnYoY1SziexIR5V4wckMT+1Fzc1PLKt4KiNQd3h5Yf14I+Ta6fUWk3DumKdZ8nIr
         WHM32qDx5MQzVr6Ewizcv+SAO9qRdlt3EDZNUo2gWYZyC1odC3LXL1D0TVmPHA6Trv77
         tuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+t3LQMBsSqNtOgurGKhZ9wHHLkH0/0oqZfvSxZFI7Kc=;
        b=aQGb9XSLj6P/bH9UvoSj+90lp3VX3eouo2sDmRU10eyVcOFIXbPav2BSPQepjHAVCK
         jv7M01EMms2S/dLlkwjMIOy2Q+d6AtuhndQ9Q612t27inKkhFt4iYowT/wJRbafAh/84
         u8e8kPrLrw80lxM4q0cU2q3aXniqap/WuOKH8L5QKo7dfY2JETEyiruaR3mqhvp14T+t
         AwvhXy2+d6ERsxjL9bNWLugFy9aCf23H6S8khYBNQ5+IULN/MGKQkdIz0sHHyciwCqAk
         iZG4WztfgD7Z4d8FUv+VoBhi/ALIWSTcXiNR7FKLhCuqFiu8zdbH/oqSktkGUlmeByAi
         +cbw==
X-Gm-Message-State: APjAAAV3SnYMAKq7raoXRuw7PdKnhmpr55om92VNDJ7Yj0QQNcBljlnR
        DquPBEKfuiKxBBTt3ylBYWnzgg==
X-Google-Smtp-Source: APXvYqyDJPoBROgH3mSWPPQRVi3n6qSDQYx/A8Z/krsdoVGn3+rKHtb0XvRz2rf/n5uAvUz1nVx4NQ==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr20161009wrx.100.1566120885734;
        Sun, 18 Aug 2019 02:34:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id g26sm8352268wmh.32.2019.08.18.02.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 02:34:45 -0700 (PDT)
Subject: Re: [PATCH nvmem v2 0/2] nvmem: imx: add i.MX8QM platform support
To:     fugang.duan@nxp.com
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190807040320.1760-1-fugang.duan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5c7e5ff3-f453-c765-8795-c392434c7663@linaro.org>
Date:   Sun, 18 Aug 2019 10:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190807040320.1760-1-fugang.duan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/08/2019 05:03, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> The patch set is to add i.MX8QM platform support for i.MX8 SCU
> OCOTP driver due to i.MX8QM efuse table has some difference with
> i.MX8QXP platform.
> 
> V2:
> - Add dt-bindings for the new compatible string support.
> 
> Fugang Duan (2):
>    nvmem: imx: add i.MX8QM platform support
>    dt-bindings: fsl: scu: add new compatible string for ocotp
> 

Applied thanks.

--srini
>   Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
>   drivers/nvmem/imx-ocotp-scu.c                               | 7 +++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
