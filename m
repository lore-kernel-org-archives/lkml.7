Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FADC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B8020657
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaSfJOyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfEZRLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 13:11:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38718 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEZRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 13:11:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so14563018wrs.5;
        Sun, 26 May 2019 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VngFnjA4I4U+hR5vVA1V+FR99S/7mW1ulvqMkxupRbI=;
        b=GaSfJOyt+7qw6hYvN64VIrzBsznUACz44yH+Oy28DcChFwBL7LYSo4PjEO36sBGIpn
         d7K9/49IUewk0bztOM9JWzUYo0lLDwC3jqLyOQ11OdI4hJCMKUNi3+pO6RfBjMt3LmKV
         V0eHbhynMlSSnHVtQHJn4o/6IjPagkWRoxhIuPj/jy/5Me92S/q+QMxoqi100NP4AP8D
         X8aKkissPhykWUVdfYO3jo8dmW3KepFjpuzJT3OiZNNJO3tT4dGE7PWHkT8KzhK0ba2M
         qi7UBzjoYwlov/aciwBc/9Inh8lNXoNxAtUEz6EebLNVzZhY6I79kN0tQGSOVGcOX+AJ
         ZcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VngFnjA4I4U+hR5vVA1V+FR99S/7mW1ulvqMkxupRbI=;
        b=ep1bWQLsX88LOyT3P5A1A9BkYBMTVimIEFnIo0bcYt97FvL2SX09rd3yS+sk3MWYOZ
         lj+JNubpvwHUunqxX2ey4NyAw4vHL5mLuNhKHy3guuSEUhLJ0gUYOXUOq9aTTw0Qquwa
         FRpnoZwQ0dvRZ4zpt5SeCgIGE2IHH/KCMeLssGacMp+BLhtnTH9uXsLdXFXRbVw45xtU
         AEpmc7KUHtlhTRHruBUcxD/3X4ki8sMrwGCy1JGqZu+9pdIwB0XKfyxaQYdVJOIKVjG1
         F6RW+uJ1KIztuoPAFtwZRvllZFMUPGfXOstORU0iXyMzxUKFQBDxK4u6PIyp4hcg2T00
         vqJg==
X-Gm-Message-State: APjAAAU7MQzsXUeNVSINlPxWEQ7ZkSbZdu+64TPz1K+8Z6+Av2pMxyjB
        Hb2qoRbtRzBGK0U785+8PWKUpB3+
X-Google-Smtp-Source: APXvYqx2eE/N+5VbL1d/FsoGbWkSsuScJSYNiuMOiFBX9WEbS6yjguY5wdetGkEni0qw4Rb1GWYueQ==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr1368214wrv.89.1558890697582;
        Sun, 26 May 2019 10:11:37 -0700 (PDT)
Received: from [192.168.1.17] (dnl167.neoplus.adsl.tpnet.pl. [83.24.93.167])
        by smtp.gmail.com with ESMTPSA id h90sm16365184wrh.15.2019.05.26.10.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 10:11:36 -0700 (PDT)
Subject: Re: [PATCH -next] leds: max77650: Remove set but not used variable
 'parent'
To:     YueHaibing <yuehaibing@huawei.com>, bgolaszewski@baylibre.com,
        pavel@ucw.cz, dmurphy@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190525141941.16088-1-yuehaibing@huawei.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <06cdba20-4bce-6739-7db9-dcf3a3c7b6bf@gmail.com>
Date:   Sun, 26 May 2019 19:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525141941.16088-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

Thank you for the patch.

On 5/25/19 4:19 PM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/leds/leds-max77650.c: In function max77650_led_probe:
> drivers/leds/leds-max77650.c:67:17: warning: variable parent set but not used [-Wunused-but-set-variable]
> 
> It is never used and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/leds/leds-max77650.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
> index 6b74ce9cac12..8a8e5c65b157 100644
> --- a/drivers/leds/leds-max77650.c
> +++ b/drivers/leds/leds-max77650.c
> @@ -64,7 +64,6 @@ static int max77650_led_probe(struct platform_device *pdev)
>   {
>   	struct device_node *of_node, *child;
>   	struct max77650_led *leds, *led;
> -	struct device *parent;
>   	struct device *dev;
>   	struct regmap *map;
>   	const char *label;
> @@ -72,7 +71,6 @@ static int max77650_led_probe(struct platform_device *pdev)
>   	u32 reg;
>   
>   	dev = &pdev->dev;
> -	parent = dev->parent;
>   	of_node = dev->of_node;
>   
>   	if (!of_node)
> 

Applied.

-- 
Best regards,
Jacek Anaszewski
