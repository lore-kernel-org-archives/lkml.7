Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDFEC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767DF20673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tf0kGDzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbfFKK5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:57:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36696 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388487AbfFKK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:57:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so754783pgi.3;
        Tue, 11 Jun 2019 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NTaC/S77N+wYOnB6ltXnK1NPB8xaQz3FUn5xkbGkDUE=;
        b=tf0kGDzD4d9DW6cYr4GzUHjL43Qv448VyaoCqkh6aLb1dLuPlH4LnWC4zV+v0FM6KJ
         XHZliyo+ZVMcR5h7a0s3zm9GMZ3hjW7eaHZixQh7FKR27XHF5Es6EI4ivLc9Io5iy/nZ
         fflJOg4/NasnBDELNjEZ8t3MqJ5YzXLWxe6mfYGDzU8sydoqPpLxjpJIGhWI+RiQllWp
         B//IygIHK4TWFgVcH43juR0OYxM8ciCl+u4sIuDOzyn1V0fPzKLDeCAaTFDXUeyC+bXL
         fFpycW/QoNtfF3I8FxiYQqwRY8VaNjniMcfudR9rkChWd0AareHQSGyxmbGmhAvAzzLg
         mGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NTaC/S77N+wYOnB6ltXnK1NPB8xaQz3FUn5xkbGkDUE=;
        b=d0bh9r09ultCO+aVMGsrGoUZILC+Dn/z427HWg0DTvTBaN/rWk7kxrudEW0h4t8EJ6
         XxfPENm04SVRBxSMV2xmHu6lbS2bAiJjIPKBPoDEr1gHeHWpx4tN0LUXiP/msxsTjQj4
         3H94Ei8iacbFpSf4OjUoilkQR8SkoQJedlhtaQfQFmQnLQo7Ke8reKwF+zwokasOWC2N
         SBHmRP5c377kJNxubEeiFZ/esS3fuXkJShQB1FMSvbBmtbFZCqIL7cgpk5GPAtyQIdJi
         tbzp99kCDUZNwGE6iGzyZ5O9Rb0vreikE74kJmy6OeSfIhffEe4rNUvxDj/prd8RhOc7
         EvAw==
X-Gm-Message-State: APjAAAXu64PEbNEgt9/lmWG3bcXkBZV9bmh439aOOKaxTNiQrmd0K9R1
        zXcLzo43mevUmbmPk58f99OXJx8D
X-Google-Smtp-Source: APXvYqwd6hTQb8b5qIav5oS0XelM/MKJ+RUEzzPMdD8olaaGc1NwQCgINyg+qjDh1QzxWJFOWXJfpA==
X-Received: by 2002:a17:90a:dd45:: with SMTP id u5mr5481580pjv.109.1560250672123;
        Tue, 11 Jun 2019 03:57:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g8sm1772700pjs.23.2019.06.11.03.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 03:57:51 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (ads7871) Switch to SPDX header
To:     Lubomir Rintel <lkundrak@v3.sk>, Jean Delvare <jdelvare@suse.com>
Cc:     Paul Thomas <pthomas8589@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190611071948.2978150-1-lkundrak@v3.sk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c080938b-eb7e-c21f-52d1-a35a1150c82f@roeck-us.net>
Date:   Tue, 11 Jun 2019 03:57:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611071948.2978150-1-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 12:19 AM, Lubomir Rintel wrote:
> The original license text had a typo ("publishhed") which would be
> likely to confuse automated licensing auditing tools. Let's just switch
> to SPDX instead of fixing the wording.
> 
If you have a look into the upstream kernel, you may notice that
this has already been done. Same for the other patch.

Guenter

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>   drivers/hwmon/ads7871.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
> index cd14c1501508..7ccc79f77f95 100644
> --- a/drivers/hwmon/ads7871.c
> +++ b/drivers/hwmon/ads7871.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    *  ads7871 - driver for TI ADS7871 A/D converter
>    *
>    *  Copyright (c) 2010 Paul Thomas <pthomas8589@gmail.com>
>    *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - *  GNU General Public License for more details.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2 or
> - *  later as publishhed by the Free Software Foundation.
> - *
>    *	You need to have something like this in struct spi_board_info
>    *	{
>    *		.modalias	= "ads7871",
> 

