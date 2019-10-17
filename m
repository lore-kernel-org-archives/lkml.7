Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF82ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20CC21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy0xVF3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436666AbfJQNlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:41:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44719 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436617AbfJQNlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:41:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so1143661pll.11;
        Thu, 17 Oct 2019 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TL3Bg7r1MXFPw1qs6Uz1yY89VM2LxUEc4gTHtQnByTU=;
        b=Zy0xVF3gW175CXK55XKrdH/JLGDt7X4DOFuNpbYIGPoM14uKARAnqw7WcnM8zChdKb
         pbzT13T67DsiJMFD8fgtHQ+/frSFrC+UkMZW4iPyvvaq5sUKJ7UmEHRwJH26u54fHRCK
         gaRy6kNkw4M0jkSIbEYXiSOOx6wMx3Lw+lso7kMfXPgKd1iTKBTK8F2s8g9Dsltqpezj
         n/+7TK0janpFmElAtHDN8Y1DLiLud+0DWAlLN8KsMGNTbrz/gUueF5kRvLknPkadhuFH
         +0Su+pFYBqDdpfqgLPtkeH2LvTO74p3Gkpk4w4okqdvDKWSZC4dbUEZuHR22tWaUvDLW
         Baqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TL3Bg7r1MXFPw1qs6Uz1yY89VM2LxUEc4gTHtQnByTU=;
        b=fvpDt/DM+Cc/6hd6uycFP5jPqo/JMDoJgOAJe5FEt6x/plgYLG+0f5iifbrTT6KTZP
         h2b31N+AU7eZU6X1Vlf+XDl5MhmX7BPzRDfV+0Sg22hdBfaUoW6PSDCbHjLzP34ByiYC
         JhWszThwxnzJWIRKrQ4VwcuxS140UG3uTSTN6EduoHvvnWKFygz9IJXKW5k3MkAjkgn3
         /HVeq4OfxZTJKgjA/D2pu3oQ8zFIdpetEiTqK4VklhQgEwUbbfyVPW8M6gRTCVvewvCL
         bYf/ygt7dEqoYxK1R0vhPkt26Oinq6FmRxmIx0Wmv7ToQfiE8fDh3SQ+k4zrQQ/tJIT1
         pdqA==
X-Gm-Message-State: APjAAAUlbV0kv5VTHSkwyvXDG0JyIt/72DgntMTFO8yLFrTU7BDDtgqc
        Ua6wEcKnSQ6gjutQ1vTpTug=
X-Google-Smtp-Source: APXvYqwGQCGTWsGO+MsP8uWNdB9De0wiZ/ITWfcDFpRvFh1F4msaJNgw+5RJInI+8eM5QXmtXdgMpg==
X-Received: by 2002:a17:902:ab82:: with SMTP id f2mr4192546plr.39.1571319667155;
        Thu, 17 Oct 2019 06:41:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p189sm2717695pfp.163.2019.10.17.06.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 06:41:06 -0700 (PDT)
Date:   Thu, 17 Oct 2019 06:41:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Roeschley <kyle.roeschley@ni.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (tmp421) Allow reading at 2Hz instead of 0.5Hz
Message-ID: <20191017134105.GA6766@roeck-us.net>
References: <20191014140310.7438-1-kyle.roeschley@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014140310.7438-1-kyle.roeschley@ni.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 09:03:10AM -0500, Kyle Roeschley wrote:
> Our driver configures the device to read at 2Hz, but then only allows the
> user to read cached temp values at up to 0.5Hz. Let's allow users to read
> as quickly as we do.
> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/tmp421.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index a94e35cff3e5..83a4fab151d2 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -127,7 +127,8 @@ static struct tmp421_data *tmp421_update_device(struct device *dev)
>  
>  	mutex_lock(&data->update_lock);
>  
> -	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
> +	if (time_after(jiffies, data->last_updated + (HZ / 2)) ||
> +	    !data->valid) {
>  		data->config = i2c_smbus_read_byte_data(client,
>  			TMP421_CONFIG_REG_1);
>  
