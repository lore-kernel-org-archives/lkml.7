Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2160C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3EA2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtrioXay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDKSju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:39:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37141 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKSjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:39:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so3826918ply.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uKv4sXYEnLM2eTvAi0c8sXVoRbjoKhn+nrSO0wy5muc=;
        b=qtrioXayrVod4Vi9AQqF0n/wGojB9ngnDKgjmQ40bwVSAkMiCLSMi0gzaZsiZUhMrt
         C19sLGy4d8KCFFUCt1ZPm5xfgANe/rRCXaowey+hlstypnkbh55rWjIDx89du70ovWjz
         U6HXDWtCQUuvIcE8iM0TzHJKFS+9DvbYlQvEw+VVHmGqq7Bu9KnlOpKhyfSiVFh+MEY2
         O16/YccDT6YoJSO/FEYf01dD/NDu5YrqDycK5rr8BkJXqJL2wqFl4D20I83KGYNo88wr
         ajoH50lAFdW2M9Uo85RCwwqORtS9IffzE7cpeRZoviaiTOIShv6UvIdxxEVRt7tFM/4d
         nHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uKv4sXYEnLM2eTvAi0c8sXVoRbjoKhn+nrSO0wy5muc=;
        b=Qzeng65/yKOCit4U7pNogPK8/Db7rjcXSFZ1Jq0VFcQOmgCaDuH45r0FNtqk5SUN1B
         iyAuCCQ99Pkwy04czjA6hL+ymoL6TKVwZqIxJ8HpNwXnPD2XZzon2T9IuqIVc4upoW4Y
         3O3nyWRBZ7t23HWlGYJjqMpW1dlC87jpzX2ykthRQ7krwQzmdhY6gdhbU2/Xeu77iGxP
         ondCSvMg4dHDkZfUGd/QPVKBTPuwUm5TDHwjev2rt5Kv5K75Dno8X2hprMRoiLH09/hQ
         v+1AhYgAX+Gjy0sol+zk8izKy4QmE4RS3izpmUv3B1vFeRWIYn6+9LJHTHlDRiog0duj
         DkZA==
X-Gm-Message-State: APjAAAUAPSnWle3qposvktAKAbGTGF+EyRxQBr5cR0ademjenYq5eez9
        6jKrV41cwroh2j+86TW/Ws4=
X-Google-Smtp-Source: APXvYqzQVp3+wOVAoT8JZ/h0/N1Hc9pNOfL0J7pUib83mWeo8nHQ4hE/emI9w/pWo25ucPt2XbL2gg==
X-Received: by 2002:a17:902:e709:: with SMTP id co9mr52670433plb.86.1555007989114;
        Thu, 11 Apr 2019 11:39:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 143sm74789704pge.50.2019.04.11.11.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:39:48 -0700 (PDT)
Date:   Thu, 11 Apr 2019 11:39:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>, Yury Norov <ynorov@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] lib/test_bitmap: add testcases for bitmap_parselist
Message-ID: <20190411183946.GA13348@roeck-us.net>
References: <20190405173211.11373-1-ynorov@marvell.com>
 <20190405173211.11373-5-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405173211.11373-5-ynorov@marvell.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 08:32:10PM +0300, Yury Norov wrote:
> Add tests for non-number character, empty regions, integer overflow.
> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_bitmap.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index b06e0fd3811b..709424a788ee 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -224,7 +224,8 @@ static const unsigned long exp[] __initconst = {
>  	BITMAP_FROM_U64(0xffffffff),
>  	BITMAP_FROM_U64(0xfffffffe),
>  	BITMAP_FROM_U64(0x3333333311111111ULL),
> -	BITMAP_FROM_U64(0xffffffff77777777ULL)
> +	BITMAP_FROM_U64(0xffffffff77777777ULL),
> +	BITMAP_FROM_U64(0),
>  };
>  
>  static const unsigned long exp2[] __initconst = {
> @@ -247,19 +248,34 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
>  	{0, "1-31:4/4",			&exp[9 * step], 32, 0},
>  	{0, "0-31:1/4,32-63:2/4",	&exp[10 * step], 64, 0},
>  	{0, "0-31:3/4,32-63:4/4",	&exp[11 * step], 64, 0},
> +	{0, "  ,,  0-31:3/4  ,, 32-63:4/4  ,,  ",	&exp[11 * step], 64, 0},
>  
>  	{0, "0-31:1/4,32-63:2/4,64-95:3/4,96-127:4/4",	exp2, 128, 0},
>  
>  	{0, "0-2047:128/256", NULL, 2048, PARSE_TIME},
>  
> +	{0, "",				&exp[12], 8, 0},
> +	{0, "\n",			&exp[12], 8, 0},
> +	{0, ",,  ,,  , ,  ,",		&exp[12], 8, 0},
> +	{0, " ,  ,,  , ,   ",		&exp[12], 8, 0},
> +	{0, " ,  ,,  , ,   \n",		&exp[12], 8, 0},
> +

This results in error messages such as

test_bitmap: parselist: 17: input is ,, ,,  , ,  ,, result is 0x0, expected 0x11111111
test_bitmap: parselist: 18: input is  ,  ,,  , ,   , result is 0x0, expected 0x11111111

on 32-bit systems. The above should be "&exp[12 * step]".

Guenter

>  	{-EINVAL, "-1",	NULL, 8, 0},
>  	{-EINVAL, "-0",	NULL, 8, 0},
>  	{-EINVAL, "10-1", NULL, 8, 0},
>  	{-EINVAL, "0-31:", NULL, 8, 0},
>  	{-EINVAL, "0-31:0", NULL, 8, 0},
> +	{-EINVAL, "0-31:0/", NULL, 8, 0},
>  	{-EINVAL, "0-31:0/0", NULL, 8, 0},
>  	{-EINVAL, "0-31:1/0", NULL, 8, 0},
>  	{-EINVAL, "0-31:10/1", NULL, 8, 0},
> +	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
> +
> +	{-EINVAL, "a-31", NULL, 8, 0},
> +	{-EINVAL, "0-a1", NULL, 8, 0},
> +	{-EINVAL, "a-31:10/1", NULL, 8, 0},
> +	{-EINVAL, "0-31:a/1", NULL, 8, 0},
> +	{-EINVAL, "0-\n", NULL, 8, 0},
>  };
>  
>  static void __init test_bitmap_parselist(void)
