Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8092C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702DB21929
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW8QRsc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfKFAxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:53:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44012 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfKFAxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:53:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so7333218oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9Pg0JQBq9olWzIox809pWVr9m3m9tTHnVzraba7SzM=;
        b=lW8QRsc5AkkZwfN0feDJmRYBr3aYw7pQal8SFSlGBYYB5pyPFlopEm3/fY102S85OD
         +GWLcgmMtSMJV+7e1b1kHUpvmZQSyGVCJhYvC1KfFxkcd0V7vZKQUjGEzoySz94SNvi+
         QjCHudKIe5fbXdlgnze8ffVrk8Kg/5tpVZuaywZV+uSdPNEHevH78VeZt5lYrEWYCO6U
         cMCH0DjXBXYf8u0XGgjKEbbxEmYRI9JdfUYlkFxuCqFN1pXZ5YxDlvyuZ1mQMg1KY2m4
         hC7Cq+jZvnwOXPVb927XxC86sRxXLQmgAEGEnBbKBhsuvffUUtRe8yEezM5ua+HdcEkZ
         +s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=P9Pg0JQBq9olWzIox809pWVr9m3m9tTHnVzraba7SzM=;
        b=b1eLBPcFT4RH+aHA0Asz4gq2gNUdGyj9Pbv8wyGFaMZ1izJxDiAdBqyu1LxTwq/Xw/
         At02YRU04me4kFwHZNV7+DMbFJ3NMX30Gnl5YEdz+IewARQWYY4Wpp4vfE16GgpAqc3l
         NJSxSst7Bw069tGMQxd4G4HimU0LGKfDY2blapyUKFucOt5XYKe41VGvFK3eqGopYGy2
         s2h97ZWJZY5f4NkJrJkaFkQSw/SoXW1ocZ7nUqKG0OMyDqQugqiwD8TZZxGmxnLXAkwa
         5yWrevX3m5KjkSKkibZD8jowJ9+KvvzQmEcYR+s5AZn45W/BoIsv9IHH/IDA4TnqkBaU
         szBw==
X-Gm-Message-State: APjAAAUMxZuMMsflfYBNzfQtjwjqrWbFsW3nfMLOed/3sbSR99My/oQT
        uoF87ubLIvHrnvEASMP1MfmdniA=
X-Google-Smtp-Source: APXvYqw5BBxvW9KfjRdTCsJ0Opct2+UrH4BnJ/XsbHqv05DiaZYEZmhjOaQY6LKSrI56LdVdFfjZbg==
X-Received: by 2002:aca:3889:: with SMTP id f131mr124947oia.14.1573001615578;
        Tue, 05 Nov 2019 16:53:35 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id v13sm1308951ota.53.2019.11.05.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 16:53:34 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id E48E6180044;
        Wed,  6 Nov 2019 00:53:33 +0000 (UTC)
Date:   Tue, 5 Nov 2019 18:53:32 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, cminyard@mvista.com,
        asmaa@mellanox.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        sdasari@fb.com
Subject: Re: [PATCH] drivers: ipmi: Support for both IPMB Req and Resp
Message-ID: <20191106005332.GA2754@minyard.net>
Reply-To: minyard@acm.org
References: <20191105194732.1521963-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105194732.1521963-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:47:31AM -0800, Vijay Khemka wrote:
> Removed check for request or response in IPMB packets coming from
> device as well as from host. Now it supports both way communication
> to device via IPMB. Both request and response will be passed to
> application.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 29 +----------------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 285e0b8f9a97..7201fdb533d8 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -133,9 +133,6 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>  	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
>  	netf_rq_lun = msg[NETFN_LUN_IDX];
>  
> -	if (!(netf_rq_lun & NETFN_RSP_BIT_MASK))
> -		return -EINVAL;
> -
>  	/*
>  	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
>  	 * i2c_smbus_xfer
> @@ -203,28 +200,6 @@ static u8 ipmb_verify_checksum1(struct ipmb_dev *ipmb_dev, u8 rs_sa)
>  		ipmb_dev->request.checksum1);
>  }
>  
> -static bool is_ipmb_request(struct ipmb_dev *ipmb_dev, u8 rs_sa)
> -{
> -	if (ipmb_dev->msg_idx >= IPMB_REQUEST_LEN_MIN) {
> -		if (ipmb_verify_checksum1(ipmb_dev, rs_sa))
> -			return false;

You still need to check the message length and checksum, you just need
to ignore the req/resp bit.

-corey

> -
> -		/*
> -		 * Check whether this is an IPMB request or
> -		 * response.
> -		 * The 6 MSB of netfn_rs_lun are dedicated to the netfn
> -		 * while the remaining bits are dedicated to the lun.
> -		 * If the LSB of the netfn is cleared, it is associated
> -		 * with an IPMB request.
> -		 * If the LSB of the netfn is set, it is associated with
> -		 * an IPMB response.
> -		 */
> -		if (!(ipmb_dev->request.netfn_rs_lun & NETFN_RSP_BIT_MASK))
> -			return true;
> -	}
> -	return false;
> -}
> -
>  /*
>   * The IPMB protocol only supports I2C Writes so there is no need
>   * to support I2C_SLAVE_READ* events.
> @@ -273,9 +248,7 @@ static int ipmb_slave_cb(struct i2c_client *client,
>  
>  	case I2C_SLAVE_STOP:
>  		ipmb_dev->request.len = ipmb_dev->msg_idx;
> -
> -		if (is_ipmb_request(ipmb_dev, GET_8BIT_ADDR(client->addr)))
> -			ipmb_handle_request(ipmb_dev);
> +		ipmb_handle_request(ipmb_dev);
>  		break;
>  
>  	default:
> -- 
> 2.17.1
> 
