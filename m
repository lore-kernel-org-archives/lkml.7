Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAC7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058C922C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IuAAVnx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404092AbfGYNxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:53:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53636 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403804AbfGYNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:53:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so45094940wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/Kj7OdNc4vKrUG2qrwcQ6Gqjaaduh2n9Gif9XQMH8UI=;
        b=IuAAVnx3OcBDhT6g4leu/5sG9eZM1cBIoX6wt1TOSKISjyQl+einalGKU9vDYedC+H
         NHramEzlVMlvtdBrsFujHMulCkCxYkO4D6CeRj/thr/86rTSd9wthMwWDDzKs1oo02lD
         6e1DzNHM5Sx0EbBmczfe4kELw1Nq1At1gaMYNaTNJAqi6TQYi2wUdBgRvPnIaWzVd7bs
         tWHgSDDAxjtcpAWOvcJi1E7UncGTEt+3/WKiQLcedKCJ16B73XkkxyZiYPyGiTHbVxn1
         kxU5hIOdKyY9AdJXjfQR++0ebLNEqJyjFf/Qbm6E6+RlqPSZNpSkL7rzHX2JncW5dOBq
         5iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/Kj7OdNc4vKrUG2qrwcQ6Gqjaaduh2n9Gif9XQMH8UI=;
        b=op/MISxFlzdFcdqj91kCmHbzNvrfYFQbHh2dEUQZwveAiYYcNmQen2BsYgnu/JT3Lh
         YSCgbsPnyl9/gqPLoTC9vFn2sRosALSaxhIlpihlI1fWG0byFwU/2sHmt9mUTMnGuhaO
         oypnsk/kjcjINRL5Ayo54rtqJAAM9PuK/knjtmK6wDkX8mxl/czRUWc0ueS1nscUlIMs
         qwg+ls9a81Bv526LrBmbLO1PsxbFPgMK7wcOc/GnZzkuSQECsnumtHj+AJAagkrNYGQa
         jgX4Wn9ZcGNv2DAcZqeYI/pW9Ip/RBcDkp5TkMoAtT2w0vXArWIUTr0oTBs0CpQi7Kyg
         elUg==
X-Gm-Message-State: APjAAAVu35mOB25/0BadgAnUOtwXvgP8a/OpQ1h7QU1WMb172bgC2jJ8
        PoavdtxLlgOWxG2LNW1HqNidyQ==
X-Google-Smtp-Source: APXvYqwct1CkXuw5g8BXaKHLcZz60COi0xZJyXahWLQI83KPuF5bOK5xMjTM5XOreuA3w1Q6MFP43g==
X-Received: by 2002:a1c:f918:: with SMTP id x24mr76950829wmh.132.1564062822618;
        Thu, 25 Jul 2019 06:53:42 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c4sm39496984wrt.86.2019.07.25.06.53.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:53:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>, narmstrong@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH] clk: meson: g12a: fix hifi typo in mali parent_names
In-Reply-To: <20190524091532.28973-1-amergnat@baylibre.com>
References: <20190524091532.28973-1-amergnat@baylibre.com>
Date:   Thu, 25 Jul 2019 15:53:41 +0200
Message-ID: <1jftmuxlsq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 May 2019 at 11:15, Alexandre Mergnat <amergnat@baylibre.com> wrote:

> Replace hihi by hifi in the mali parent_names of the g12a SoC family.
>
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Missed that one in the last cycle, sorry
Applied for next

> ---
>  drivers/clk/meson/g12a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 739f64fdf1e3..e16fe882789e 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -2369,7 +2369,7 @@ static struct clk_regmap g12a_hdmi = {
>   */
>  
>  static const char * const g12a_mali_0_1_parent_names[] = {
> -	IN_PREFIX "xtal", "gp0_pll", "hihi_pll", "fclk_div2p5",
> +	IN_PREFIX "xtal", "gp0_pll", "hifi_pll", "fclk_div2p5",
>  	"fclk_div3", "fclk_div4", "fclk_div5", "fclk_div7"
>  };
>  
> -- 
> 2.17.1
