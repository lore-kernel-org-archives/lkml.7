Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69DEC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA40C2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuAZGv3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfHZGMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:12:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41202 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfHZGMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:12:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so11091151pfz.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DvsJ6EXOfQy8viwASBJ8g0n3qm0G5rmq/MMogh3criM=;
        b=RuAZGv3syoZI9rmONxZGxWuycwQ7c+GoUjWFHPGEcyXfngduW+pnagJhm07OwrHED5
         BHSJznyzG4eluRx+1lb6mSiWlnMXmC8DBB1NrMpDpOIo7mqfrjEvl8STPPRTD0c2yBIX
         a/EuzaZA4vT6I5nbM9EFewegks2u8lNgysOlIb7W7Ciq4J4V5+33wsgbCUgS4ntwkR68
         cubBpL/iTGfQGq8lzv81Y3WqavoMfc0jJUXBJP37noiR1vKfr+8PbxsyXymFgBqDQxQp
         JlOxyyxa088C+L6bQ/yGSDH3KSycqAuh7zWCdi6seBcP2JWSzx5SZrFJQmnC2Xgegx36
         hiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DvsJ6EXOfQy8viwASBJ8g0n3qm0G5rmq/MMogh3criM=;
        b=Tl6LJsfWOcJsIWVFERTq6V1HO8GW/N6huhfkK4tcssd9DuFlyHb1++ksO++gN6od5/
         az1+IrqBTIHHf4Q6lHPuC2NmgBrO6rOPR812yOGFFEQg0UXJyPsk2kyzOja14aLXeKzV
         cNhJE6oDbFIGYXGhgkc0bGu9ghWHqmbMzC9gUBOj7WTVadwd5bKOwrXzTP5u2BwGONAJ
         lR4+B9s07LCLHPL4G/2YcHCy9waFN19OH7RwnHIKwpWLcpJAqukhGZeLY9vKnqL4lSlM
         W6nK7iUJoak9k8SipTayM0uzaYM4boFGq1+axT1IIh/ZIDzBlEts9hk+BbR7mp5qGbwW
         PYZw==
X-Gm-Message-State: APjAAAU5cpc/FFJE13muljlthjQ4siamx6s7cvD2NC29RMkZvnMia+uN
        xA/dxTh53EAPmY5UrYGnesiuvA==
X-Google-Smtp-Source: APXvYqwtlXSI25+XX1DTZ+KVKX1tQjMTjHeyedgEYej4K24WlFsnqkbZlM+vldAx6tACcs6bwx8/jg==
X-Received: by 2002:aa7:9e0a:: with SMTP id y10mr18197049pfq.93.1566799970382;
        Sun, 25 Aug 2019 23:12:50 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id br18sm10747731pjb.20.2019.08.25.23.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 23:12:49 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:42:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH 6/9] staging: greybus: loopback: Fix up
 some alignment checkpatch issues
Message-ID: <20190826061248.emfuj2wcpwtaizr6@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-7-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-7-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> Some function prototypes do not match the expected alignment formatting
> so fix that up so that checkpatch is happy.
> 
> Cc: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/greybus/loopback.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index 48d85ebe404a..b0ab0eed5c18 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -882,7 +882,7 @@ static int gb_loopback_fn(void *data)
>  				gb->type = 0;
>  				gb->send_count = 0;
>  				sysfs_notify(&gb->dev->kobj,  NULL,
> -						"iteration_count");
> +					     "iteration_count");
>  				dev_dbg(&bundle->dev, "load test complete\n");
>  			} else {
>  				dev_dbg(&bundle->dev,
> @@ -1054,7 +1054,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
>  
>  	/* Allocate kfifo */
>  	if (kfifo_alloc(&gb->kfifo_lat, kfifo_depth * sizeof(u32),
> -			  GFP_KERNEL)) {
> +			GFP_KERNEL)) {
>  		retval = -ENOMEM;
>  		goto out_conn;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
