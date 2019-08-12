Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E8AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E572067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HRqI7gpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfHLR3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:29:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35024 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfHLR3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:29:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so19440814wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gLmU/oA3BCk2uiOw0NCotyQaVZi//v3NX7oeTBpbzPI=;
        b=HRqI7gpgVlreUi1D++HQHECQSCm+7bHRVkxlJA31xjKyAOIIwHmSF0LjBvN65ZEOzo
         xj0MNruGBDagLsis6PIDdhDXNL56WaiUmZalJAk7WI+Eu4argckKozpmRBWBGvGat+Ps
         jB1DJLIHnq73jpePKgYdnjSfprtsMhRY1uvCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLmU/oA3BCk2uiOw0NCotyQaVZi//v3NX7oeTBpbzPI=;
        b=V0Dv9EfcS2hWS9+IA5mFnzRDgSwST5o+p8sFyQM0N8urH2HGupRA/1tEeFoa1Tbvxq
         UEkhxaFegqqJG4RWcHTGT16W1B55iBEmOlLzSD4QZ1mF4i0MU8Vy9XIOO4KF4NeJgt6U
         gbTCxZRrpTSusD4DkZVp8BmeXzCTH6+ur9F8KDQFe3j8L9X2cyBNq5q4S2sw7KQqYyRT
         GOm5+DILQcy1l3pSG+A8q2rN1wtIX1b4tGn++zQlW/DvbZYtgnPJmYnAmvJkjqCCUAMb
         3J+VY2oVKJ3iFu6l95dTFPxfLQGfqhYObVv6FeI1EUFMh5pcYjvW92J9UOvOLoHYZR46
         2FFQ==
X-Gm-Message-State: APjAAAVbwbXkxo5KaA/jciPo23G8WnQ/hY31DxcwwZ+/M94Of/KXE/vd
        DB++upq9pJd1LsPIdvSt3qP4ow==
X-Google-Smtp-Source: APXvYqxHJNwUpwVM9tbfVDO/o2ELdYI+GRRNwxKxz0h2W8TZ4S/n1eM8b2GMn7in/kY22iY0PrtG+w==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr10405833wru.207.1565630958564;
        Mon, 12 Aug 2019 10:29:18 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a64sm606796wmf.1.2019.08.12.10.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 10:29:18 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] i2c: iproc: Stop advertising support of SMBUS
 quick cmd
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lori Hikichi <lori.hikichi@broadcom.com>
References: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <1565235473-28461-2-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <201903a5-c517-f436-0337-4110165d18a0@broadcom.com>
Date:   Mon, 12 Aug 2019 10:29:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565235473-28461-2-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/19 8:37 PM, Rayagonda Kokatanur wrote:
> From: Lori Hikichi <lori.hikichi@broadcom.com>
> 
> The driver does not support the SMBUS Quick command so remove the
> flag that indicates that level of support.
> By default the i2c_detect tool uses the quick command to try and
> detect devices at some bus addresses.  If the quick command is used
> then we will not detect the device, even though it is present.
> 
> Fixes: e6e5dd3566e0 (i2c: iproc: Add Broadcom iProc I2C Driver)
> 
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>   drivers/i2c/busses/i2c-bcm-iproc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index d7fd76b..19ef2b0 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -790,7 +790,10 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
>   
>   static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
>   {
> -	u32 val = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +	u32 val;
> +
> +	/* We do not support the SMBUS Quick command */
> +	val = I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
>   
>   	if (adap->algo->reg_slave)
>   		val |= I2C_FUNC_SLAVE;
> 

Change looks good to me. Thanks.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>


