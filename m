Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB8C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FA021897
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4bFhJdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfIQW3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:29:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46026 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIQW3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:29:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id x3so2123260plr.12;
        Tue, 17 Sep 2019 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yhCiZwesMhjcDNHUHsCDs9+tElqifQi7cy9pdjsNsPM=;
        b=m4bFhJdcMgI/amTn4qUElX1M0ASrorpBRQrFTWeqs3qnmdU0hJ3S8ZZR6WNBsgckLD
         8yn1JwcExwhViXznkTpa3eqQXCUeUOxHiEyqPus7A61HyPAFdrZgyUZ/0ql3qyMMFlLd
         3iVVUjV04LBmYhWh30qJ5SZwtK/4UnmKX1EGyiJguy+72JgIUnuX/mJWm76k4Ceuq3Os
         tJZUPbMNvBNvrmoFummxvXeADo/sHIF39nZxJk/aFVLGv5JW9SZ3olYtGDAsugHKFuiw
         1FxWEZTOfxZZ5zGyjzy3fYZyX5c6VdfZF6xo6cQKScZzLlSU3huhmjSXT+GE1SpnBUi3
         lmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yhCiZwesMhjcDNHUHsCDs9+tElqifQi7cy9pdjsNsPM=;
        b=BxX0ePUVz/rWrp9Z3pBDBQq/AUsGBC9H5jkBzDh8x6wH752jCzlhSC8lVD1hiIH9J7
         3WTCMM7iRM/+6n3hAHfsY+aQ5cWJZVku3rS7W+n1KEhdU2tpZX33SHeJiHxW+fQL6axz
         zXTHyQICgXTLzlJdq4sk07HWmVIV2q3swWXmJd3Q043k9GTdSOmix5dj2PwQrQa4qTBe
         +i6TtcYWOv+kvrbtauGTGC/iDavYgvNH53PN661F8CWUfYsVG07Go+girP9AePlSjPRb
         fuico9aCoHshj//CpxnUrJn97B1dB8lzIcJSRPnQdygJUOxu02kWtpe75EpuxzKy4TOP
         uHUA==
X-Gm-Message-State: APjAAAWF1TCShReZb7dRMLRrsaE0MhVhATKwyt23BX2npitHPA0h/deu
        tmCocsc62WbLylSO+vCjtGo=
X-Google-Smtp-Source: APXvYqzLNRyXZL1IUWFbHM/DpDQDoO7mfwqk69H4u2h1byWpXXuE+oOVNYp3UpCYCL40PVzthzms3g==
X-Received: by 2002:a17:902:5a89:: with SMTP id r9mr981630pli.206.1568759384806;
        Tue, 17 Sep 2019 15:29:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u3sm3777650pfn.134.2019.09.17.15.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 15:29:43 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:29:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        bichan.lu@advantech.com.tw, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2,1/1] hwmon: (nct7904) Fix the incorrect value of vsen_mask
 in nct7904_data struct.
Message-ID: <20190917222942.GA1994@roeck-us.net>
References: <20190916034111.2714-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916034111.2714-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 11:41:11AM +0800, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> Voltage sensors overlap with external temperature sensors. Detect
> the multi-function of voltage, thermal diode and thermistor from
> register VT_ADC_MD_REG to set value of vsen_mask in nct7904_data
> struct.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
> ---
> Changes in v2:
> - Moved the if statement to outside.
>  drivers/hwmon/nct7904.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 95b447cfa24c..e2b3ec74491a 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -921,6 +921,8 @@ static int nct7904_probe(struct i2c_client *client,
>  			data->tcpu_mask &= ~bit;
>  		else if (val == 0x1 || val == 0x2)
>  			data->temp_mode |= bit;
> +		if (val != 0)
> +			data->vsen_mask &= ~(0x06 << (i * 2));

This is a slight change in semantics, since val != 0 includes 3.
Should this maybe be as foillows ?

               if (val == 0) {
                        data->tcpu_mask &= ~bit;
                else {
			if (val == 0x1 || val == 0x2)
                        	data->temp_mode |= bit;
			data->vsen_mask &= ~(0x06 << (i * 2));
		}


Also, please you have a look at the code further above.

		val = (ret & (0x03 << i)) >> (i * 2);

Should that possibly be as follows ?

		val = (ret & (0x03 << i * 2)) >> (i * 2);
		                      ^^^^^

or, somewhat simplified,

		val = (ret >> i * 2) & 0x03;

Thanks,
Guenter
