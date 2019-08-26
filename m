Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C4BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D8E217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZtqhUVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfHZGOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:14:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38617 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfHZGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:14:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id w11so9022550plp.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 23:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DFNKLlML8ZG0U6zSvck4G0suOs1+3RpMULNqnE5vfmE=;
        b=HZtqhUVgaaWvXSuMadlnQlfTp0nMMEvpsWVtBYe/NNERsuqqMBdf6Z/CIv7esFkvEq
         VK4itHwOLhgftKByG86oc7HifeQpF5/fpyzukMA2zTvz9xr44gmtJUJDmaufTRocf7+l
         e78E+Tjqq9wAFfTfNdTXVtqZZvD9scAvIVH7IEHt1zXPuKv03+ockt/3ZDVsGYmJ277N
         UED8KhWfCWo7WSSvkKWuIK+IMcX/sKn5ohfxdOBYH3JyKTv2iGcV3nHXU/ZTtRUgAniB
         EJngDM95BxyFQFDehH3Et8Jd06PUX6rsQnT16ZqFUak26ZB/XaWaUUPQMF7d12trj8Ax
         YwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DFNKLlML8ZG0U6zSvck4G0suOs1+3RpMULNqnE5vfmE=;
        b=GLbDCTvdifXV3YGyI7SHau9iZ9a5NBjmr4kc7N5t59B7eguZ5MOnPUf6cb6wrEiueJ
         OuxNZM+cN7tUFUI4QVeHoQoE5XgVOsuvhGsySfgrrUt7J71A9Ce2YlrjaxJHbuRT8wTJ
         gsD/bvwdW7Dr6UlmorbtnDgNSC23xng6iixo5E1RvG0RVkaruFLCyKCORcpj/ZQ6EYpH
         fvy1ABmcsQAJCsMwI9HqJvZUgz5qdXEC40cnF0PEbZHCtFi+UUbp9AiV49fWJAFfKwf+
         mRptoleWzgmZPL1fGxblaFq/jVdlTT5OrmCmegvqJ0NVT32EZ7Atk3HeWRo5GeNGwKTh
         IuVQ==
X-Gm-Message-State: APjAAAWuy19CtJPWLJNomW8TJLYT1BoW6l3eOthEx4XLQIYt01ZGOBjP
        Cs+y2Eizn7DZjzgakgTDVVgCvQ==
X-Google-Smtp-Source: APXvYqw3O24kdVqAku1lk9iqySccxlxqBlpdpGlSV0fOUZdZbeox5M+FlskBtNUYqKT8CggkpjYO0w==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr17762668plb.58.1566800089617;
        Sun, 25 Aug 2019 23:14:49 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id h197sm10948152pfe.67.2019.08.25.23.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 23:14:48 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:44:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH 9/9] staging: greybus: move es2 to
 drivers/greybus/
Message-ID: <20190826061447.7oynduw2schwrck4@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-10-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> The es2 Greybus host controller has long been stable, so move it out of
> drivers/staging/ to drivers/greybus/
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/greybus/Kconfig              | 16 ++++++++++++++++
>  drivers/greybus/Makefile             |  7 +++++++
>  drivers/{staging => }/greybus/arpc.h |  0
>  drivers/{staging => }/greybus/es2.c  |  2 +-
>  drivers/staging/greybus/Kconfig      | 11 -----------
>  drivers/staging/greybus/Makefile     |  5 -----
>  6 files changed, 24 insertions(+), 17 deletions(-)
>  rename drivers/{staging => }/greybus/arpc.h (100%)
>  rename drivers/{staging => }/greybus/es2.c (99%)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
