Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E463C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225EC217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbv6ev8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfHZGMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:12:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34285 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbfHZGMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:12:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so9500584plr.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXdWl/5I4AMEty6E0BlvbYSkUcbQAuqmZdC08RJD18M=;
        b=jbv6ev8JlZxB9ZIAPq1Si7oAf6zojp/v8OWLfvQ4/jCafQ1UQnfuAqRp+AqlLywcPD
         mS4+vCbHJPqIykvI5npb1D3Z3CYRSmGUqEi7NEUjqCnMqbj52dzgvce9FAR+56I3spBc
         fqjrTuyCJ3QyX3LAdpUvXaPVHo3YsVL8kcR93OXW+3/fdS/UXxjfgAHh41zGgzrOxcGS
         oisNw05yEEXvrhP4o+frYwGHsTDJg5HIcb4+ATb3TMEauwowyIOAf+1MuCOdYos0tepe
         mOETzQTPWhZam2MRCO6fB+p2IOzM/sBL2C8j5d/0d2hRaSTZ9XvoRuVJOoQOAZDCu1i5
         cPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXdWl/5I4AMEty6E0BlvbYSkUcbQAuqmZdC08RJD18M=;
        b=VBL0kkzgT1LlkGnQFD3Zu3NOelgJwPpK21nlWB0dPhdFlYM5eLGj6oSN+4QJeSynkS
         GShQw4XJgcwFASm34cMlon5IXEnw2QCl/LR72oaGi7hQ7/1ExgCLA5+ATVdxv0YYN/WX
         meL4owve22QvCLJW+xZ/BXZSljyA2s0gBsvGf9FHUK9EzHiw6cIA1li8GT2Vk0cFrs90
         ADjMoV41GVZUeQVMtxPZvVqofb1i50y7fbjpsezflI1U9tF8T4CNCz/F/gnsXESJDze6
         5z3ooEXLAqOMDyKdTPQIkfqAJrHsLcFG2Wmx87iaXRREHuB3WNbuKwXEeTAKAZq9emJI
         OUwQ==
X-Gm-Message-State: APjAAAVDiNrZfrrGk72OAHiv5AwQH6iIuk7FijKSCAp9IAtcMxHzWLMC
        f9+6om8hLPi+6Zv9Sc0P+aNElg==
X-Google-Smtp-Source: APXvYqzoYUDpRJUFiNoriejK+QdfOyXNvh5rJkI3pY3J+q+ZnVSlsneboHXqF3lobm90wLJVSkLaHA==
X-Received: by 2002:a17:902:7781:: with SMTP id o1mr17216873pll.205.1566799919996;
        Sun, 25 Aug 2019 23:11:59 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id t189sm10691274pfd.58.2019.08.25.23.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 23:11:59 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:41:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH 4/9] staging: greybus: manifest: Fix up
 some alignment checkpatch issues
Message-ID: <20190826061157.zpvbmbrqhl5krqcg@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-5-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> Some function prototypes do not match the expected alignment formatting
> so fix that up so that checkpatch is happy.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/greybus/manifest.c | 39 +++++++++++++++---------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/greybus/manifest.c b/drivers/staging/greybus/manifest.c
> index 08db49264f2b..4ebbba52b07c 100644
> --- a/drivers/staging/greybus/manifest.c
> +++ b/drivers/staging/greybus/manifest.c
> @@ -104,15 +104,15 @@ static int identify_descriptor(struct gb_interface *intf,
>  	size_t expected_size;
>  
>  	if (size < sizeof(*desc_header)) {
> -		dev_err(&intf->dev, "manifest too small (%zu < %zu)\n",
> -				size, sizeof(*desc_header));
> +		dev_err(&intf->dev, "manifest too small (%zu < %zu)\n", size,
> +			sizeof(*desc_header));
>  		return -EINVAL;		/* Must at least have header */
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
