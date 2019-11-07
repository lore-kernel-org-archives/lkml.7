Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60EBC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B642F2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbfG07kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbfKGNea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:34:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40610 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbfKGNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:34:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id m15so1996727otq.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+syRc+agoo08pLNzrJjXzWzp/e66MwKC2W+ow4e7bw=;
        b=GbfG07kSp5ixMQ4oonu7FLSf/87Uy4yl6Eiho1GtkM5AKVAv2sZ943At2fCDaBDJT2
         MC31nwMYp8r3iNBjuIHdBKTQUuoO5koaiBvy4wRKxMw3HYaXD6iCcpc+tvDw6ZHQGrhE
         U4UzGO6XTkWpl9D0+A2bVxNF//x9tHk1soaBDw2Yy5Ve6paG+Cirj21kY1zQf36xnnXN
         k2wcFx1K9EY8XEVPZ9i3cGxNtz/8wXqnf4IRh/cmzzKFue7CgK4L28JNaD85kBuwJFaz
         m7ECXnoWR9eHAhtMrQ+ykJLy+IW7yp2bs4DlFbFIsI5kITF14/Tfd3UjV9sWWYqiukwr
         2mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=x+syRc+agoo08pLNzrJjXzWzp/e66MwKC2W+ow4e7bw=;
        b=pVrs1eADWdp4n7G8zXGeZqXaqEgQH2HriUf2XJMMogh7aJnYLpXL9JL5KLD95LbHTR
         5CZcuis82fu5XnkFqkhWyLWLYaxUor1+VLHT1KnCH0Pczmlmy9Hk2A+siJOI2oYpMN48
         pVQ2OXjCGltrd4GiJsTEu5kabWqK73zKaKHO2XhZPfPPZ4Z22sKyME6VU2j0+Jh1Rcd1
         nQ9W4UkmJgJiahFLfQEAnp76PR58ywdbKK2U6roMXENkC/yZbmiMbu4gr1GgVxlEolpo
         Thadnkx8hNPRWDlC+gGnf6y0te7mMsNx++2iIGMCQ72mT72twZtObqjnOluge/rnOJQu
         fhDQ==
X-Gm-Message-State: APjAAAX1noTueZnmIv9ZG6YBel7Lbj7gg2z8RVkYz5qMjeS3Vu2Qnnoi
        AAYgaPr+lhhk8w0EXhe9TQ==
X-Google-Smtp-Source: APXvYqx78JdRY1/hVtPOwuo/shXRgmMvkCD+fJAlFhVerBdkFmI/xeERxi3QZg0O16tnBmjg70TbYA==
X-Received: by 2002:a9d:365:: with SMTP id 92mr3243984otv.9.1573133667411;
        Thu, 07 Nov 2019 05:34:27 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id 9sm620925ois.16.2019.11.07.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:34:26 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 32E62180046;
        Thu,  7 Nov 2019 13:34:26 +0000 (UTC)
Date:   Thu, 7 Nov 2019 07:34:25 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, cminyard@mvista.com,
        asmaa@mellanox.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        sdasari@fb.com
Subject: Re: [PATCH v2] drivers: ipmi: Support for both IPMB Req and Resp
Message-ID: <20191107133425.GA10276@minyard.net>
Reply-To: minyard@acm.org
References: <20191106182921.1086795-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106182921.1086795-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:29:21AM -0800, Vijay Khemka wrote:
> Removed check for request or response in IPMB packets coming from
> device as well as from host. Now it supports both way communication
> to device via IPMB. Both request and response will be passed to
> application.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Thanks, this is in my for-next tree now.  Asnaam, I took your previous
comments as a "Reviewed-by", if that is ok.

-corey

> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 285e0b8f9a97..ae3bfba27526 100644
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
> @@ -203,25 +200,16 @@ static u8 ipmb_verify_checksum1(struct ipmb_dev *ipmb_dev, u8 rs_sa)
>  		ipmb_dev->request.checksum1);
>  }
>  
> -static bool is_ipmb_request(struct ipmb_dev *ipmb_dev, u8 rs_sa)
> +/*
> + * Verify if message has proper ipmb header with minimum length
> + * and correct checksum byte.
> + */
> +static bool is_ipmb_msg(struct ipmb_dev *ipmb_dev, u8 rs_sa)
>  {
> -	if (ipmb_dev->msg_idx >= IPMB_REQUEST_LEN_MIN) {
> -		if (ipmb_verify_checksum1(ipmb_dev, rs_sa))
> -			return false;
> +	if ((ipmb_dev->msg_idx >= IPMB_REQUEST_LEN_MIN) &&
> +	   (!ipmb_verify_checksum1(ipmb_dev, rs_sa)))
> +		return true;
>  
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
>  	return false;
>  }
>  
> @@ -273,8 +261,7 @@ static int ipmb_slave_cb(struct i2c_client *client,
>  
>  	case I2C_SLAVE_STOP:
>  		ipmb_dev->request.len = ipmb_dev->msg_idx;
> -
> -		if (is_ipmb_request(ipmb_dev, GET_8BIT_ADDR(client->addr)))
> +		if (is_ipmb_msg(ipmb_dev, GET_8BIT_ADDR(client->addr)))
>  			ipmb_handle_request(ipmb_dev);
>  		break;
>  
> -- 
> 2.17.1
> 
