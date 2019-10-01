Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB0C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A50A20673
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Onu3VeWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfJANP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:15:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39002 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbfJANP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:15:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so15496700wrj.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=cXF4bVzNL4mZ2sHi864OWjqQClm3/0ygqJ8rSRmtP5k=;
        b=Onu3VeWm380M/EcHG3V4up0pacX5N7qyK+GcKh4RVDpsXjhG8iF1hVGSqVEDuTNHBr
         igv8Mp9D47/2O7KwJhOV05NOxTruiNNqh84p16oV0Tx3luG3ngEGsUbST7CbdzlaSvY8
         9jbAlopFmI4zkpOeVaypIcG9P3cnoQzkd1vALhD4aR6Lv+PFXfgfuPfXqNSoICsSsnee
         jDG+/79iaUkjy+lVUtSZ9UhDeF+i37n1GE1Hr3ih0F1nJtU76vwbCx/FVp+ivkyAfuHd
         uXFGB1AuXv5rMimvOiA0qlImpHbeviLnzF/aQU2N4UOkB/ABQQpWAWhtew0KVL3vygAL
         EU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=cXF4bVzNL4mZ2sHi864OWjqQClm3/0ygqJ8rSRmtP5k=;
        b=EmsIEUjrQVE4uVAO2pX7Zh0RyN841huBKh3TJkYMH01jcDI/VOsi0G2F/bd4SfzOhb
         eUGfBD+3cY5diZ3feKu6kK3Tj1/2C2pE4C8NpUjQTK8I/sVj5pXevZm04BiyC004SqfS
         XTNXaDu9A9QfjJYpPGNa5Ch057cwe07I4vij1JAOPljtL5EizU0nZVedo8sTb70UzBwj
         lYPk4HpNOZJgc/qn7gglCrOrVYWDzT4R9uI9q06X0NOzUy/WnFCyrB3OmyK2W/J6cyWQ
         wwU9oyyV/3vnYZzu0KB/yxqIMBVgRjW0otsGb9lbC2S79JhA/fJLmiZubayy/u5i3NNB
         dSNg==
X-Gm-Message-State: APjAAAXQCjxGXGndf7+nhl96GOpErYwjWA+jnWTckkayyU4gQsi0olS+
        pnWkTXY1OB46Gu9ZTNEmYVK20Q==
X-Google-Smtp-Source: APXvYqw3udqS1Bk2K1srDEo4MExMVnaFf4vYT26GxKPArptG/M5yBwGjHsl5CLADaxkzRiOToYR2dA==
X-Received: by 2002:adf:f708:: with SMTP id r8mr17219949wrp.187.1569935756509;
        Tue, 01 Oct 2019 06:15:56 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y14sm31335535wrd.84.2019.10.01.06.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:15:55 -0700 (PDT)
References: <20190919093627.21245-1-narmstrong@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: meson: g12a: fixes for DVFS
In-reply-to: <20190919093627.21245-1-narmstrong@baylibre.com>
Date:   Tue, 01 Oct 2019 15:15:54 +0200
Message-ID: <1jh84sr4hh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 19 Sep 2019 at 11:36, Neil Armstrong <narmstrong@baylibre.com> wrote:

> This is the first serie of fixes for DVFS support on G12a:
> - Patch 1 fixes a rebase issue where a CLK_SET_RATE_NO_REPARENT
>   appeared on the wrong clock and a SET_RATE_PARENT went missing
> - Patch 2 helps CCF use the right clock tree for the sub 1GHz clock range
> - Patch 3 fixes an issue when we enter suspend with a non-SYS_PLL CPU clock,
>   leading to a SYS_PLL never enabled again
>
> Neil Armstrong (3):
>   clk: meson: g12a: fix cpu clock rate setting
>   clk: meson: g12a: set CLK_MUX_ROUND_CLOSEST on the cpu clock muxes
>   clk: meson: clk-pll: always enable a critical PLL when setting the
>     rate
>
>  drivers/clk/meson/clk-pll.c |  2 +-
>  drivers/clk/meson/g12a.c    | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)

Applied the 2 first fixes. Thx
