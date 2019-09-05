Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A97C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7219820825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WeZp7CNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbfIEWbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:31:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35801 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfIEWbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:31:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so2860807pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UWxyqNrYhp6a4ye8ByljRT4jAOGJs2jnp3Q/EXHI63A=;
        b=WeZp7CNrvoM0wc8oN7BO9imXAU1l/xih81gqOFHyM/uuvvN1t3HIBYAo669zNiX6gy
         jpMwfmAmo/VWm/v4dD7Ab7rug3Dsc/fgdz7nb+tjP6z5HJMSGq51+n0xxNLVH1Moy3bL
         jZSjDl9uUHkLSHMI1IP672lWtP2E5kpS/06rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UWxyqNrYhp6a4ye8ByljRT4jAOGJs2jnp3Q/EXHI63A=;
        b=mo18FwX4NJxtcsz8QGDnUcPZjwBFtSruuPVAyoQKH7C5EL37zEunkdotYhcWwfRZhY
         ILvnUudANLEYZtuKmqu8PiWJeIldnkuMjqJub83l5a4m2rTTVOTrqWnibNJ6xddZq4GB
         tmcx8MclCxzZEdns5uuyZDh0DOLgRZDl4vrUs8Eri4OV85pvohVDs9kgTSp1CRiiXIGm
         VFys9PyAsOwY1ihG2zUcXdwXFobn9SI8SMAuxOc0DJA/5Cxgpar/sc6AotYIuylNMwOL
         6zXGTVU91sDWjCnfMVV3lXYOS9UstWsqp132siuq/UKpUAJjVCP0fF/E5zPD7vWCl4iz
         aEUA==
X-Gm-Message-State: APjAAAXVy7SLQlsyCvLFQ34Mx092zxnNM/puRPWhCt+wGdYLW8l7eJY3
        99e1G2PBX5t3RhqxFNzTP44+AQ==
X-Google-Smtp-Source: APXvYqwoHhToZPfUzpzRvBYctT9nG3acR7k1VMNWYFc651HR8iVJ14YNU/3N9bwA+nn3GFOnOs7F7g==
X-Received: by 2002:aa7:9a5b:: with SMTP id x27mr6570262pfj.232.1567722680968;
        Thu, 05 Sep 2019 15:31:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n128sm3802831pfn.46.2019.09.05.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:31:20 -0700 (PDT)
Date:   Thu, 5 Sep 2019 15:31:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] minor kstrdup_quotable simplification
Message-ID: <201909051531.ED9BF2AD8@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-8-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-8-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:32PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> ---
>  lib/string_helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I think this can be folded into patch 7.

> 
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 47f40406f9d4..6f553f893fda 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -518,8 +518,8 @@ char *kstrdup_quotable(const char *src, gfp_t gfp)
>  {
>  	size_t slen, dlen;
>  	char *dst;
> -	const int flags = ESCAPE_STYLE_HEX;
> -	const char esc[] = "\f\n\r\t\v\a\e\\\"";
> +	const int flags = ESCAPE_SPECIAL|ESCAPE_STYLE_HEX;
> +	const char esc[] = "\"";
>  
>  	if (!src)
>  		return NULL;
> -- 
> 2.21.0
> 

-- 
Kees Cook
