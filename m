Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B9C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3A920B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="J29qlBrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfECIpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42271 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfECIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so3852947lfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zaRsn/g4+Scrvd9QffeeQZcCaOKO0r6yp/twndpRhM=;
        b=J29qlBrRDMBWZUJdNN5p12YGrIys/NsojzcLa1n1TYLAUB518riMbaBuJQO5+mDEJK
         L2htaevZM1u1JKo0IzFcQJ+sA6EHz2fcvoFO0my6fdQIeXl5cvKpH7uhuXu4dBjCrTgA
         /u60oBNQ1uLuPDvz87mMX77P2G1fJeSt/AUabcTFhCz0X+kP8pY5GBhuL7rJxYI7D7ei
         0/IHjmhgyReOcnaGEXru+yo4GVYidglu2WIpgkc2KFXGjF8/z98fqMnmKjxH1xu9RGKy
         Xv/9z2Ag934kKZPwMfNdaHOELa35GigKKUAC/0JRFbIS9l6Mklp8/6nH8ZzboTicnxiV
         75qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zaRsn/g4+Scrvd9QffeeQZcCaOKO0r6yp/twndpRhM=;
        b=FqxcBxpije7AZ7jyByP7dPldzuZ6lKKxsmySRheCx4exrSj0ff0/nvJy+6yzhexFgg
         suPTOibF7drH+2pUgNP/LIJs6bALyEEJjvmM5xT1waUT1vMrY0/OSdb2d9eSlkiGTmsM
         O4dRsGWly9JTHHkM2zbNDRiVyUK08Awyg++JSkQXx8aieQqTJcxAs9kYRKiqbhBZYBfh
         VZ0KqpdCd5Zi/GYous7lHu1sxWc/u82GGp6bXjd83GV+8jYfnnrvoW721XF0+ITscihc
         UuS32SiMvOYhPsBIVToVH5JVq/HwzlaS1uziu5Kxhgh0wceMBteIhREneEnfyLwVVlzj
         mN7g==
X-Gm-Message-State: APjAAAXucztEHImdAqT9h2IFMLj15bheHT3CnJzuDm4/FHYa5ZxOVa/e
        ZpIKqaDUazfATyvaTeh6h+8itnJqYaQ=
X-Google-Smtp-Source: APXvYqyqfYigHLJVXnG7jnnuj50dTMyohCgOVYg1Pu5wNkO5Y4cooG5oT/xf8nz76WLGS04Xse2DPA==
X-Received: by 2002:ac2:4ac2:: with SMTP id m2mr4490084lfp.154.1556873106562;
        Fri, 03 May 2019 01:45:06 -0700 (PDT)
Received: from [10.114.8.178] ([5.182.27.10])
        by smtp.gmail.com with ESMTPSA id g21sm274007ljj.2.2019.05.03.01.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 01:45:05 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] of_net: add NVMEM support to of_get_mac_address
To:     =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
References: <1556870168-26864-1-git-send-email-ynezz@true.cz>
 <1556870168-26864-2-git-send-email-ynezz@true.cz>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <2a5fcdec-c661-6dc5-6741-7d6675457b9b@cogentembedded.com>
Date:   Fri, 3 May 2019 11:44:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556870168-26864-2-git-send-email-ynezz@true.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03.05.2019 10:55, Petr Štetiar wrote:

> Many embedded devices have information such as MAC addresses stored
> inside NVMEMs like EEPROMs and so on. Currently there are only two
> drivers in the tree which benefit from NVMEM bindings.
> 
> Adding support for NVMEM into every other driver would mean adding a lot
> of repetitive code. This patch allows us to configure MAC addresses in
> various devices like ethernet and wireless adapters directly from
> of_get_mac_address, which is already used by almost every driver in the
> tree.
> 
> Predecessor of this patch which used directly MTD layer has originated
> in OpenWrt some time ago and supports already about 497 use cases in 357
> device tree files.
> 
> Cc: Alban Bedel <albeu@free.fr>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Petr Štetiar <ynezz@true.cz>
> ---
> 
>   Changes since v1:
> 
>    * moved handling of nvmem after mac-address and local-mac-address properties
> 
>   Changes since v2:
> 
>    * moved of_get_mac_addr_nvmem after of_get_mac_addr(np, "address") call
>    * replaced kzalloc, kmemdup and kfree with it's devm variants
>    * introduced of_has_nvmem_mac_addr helper which checks if DT node has nvmem
>      cell with `mac-address`
>    * of_get_mac_address now returns ERR_PTR encoded error value
> 
>   drivers/of/of_net.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
> index d820f3e..258ceb8 100644
> --- a/drivers/of/of_net.c
> +++ b/drivers/of/of_net.c
[...]
> @@ -64,6 +113,9 @@ static const void *of_get_mac_addr(struct device_node *np, const char *name)
>    * addresses.  Some older U-Boots only initialized 'local-mac-address'.  In
>    * this case, the real MAC is in 'local-mac-address', and 'mac-address' exists
>    * but is all zeros.
> + *
> + * Return: Will be a valid pointer on success, NULL in case there wasn't
> + *         'mac-address' nvmem cell node found, and ERR_PTR in case of error.

    Returning both NULL and error codes on failure is usually a sign of a 
misdesigned API. Why not always return an error code?

[...]

MBR, Sergei
