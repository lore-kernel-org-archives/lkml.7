Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03FAC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AAE2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsXM6obO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfHZGMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:12:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44732 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfHZGMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:12:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so11073914pfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YwQsICc+3DjGnun37xdBipcHejPDbWJbE4T4sSSvK/8=;
        b=JsXM6obO3s98zghqwnJOHh5dnIRH0wCR7FN4My7XafFUbegpBWBVk4b/0cvUgJO8fj
         c++HQRVw6iamu8+y9JHp2Ul3n14zcd9NQ7VVn2G85qjYHvkRaNqnJVnn0Xsua2NUVC9E
         14rFVASTv4sQO3Al214u69RBIm5Y3xl9RIsIadA2Wwe8SlJF9qMQqwxUVIwftBR9G93A
         fXxZ3qJjRvU9fZTLB0I5kpWR0Qfn8q6RDo2WhS6mQ/Q+Wz2LMQRjnvL+teZsynyqLPpv
         pUBVHpkC5N/TbJsoPV5V2JIkQMZ7B9NVxbe5ihXLml0U9ax1wqqK9txq3rhG+e/tWIuL
         wQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YwQsICc+3DjGnun37xdBipcHejPDbWJbE4T4sSSvK/8=;
        b=s1QftvbxiiS6nMsUxsa1n8e0ryjh2hyjQrtHSGH0dtJfy7s4epnwUtisBuxyQzgctx
         6L1ny1Uf9xf8bsC9pqIDN7RcavUNeMfaztU77yQs/aNYznvHQHrvv3od2UAVq3Vhj0VF
         tqni3+kaHssM8ByS9pXbhyYP3Gv5AfjMw0RO/IVRETDl5zTUvgWnVP+44HTIWRzEj8FG
         BaEE1ZU2Lba7rCnyWgZCXNwWMajJqIFDjBhdnikyGe3u3DWMuQ5zuQvrFhJz1tD6NuWh
         lY6ZHApmJ4t5i7wDaqT5p64mtlRISyxXsnxwC5tv8iwA2mk7aKgAyUPwpv8ztxGdrNSq
         HJMg==
X-Gm-Message-State: APjAAAV08R4L0Su6lENVpATg9ztZToSlFWIh+qO6iCdmj0UWO/BHWeyR
        kNkDUR7mxWea/XQGPMs3D064yA==
X-Google-Smtp-Source: APXvYqyGBN3wo8dRli31bYRk//ubQT7ognpni0im2Cb82s74c+87koVPnEoqmcuW4M8PTq83s7doDQ==
X-Received: by 2002:a17:90b:28f:: with SMTP id az15mr18038596pjb.18.1566799957389;
        Sun, 25 Aug 2019 23:12:37 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id e13sm10396911pff.181.2019.08.25.23.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 23:12:36 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:42:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        David Lin <dtwlin@gmail.com>
Subject: Re: [greybus-dev] [PATCH 5/9] staging: greybus: log: Fix up some
 alignment checkpatch issues
Message-ID: <20190826061235.u3chbbctniukjdys@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-6-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-6-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> Some function prototypes do not match the expected alignment formatting
> so fix that up so that checkpatch is happy.
> 
> Cc: David Lin <dtwlin@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/greybus/log.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/log.c b/drivers/staging/greybus/log.c
> index 15a88574dbb0..4f1f161ff11c 100644
> --- a/drivers/staging/greybus/log.c
> +++ b/drivers/staging/greybus/log.c
> @@ -31,14 +31,14 @@ static int gb_log_request_handler(struct gb_operation *op)
>  	/* Verify size of payload */
>  	if (op->request->payload_size < sizeof(*receive)) {
>  		dev_err(dev, "log request too small (%zu < %zu)\n",
> -				op->request->payload_size, sizeof(*receive));
> +			op->request->payload_size, sizeof(*receive));
>  		return -EINVAL;
>  	}
>  	receive = op->request->payload;
>  	len = le16_to_cpu(receive->len);
>  	if (len != (op->request->payload_size - sizeof(*receive))) {
>  		dev_err(dev, "log request wrong size %d vs %zu\n", len,
> -				(op->request->payload_size - sizeof(*receive)));
> +			(op->request->payload_size - sizeof(*receive)));
>  		return -EINVAL;
>  	}
>  	if (len == 0) {
> @@ -83,7 +83,7 @@ static int gb_log_probe(struct gb_bundle *bundle,
>  		return -ENOMEM;
>  
>  	connection = gb_connection_create(bundle, le16_to_cpu(cport_desc->id),
> -			gb_log_request_handler);
> +					  gb_log_request_handler);
>  	if (IS_ERR(connection)) {
>  		retval = PTR_ERR(connection);
>  		goto error_free;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
