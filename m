Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A2DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B293D20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKdKio74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbfJOTI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:08:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46596 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJOTI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:08:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id l64so7622826ywe.13;
        Tue, 15 Oct 2019 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vwcalfo0nj8jqf6x0P9ha0tnIv3sLojEIn4D2EyQfQA=;
        b=PKdKio749L09WSgW3MVYy+qidUxNVF63exMQyMYgFaPmXoymBwDF2QKwjg3mt5G1Eb
         pLVHKbQ9L4+0rKrw9ootuTTr3bhwwWgG0vS2PnDA1cUYEUqtMY7gHLNyCT+XCyfwwjpB
         zzi66QIz44iVXLqQAAuOKSWkZbXJWzLxyJD7FUrM62REFQJnDaWDaReE4OXP9KwZnp/7
         kCJrCfkobRAv+gcJv48BTrcN6oRShMEu+aVDg1Zqhq99Ypb41twtmUpYJo2Ae82XIxEp
         kCf5HdOgjy5MjRX1rr+NM9JQ4KbldMuPUE3ugZ1hq3Ai1KhpXBh1RaZW6GCkweQaikFr
         2MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vwcalfo0nj8jqf6x0P9ha0tnIv3sLojEIn4D2EyQfQA=;
        b=SJSGuZeXCzP2QD/FPKFhft91xKHE8cB+wcLt3NL0BkH9HlW0WEdsisp7OO56LZF4WD
         W5Oz9GcJ5jmmx77K6SnkQN2cCHuKSP2HKxs37pepHoqSxBNEaaS8QYD7tTdMrX9+pGLl
         Ke07wgZNW/nhq9ZCWuxo/+HmcC9POvceacptcwaRFgrq0JMPFvqNF0+gHU9j7eJFJtCk
         eLchlNS0Ou3A9/W6RVg18GdJZo401/TPzP7GFgO4gswDHWZB+/v9vO/1dYIyIGkQwppO
         2SJ2LyyZGddLGrlXEtSfPe3UAxBeVMgh9eB7rWeTLmsM3e/VVJlPzRHKo5zGP+1E0sjK
         YG6A==
X-Gm-Message-State: APjAAAXRoyPgIlQxbEQNi+gj3LAu2S3i5a6k15ERHWh0bJtwIFIgqcBu
        RlutBEDb7Sy66c95Y3AZvg==
X-Google-Smtp-Source: APXvYqyBFRC7bbBOnpMBP0iijziJzkCnwBfMmkTyrvGtTOZ5MxkMdLyJozDW4iaZpvwCIKnY68puQg==
X-Received: by 2002:a81:2396:: with SMTP id j144mr17565583ywj.219.1571166538119;
        Tue, 15 Oct 2019 12:08:58 -0700 (PDT)
Received: from 960 ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id 137sm5466855ywp.64.2019.10.15.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:08:57 -0700 (PDT)
Message-ID: <336c7fa6eebdbada759c9ad30a0a6b85af6f6c58.camel@gmail.com>
Subject: Re: [PATCH] platform/x86: huawei-wmi: Fix misuse of strcmp()
 function
From:   ayman.bagabas@gmail.com
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 15:08:57 -0400
In-Reply-To: <20191015182549.GA13772@embeddedor>
References: <20191015182549.GA13772@embeddedor>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Tue, 2019-10-15 at 13:25 -0500, Gustavo A. R. Silva wrote:
> Comparing the result of strcmp directly with 1 may cause it to be
> misinterpreted. Note that strcmp may return an integer besides -1,
> 0, or 1.
> 
> Fix this by returning -ENODEV only when strcmp() returns a value
> other than 0.
> 
> Addresses-Coverity-ID: 1487035 ("Misuse of memcmp-style function")
> Fixes: b7527d0f4502 ("platform/x86: huawei-wmi: Add battery charging
> thresholds")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/platform/x86/huawei-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/huawei-wmi.c
> b/drivers/platform/x86/huawei-wmi.c
> index 6720f78c60c2..b43f76acbfea 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -470,7 +470,7 @@ static DEVICE_ATTR_RW(charge_control_thresholds);
>  static int huawei_wmi_battery_add(struct power_supply *battery)
>  {
>  	/* Huawei laptops come with one battery only */
> -	if (strcmp(battery->desc->name, "BAT") != 1)

Note we don't have a battery number in BATx, strcmp would return 1 if
battery->desc->name is "BAT0" or any one digit. This is a desired
behavior where some Huawei laptops identify the first battery as "BAT1"
and this would match if name is greater than "BAT" by one digit.

Maybe strcmp(battery->desc->name, "BAT") < 0 is a better way to go.

> +	if (strcmp(battery->desc->name, "BAT"))
>  		return -ENODEV;

Now this would always return ENODEV.

Thank you,
Ayman

>  
>  	device_create_file(&battery->dev,
> &dev_attr_charge_control_start_threshold);

