Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CADC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032F3218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V1ADhv36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfGYOi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:38:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53746 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfGYOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:38:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so45240793wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=xKhjaESpwvk6sR4/SITRYpcTnlFG6jIulb5Z7EfG/G8=;
        b=V1ADhv36o2+cFrscOoSHKnRjQaO9dDNPwd3Ahh6Kl9afPgC4H7hsakbzpEII9ZBu3/
         LtKUTgwGP2hJW4bT58gqaxPReeLUWvqMGCpXPUyrP2WYF1zGLO+3neKuDwwo+Y3FHCkE
         Wvtcz3x2U+4xnulIqZltKgwoIt38DxPDPPyDf0XK3AqxmKDqo2E7Y49/iUffPrC/TJsv
         NYdXwTKkWfoIiM8q8r1eJXEbaHZSwVM7s1gB2mHAPGnEbGDnwE8T9PNUTUikrXHii2T9
         wA0jAXz+9MA1wlhWFtP21oNGb7/Ahj3vr3lwVYFCVAXVtbenOm+Zdo596KtqjgZ91d61
         lprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xKhjaESpwvk6sR4/SITRYpcTnlFG6jIulb5Z7EfG/G8=;
        b=kXSLGwcYaZps1FYh48CNjniew8DNchhu/v/Ej0JALBDSJP1bWZz6I2LIV6zq6NYKVD
         3TBO+j2sWsp7c4rFWWobKKrrcHyV0h0DSWtar/1jiKrIEQuDKseGeiwdITwRrCw8Y6Ak
         kgR1gAnGfYf65oAB+c4zCAoJ9OsjgDIwO6EUAZm42jnzHCeHkJqsR9Gkr6QEqkbgei7y
         p0EdZDponovS1AllxRJC19qFIVQJmplyzQhnnxBicvmOWtNd7eNJ/0G9AvsU1Hgs3FU7
         xVBHqaKOHpl4aXOcVE5ieHMHhjqkNHzdxL9bFupFflRSPFFgu9ZFLtUN4J5/X8FiTkjJ
         RvrA==
X-Gm-Message-State: APjAAAU9/kDCkc1EJoiizvycGV6zJoncJLRCHebc7TbrNimSk+L1oXTI
        /6UE4sUzZ+OPPM3fohad3SbJzQ==
X-Google-Smtp-Source: APXvYqxUa4coqzdXQVeu4+Cob/EMTrXyHltG48aeyxm8e5yNgpQ4cUf2+pfTE9+Acv3S/pIJ6kzOxA==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74mr84250838wme.9.1564065506038;
        Thu, 25 Jul 2019 07:38:26 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z1sm51923870wrv.90.2019.07.25.07.38.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 07:38:25 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH] clk: meson: axg-audio: migrate to the new parent description method
In-Reply-To: <20190722094954.14040-1-amergnat@baylibre.com>
References: <20190722094954.14040-1-amergnat@baylibre.com>
Date:   Thu, 25 Jul 2019 16:38:24 +0200
Message-ID: <1jd0hyxjq7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jul 2019 at 11:49, Alexandre Mergnat <amergnat@baylibre.com> wrote:

> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 8028ff6f6610..4253a466eae8 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -15,7 +15,6 @@
>  #include <linux/slab.h>
>  
>  #include "axg-audio.h"
> -#include "clk-input.h"
>  #include "clk-regmap.h"
>  #include "clk-phase.h"
>  #include "sclk-div.h"
> @@ -24,7 +23,7 @@
>  #define AUD_SLV_SCLK_COUNT	10
>  #define AUD_SLV_LRCLK_COUNT	10
>  
> -#define AUD_GATE(_name, _reg, _bit, _pname, _iflags)			\
> +#define AUD_GATE(_name, _reg, _bit, _phws, _iflags)			\
>  struct clk_regmap aud_##_name = {					\
>  	.data = &(struct clk_regmap_gate_data){				\
>  		.offset = (_reg),					\
> @@ -33,13 +32,13 @@ struct clk_regmap aud_##_name = {					\
>  	.hw.init = &(struct clk_init_data) {				\
>  		.name = "aud_"#_name,					\
>  		.ops = &clk_regmap_gate_ops,				\
> -		.parent_names = (const char *[]){ _pname },		\
> +		.parent_hws = (const struct clk_hw *[]) { &_phws.hw }, \

Those '\' are aligned with tabs. please check, you have aligned a few
with spaces instead

>  		.num_parents = 1,					\
