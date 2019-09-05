Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1742C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862802082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IcLjJF6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbfIEQqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:46:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33790 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389741AbfIEQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:46:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so1738248pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L9WHyJ99KP39xuH8ZsBbeD/D63ObFkXNBLywQqZYCeQ=;
        b=IcLjJF6Drj/jNnHL/b3X6MBESCOo9YBQ726xZEEEmWRXc8xz/NMkPi5oQm1CTl46ju
         10h5rfJrJmPahQG5I7wfMHm3Fmn2auuA4hO62jagzIOVh3dGJ1gcyIxA2phxbSqlEL8c
         65/MGCgUUJ5lOBWoETWECotdK7cREeFHnQuuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L9WHyJ99KP39xuH8ZsBbeD/D63ObFkXNBLywQqZYCeQ=;
        b=fwCUBGZgKGpzQROwQSHEwnp2FVftCJggyBxJ94VXTN3/flSUfpDSB60d/9E3KHgEYd
         PtiY96IUd1yqujDtlnnihl4gWYSKEPUcxgXaZCc6kh8mvcwUkYQlfnpAc2Cmt8TIEm9k
         X2KOpuG4LJJA4Ro+Ki0etbzPX4PDHPddhudHqJhdU14af1AV1UVita5k7vxXpQo9QFcE
         tVCFmmxeXJMO0KMkLqgascQMflt1yMptIJEiNg8hGKYxyo0jG+k5hJ853jJHDxKc9QKk
         VzD8rXXg6DxdsHoAy1f9yLZ/m2zNB3s7n3pPrejJCHy1dal9nPaIOZZBjL28BupvFAH8
         ww1Q==
X-Gm-Message-State: APjAAAUijfrtuU9zd2ohzwe8QzOuu/i8lD2Pw+MMwIDAl9AeWknO6+2R
        IXsDrBfHPVh9lGzeyrcuMJ+/UgxH2XXkdiAj/pF24vmu3BJkgcVh2Qc02SzdrlX6LaY4Th+O6YU
        Y8jR/PithsFC6wxv0SjI92rIr9J7z2K8CZ4C1PmHMf1Laky287mbLb9Lm92Nbwbx7MpdTklKklb
        lmZrc=
X-Google-Smtp-Source: APXvYqy0sZl+jGcPJei+V5sF4FXAeaGn9GQV14FyFINPWV2xmay1Mt/P6SirlNi+G2x6Daricnqaag==
X-Received: by 2002:a65:620a:: with SMTP id d10mr4029784pgv.8.1567702010015;
        Thu, 05 Sep 2019 09:46:50 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x11sm7683567pja.3.2019.09.05.09.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:46:49 -0700 (PDT)
Subject: Re: [PATCH] pinctrl: bcm: remove redundant assignment to pointer log
To:     Colin King <colin.king@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190905140919.29283-1-colin.king@canonical.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <190fef22-fe90-dfa0-0943-4d30b10b6b1d@broadcom.com>
Date:   Thu, 5 Sep 2019 09:46:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905140919.29283-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/19 7:09 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer log is being initialized with a value that is never read
> and is being re-assigned a little later on. The assignment is
> redundant and hence can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/pinctrl/bcm/pinctrl-cygnus-mux.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
> index 44df35942a43..dcab2204c60c 100644
> --- a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
> +++ b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
> @@ -923,7 +923,6 @@ static int cygnus_mux_log_init(struct cygnus_pinctrl *pinctrl)
>   	if (!pinctrl->mux_log)
>   		return -ENOMEM;
>   
> -	log = pinctrl->mux_log;

Yes, this indeed looks completely redundant.

>   	for (i = 0; i < CYGNUS_NUM_IOMUX_REGS; i++) {
>   		for (j = 0; j < CYGNUS_NUM_MUX_PER_REG; j++) {
>   			log = &pinctrl->mux_log[i * CYGNUS_NUM_MUX_PER_REG
> 

Change looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
