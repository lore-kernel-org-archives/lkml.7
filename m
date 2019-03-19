Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CEDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C493120854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MIGKVcui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfCSJjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:39:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50986 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:39:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so7382538wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=j4LluMz8zBVBlBijmLUX6TcBWQHn83DSqbxHhxWrKV8=;
        b=MIGKVcuik3tM5vzjuN4/C2+SPU/FXaaOp74zzb60EgZ4QeJgaw8MFw/tk93p1VfH1P
         XOwjY7bq1gr1b3UmQkbJQ5kaWtAgJC0MYWZDTHH7SDgTzLkvXkZBirX/6USFtL250XY/
         EWnyvnPDsUEKqqzjeQ9MlIm5cio1OzNDXLlqRc1xuAmMHB2A0881JpZDYmEDojL8J2YZ
         RNGh5qOtMbAzTqLiZ16TJxNax7L9OavEHLLO8KFYg6jNvSB2idgSkJi+M+YwTexL9ASG
         7lSvq+pHVf/wAWrdtRZ1vmR6hGzFTk59UxjwapJUXPDpgKbXhxQ28v17jeu/dXNdrDqR
         2SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=j4LluMz8zBVBlBijmLUX6TcBWQHn83DSqbxHhxWrKV8=;
        b=sjKeFuKgVPcTSmK6OvjCD4I8Yam1UJxlbUdVIJ+I0GFfHqySBmqQkdGH+mJhZ2HmrI
         FWobbCHXXwPWcA3XjJv6E9pktw7fbOFEZyFxueQb2VASvcvG8q7pDjsgbruio8VLCyB0
         2JIkVlgMnjVtvikjFJWkUTdSW9NF56xibG77QeCEIjp+mr7R5cEe56QApYzRzc+NWnCA
         70RNMtN/xzRNp0EV6xFoWTKTfIh9PX/SJkb3tu7WtU+m0VKkWOHaO4Xd3DPi6k+5cUgX
         Y4NO3xPXrf2HdkARiQZyaIQguSgD+g7oonnqVXC9Qb9dMauopLf8smTlkX/16lqTzwAq
         0MLg==
X-Gm-Message-State: APjAAAXjtOEiGcYumFCJXh4Jib5vy/SDtdA+zFKTnlzlacIaklGJkCD2
        DRWwmWshZ6SfN+DTQCSDG98DbQ==
X-Google-Smtp-Source: APXvYqwpTR8XfsZzMwNp41YJa6kGiyx/NyZGDsveoP2x0c498jnspqeKsy9vFoBMmX4ucJQobuYjOQ==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr2599671wmj.62.1552988383839;
        Tue, 19 Mar 2019 02:39:43 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id w12sm10432604wrt.97.2019.03.19.02.39.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Mar 2019 02:39:43 -0700 (PDT)
Message-ID: <e9e5644385fb0ac45faceec5ba005dc20ab65989.camel@baylibre.com>
Subject: Re: [PATCH v2 0/2] clk: meson: g12a: Add CPU Clock support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 10:39:41 +0100
In-Reply-To: <20190304131129.7762-1-narmstrong@baylibre.com>
References: <20190304131129.7762-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 14:11 +0100, Neil Armstrong wrote:
> This patchset adds support for the clock tree feeding the 4xCortex A53
> cpu cluster.
> 
> This patchet does not handle clock changing, this will be added in a
> secondary patchset.
> 
> The CPU clock can either use the SYS_PLL for > 1GHz frequencies or
> use a couple of div+mux from 1GHz/667MHz/24MHz source with 2 non-glitch
> muxes.
> 
> The CPU clock must be switched to a safe clock while changing the clocks
> before the non-glitch muxes. Proper support will be added later.
> 
> In this patchset, clocks are set read-only.
> 
> Changes since v1:
> - moved to clk_regmap_gate_ro_ops for R/O gates
> - added comments with datasheet field names
> - moved pribate bindings changes to driver patch
> - removed invalid PCIE IDs
> 
> Neil Armstrong (2):
>   clk: meson-g12a: add cpu clock bindings
>   clk: meson: g12a: add cpu clocks
> 
>  drivers/clk/meson/g12a.c              | 350 ++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h              |  22 +-
>  include/dt-bindings/clock/g12a-clkc.h |   1 +
>  3 files changed, 372 insertions(+), 1 deletion(-)
> 

With the small naming comment on patch 2

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

