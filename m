Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ED5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE9C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FkOMMl3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfHLRdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:33:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52813 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfHLRdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:33:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so317229wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cAgtYZHgV6xUR+yC/VEEeHLdtqd6juyZ2ABBZdUumQE=;
        b=FkOMMl3g4RPI0502AjI9JhmjFGhx8iEHR6MXlhd7QQb38nkD5pmT0wlZ6B3cwjdfkR
         a4w1WS5ORSm542pGKgVcQXmLXR4jP/kFGbW6sQYIOny5xVRPsj5D3HEidrrZ5iJVn8JP
         u+CpTzQoxr5Pe+QSU9KvI1UUpxSr9VhDPwGOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cAgtYZHgV6xUR+yC/VEEeHLdtqd6juyZ2ABBZdUumQE=;
        b=BCCWfEH4X+6wR9wOfnPSBkk0YNIw1jNs748UrVX35+HdeC4EuZLtnmEoPQbgdMpoho
         eIvLqHMHJwWOOXYVtCn8ER6w7rSduI2BlUuZR2xpRocZSd9Oni81Cy66McFdisRaRl14
         azjd3b2P5Hd3HsI+kAVVxe5Vu9dkFICTsdo2bDt1NzLh4bIU35AXbT38RUwyG9K7pEwr
         cfmeONTf0LJXMWX3ZWI5RiH5TWvWzla++kPsGJlhtNNR/hK9m75CMuqtNZBMuitVtaiX
         mHmb7ZNF4L7WvTYOZJqA4aPkgIqlVF4Dcs7IMfX7jvtUMqJPGKZsNmk4Iop6fcYUl6u1
         yLqA==
X-Gm-Message-State: APjAAAVtsehpnWI2M2TcP5K7b26S1JKqFALCZk8kOkhqAAEyNLDRURbN
        YNbrPkJ2Np8GFWnxO+H0urKAKg==
X-Google-Smtp-Source: APXvYqzl9ysVhJW+R47AyXAx8TEcPlPa5dLrHEwezvxULcJifU7LOO2WC9NW3PQshBaROW+6GP8lMw==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr402521wml.175.1565631227782;
        Mon, 12 Aug 2019 10:33:47 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j10sm183930432wrd.26.2019.08.12.10.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 10:33:47 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] i2c: iproc: Add i2c repeated start capability
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        Icarus Chau <icarus.chau@broadcom.com>,
        Shivaraj Shetty <sshetty1@broadcom.com>
References: <1565150941-27297-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <a2b0ccc1-63d5-177d-2b54-d79c65057907@broadcom.com>
Date:   Mon, 12 Aug 2019 10:33:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565150941-27297-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 8/6/19 9:09 PM, Rayagonda Kokatanur wrote:
> From: Lori Hikichi <lori.hikichi@broadcom.com>
> 
> Enable handling of i2c repeated start. The current code
> handles a multi msg i2c transfer as separate i2c bus
> transactions. This change will now handle this case
> using the i2c repeated start protocol. The number of msgs
> in a transfer is limited to two, and must be a write
> followed by a read.
> 
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Icarus Chau <icarus.chau@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Shivaraj Shetty <sshetty1@broadcom.com>
> ---

Note this patch has gone through internal review and testing on various 
I2C slave devices. It is introduced to work around limitation of our I2C 
controller and allows it to work on certain I2C slave devices that are 
sensitive and requires repeated start between transactions instead of a 
stop.

Given that my name is also on the Signed-off-by since I helped to 
rewrite part of the patch, I'm not going to add my Reviewed-by tag here.

Please help to review.

Thanks,

Ray

