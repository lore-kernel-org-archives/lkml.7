Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DBC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF122070B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ury/kvRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfGYOlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:41:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32785 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfGYOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:41:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so51168259wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=afaFQV2+gmSxhIryTqlJume5dpsRUmNQp36xGyN5C8c=;
        b=Ury/kvRj+NiTLXBSM04pVrmFHM/wLxt6u/rgc/s5fuHi96rbi2u3sokiMds9/2p9vy
         kKNRDRgjlu9jCbJsEO1aD3mvta0FkTmy0YPyqb9rnbwzDSACsGZoWZDIAbwJFo1YBn8P
         YQ9MQXCXdW87VxyXUUk4wWZtXe6nMrXFSjsH+C73aDNT2pEft53bo1xCeON8XAazNq4V
         P58r7dQwNCCrs2/F6/1zD7ggMNcElPZT0wmDS4w19b/Z8H8eO9tEI6y17cwcjl7rf9nI
         COcPtjo0VIxFgwKJyYoHDmEZOMMnWSYcYfXnZAnhiLIpxVEzxBulGfurwIC1vTS2nNJ0
         jjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=afaFQV2+gmSxhIryTqlJume5dpsRUmNQp36xGyN5C8c=;
        b=cXp+A1MD58ZMsrSy4NAPXmLwUG1JTWZMxbwMEsA2PAsSSOTedWHzmSUS1FBLE9ExFQ
         /PBov+D85ZGAmMG9uCxdIxCGRPCXwJ64BJBJ7+VbJj4m0J0n8Xee+zD/8DMy/W0Xlvjv
         /EqDUXsQFFSJ9SB5zEtUkuUTxe2VITTI+XNEQBbTO3lowbcj8Nwdl0kShqglTWVwG0n0
         /9XCBYmK6HeUr97FDe8qrrjxh9FQzabvjuV4iBwPclc/a7M5375c23wWzJk4moN0qeYO
         tHaKL+G23UGB42YE1eR/uPVVUzzZbDU589c7odFu33e3G/Od6hWJZlvOmodiP/kjFt3a
         F9gg==
X-Gm-Message-State: APjAAAW3//2PiNWhw1fJAzT9BwliRQtmmSd85gYuBWwGrgvzGUUAt+BD
        NHE8jWtpmjqaAVXtjAvp73O1qg==
X-Google-Smtp-Source: APXvYqy2GHFBySWKMfAzGAvRpQ7QBGKW3FV/iX32ZBFt+sohr5Tc9Rcu6r1RKs+nXquFhZPtzZjVWg==
X-Received: by 2002:adf:afe7:: with SMTP id y39mr92710271wrd.350.1564065677169;
        Thu, 25 Jul 2019 07:41:17 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a2sm50055474wmj.9.2019.07.25.07.41.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 07:41:16 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH 2/4] clk: meson: gxbb-aoclk: migrate to the new parent description method
In-Reply-To: <20190722095053.14104-3-amergnat@baylibre.com>
References: <20190722095053.14104-1-amergnat@baylibre.com> <20190722095053.14104-3-amergnat@baylibre.com>
Date:   Thu, 25 Jul 2019 16:41:15 +0200
Message-ID: <1ja7d2xjlg.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jul 2019 at 11:50, Alexandre Mergnat <amergnat@baylibre.com> wrote:

> @@ -208,8 +216,10 @@ static struct clk_regmap ao_cts_cec = {
>  		 * Until CCF gets fixed, adding this fake parent that won't
>  		 * ever be registered should work around the problem
>  		 */
> -		.parent_names = (const char *[]){ "fixme",
> -						  "ao_cts_rtc_oscin" },
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "fixme", },

Hum, that would work I suppose but I'd prefer if used .name for this
work around. Remember to throw an '.index = -1' as well

> +			{ .hw = &ao_cts_rtc_oscin.hw },
> +		},
>  		.num_parents = 2,
>  		.flags = CLK_SET_RATE_PARENT,
>  	},
