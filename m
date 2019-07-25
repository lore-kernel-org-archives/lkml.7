Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED2FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656B2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGVzGqhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbfGYQq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:46:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41873 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGYQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:46:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so23055660pff.8;
        Thu, 25 Jul 2019 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wqHGs0W9dhrroACMuLmGmG4a/N9HRNOca7cF6MXu8oc=;
        b=cGVzGqhbqjhCUDRKLriWnDTHZ/iA4EJ6CJ2y6nyqQkS838JMU5t+Nt+wjKDIAVOnAn
         y/9CnnkeXXuJTEnRbnhqOVjutp9f/kE1MCiCJ+HLApB7IdT/PXje0tFrwRXvdDkSE+lw
         0E3uO33OvSOqUk+e8o7SRlYvwyI+sn8ykzOhsABWNyGHbfNeZ8MsyhGJuhO780WaLCkt
         Jwd6PrY9tPxaHcXZx8v8sHDkg9wQ3jQngfcRF0sP0XAZ3MSjlN30PHlES18O8fdplRgy
         mtH4hWFPx1SoKkVNRC98gKcWjvaIQ3My2DNbq4y8ukRnSUYxg8aPtjooCCiBQt3ZI2Xa
         IDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wqHGs0W9dhrroACMuLmGmG4a/N9HRNOca7cF6MXu8oc=;
        b=nnBecKryeoLUTc+ZqX0zxYJs00kGFsOtBRhh2gqHmfpsaQ3z7zMkREc8+MpEo0vqS9
         vuaa/Om6xNDWJJ0Qd/JyDstfZTxIu1FtHFO+j3/+RM+3trc2Im2e1VDFBRmgD7mU9vjQ
         LihKTxep34IJfeLaeDX9YeCOofXyumZBlfDRq9FqaYt/8CsKLv/m4+czCQDTwnfNHNjZ
         vr7NLemVHbvXwHt9U/rjPTL1EjxM9inbev7PpClKlvvmR5AvWa10WfS2iAs8Ucb8DOUo
         C94qb7cC/q53IH4YqpDd5poZRoDjOdDLryUjPYG8ylUcLQhsoMkvYXmcorR8pOnJxYCy
         rMsw==
X-Gm-Message-State: APjAAAXvuoJuVncL43TJMpGO8+T2gpwUO8sPH0U2+jnJiror8n32rPq9
        ruIT1poUIpCL4D7wXqPlfxTJIPKs
X-Google-Smtp-Source: APXvYqw0UneiWfUn8WTfkS2QppYn6sL6sOc1ydxVhpo/w4zl3zpCalmNspVXrYCp8uhHWvX7rkivwQ==
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr95888474pjp.70.1564073215036;
        Thu, 25 Jul 2019 09:46:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 85sm52396243pfv.130.2019.07.25.09.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:46:54 -0700 (PDT)
Date:   Thu, 25 Jul 2019 09:46:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     r.marek@assembler.cz, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: w83793: Fix possible null-pointer dereferences in
 watchdog_open()
Message-ID: <20190725164653.GB11220@roeck-us.net>
References: <20190725084156.15554-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190725084156.15554-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 04:41:56PM +0800, Jia-Ju Bai wrote:
> In watchdog_open(), data is initialized as NULL.
> After the loop "list_for_each_entry" on lines 1302-1307, 
> data may not be assigned, thus data is still NULL.
> 
> In this case, data is used on line 1310:
>     watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
> and on line 1317：
>     kref_get(&data->kref);
> and on line 1326:
>     watchdog_enable(data);
> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these bugs, data is checked after the loop.
> If it is NULL, the mutex lock is released and -EINVAL is returned.
> 
> These bugs are found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

In practice this can't happen because the device can only be opened
if the device node exists (because otherwise there is nothing to
open). The potential race condition is addressed with watchdog_data_mutex,
which ensures that the device is added to watchdog_data_list by the
time the open function is called.

I understand this is tricky, but in situations like this it would really
be better to rework the driver completely. It should use the watchdog core,
and the hwmon driver part is in equally bad shape and should at least use
hwmon_device_register_with_groups(). That is quite unlikely to happen,
given the age of the chip. As such, it is better to leave the driver alone
unless something is really broken with it (ie breakage is observed, meaning
someone is actually using it).

Thanks,
Guenter

> ---
>  drivers/hwmon/w83793.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index 46f5dfec8d0a..f299716d5d94 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -1306,6 +1306,11 @@ static int watchdog_open(struct inode *inode, struct file *filp)
>  		}
>  	}
>  
> +	if (!data) {
> +		mutex_unlock(&watchdog_data_mutex);
> +		return -EINVAL;
> +	}
> +
>  	/* Check, if device is already open */
>  	watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
>  
> -- 
> 2.17.0
> 
