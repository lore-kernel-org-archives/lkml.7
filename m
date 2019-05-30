Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F351C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4576F25E46
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvyah85P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE3RVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:21:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3RVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:21:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so4347809pfm.13;
        Thu, 30 May 2019 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ImDPwL3I+w8BoRqnd5eRM3+R8I/eXEMLrLJdrRnJGP8=;
        b=rvyah85PBMMF6fSehi9wvZfJvOlEiwurKCDdHwrZ2f5fh8OIO5nuTy4ApgBznEv7xq
         ZVJbTGAiTAc4HnxcdFtHuUUrYjIlVKkiDnPsXqxtLTowv9VDw6l8yufrilq9B+S0XuMA
         +WDbzrxSaCSzRb3AJJF1Bjc4VSvEL+U6TaYnPIen5MLG2H6wsyuBzTHu73TJ9HG4/34v
         dPX14My1cnc8XywDE3mC64bL4U1xivYIip1qqG0Y93iuuzcme4oyH/a8hnSvcNdYfClw
         3khKWCCfS6qdwK/wCe4IdIQFkb476hULgTr1d3MwwnsAlJloHVOMubOJeR8DbEMaq+Kj
         OhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ImDPwL3I+w8BoRqnd5eRM3+R8I/eXEMLrLJdrRnJGP8=;
        b=FPODyWB5pOcAG6M4ZVOLJcmvPagk7/VV2+QcmKkzMk0QuuUjtJdtx7eoC5hhN4unFd
         /9RbAYc+WBLBAwjJ14DAg8H9ccC6UpKBjvpkV96++WAZZJqki9OiInGjquEPUgSlsp1A
         Ct8Fc5aDd0uPNgC+2RXdu8dJm3noqKKpVvychz2ek/x2rgv+vG4Xr5jJ/IlyjGrGjx+D
         5ym7wlxN8vltM9m3Rb9wS3bEUBkDYKUrhuAkcY9K2umlQLeH06ptoJVuyBkEZlSscMyu
         yfW711LnD2qlDXiQVSEx3U1sfz+FrgV+WCQR8xGVBQjGWtDdE4e7AnKiGEGBorbNFSwd
         m8gA==
X-Gm-Message-State: APjAAAXS4cznpEj3tISBZZLfbSxyI3iitGtD4fUPboYbePH1GxBWPMi2
        U5JGWTsaLOT9TXoZzNIzyAo=
X-Google-Smtp-Source: APXvYqwu621Z9vd819IPtN8DotvELno2ZdptP5eZ+k/WpG5kRtSvkQG3qtAcf1ovJ4KF97KqXwEm+A==
X-Received: by 2002:a63:cb:: with SMTP id 194mr4561175pga.395.1559236883517;
        Thu, 30 May 2019 10:21:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i7sm3660624pfo.19.2019.05.30.10.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 10:21:22 -0700 (PDT)
Date:   Thu, 30 May 2019 10:21:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Message-ID: <20190530172120.GA22145@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 30, 2019 at 06:45:48AM +0000, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
> The operation done in the pmbus_update_fan() function is a
> read-modify-write operation but it lacks any kind of lock protection
> which may cause problems if run more than once simultaneously. This
> patch uses an existing update_lock mutex to fix this problem.
> 
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> ---
> 
> I'm resending this patch to proper recipients this time. Sorry if the
> previous submission confused anybody.
> 
>  drivers/hwmon/pmbus/pmbus_core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index ef7ee90ee785..94adbede7912 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -268,6 +268,7 @@ int pmbus_update_fan(struct i2c_client *client, int page, int id,
>  	int rv;
>  	u8 to;
>  
> +	mutex_lock(&data->update_lock);
>  	from = pmbus_read_byte_data(client, page,
>  				    pmbus_fan_config_registers[id]);
>  	if (from < 0)
> @@ -278,11 +279,15 @@ int pmbus_update_fan(struct i2c_client *client, int page, int id,
>  		rv = pmbus_write_byte_data(client, page,
>  					   pmbus_fan_config_registers[id], to);
>  		if (rv < 0)
> -			return rv;
> +			goto out;
>  	}
>  
> -	return _pmbus_write_word_data(client, page,
> -				      pmbus_fan_command_registers[id], command);
> +	rv = _pmbus_write_word_data(client, page,
> +				    pmbus_fan_command_registers[id], command);
> +
> +out:
> +	mutex_lock(&data->update_lock);

Should be mutex_unlock(), meaning you have not tested this ;-).

Either case, I think this is unnecessary. The function is (or should be)
always called with the lock already taken (ie with pmbus_set_sensor()
in the call path). If not, we would need a locked and an unlocked version
of this function to avoid lock recursion.

Thanks,
Guenter

> +	return rv;
>  }
>  EXPORT_SYMBOL_GPL(pmbus_update_fan);
>  
> -- 
> 2.20.1
> 
