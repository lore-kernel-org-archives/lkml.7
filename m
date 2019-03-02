Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D2C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D12A20823
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTEFEJNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfCBDO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:14:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44875 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfCBDO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:14:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so12293765pff.11;
        Fri, 01 Mar 2019 19:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQDSDvv+8YNV0MRBXqf5FonE7iohMnXJXimqZ/DxZQs=;
        b=tTEFEJNawjchMk6h6v6mVa0nFmxcmL8clY3mjxkm2+4KE+e8RLb+1BGas1pN/fX7hO
         KORSbuJvpjbOAz962rQ0cM3JsXKSlB3QQtPuKyaiSpIxpGVIhalqoBVfpmDVL1+k+HNs
         IKv6GbaUIViTEuEXk/yQmxUrHgegPUdFrBaHHdjjEeySBLyVb8HwpUBPI3he/mHKCTFw
         wzIHSVFHSIyFTWeBew6i65EJsI6/VVfaJpjhGXmn8O6rqXvsBsG4gkFqVI/C49rLhGC1
         LWuA5bw32BqT99ptZguApMQDJ8VtVxpglI6AoRAfhIF95lOF2I9jGf+2vehZOZuN8VbR
         ST7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yQDSDvv+8YNV0MRBXqf5FonE7iohMnXJXimqZ/DxZQs=;
        b=Z6Nb5rdBCkTjT3ar4wlRiy3M9Ur1ZIaJetBfs3gbMCC9CSjmximfD4xepDKs6tRb4/
         VlgVQEg5jtcybtrYwWgobxcuw9UIafEY9m3vm+wEzQDUhia6md5dTZOTXmeRD1UJWY/s
         cf2hPfPlt/iBPHp1Diu+aZsKKzHcLYjHjZFRLi8yKWr7UvOwEtB33/uuIy4UX+VkRMwA
         k6ujWENkBSPr9qtgJRXAC0sC4atCPZGveqTerXEBKco2N8fxrx6J/+Z3drPjfjjQxKGB
         vgJFidE7oJb/cFSCORSDntj9uU8ieNm1nOMPc6Pfhuf9xMokKkwDNstc+LOrskaq8Xeo
         Jjbg==
X-Gm-Message-State: APjAAAVZy19L3EpUlVb/OV6ABNxq2vGJwfyXwIyc6ozQVR/9+vxuikTj
        t5jm16AJGmWQp0+UaWwOB6s=
X-Google-Smtp-Source: APXvYqyPQeZH+LZZ8YpN5PUvxVgTJIRnOU+neEBfG/0QV4zcCPUzHi94+2KdoJiwTxFz/qWLxeLUEQ==
X-Received: by 2002:a65:4244:: with SMTP id d4mr8226163pgq.419.1551496465354;
        Fri, 01 Mar 2019 19:14:25 -0800 (PST)
Received: from [10.230.26.115] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id j24sm40671298pgl.58.2019.03.01.19.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 19:14:24 -0800 (PST)
Subject: Re: [PATCH net 1/2] net: phy: Use C45 Helpers in phy_read_status()
To:     Jose Abreu <jose.abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <cover.1551437561.git.joabreu@synopsys.com>
 <27b3e9f2318c87aac928165b8dfe7d98e272f3d1.1551437561.git.joabreu@synopsys.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <237f5214-c49e-53f9-65f0-479951f62d4a@gmail.com>
Date:   Fri, 1 Mar 2019 19:14:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <27b3e9f2318c87aac928165b8dfe7d98e272f3d1.1551437561.git.joabreu@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2019 2:54 AM, Jose Abreu wrote:
> Currently phy_read_status() considers that either the PHY driver has the
> read_status() callback or uses the generic callback.
> 
> For C45 PHYs we need to use the gen10g_read_status() callback.

Right, so we could expect your C45 PHY driver to assign the read_status
callback to gen10g_read_status() if it is appropriate. So far most of
the 10g PHY drivers (cortina, marvell10g, aquantia) have to define their
own read_status() callback to be feature complete. Unlike C22 PHYs that
can really be driven with a simple generic PHY driver model for standard
features, C45 PHYs seem to be quirky enough this does not work anymore.

> 
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Joao Pinto <joao.pinto@synopsys.com>
> ---
>  include/linux/phy.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 333b56d8f746..872899136fdc 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1030,6 +1030,8 @@ static inline int phy_read_status(struct phy_device *phydev)
>  
>  	if (phydev->drv->read_status)
>  		return phydev->drv->read_status(phydev);
> +	else if (phydev->is_c45)
> +		return gen10g_read_status(phydev);
>  	else
>  		return genphy_read_status(phydev);
>  }
> 

-- 
Florian
