Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C9FC4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F13320665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q/WqUD0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfFXXYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:24:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44112 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfFXXYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:24:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so7890912pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=97J2mQ8W9rxbq9xESMLvP971OTTkTA5uAArzuGfjVX8=;
        b=q/WqUD0hfVCG+bMiazVQEDX1BfPkf+2pUEhLqUL0KLAh7VEB54OkzB4glqfypnW1Vi
         JYJHp7jpzLg8iCwrFF4v9i/wNJm0f4KFcLQn2sJ+65DRtI/W2kniOHzCpcUcm9igWdgB
         4VwveWtICtwDSWbVZWAsrL2oDMD/CSjIOF6h5EimvwMtoi0Gy7GQSmI747P+E0aqeKVs
         jebJ/M3g/YzXrFslWpv5ExSiZtx6pQpkHlzCZyha0zeDRNp9IWXOCNhfVRrpF4PvsDD/
         j1flPIXcRJ4r0HQZc1LMMFO7T8dMliZD6E3xJUjuLbqCvastIIG3Wl03BdjT3a1sUiSz
         KNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=97J2mQ8W9rxbq9xESMLvP971OTTkTA5uAArzuGfjVX8=;
        b=YmmtEcIWTBugVF5NXriQJOsOed8E7jJhjb85OEz9k2FlH6S1qUwAHOgpmph6oqbkXo
         Ok1FukVOeP5SBQPSK0apK+QjAPxZVKdCOB2fdTH1YMHiw0net9BYn7MzQ3yyOovCR6zx
         s1EzoB9UxHmBFk1YbYwF30vptbMlj+n4yzZSWAVBmgS7taE7+KPv6T9aV/4ZP7WCm35/
         rJaDiXVmfqUnBSdX78LvGWMvgI3H3rBH+yoQ0EKNk78iZJ9E3q5pOwGH1pvG/vy/B0TJ
         7FeVpNwTFlwmYCLgvyXmJ5rG8XfsJEEDjMlY7d+OZlWyZO6G3cK3ok83noYyGm1cT6OJ
         uocQ==
X-Gm-Message-State: APjAAAWNx/qJ8qSX/IUZOHBn74W/KijGNj/VCjYRKJyqgA7jSrqQtl7y
        GEyjw/mzm3BMfpJdO+kRXqTzhw==
X-Google-Smtp-Source: APXvYqyJ4qa0FiXJgxfwOsACg9uzcWq9QV35TxSpj/Rhhn6aABo5DnNey+XA0cB/QHxSOT2N21tfLw==
X-Received: by 2002:a63:f746:: with SMTP id f6mr11806300pgk.56.1561418677315;
        Mon, 24 Jun 2019 16:24:37 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:559b:6f10:667f:4354])
        by smtp.googlemail.com with ESMTPSA id q1sm15808527pfn.178.2019.06.24.16.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 16:24:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Julien Masson <jmasson@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: Re: [PATCH 0/9] drm: meson: global clean-up (use proper macros, update comments ...)
In-Reply-To: <86zhm782g5.fsf@baylibre.com>
References: <86zhm782g5.fsf@baylibre.com>
Date:   Mon, 24 Jun 2019 16:24:35 -0700
Message-ID: <7ho92mwor0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Masson <jmasson@baylibre.com> writes:

> This patch series aims to clean-up differents parts of the drm meson
> code source.
>
> Couple macros have been defined and used to set several registers
> instead of using magic constants.
>
> I also took the opportunity to:
> - add/remove/update comments
> - remove useless code
> - minor fix/improvment

Nice set of cleanups, thanks!  I especially like the extra in-code
comments.

Could you also add to the cover-letter how this was tested, and on what
platforms so we know it's not going to introduce any regressions.

Thanks,

Kevin
