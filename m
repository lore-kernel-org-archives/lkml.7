Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215BFC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA29C20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xjg2ACyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406958AbfHINC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:02:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46933 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406273AbfHINC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:02:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so98176937wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=guKBWWb3eeZ7l9sjmmrFhL2DHqTLBp7eL7U+EUACDM8=;
        b=Xjg2ACyHEuYzp7VVPyYXDDOpLZ7hCP/FwuXUsYIVKWH7tM0BC7WOlwO7zKUjhYotVP
         rHGLALHOhALV6DiB2heE8wKNPFy6F/JLb1mOJg8mfJV4pN3jzj2GIc5OOISpmByP0f9l
         wysMSu1etTSz9InGf+eX9NjVFvEiji/0GfFMni4Wp1A7v+duNuFbkHfqvADKqI589VDr
         R2iezcgxY2AGfVSmA2YqjtQKLCdYh3EU2LFVgr+pz9+KM0dNG/94LYvjCp62k0ny+gmJ
         5BallfcItdto7cNXHWjDaU/XR7ykQadkqJPsMKJsw9lyk73fUcJ4CtvCc+IJQjVnot3M
         Lz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=guKBWWb3eeZ7l9sjmmrFhL2DHqTLBp7eL7U+EUACDM8=;
        b=oEp9Ak7IpSuFqLGpPMpjTZe0jTINmXzC/W/uhvnxotAWEy6M+OHHfvCXid3YnMvH6+
         rn43/kqGjh9L1MjTUqh6WKKVCK+1TexyFFDf+nHrGtG6eL4m3eM2zmgBUHih7nSzicjl
         lY237ysB4AusFbrQvCcDO745PPj0GUNQQ+bkwX4l3OXb7NyUUgrSqXB4KxxDkclTSvRA
         CQlMbn/zawanW8U7CptpePYfyw91WC2vbaRrjSIaRFAtzYt7t3onjdqRVs9NW61jql9t
         +J2gg9SVarSNif4emEE7RfEKjLDUDwF+MS3RXF9Wm8xoO4xcv47OrcG8kMjQTW8Jy0cL
         0EOw==
X-Gm-Message-State: APjAAAUHgCxa81fy+qw/kMa6ZxAxzeXaVqn95O6MVQk2W1seFpjPcsQD
        hnt4ARJZhiI6uP0EXEX7yYwGoA==
X-Google-Smtp-Source: APXvYqxUWEqrAbLvbnYlAsqu5B1nR64GqnOYDQyeEk0f7fVfQpAONB4B8gK0T4HcpGUquzK6j54zXg==
X-Received: by 2002:adf:e790:: with SMTP id n16mr23176826wrm.120.1565355773854;
        Fri, 09 Aug 2019 06:02:53 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t24sm7932983wmj.14.2019.08.09.06.02.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:02:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>, sboyd@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] clk: meson: g12a: add support for DVFS
In-Reply-To: <7hzhkje4ov.fsf@baylibre.com>
References: <20190731084019.8451-1-narmstrong@baylibre.com> <7hzhkje4ov.fsf@baylibre.com>
Date:   Fri, 09 Aug 2019 15:02:52 +0200
Message-ID: <1jy302o5j7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08 Aug 2019 at 14:18, Kevin Hilman <khilman@baylibre.com> wrote:

> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> The G12A/G12B Socs embeds a specific clock tree for each CPU cluster :
>> cpu_clk / cpub_clk
>> |   \- cpu_clk_dyn
>> |      |  \- cpu_clk_premux0
>> |      |        |- cpu_clk_postmux0
>> |      |        |    |- cpu_clk_dyn0_div
>> |      |        |    \- xtal/fclk_div2/fclk_div3
>> |      |        \- xtal/fclk_div2/fclk_div3
>> |      \- cpu_clk_premux1
>> |            |- cpu_clk_postmux1
>> |            |    |- cpu_clk_dyn1_div
>> |            |    \- xtal/fclk_div2/fclk_div3
>> |            \- xtal/fclk_div2/fclk_div3
>> \ sys_pll / sys1_pll
>>
>> This patchset adds notifiers on cpu_clk / cpub_clk, cpu_clk_dyn,
>> cpu_clk_premux0 and sys_pll / sys1_pll to permit change frequency of
>> the CPU clock in a safe way as recommended by the vendor Documentation
>> and reference code.
>>
>> This patchset :
>> - introduces needed core and meson clk changes
>> - adds the clock notifiers
>>
>> Dependencies:
>> - None
>
> nit: this doesn't apply to v5.3-rc, but appears to apply on
> clk-meson/v5.4/drivers, so it appears to be dependent on the cleanups
> from Alex.

Indeed, Applied on top of this.

>
> Kevin
