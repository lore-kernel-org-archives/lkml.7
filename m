Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DAFC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA94B206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbKkzylQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfD0A0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 20:26:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45435 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfD0A0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 20:26:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so2277371pls.12;
        Fri, 26 Apr 2019 17:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Ha6IGzUAbNJa8v4foUXIvt0exapbiOIVu6T2E/z1rU=;
        b=DbKkzylQpmCTdBWcg3f1rxEP5G+fsER02UTw8CIvwTQ2FV8V9tkc5TlF5rN4ZXlDT3
         giRdb4ZsdYbHSxG/J4KpjU4PG7QC7RliYGSAsbWWkwlCZEr+hfmD6GdRLEfIPPpnHlI2
         RCtnBHVCRK7FKTRvK6wErbd7zzipfr900pv/w1ZYMbZse3GJ/swDkY6p9958P5AxdXzJ
         3rXyh6mrIAnphCofhD96Sd7kqTdf/Ez7zt+qgApCXTlseC68BNZ0P3hvjmibSo9zWYdy
         n5inO53BRPz/l0HQrWXbnY2X8T8ZauhKNKcsuG00+OB4c1TVNp9OycE+405kALWH08Jx
         zUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Ha6IGzUAbNJa8v4foUXIvt0exapbiOIVu6T2E/z1rU=;
        b=XT5+HSxdKOt1LM7xiIFdT1+CR4hyCfhKCkdYPo2KgTbvJSQIsr+KQu2Yztkn85wl3M
         wzHZUt/ekdo3uDRzpUEFvhOvlM+f4PxkZ4zKkUV+C3WQzFrTXK8OcifkV2CsJZKmNAUP
         1U8L5etWPdNZbKGQGQesqz4f2fofbHOBqCqm0h2rA8pwhHM1P5eZcsUw9qwieJgCcmKD
         0g5EBKHCdKQC6Zvt0fAFZEb9W40u5hP1OsnGKOJh84cWJzKQOSoBiNYEkwGFeae2HOJ1
         BRSQBQel/pHJP0eqYVLI4covjVWXsE+S7AecN55AJ1yCTtLbyxTNXQYzCoizwrPF9fF6
         4C9g==
X-Gm-Message-State: APjAAAUuU8+z5oyKnQQZxsiT5sZaedMGrGyF6EIWg5nJ9wgoh4L6ZQx5
        FyDpq6OcAcsubH+H8hoCGgw6D84j1nk=
X-Google-Smtp-Source: APXvYqyN0pIEwPAqbb5WTVvBiA5y0eEIwoEItQQ8pwJcx+/nuSCOH+e08Al7NPDyF+V5/kmj2pcMpw==
X-Received: by 2002:a17:902:bc83:: with SMTP id bb3mr4029886plb.303.1556324781442;
        Fri, 26 Apr 2019 17:26:21 -0700 (PDT)
Received: from icarus ([2001:268:c1c1:24b4:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id o81sm47848184pfa.156.2019.04.26.17.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 17:26:20 -0700 (PDT)
Date:   Sat, 27 Apr 2019 09:27:20 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] counter: 104-quad-8: Make quad8_ops static
Message-ID: <20190427002720.GA26000@icarus>
References: <20190426164816.37032-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190426164816.37032-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:48:16AM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/counter/104-quad-8.c:836:26: warning:
>  symbol 'quad8_ops' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/counter/104-quad-8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 4fa2931..00b113f 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -833,7 +833,7 @@ static int quad8_action_get(struct counter_device *counter,
>  	return 0;
>  }
>  
> -const struct counter_ops quad8_ops = {
> +static const struct counter_ops quad8_ops = {
>  	.signal_read = quad8_signal_read,
>  	.count_read = quad8_count_read,
>  	.count_write = quad8_count_write,
> -- 
> 2.7.4

Yes, thank you, this should be static.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
