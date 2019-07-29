Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250D42070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JaMcne2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfG2Kxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:53:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50315 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbfG2Kxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:53:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so53425064wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=P3COhzyH6iXhkUqb58Ll+n9CaZJ1lhlavM2fMRktAGU=;
        b=JaMcne2DiIeeVdHaTOx7JgVOlm1khWybU1LyPFgBTqmdGdKfa9IF6b1ryZ2sB+bASI
         Fi2JBz7VOeu8iKN+vl4MO5yNst6wEnE2TqUsVhBiNePV0f3zFT3jzs2RL7c+Sb9kcQxm
         CG59Hh/jNrQbPWIpCAo9g+OsOTjKTyUjGfA990pehRyBz0gvUdzeP1pzVdohzIdGOemP
         fiVrSttr2vz+jWzQxvJ7d3GcWtgQdpmSyiv50M02cUS1ChTJ8z7Fnj+45R8o4VejuBRO
         jUHBx90LyQtnv7Tklc6uaYD0QK7/OWaB6JmVSEU19GSqhUnO3kxP8m3sLeaiYIVbb7o2
         385w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=P3COhzyH6iXhkUqb58Ll+n9CaZJ1lhlavM2fMRktAGU=;
        b=JIhtLeyzKP5bED7WjTrz1oUwJS/7FOpl0FitlcyUPKTn+vivYYueT8JlOf7JU4vgyu
         pDYzZgYcWAzj1kALP62eoryznW8/aF15oQ8GhkAEYgThWpSSEymQ8731eEB9afzLVT83
         a1AulgBVVYGdTmwSYgTRTq/cxn7guzTeVLNvzLqcn0iR78n5samuBUkWf2KZ88HtO4di
         Zv58Tu4GCAUMdOMawnFUI8vyG69qyXTeBGpsaEQAn3eUxMiyJnfOGdT3SmtKt9BHxHF3
         xGUdsSDvyAMTEANtY2k1yX0//0AWu5alZz3D+TpRkUG1/Rzuzid5duNSYboogF2ckdS5
         PmIA==
X-Gm-Message-State: APjAAAXedqNR9A8L32yAgyw5kAfiNE7u6DFtBk12kCqdwpGqI2TOYjx+
        drwIxSXvoMCJfPmDi+cWKsb4Eg==
X-Google-Smtp-Source: APXvYqxwuWo8lB42LjgZDeetJ6kM9JIYJvns12qyruinqHeJddpFQariDUkpt28Qlhw6t91UoVT+pg==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr41453713wmh.165.1564397620334;
        Mon, 29 Jul 2019 03:53:40 -0700 (PDT)
Received: from localhost ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.gmail.com with ESMTPSA id i13sm53855709wrr.73.2019.07.29.03.53.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 03:53:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v2 0/4] clk: meson: ao: use the new parent description method
In-Reply-To: <20190725164126.27919-1-amergnat@baylibre.com>
References: <20190725164126.27919-1-amergnat@baylibre.com>
Date:   Mon, 29 Jul 2019 12:53:38 +0200
Message-ID: <1j36ip9knh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Jul 2019 at 18:41, Alexandre Mergnat <amergnat@baylibre.com> wrote:

> Meson SoCs clock controllers use the string comparison method to describe
> parent relation between the clocks, which is not optimized.
>
> Its also use bypass clock made from device-tree clock to provide an input
> clock which can be access through global name, but it still not optimal.
>
> A recent patch [0] allows parents to be directly specified with
> device-tree clock name or without string names from localy declared clocks.
>
> This patchset replaces clock string names by clock pointers (as possible),
> removes bypass clocks and uses directly device-tree clock names in parent
> assignment.
>
> Tested on GXL, GXBB, Meson8b, AXG SoCs by comparing the clock summary
> (orphan too) before and after migration.
>
> [0] commit fc0c209c147f ("clk: Allow parents to be specified without string names")
>
> Change since v1:
> - Improve clock parent assignment for "fixme" using name instead of fw_name.
>
> Alexandre Mergnat (4):
>   clk: meson: g12a-aoclk: migrate to the new parent description method
>   clk: meson: gxbb-aoclk: migrate to the new parent description method
>   clk: meson: axg-aoclk: migrate to the new parent description method
>   clk: meson: remove ao input bypass clocks
>
>  drivers/clk/meson/Kconfig       |  1 -
>  drivers/clk/meson/axg-aoclk.c   | 63 ++++++++++++++-----------
>  drivers/clk/meson/g12a-aoclk.c  | 81 ++++++++++++++++++++-------------
>  drivers/clk/meson/gxbb-aoclk.c  | 55 +++++++++++-----------
>  drivers/clk/meson/meson-aoclk.c | 37 ---------------
>  drivers/clk/meson/meson-aoclk.h |  8 ----
>  6 files changed, 114 insertions(+), 131 deletions(-)
>

Applied
Thanks !

> -- 
> 2.17.1

