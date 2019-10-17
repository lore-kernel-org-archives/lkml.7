Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D13BFA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702052089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxy0x9pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436615AbfJQNjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:39:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37213 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbfJQNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:39:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so1690028pfo.4;
        Thu, 17 Oct 2019 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j+SsM7b+serKOV0a1OL5fJKTRYrA8B2EbLYPvjwJqF0=;
        b=Hxy0x9pWWQ9v1MYv0iktCe2UUJRjGUPJVPsf+fMy9I3MWgi5wa82Oc7+Aa2zGV9gmk
         3y/dWcoYWmZR20eZ5nu4jVd/WtIQhkRStD2+lfUgZmTns6YfJmckhMGLaLwB2jVkdcC2
         lViALbi67Xl3Ufl1frKuMSPH6BmSsSv4k3Fnnb5HvloAMxJ0xW+aeqnSN39k9c0smky9
         lRrNNdg2E85cm5fDr37uq1KRYBU03cvg4av+it7dkIA+AeidNwqd49w3sHZn4tRt0h1a
         yfJDEBYmHNjCrK/sffnnd4BkDDvQFWq6DmjdfTxa/F5sqoviHaC7/yuRSWCdJC6/FWoZ
         emPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j+SsM7b+serKOV0a1OL5fJKTRYrA8B2EbLYPvjwJqF0=;
        b=Q8Cad6UqmwrSUQ9GAbK7A+36zIVZdVCnmVGkd+tZ29kgvOVU4iIW2X4Ju020STwoCm
         su0+3S7VLxKU6Sbjq9+Peced6ZSak74RDAAMaQ7gUginpLxCt4N/BjCk0k6oVbu0w+wt
         ykIc07QRUTMIyhSgoX7hbiCJqyg9Nuqs0hjg0xhwmi4kISi+KN27gUYz9gxn7BC2AZ3W
         vAUVeBapoPufBycRq9vi4+V201Ho7he1miiMgA1DtnwQs8lKtr7z1BUvp/9zMeXeyP9z
         W8Zte6nH67brLmHQvrguEknxLaxBvclOG0cUuTkzSqoH+iKpcTFucV1KcIcpimLDkuUK
         FL3g==
X-Gm-Message-State: APjAAAVt/mAyk7JaHO/LKLfYje09pOtogv5zBfZv820YxAozG4nQPLnR
        +S3LxMYmyo+i+mWbCbQs0nt8DJsq
X-Google-Smtp-Source: APXvYqwivP6Moq2Hf1CSOnfBIzu4CkKMzsFVoLpK9HwneTAmWn06dYrwWR97qS3wohSUnruLSo2xlw==
X-Received: by 2002:a17:90a:9416:: with SMTP id r22mr4519604pjo.20.1571319543083;
        Thu, 17 Oct 2019 06:39:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x23sm2962192pfq.140.2019.10.17.06.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 06:39:02 -0700 (PDT)
Date:   Thu, 17 Oct 2019 06:39:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: w83793d: remove redundant assignment to variable
 res
Message-ID: <20191017133901.GA31691@roeck-us.net>
References: <20191011170215.11539-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011170215.11539-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 06:02:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable res is being initialized with a value that
> is never read and is being re-assigned a little later on. The
> assignment is redundant and hence can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied. Note that I removed the above Addreddes-Coverity tag as
it doesn't really make much sense.

Guenter

> ---
>  drivers/hwmon/w83793.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index 9df48b70c70c..a0307e6761b8 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -2096,7 +2096,7 @@ static struct w83793_data *w83793_update_device(struct device *dev)
>  static u8 w83793_read_value(struct i2c_client *client, u16 reg)
>  {
>  	struct w83793_data *data = i2c_get_clientdata(client);
> -	u8 res = 0xff;
> +	u8 res;
>  	u8 new_bank = reg >> 8;
>  
>  	new_bank |= data->bank & 0xfc;
