Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D70C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178072075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdTvKoBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfDBSRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:17:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55037 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfDBSRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:17:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so4452451wml.4;
        Tue, 02 Apr 2019 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GtD7/c+XLFabRb4HcT0EFttSXo2eDZN72QYdwoD9zk=;
        b=vdTvKoBveTKHOMcvV1qtSQjSGn56TWpUXhYILsIY4qeI5HHFbt5BlJ2BoKZLe1OTjg
         eS36cUxNFsq9N5W8AoBGjG61Pkyc4o5h79Lvmju4SgR8ANgk7Vqm0iaolEIPscv/tA8p
         FJUVqGcpO+AUulYDHEi5kdK8Lz2T14NwBSMMckDV3Eiyfou1vo2+ep542PYz9SyQjaMJ
         TodZOqWz1l3XNHpY5FZcZA1Zcr+q71aeS/xRsgLc98ysp1xWt6MeWdESx41bz47mL/bg
         9KxWeRgCQFruWFIPLuYpUOurllBDRHWL0azJF1/+Fu88kwffpJaqqO4rAOR/scBjfIei
         ehWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GtD7/c+XLFabRb4HcT0EFttSXo2eDZN72QYdwoD9zk=;
        b=KyRewmZrlNhJQ/eeaUMAIhVkhy8gjPeoQWtWxj+B8DsLUaHrIwyonsdAku8D61/bpk
         Eh6btaum0KzuCnHtBmWni7Iu7hY27DQ5qF1xvaBeYhhIGi8a9ylfJOlj3DIWeMI8tv7A
         /1oRsUdE51YIEtfQRp8zB7rrUXskVX+jzZNdjFkLippkx85App+5iaWO92s323heqUZG
         B5QFRRJip/Y/1jMgjmdPijGoxQHIqv0NhMMmxdCc4mnMaeqCBo3l57HxvU0EAp9sQ1Ln
         LmCp2YyUGfpdTXw5YXeJQLK6W/yZ8Co+n0IOE64B1+1sEevE5V9PxGVImuQG+kvtPcVT
         qZ/A==
X-Gm-Message-State: APjAAAV4+tL5mxe4iljHqFmvXN7RonRqAgA7tOwnhw6eGSeyjsEn8Ga3
        YH/k2hdCeJhh232IqOI3Dgc=
X-Google-Smtp-Source: APXvYqzWwQki6UWxmkQO4gIb6E13FGWEK2Ko5bMFJ6ct9hj17iFUw5KmBon330Gxp8CoVDhp1Eb4sw==
X-Received: by 2002:a1c:23cc:: with SMTP id j195mr4391096wmj.74.1554229049417;
        Tue, 02 Apr 2019 11:17:29 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be1:dd00:e07d:a1a:1bc0:370? (p200300EA8BE1DD00E07D0A1A1BC00370.dip0.t-ipconnect.de. [2003:ea:8be1:dd00:e07d:a1a:1bc0:370])
        by smtp.googlemail.com with ESMTPSA id 61sm48681969wre.50.2019.04.02.11.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 11:17:27 -0700 (PDT)
Subject: Re: [PATCH net-next v4 1/2] net: phy: marvell10g: implement
 suspend/resume callbacks
To:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
References: <20190402131029.26880-1-antoine.tenart@bootlin.com>
 <20190402131029.26880-2-antoine.tenart@bootlin.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <762a34e2-e89b-9a96-938f-5c85709c8760@gmail.com>
Date:   Tue, 2 Apr 2019 20:17:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402131029.26880-2-antoine.tenart@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.2019 15:10, Antoine Tenart wrote:
> This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
> three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
> are powered down) when the PHY isn't used.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/phy/marvell10g.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 80678919641d..9ee033c8a12b 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -51,6 +51,8 @@ enum {
>  	MV_AN_STAT1000		= 0x8001, /* 1000base-T status register */
>  
>  	/* Vendor2 MMD registers */
> +	MV_V2_PORT_CTRL		= 0xf001,
> +	MV_V2_PORT_CTRL_PWRDOWN = 0x0800,

If this driver is touched again I think it would be good to change all
such constants to BIT() and GENMASK(), ideally combined with the macros
from bitfields.h. This makes it much easier to check the code against the
datasheet. Apart from that:

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
