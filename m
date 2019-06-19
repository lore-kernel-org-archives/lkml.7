Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9639C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B952206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpgCYgV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFSOIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:08:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35225 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfFSOIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:08:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so19423882otq.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pAiH03kncavoXyLc1Eknk+svRY2+Ge1NcF9vyuUm92A=;
        b=dpgCYgV+kWHJKNjqwnayFjgikgytQOekff4vmPGqKiXN9ziupaPpZj6+0HUvI9TcUk
         1jdifpAXy7T1+b/VH4nikcXUu7/DjT7ivqggirJN9Cl36mrTpDNqeoin3rh25NztOjqB
         sZCONy61pZiDv5Uf5dsX3sQsh53jkRS+h3c68ozprkjrOskso+Ctf6mog9okrbvhpkGs
         Q9qelni5rGHgJwE3BCdFfzcooS3IxqrlXXJtPlBYwoo+DQ+Im23UXz1HYimuDnknmxGd
         akuFghcS3V/1P+rsMjIdSCd0QfSNCnj3pkvUVBb1fVIUREhHGZAdrJjLNnKhg8+Ve8KX
         9Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=pAiH03kncavoXyLc1Eknk+svRY2+Ge1NcF9vyuUm92A=;
        b=ettTuyMQcOIcSPGextyfNrUWvXSSxEnI5af7202tt+kygW+Jx2UZqHFR9NkPxW5f9T
         zEF2kxAkT2FSojvmRcC3Lr5mIPsrM84IBePdB1o/QjBFq2j5axl+lPcEVNgEDh6BJXd5
         aRmpPBnTK08uWxqSkYXGDz+EmJ7HC0c8BAkDr2G/61V/840SOxyvuxYxouk5VgSwJBmy
         6m6RgqhGgYcWTYYbM0hKq/3Yrln+FI5FIFIuUTRdSDvKHrVUNjDoHwI3c4Q+lnsAhInG
         a04UwHiu+YFkK/4byrXiIpNCKYdBPm+T3wKnZVrN+nsDopDmQSNFQfOJ55KJHYUt8PP3
         svCQ==
X-Gm-Message-State: APjAAAVNI+sYIC1sdlEidzCgwO+15zMnEkZ3NwosdrawRkQHMgSbDc1j
        Q/M8TNNn1DBG1PjCZmx0CeSrgEs=
X-Google-Smtp-Source: APXvYqxpYFHJG2nhLsugZY7xZIOIvhW0nXQTNOsL8SUKG9gxcyHsUg0YhQr++tfaOBQauJN45wQZxw==
X-Received: by 2002:a9d:6e93:: with SMTP id a19mr6113364otr.216.1560953284891;
        Wed, 19 Jun 2019 07:08:04 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id w17sm6834733oia.24.2019.06.19.07.08.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 07:08:04 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5546:341d:943c:c2a3])
        by serve.minyard.net (Postfix) with ESMTPSA id E51B31800CE;
        Wed, 19 Jun 2019 14:08:03 +0000 (UTC)
Date:   Wed, 19 Jun 2019 09:08:02 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Asmaa Mnebhi <Asmaa@mellanox.com>, vadimp@mellanox.com,
        Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: ipmb: don't allocate i2c_client on stack
Message-ID: <20190619140802.GB7168@minyard.net>
Reply-To: minyard@acm.org
References: <20190619125045.918700-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619125045.918700-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 02:50:34PM +0200, Arnd Bergmann wrote:
> The i2c_client structure can be fairly large, which leads to
> a warning about possible kernel stack overflow in some
> configurations:
> 
> drivers/char/ipmi/ipmb_dev_int.c:115:16: error: stack frame size of 1032 bytes in function 'ipmb_write' [-Werror,-Wframe-larger-than=]
> 
> There is no real reason to even declare an i2c_client, as we can simply
> call i2c_smbus_xfer() directly instead of the i2c_smbus_write_block_data()
> wrapper.
> 
> Convert the ipmb_write() to use an open-coded i2c_smbus_write_block_data()
> here, without changing the behavior.
> 
> It seems that there is another problem with this implementation;
> when user space passes a length of more than I2C_SMBUS_BLOCK_MAX
> bytes, all the rest is silently ignored. This should probably be
> addressed in a separate patch, but I don't know what the intended
> behavior is here.
> 
> Fixes: 51bd6f291583 ("Add support for IPMB driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I broke up the line with the call to i2c_smbus_xfer(), which was
longer than 80 characters, but that's it, it's in the IPMI next queue.

Thanks,

-corey

> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 2895abf72e61..c9724f6cf32d 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -117,7 +117,7 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>  {
>  	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
>  	u8 rq_sa, netf_rq_lun, msg_len;
> -	struct i2c_client rq_client;
> +	union i2c_smbus_data data;
>  	u8 msg[MAX_MSG_LEN];
>  	ssize_t ret;
>  
> @@ -138,17 +138,17 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>  
>  	/*
>  	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
> -	 * i2c_smbus_write_block_data_local
> +	 * i2c_smbus_xfer
>  	 */
>  	msg_len = msg[IPMB_MSG_LEN_IDX] - SMBUS_MSG_HEADER_LENGTH;
> -
> -	strcpy(rq_client.name, "ipmb_requester");
> -	rq_client.adapter = ipmb_dev->client->adapter;
> -	rq_client.flags = ipmb_dev->client->flags;
> -	rq_client.addr = rq_sa;
> -
> -	ret = i2c_smbus_write_block_data(&rq_client, netf_rq_lun, msg_len,
> -					msg + SMBUS_MSG_IDX_OFFSET);
> +	if (msg_len > I2C_SMBUS_BLOCK_MAX)
> +		msg_len = I2C_SMBUS_BLOCK_MAX;
> +
> +	data.block[0] = msg_len;
> +	memcpy(&data.block[1], msg + SMBUS_MSG_IDX_OFFSET, msg_len);
> +	ret = i2c_smbus_xfer(ipmb_dev->client->adapter, rq_sa, ipmb_dev->client->flags,
> +			     I2C_SMBUS_WRITE, netf_rq_lun,
> +			     I2C_SMBUS_BLOCK_DATA, &data);
>  
>  	return ret ? : count;
>  }
> -- 
> 2.20.0
> 
