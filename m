Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8BDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062D7216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HHyCrQv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfETVQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:16:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42349 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETVQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:16:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so7363767pgg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=X11xXTQxYWoosLNPwRWlFnmTEam1kT0o1szWaMkgM9c=;
        b=HHyCrQv6G5aQvUtrHbokaGqaA/73YvYWAPzeYncd6Xx/YJz+fQgr/B6bilk7OIBcjV
         51/buRSX19vrNFecv6DsT46TQ2unVCXeA8Iy50BJNK+YVIzc+bb3SS6ekZprsUaIhTsT
         7upkgRb3XycoDsCp6DRRSlbZbd9dKhSfXUgBEyanuLsMd1CVPBQvGsO1OsEfgKxGTlzI
         XMShRDzXRkMW6zfE6RwzHcLa1/WfLRffKsTZuXS5bfUGhos/eOsBWRh3XQxEybqRk/fi
         oAUa2nQtG4Rk7ZijOf3EfSMu9Pg24vqpDlrOlyxtWzROmEqpmuqLG6sFIQMAwQ44R7HC
         PYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=X11xXTQxYWoosLNPwRWlFnmTEam1kT0o1szWaMkgM9c=;
        b=HxZqczmfWtzRU3R4r6hfDRsvgEEGuGFpbYGmZPoXakD2tk2MmTI6VYNKQTIsZnixpI
         PnJMoHFwaszsPG3+avV65ved0h3eUs0YpfVFSAqZX124J+qazRP5Vs2/qvyZfmA9sPoL
         eTcY6wHvqLVvCgTj0gPMd34osbTOO+sqUUxR4i5RDHVyIMfdtcWHM81kMLwl7c9xNhba
         GKu8XVNhTT9Jb9tCcmEAI1NuWTUnsAODvlv2Nrx9eJ2Vzf+Ba4NkmRBv54I0z4OZHGbv
         K0qFhvUiS6QJPTXja4P3V7Zx205kQupANaykRuO6UHiRg25Fe1ATH1QFy0pSJn1EUJlN
         PdmA==
X-Gm-Message-State: APjAAAVexr50wr+Bgo8Ocmyd8uzf2KG9QlyYieRnAKw6wR3wGRd7RoPr
        VpDqJncbTsBrUJ0tDCwj9gwdQQ==
X-Google-Smtp-Source: APXvYqxbwqwmTVULcWbnwfmIPrqu9zdhqXuY6SOKl7pRTLfZmefQFMMzdblKBydMvMK93i419kRUbQ==
X-Received: by 2002:a63:285:: with SMTP id 127mr5571201pgc.200.1558386978322;
        Mon, 20 May 2019 14:16:18 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e483:1cc0:e2c2:140d])
        by smtp.googlemail.com with ESMTPSA id 79sm34029407pfz.144.2019.05.20.14.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 14:16:17 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] arm64: dts: meson: g12a: add audio devices
In-Reply-To: <20190514142649.1127-1-jbrunet@baylibre.com>
References: <20190514142649.1127-1-jbrunet@baylibre.com>
Date:   Mon, 20 May 2019 14:16:17 -0700
Message-ID: <7hy3307roe.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds audio related devices to g12a SoC family.
> It adds the clock controller as well as the memory, tdm, spdif
> and pdm interfaces.
>
> At this stage, the HDMI and internal audio DAC are still missing.
>
> Notice the use of the pinconf DT property 'drive-strength-microamp'.
> Support for this property is not yet merged in meson pinctrl driver but
> the DT part as been acked by the DT maintainer [0] so it should be safe
> to use.

Oops, I replied to v1, but I actually queued this v2 series.

Thanks,

Kevin
