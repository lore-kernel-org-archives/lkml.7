Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E822720830
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Tw1R75wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfDPAtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:49:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40717 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfDPAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:49:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so9473372pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OHIy53jp0JN+BxNZ3p8lR9FcsiEoisvep8pYnRgGgYc=;
        b=Tw1R75wbypJ9p9BQrwN1jgSXpgLo7YPplS7L9OBVX8vSitRmwTQ0w03QnAEBsKC94c
         Egqc6Dq5Ka2ecux9/0d5UDe2BWZOd/piLGW+G+GXSgsMHrnwOMBfeVhnsgBy4xTCT9se
         Bpz2hDHDhazbpAUFfgcoM94zsXc48Ot+VTsZ6N00TXBR3/fWiYkXOl0y0Bsux4Sgj37e
         H4fcDRqDWyXqp+M3erQwo0zh57dVKoFpwIMSAa+9qtcOaQmQ6eesbM1/2Fu/vM9jdUUy
         yQY/vhR20ostPFS3btAXwCWahQNMr0KOgXJP4cvHLjLgzR8vypHlnSJBA6pDp0EmCajw
         bi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OHIy53jp0JN+BxNZ3p8lR9FcsiEoisvep8pYnRgGgYc=;
        b=QSMhF4t+kiJWPHz8sWoiHIHtPImDy6wrssiwc3Z0aKSAHb/05/KqWV1uv9iVNQoW8e
         X1nU8xtuYIYEPugLbcoLW/H+1M791+F59eDG7J1tDHh9+JvVO1/5xeuU3dQfIwHA79HT
         OrAvLBeKiFAUslLY4qbI6RFcRBMg//B9Y6G4nRyjXKpFrGmKrr8kOVq06oM28KN/dA3x
         vwmgXrNOPnH3FC0omLxOQj6SX7B9ew5ki4YFLqdZqwMLXznF2VB+xP+jHB02trfcvjqh
         nYfI91EdXSgJh9y/D3+gTda2q51X0YhJJcHy79iqfY2iwXhHuCG4WHn2058LwoCc6xKO
         QPkQ==
X-Gm-Message-State: APjAAAXQhXk4ix757fPCJ4vKrqcqRqXj36h5x/tbEXf+xDyMwnI3ULS4
        HEjhzZQ/UFcbHt59osZPQ/lnvQ==
X-Google-Smtp-Source: APXvYqxva3oSqCYkNH8pK9yZYbUCXmByJ/xklor3Ndaud8sEbhlZnoZ9EeR1uKOf6hoAKp+OVpFMmA==
X-Received: by 2002:a63:720e:: with SMTP id n14mr72547346pgc.93.1555375748757;
        Mon, 15 Apr 2019 17:49:08 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id 128sm38230819pgb.47.2019.04.15.17.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 17:49:07 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] arm64: dts: meson-g12a-u200: add regulators
In-Reply-To: <d262d931-526f-f0eb-ed90-d6400453daa6@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com> <20190318100458.5619-5-narmstrong@baylibre.com> <d262d931-526f-f0eb-ed90-d6400453daa6@baylibre.com>
Date:   Mon, 15 Apr 2019 17:49:07 -0700
Message-ID: <7hy34apyf0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hi Kevin,
>
> Seems this patch is missing in
> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/log/?h=v5.2/dt64
>

Yup, I noticed it when applying  the rest of the boards peripherals DT.
I've added it now.

Thanks,

Kevin