>   drivers/i2c/busses/i2c-bcm-iproc.c | 70 +++++++++++++++++++++++++++++++-------
>   1 file changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index d7fd76b..15fedcf 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -81,6 +81,7 @@
>   #define M_CMD_PROTOCOL_MASK          0xf
>   #define M_CMD_PROTOCOL_BLK_WR        0x7
>   #define M_CMD_PROTOCOL_BLK_RD        0x8
> +#define M_CMD_PROTOCOL_PROCESS       0xa
>   #define M_CMD_PEC_SHIFT              8
>   #define M_CMD_RD_CNT_SHIFT           0
>   #define M_CMD_RD_CNT_MASK            0xff
> @@ -675,13 +676,20 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
>   	return 0;
>   }
>   
> -static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
> -					 struct i2c_msg *msg)
> +/*
> + * If 'process_call' is true, then this is a multi-msg transfer that requires
> + * a repeated start between the messages.
> + * More specifically, it must be a write (reg) followed by a read (data).
> + * The i2c quirks are set to enforce this rule.
> + */
> +static int bcm_iproc_i2c_xfer_internal(struct bcm_iproc_i2c_dev *iproc_i2c,
> +					struct i2c_msg *msgs, bool process_call)
>   {
>   	int i;
>   	u8 addr;
>   	u32 val, tmp, val_intr_en;
>   	unsigned int tx_bytes;
> +	struct i2c_msg *msg = &msgs[0];
>   
>   	/* check if bus is busy */
>   	if (!!(iproc_i2c_rd_reg(iproc_i2c,
> @@ -707,14 +715,29 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>   			val = msg->buf[i];
>   
>   			/* mark the last byte */
> -			if (i == msg->len - 1)
> -				val |= BIT(M_TX_WR_STATUS_SHIFT);
> +			if (!process_call && (i == msg->len - 1))
> +				val |= 1 << M_TX_WR_STATUS_SHIFT;
>   
>   			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
>   		}
>   		iproc_i2c->tx_bytes = tx_bytes;
>   	}
>   
> +	/* Process the read message if this is process call */
> +	if (process_call) {
> +		msg++;
> +		iproc_i2c->msg = msg;  /* point to second msg */
> +
> +		/*
> +		 * The last byte to be sent out should be a slave
> +		 * address with read operation
> +		 */
> +		addr = msg->addr << 1 | 1;
> +		/* mark it the last byte out */
> +		val = addr | (1 << M_TX_WR_STATUS_SHIFT);
> +		iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
> +	}
> +
>   	/* mark as incomplete before starting the transaction */
>   	if (iproc_i2c->irq)
>   		reinit_completion(&iproc_i2c->done);
> @@ -733,7 +756,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>   	 * underrun interrupt, which will be triggerred when the TX FIFO is
>   	 * empty. When that happens we can then pump more data into the FIFO
>   	 */
> -	if (!(msg->flags & I2C_M_RD) &&
> +	if (!process_call && !(msg->flags & I2C_M_RD) &&
>   	    msg->len > iproc_i2c->tx_bytes)
>   		val_intr_en |= BIT(IE_M_TX_UNDERRUN_SHIFT);
>   
> @@ -743,6 +766,8 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>   	 */
>   	val = BIT(M_CMD_START_BUSY_SHIFT);
>   	if (msg->flags & I2C_M_RD) {
> +		u32 protocol;
> +
>   		iproc_i2c->rx_bytes = 0;
>   		if (msg->len > M_RX_FIFO_MAX_THLD_VALUE)
>   			iproc_i2c->thld_bytes = M_RX_FIFO_THLD_VALUE;
> @@ -758,7 +783,10 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>   		/* enable the RX threshold interrupt */
>   		val_intr_en |= BIT(IE_M_RX_THLD_SHIFT);
>   
> -		val |= (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
> +		protocol = process_call ?
> +				M_CMD_PROTOCOL_PROCESS : M_CMD_PROTOCOL_BLK_RD;
> +
> +		val |= (protocol << M_CMD_PROTOCOL_SHIFT) |
>   		       (msg->len << M_CMD_RD_CNT_SHIFT);
>   	} else {
>   		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
> @@ -774,17 +802,31 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
>   			      struct i2c_msg msgs[], int num)
>   {
>   	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adapter);
> -	int ret, i;
> +	bool process_call = false;
> +	int ret;
>   
> -	/* go through all messages */
> -	for (i = 0; i < num; i++) {
> -		ret = bcm_iproc_i2c_xfer_single_msg(iproc_i2c, &msgs[i]);
> -		if (ret) {
> -			dev_dbg(iproc_i2c->device, "xfer failed\n");
> -			return ret;
> +	if (num > 2) {
> +		dev_err(iproc_i2c->device,
> +			"Only support up to 2 messages. Current msg count %d\n",
> +			num);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (num == 2) {
> +		/* Repeated start, use process call */
> +		process_call = true;
> +		if (msgs[1].flags & I2C_M_NOSTART) {
> +			dev_err(iproc_i2c->device, "Invalid repeated start\n");
> +			return -EOPNOTSUPP;
>   		}
>   	}
>   
> +	ret = bcm_iproc_i2c_xfer_internal(iproc_i2c, msgs, process_call);
> +	if (ret) {
> +		dev_dbg(iproc_i2c->device, "xfer failed\n");
> +		return ret;
> +	}
> +
>   	return num;
>   }
>   
> @@ -806,6 +848,8 @@ static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
>   };
>   
>   static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> +	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
> +	.max_comb_1st_msg_len = M_TX_RX_FIFO_SIZE,
>   	.max_read_len = M_RX_MAX_READ_LEN,
>   };
>   
> 
