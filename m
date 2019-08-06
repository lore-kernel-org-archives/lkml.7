Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42845C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E1A216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUsefNX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfHFWed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:34:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43277 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfHFWed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:34:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so31434645pld.10;
        Tue, 06 Aug 2019 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VhumLkAPF7G9y/jlJ2nuL1edo6Y3KiXKftsrAG7O/Vg=;
        b=gUsefNX6Qqwib3eU2HyupqLa66HChi5k7EMP/hkeLkWiMpNBLYwjXq1s3BKHtnWUOw
         bkTjVJUuzr6fGSe5FUCrKrBklMMo/Gd85LjVDyqer+nIo9DfHX3rf+vjJvKvGhNHvmbP
         kgrAQz8Se5fspxfMlilNrKsEGFYZ6eQ0yAXdAHpp2KgnsjxXJFldRSiCy12zxMAoTlY7
         i5/AYMBT6+rmeWWasFwD4VPiDzHEkKhnA0Va92Rb+FEtpn2wMgNkqU/d4KMBEvqBLj8I
         KBAUWHFysMIuZQF8Htf+vySFRISK2xRiuqO4Jro38gTiaOmWVO0cu8GeAIeK51E8JEvT
         DNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VhumLkAPF7G9y/jlJ2nuL1edo6Y3KiXKftsrAG7O/Vg=;
        b=Lj0E9FVaDNNVX9lYPgRV/vCAMgyD1u+wySEhQ1oIh7/iGMBovHQOHcl/fSyx/v8Vp1
         VIo5rCEw57Sr8Aiv9EryY8DGdt6PaJcFwa2s7bCmQruDiZKnL9ewSTzQoLY0CjlNXTU5
         JDAcGLbvHoRih6CC7zp5866hmdtKvtHrvQeCLn/mkMKVZB76WyQlt0OXJMRFOnVzDkrr
         NzYU/AscefmTyUqQXQcdF5dXSV/cu1xMpZvQ02PjN4lvjxoDH0yrmtyNqCzKulDZkPKU
         FgrW249OToA2WG2FQHofzZUcsnh6Vzhn95qUVfA1h3m0wKAklPda5TK+JLZ8vzyabEd2
         +GOQ==
X-Gm-Message-State: APjAAAWc9nlLQFTsXeiN3dKEOnLvodbREZhE6nPACBPINFLsqBTPQhbC
        0u1gqmkjy4RPIrLL/zvHTQI=
X-Google-Smtp-Source: APXvYqx94eUaAcCLOLXw+7Wd/6gkui4cOECebIzYGxQiL4TFhmqM6RYomP4m5AopyZa2pOMiBRk1Jw==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr5291784plb.270.1565130872381;
        Tue, 06 Aug 2019 15:34:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o24sm163515204pfp.135.2019.08.06.15.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 15:34:31 -0700 (PDT)
Date:   Tue, 6 Aug 2019 15:34:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v4 1/2] hwmon: (nct7904) Fix the incorrect return value of case
 hwmon_fan_min in function "nct7904_write_fan".
Message-ID: <20190806223430.GA17293@roeck-us.net>
References: <d1b58bc36bcb0204bca811d97a8ef1063fe876e0.1565006479.git.amy.shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b58bc36bcb0204bca811d97a8ef1063fe876e0.1565006479.git.amy.shih@advantech.com.tw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:30:07AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> Return the -EINVAL(Invalid argument) when writing the values <= 0
> to sysfs node fan[1-*]_min.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
> 

This again fixes a previous patch of the series. Please squash
the entire series (all three patches) together in a single patch.

Thanks,
Guenter

> Changes in v4:
> - Fix the incorrect return value of case hwmon_fan_min in function "nct7904_write_fan".
> Changes in v3:
> - Squashed subsequent fixes of below patches into one patch.
> 
> -- Fix bad fallthrough in various switch statements.
> -- Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
> -- Fix incorrect register setting of voltage.
> -- Fix incorrect register bit mapping of temperature alarm.
> -- Fix wrong return code 0x1fff in function nct7904_write_fan.
> -- Delete wrong comment in function nct7904_write_in.
> -- Fix wrong attribute names for temperature.
> -- Fix wrong registers setting for temperature.
> 
> Changes in v2:
> - Fix bad fallthrough in various switch statements.
> - Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
> ---
>  drivers/hwmon/nct7904.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index d842c10ba11f..6527b56e4f6c 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -551,7 +551,7 @@ static int nct7904_write_fan(struct device *dev, u32 attr, int channel,
>  	switch (attr) {
>  	case hwmon_fan_min:
>  		if (val <= 0)
> -			return 0;
> +			return -EINVAL;
>  
>  		val = clamp_val((1350000 + (val >> 1)) / val, 1, 0x1fff);
>  		tmp = (val >> 5) & 0xff;
> -- 
> 2.17.1
> 
