Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A5C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40072070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 07:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Q5h14Lfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfG1HqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 03:46:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37132 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfG1HqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 03:46:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so50826822wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/G7IaZ8tiYQkvUjO2OGRQfRiaaHFpZ/Ktl9QzMcAM4=;
        b=Q5h14Lfr1vWRYHjX5e6phEJRFTeh+7dNc+QdnUBBekSIV3CtR0lIVJ3fd6BRZsIQj3
         Hh9/qDIlUUekUyF/zlcHYhwJWJ7c6YHQ1hmMWt7IDtGEyyNNpE/Gu0BRooM3DNGaKkAF
         GQmpZJCrBdT9B8U2g4jYormH1HLmxS58DSCyP4CaFtjxPWSHPwOOulmHdzO+2vOA8qwR
         A0xhEMeBiyXi1+FHnhqJ2Ox0ZGseYzK6n9gL1eEqE+I7VHdoI/XvjCcwItsawXAwnSeW
         kxhoz3SVHnlqAS365oB3V4fplD91va1O5hEAdCc6y3mK8ZSdxVoLHQdwCufe8lhY1ZvN
         fPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/G7IaZ8tiYQkvUjO2OGRQfRiaaHFpZ/Ktl9QzMcAM4=;
        b=NvuyXAuZ01n2TaTxrUPNaZBxXefQ+ido/Jj6127tTzj/CbjZo+I8w/Z03l47Z9VawV
         VKPYZh7XegdXXujmaUDJXYFC7uFzCAh0WglB9lLbVDtdpRjcbJweUl5IXch1Nrr7oi+O
         aFvBYwO7rl3SPGexMHIPYZ9I3qnLyBWkOlDcrXpPHlGcN30qThriXMLpUgcVesCx9Gvi
         hErDIq6SVi2kmqOVvN9SuyYdam9EIn1+gLG9dIzGZMy53OB7t/tV2IJPaIs2vqTHOsQI
         96MFteekOH+gvVbmGl66mhRNVvlJcGsOAnO2zVdl0y3jkzG6qs7ch5Sm9vk7FUKINLzD
         DvXA==
X-Gm-Message-State: APjAAAWpvwAwwhKYXzqFoBlN8C2PceKpiKeQbu9uUgQnb7S/uZSZnHGq
        wxT+lvLSGOEg1NsMAqXsqeY=
X-Google-Smtp-Source: APXvYqyg9ads4NJultwbj5Ts8UfWbNW/kHbokiWQB83owxZnaZwiVsGhlK22m19FExLQ6sHi8BCEBA==
X-Received: by 2002:a1c:ddc1:: with SMTP id u184mr91017388wmg.158.1564299980967;
        Sun, 28 Jul 2019 00:46:20 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id f1sm39579827wml.28.2019.07.28.00.46.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 00:46:20 -0700 (PDT)
Date:   Sun, 28 Jul 2019 09:46:19 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Colin King <colin.king@canonical.com>
Cc:     David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rocker: fix memory leaks of fib_work on two error return
 paths
Message-ID: <20190728074619.GA2423@nanopsycho.orion>
References: <20190727233726.3121-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727233726.3121-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Jul 28, 2019 at 01:37:26AM CEST, colin.king@canonical.com wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>Currently there are two error return paths that leak memory allocated
>to fib_work. Fix this by kfree'ing fib_work before returning.
>
>Addresses-Coverity: ("Resource leak")
>Fixes: 19a9d136f198 ("ipv4: Flag fib_info with a fib_nh using IPv6 gateway")
>Fixes: dbcc4fa718ee ("rocker: Fail attempts to use routes with nexthop objects")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
