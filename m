Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7750DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454F321773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FKXkKv4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfC2Ijl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:39:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55614 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbfC2Ijk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:39:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so1568940wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oV9s7B6fOCEuHBo7NqIclE7KCi1bwoXzo8XlZY4r4hU=;
        b=FKXkKv4C4JhWKV6p6n9guP/PK1Y8XKgAooRp8BD9Lg5pLUJLrbgJVxioVBKg7lHhvQ
         qw5Ib+w8nWtcSVzPix02g6TLa8CRrCBUik1HkN4JGeldmfGYm5KcmbtGwNLf0N5HvK2s
         NDiOy6/cb8HGdLlGMIodsFAOg2PxiXBWKsVqjN0XRsJ+aSF+6Q0HGa7EFl5aN/iGxuXw
         cEzg70Zm7UrGN3xAesDL1a+evvWwCnQmFuSmCp8aDmyHDoeLEirZrORJIH8XARHG+HXA
         AiDUhwh6I6f9mLfQ0htpbAZOyagqQ1rGrzv2v3qPbcnoDDB+WdzH3WCWjY7rOM8mtqoH
         NgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oV9s7B6fOCEuHBo7NqIclE7KCi1bwoXzo8XlZY4r4hU=;
        b=uBQciDumkOg1NV59IhuIPj9byx4qXzV3N+01ilCkNWVeWqGEbPxNTT3RiHPuMACmI/
         F/gpbfnAPBKUXGDSOAfU0drvUthCvuLKhE4szHFO+p816LSNXlYLDLfd/iVT8sqSMzbn
         7wLn0JqFp/QizirZilQPxuP4G30v2MpLxyVC9TThZyCUDQku0wbBKVjvIvgyl94RaMkX
         qJPqxuibGEHWRK5HRJe13hYFnqOOHWHjIPWYp9ZqfYVjVIwS75CLtxImyYdaNHnFnyFC
         JrFPCv4xSHIX5BeOU5XoOfhhE3iu1ea8GJ7kFjvp3n16xoJNj8sPnU6BRKe+WelY0gqW
         TtOw==
X-Gm-Message-State: APjAAAWxZWmYX6GI9UkPoWtATWgnqxMEOr3rYn3/gsPYt9e2QN4sFzBm
        Ik0Q+sz9EUTyofiTZJL8JxGWkg==
X-Google-Smtp-Source: APXvYqyotLkWO5lGRRr4pxM4xWl0007akwWtBATfp/8oZNh8Xqd7ZJcbgLMj6TnkzEM3lNF35v91uA==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr2632175wmc.63.1553848778160;
        Fri, 29 Mar 2019 01:39:38 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id a17sm1422214wmg.40.2019.03.29.01.39.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 29 Mar 2019 01:39:37 -0700 (PDT)
Message-ID: <e8360360029a29296b98586f1d1a440996d89947.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson: vid-pll-div: remove warning and return 0 on
 invalid config
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 09:39:35 +0100
In-Reply-To: <20190327151348.27402-1-narmstrong@baylibre.com>
References: <20190327151348.27402-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 16:13 +0100, Neil Armstrong wrote:
> The vid_pll_div is a programmable fractional divider, but vendor gives a
> limited of known configuration value and it's corresponding fraction.
> 
> Thus when at reset value (0) or unknown value, we cannot determine the
> result rate.
> 
> The initial behaviour was to print a warning, but the warning triggers
> at each boot and when the clock tree is refreshed.
> 
> This patch moves the print to debug and returns 0 instead of the
> parent rate.
> 
> Fixes: 72dbb8c94d0d ("clk: meson: Add vid_pll divider driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/vid-pll-div.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

