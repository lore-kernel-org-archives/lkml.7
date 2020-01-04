Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37406C3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4F24654
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVpbMSEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgADQ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:28:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37427 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:28:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so5947117pjb.2;
        Sat, 04 Jan 2020 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qstLM+wp37DOzItwPuQusYVU0Lwd3s5YFnS/husU8H4=;
        b=PVpbMSExr5+JxReZ6VGErnDUXwLHPSF64nVAQO17V/AV1rTwz3febIqMByutk3A+h7
         oZzr0K4ihq6vbdpXGmDTZn3OTsSiJYG/jmTDXgaPcJu51KnlCWw9+BA1zfWwYymzmfkB
         rYsOVNKX7mDviT9S4jU84NbwSdkWOnfkW5RicFMQ45OAcvZf/q2J/JELC9fnB3FGZzW2
         42UbXVTcEUvmcH4NLS+ZVAAIIQatc03co/sZ63t1jEBta/As/2CfEjBhh0oZgihovfMW
         VQ8cNOvs5sRGYgIAZpFUTx62MEIeo6hUq6O6SPO6SA7FtBRfXq9j+yo289rooWHLYbgn
         +pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qstLM+wp37DOzItwPuQusYVU0Lwd3s5YFnS/husU8H4=;
        b=AibxO6/OWHIAfm5ERETqtgUMRPhTzVmy+3uWNc/0MZRAVzbnvMS4nqEHIJJrk6/5jz
         587BLLEkB11Y6Ltkc5OVqvHdjeUVFmIaQc61Ztqy7VY3zVCDE6DeZE1CZYOSPHzIHxTO
         WgJ44Ha6k1O8GgfndTNWBxOFZqXOyz80rJ/RjMsO1UEv6lQqRZ2WBrNSCqLuy/VVTROE
         51LfGuSpQ+e4tTo/oeb9W4qV7ueXGgn4DH/1YrzFu1XF88P/0tlX7zx7CAP4n2SDKrVk
         EY6h1Ta8HgJnv8Sdo7vexGu3Mb5MTK8y0n5UHEvTz69NlmFa/y5A2x4SVOG3iDn4VKvz
         CVQw==
X-Gm-Message-State: APjAAAXkEmKXFsdQ+XnoRKtUM3Wrx3XHa6R5pz0Ohzb3K3VdUqnVNCRS
        Tg+zizsVCViyMBiGs46L9cQ=
X-Google-Smtp-Source: APXvYqx3NhjdhHEw++0CcAo6jtlyhKNhWZTk1UESq1TgnXYhOLzD2XsQxKevmxIQEhlrHEDp0ii1hg==
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr100896253plp.323.1578155291693;
        Sat, 04 Jan 2020 08:28:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o17sm18323201pjq.1.2020.01.04.08.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 08:28:11 -0800 (PST)
Date:   Sat, 4 Jan 2020 08:28:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, bjwyman@gmail.com
Subject: Re: [PATCH 2/3] hwmon: (pmbus/ibm-cffps) Add the VMON property for
 version 2
Message-ID: <20200104162810.GA30243@roeck-us.net>
References: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
 <1576788607-13567-3-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576788607-13567-3-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:50:06PM -0600, Eddie James wrote:
> Version 2 of the PSU supports reading an auxiliary voltage. Use the
> pmbus VMON property and associated virtual register to read it.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

I assume you are ok with v1 reading (or trying to read) this voltage.

Applied to hwmon-next.

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index a564be9..b37faf1 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -28,6 +28,7 @@
>  #define CFFPS1_FW_NUM_BYTES			4
>  #define CFFPS2_FW_NUM_WORDS			3
>  #define CFFPS_SYS_CONFIG_CMD			0xDA
> +#define CFFPS_12VCS_VOUT_CMD			0xDE
>  
>  #define CFFPS_INPUT_HISTORY_CMD			0xD6
>  #define CFFPS_INPUT_HISTORY_SIZE		100
> @@ -350,6 +351,9 @@ static int ibm_cffps_read_word_data(struct i2c_client *client, int page,
>  		if (mfr & CFFPS_MFR_PS_KILL)
>  			rc |= PB_STATUS_OFF;
>  		break;
> +	case PMBUS_VIRT_READ_VMON:
> +		rc = pmbus_read_word_data(client, page, CFFPS_12VCS_VOUT_CMD);
> +		break;
>  	default:
>  		rc = -ENODATA;
>  		break;
> @@ -453,7 +457,7 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
>  			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
>  			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
>  			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> -			PMBUS_HAVE_STATUS_FAN12,
> +			PMBUS_HAVE_STATUS_FAN12 | PMBUS_HAVE_VMON,
>  		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
>  			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
>  			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT,
