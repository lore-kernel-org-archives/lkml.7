Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F26EC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EEA2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 18:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHxm3/WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfILSxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 14:53:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36250 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfILSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 14:53:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so16571472pfr.3;
        Thu, 12 Sep 2019 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tbZXvCgg0XtoQ0bX/DaxYEnApjmLayU+6GAaStsHOF0=;
        b=nHxm3/WX8Te4f3kok0sQG0nJi1giXPwWOJIDCPWusXQZqCmbsu/xjAmL2355FS5eb/
         k2aLGQ/c4PAGWJRcyUFaQOjHFZn0dumxu5AAvwD7/4gDOeCpaBzLwjl+jmlHU8eYeTcO
         K0p3kLp5emz+s7ITwzLjlUrKdS3IA2NFANKNeotn6nbZguX0txl6veMUYSVi7vUYret5
         4P6LPRJtwuuxOTHg6c1m08uI4UGqfdHddfGLft9lTF23r1/qkopy/AMX9xtrNdtkzspZ
         S7TNXzWDHIGEvkoZR6AvaIt25JeH0XQgTjQTmtG3hSlghY40MYaGC7sMa4+DPwrqClWk
         vHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbZXvCgg0XtoQ0bX/DaxYEnApjmLayU+6GAaStsHOF0=;
        b=fXWMa+pw7ITZzHOlTNa7hgOy1IhtQAcCYCzdRmLNKUYNMoMHB2MRknOWOWHPxUSM2h
         MFMf+bCS13dEIuTlbwBfv8tvWjbqnLsqK5FyBSnrGezjm5lkpCJjlbvn1fURRmZZ/eGY
         wZMcanSSINlBK617pkog0bTx70Uck4a36MLys8j7LKz2YGfXJdvKpJr78lgW9BxwnNhE
         uEC7NrYetHAALCPOreFS3NxnUOgOrMrHFW+sYoSTXcHryVio9e6moZXn9JN5Oe4E2Z6+
         rpps5Wjkkw/WbXu2ZCeKHJf4+WQK9s98jkL41z9/gtw/2mlt/GtXkzE3JC9YAqPbKsmv
         wtnQ==
X-Gm-Message-State: APjAAAWpN6pHNINLIDVSBp7q+p/YHzMJ/iDGTEs1sNFn9sA1GYTGyO7a
        ZK9Fr4D9qnLfyaYo3I2gxXE=
X-Google-Smtp-Source: APXvYqzWHnwl4LydsRAWGpj8r280wwCYEg+wJR9kMrzB0XQhCx2m7KZwwJiJ/WCSO1pLIv2ABS7AqQ==
X-Received: by 2002:a17:90a:f48f:: with SMTP id bx15mr93798pjb.75.1568314391758;
        Thu, 12 Sep 2019 11:53:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 193sm31089955pfc.59.2019.09.12.11.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 11:53:11 -0700 (PDT)
Date:   Thu, 12 Sep 2019 11:53:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        bichan.lu@advantech.com.tw, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v1,1/1] hwmon: (nct7904) Fix incorrect SMI status register
 setting of LTD temperature and fan.
Message-ID: <20190912185310.GA6349@roeck-us.net>
References: <20190912113300.4714-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912113300.4714-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 11:33:00AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> According to datasheet, the SMI status register setting of LTD
> temperature is SMI_STS3, and the SMI status register setting
> of fan is SMI_STS5 and SMI_STS6.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7904.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index ce688ab4fce2..95b447cfa24c 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -51,6 +51,7 @@
>  #define VSEN1_HV_HL_REG		0x00	/* Bank 1; 2 regs (HV/LV) per sensor */
>  #define VSEN1_LV_HL_REG		0x01	/* Bank 1; 2 regs (HV/LV) per sensor */
>  #define SMI_STS1_REG		0xC1	/* Bank 0; SMI Status Register */
> +#define SMI_STS3_REG		0xC3	/* Bank 0; SMI Status Register */
>  #define SMI_STS5_REG		0xC5	/* Bank 0; SMI Status Register */
>  #define SMI_STS7_REG		0xC7	/* Bank 0; SMI Status Register */
>  #define SMI_STS8_REG		0xC8	/* Bank 0; SMI Status Register */
> @@ -210,7 +211,7 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
>  		return 0;
>  	case hwmon_fan_alarm:
>  		ret = nct7904_read_reg(data, BANK_0,
> -				       SMI_STS7_REG + (channel >> 3));
> +				       SMI_STS5_REG + (channel >> 3));
>  		if (ret < 0)
>  			return ret;
>  		*val = (ret >> (channel & 0x07)) & 1;
> @@ -351,7 +352,13 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  		*val = sign_extend32(temp, 10) * 125;
>  		return 0;
>  	case hwmon_temp_alarm:
> -		if (channel < 5) {
> +		if (channel == 4) {
> +			ret = nct7904_read_reg(data, BANK_0,
> +					       SMI_STS3_REG);
> +			if (ret < 0)
> +				return ret;
> +			*val = (ret >> 1) & 1;
> +		} else if (channel < 4) {
>  			ret = nct7904_read_reg(data, BANK_0,
>  					       SMI_STS1_REG);
>  			if (ret < 0)
