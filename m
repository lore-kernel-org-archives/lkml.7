Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAD8C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB66D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YdvDQmpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfEUPfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:35:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38977 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfEUPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:35:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so1533518wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0uik/HMoz37j2coMurAJJ2JSRGBbGbninuq4WxTSmzk=;
        b=YdvDQmplGwYrrQtRoix7kegU3RDr7LFfBOaAAJJgLK6wQHPTL+PyvT39LNUpvGAhR5
         kTEpm6EeyVOszu7t8m/gELtsglkW+M6UzfzSmcfqRR775Wd3JpXLQAPI7Yf0cADqiv2o
         TKqlONz5O2H8NbaWINI0tNJRQXveZ2/W01MJCgH/y4NOr9YIuOJAxS8qCX8CQzeL/VT1
         oI6Ve4yEqWBoCr1caKUjM6BnlY5B9W5gEaNH49lCIC2RBG+Nz/Gd1jQhuNTJ1/dCDPnX
         wlkz1sXfIGUqeUO3dHFrMmygoQh9yYXkHC9WMAtgGBln1LJs0i+QmXGuPsbxGX+zAQd1
         Y0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0uik/HMoz37j2coMurAJJ2JSRGBbGbninuq4WxTSmzk=;
        b=UyIM895YTYTBI+sojjsd9OwzQ0IvT0hBqq+/ZBhyRPuxyXNzE4agQzCPaINIZUGQwj
         01U1hnyubtD9rKeSAvHWnOKlXlDKNNQzQy/JiY97xyNMtKEDXOTfEIXD0x8B5dGPQ7P8
         TLTIDl47Khjdc7NDxYi7jqIfAk1Y/6e1lHeWUfMHOCktuwym/1onc2ZDSCK6W/KBGhNB
         /DhRJzecdJYpvB0oLY8VtJEZhhFSdFV5/TfXWosSmL797N0hX+tFfSiteeTfYQyIwUQU
         GQbpTR2Ikix24lRe4dUs9A/sEi8J3pk1+PZUYCUe5g7AFKH7DizViVrUOxMdkPw7gXro
         BylQ==
X-Gm-Message-State: APjAAAWPJldZGHwe9aS8xz7p9HHDGIrEcBxuI58izgGPIzBU2MJIdYDY
        pxtkmgwHXDNh84VGY0ZH/yQ7dg==
X-Google-Smtp-Source: APXvYqzp5XGeS8omRNy+ysC8swVAt9RDTiOAhNzBwblewdgtd2l9gOiPJ9lYetBBdt1eIvDzUWgk7A==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr4040780wma.73.1558452952229;
        Tue, 21 May 2019 08:35:52 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j123sm280848wmb.32.2019.05.21.08.35.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 08:35:51 -0700 (PDT)
Message-ID: <e6b7c6f8073bedcf6cc9d4810518c95b651c401b.camel@baylibre.com>
Subject: Re: [PATCH 0/3] clk: meson: add support for Amlogic G12A
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 17:35:50 +0200
In-Reply-To: <2fd7816a-de5e-c42f-a825-9552d8e79d34@baylibre.com>
References: <20190521150130.31684-1-narmstrong@baylibre.com>
         <2fd7816a-de5e-c42f-a825-9552d8e79d34@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 17:21 +0200, Neil Armstrong wrote:
> On 21/05/2019 17:01, Neil Armstrong wrote:
> > The Amlogic G12B SoC is very similar with the G12A SoC, sharing
> > most of the features and architecture.
> > G12B clock tree is very close, the main differences are :
> > - SYS_PLL is used for the second cluster (otherwise used fir the first on G12a)
> > - SYS_PLL1 is used for the first cluster (instead of SYS_PLL on G12a)
> > - A duplicate CPU tree is added for the second cluster
> > - G12A has additional clocks like for CSI an other components, not handled yet
> > 
> > Dependencies :
> > - Patch 1, 3 : None
> > - Patch 2 : Depends on Guillaume's Temperature sensor Clock patches at [1]
> > 
> > This patchset is a spinoff of the v2 Odroid-N2 megapatchset at [2]
> > 
> > Changes since original pathset :
> > - Added missing sys1_pll div16, cpub div16 and cpub atb/axi/ahb/trace clocks
> > - Rewrote "This patch .." in commit messages
> > 
> > [1] https://lkml.kernel.org/r/20190412100221.26740-1-glaroque@baylibre.com
> > [2] https://lkml.kernel.org/r/20190423091503.10847-1-narmstrong@baylibre.com
> > 
> > Neil Armstrong (3):
> >   dt-bindings: clk: meson: add g12b periph clock controller bindings
> >   clk: meson: g12a: Add support for G12B CPUB clocks
> >   clk: meson: g12a: mark fclk_div3 as critical
> > 
> >  .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
> >  drivers/clk/meson/g12a.c                      | 659 ++++++++++++++++++
> >  drivers/clk/meson/g12a.h                      |  33 +-
> >  3 files changed, 692 insertions(+), 1 deletion(-)
> > 
> 
> And I forgot Martins reviews...
> It should still apply to patch 1, patch 2 has changed with new clocks.

You probably want to change the series title as well, s/G12A/G12B maybe ?

> 
> Neil


