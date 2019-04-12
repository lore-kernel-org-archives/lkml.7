Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED73C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A022220652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmxGVCS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfDLNyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:54:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42472 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:54:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id w23so7548947lfc.9;
        Fri, 12 Apr 2019 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QSh6vX7ISwF7XAGEQK8jmmRBZDOSGV8bblYKd0oxJVE=;
        b=gmxGVCS0pHaNkD8GWu+8Tj7r8YdUqUQ84z7A+jN6VvP/Plm63BYXT0+hIisJfdxIGx
         J59cUnk6awLdTkihtKXB51W8VFaRdIeg12iZ3ZyT0hpe6TWEbm8eK98SE1es6PDuBHWz
         P0Aj/hU3Ws3ON1PPAl9g5Plrd+WwerAEiKQfyi/gU9cIkMlw6HmQYk46Ei7WDisT6sxC
         dnfbYA7ppDqsdNGXDQIGkqtM5qGINnPaWsdUuTBe5EE62b7uyV6w/wjDf08MzN8839Ba
         gn5Osb69dFUWB21LAdX5/nn9DxoM7+jOihf4N2xQmLm9WYrED0iRcGHvn1gBLac7ouoT
         qSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSh6vX7ISwF7XAGEQK8jmmRBZDOSGV8bblYKd0oxJVE=;
        b=tZ3eW7ot5AgP1rJ+Rxy9nWaUYZW9Tf1Coy3fQvhllglXoGgmT0dEZbi5y9wBvNu4Zn
         Lx49T7+fY7TjGZHrze4WLSHSK0QoMbaSC8MdQaoOXhoj7u6Bn6VLgAv9qfoXTi6fO9JR
         hMCljJKqQOB9+9pE9caiqVtyUo3zoP3tAh8tpgMZ90+YdqmyOwoIjKUFjmC8o3CPooT1
         yOQLdH24dJ7aBE3Ogsfi2lIJNQpddUc18Ym922ezGoHqB9zrJKtrpPHq1CpmgtF0uzlj
         D82KTX6xnAVS1DXdsz8aaY5mS3tW9XA1mEoIc4P9ZwAGy6PxTcWw+skVc9dNUtuiQGWM
         muTQ==
X-Gm-Message-State: APjAAAWcfvt4sJurmRZ2ryT1ttu6yALK8Rgf77s6+tRNpnqMFIMn+8GR
        yiv/GraXBNovOa4tcILBrXDmKv41
X-Google-Smtp-Source: APXvYqwVNk4aYjZluvKCy1C27/c1CJBkXnrrhE7nnApY0KTJdfW6Z+UpmfqeauL7tiBAEPlXyw2VFA==
X-Received: by 2002:ac2:482e:: with SMTP id 14mr11828703lft.1.1555077244398;
        Fri, 12 Apr 2019 06:54:04 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id h2sm1080655lfc.28.2019.04.12.06.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:54:03 -0700 (PDT)
Subject: Re: [PATCH v1 5/5] clk: tegra: divider: Mark Memory Controller clock
 as read-only
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190411220230.21726-1-digetx@gmail.com>
 <20190411220230.21726-6-digetx@gmail.com>
Message-ID: <d297dc99-696d-f38a-af3f-d3f082e95d32@gmail.com>
Date:   Fri, 12 Apr 2019 16:54:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411220230.21726-6-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 1:02, Dmitry Osipenko пишет:
> The Memory Controller clock rate can't be simply changed and nothing in
> kernel need to change the rate, hence let's make the clock read-only.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk-divider.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
> index 205fe8ff63f0..f891bbb0d06d 100644
> --- a/drivers/clk/tegra/clk-divider.c
> +++ b/drivers/clk/tegra/clk-divider.c
> @@ -175,6 +175,7 @@ struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
>  				  void __iomem *reg, spinlock_t *lock)
>  {
>  	return clk_register_divider_table(NULL, name, parent_name,
> -					  CLK_IS_CRITICAL, reg, 16, 1, 0,
> -					  mc_div_table, lock);
> +					  CLK_IS_CRITICAL |
> +					  CLK_DIVIDER_READ_ONLY,
> +					  reg, 16, 1, 0, mc_div_table, lock);
>  }
> 

Turned out there is a bug here, the read-only flag is the divider's flag and hence it shall be:

 {
 	return clk_register_divider_table(NULL, name, parent_name,
-					  CLK_IS_CRITICAL |
-					  CLK_DIVIDER_READ_ONLY,
-					  reg, 16, 1, 0, mc_div_table, lock);
+					  CLK_IS_CRITICAL,
+					  reg, 16, 1, CLK_DIVIDER_READ_ONLY,
+					  mc_div_table, lock);
 }

I'll fix it up in v2.
