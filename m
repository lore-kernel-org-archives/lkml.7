Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE23C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9E9216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1jyb7sI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfHAHzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:55:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53399 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbfHAHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:55:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so63566786wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCllPmBw4lut+Uqi6OBcOMhCVblvrSC3X451qg4jFyI=;
        b=1jyb7sI9h2Uu/fkFZ5BhBBVZzi57jo75CTaozgehdA86w5n7mdgbzo60jiiZVdMxE6
         pU9AtBQsVZQWlm3Fj86Y/7/Guo6t5FrrkQTNpzN1jnFbIPJxcn2uLdrBjAQiIB45ETGJ
         J9TgoQgHrrAtw2229GrQF+4d8T/JvLYVBTUb4XHiKyi39GxSMmrRHylwfXm10gJ9R5Br
         0TOn0DO9J7iG7Nf18SBjlN5QL59+5/Kw2mEDuX16FEcZc+Tghy0Pp2JccwIvZ9bJSxTe
         qBygl1LSw4Rk33E5JtmMmvOhd2R26tZZH7kmUCnLwzxgd4wcqbMN+ZWyjQ1jWXxE55Ko
         lwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCllPmBw4lut+Uqi6OBcOMhCVblvrSC3X451qg4jFyI=;
        b=YiJ38uOCxcgfOxpbIyXZ+naXXgvN1AW7nlswB2vlpJADJJ5bzP5IbnQbv60scemeyA
         Lo6Vc/2GLYmEE1/IoWkZRsvr8D5ZNp3Y5+gr/Fh1XoerFeoYFMsQ6cMu54NFPk12aTJV
         +CJh4WScy3XDY3JrS7ppEtLqrg8+gngsoI9kCyCytGRWfGo309DHnCKr4iUixqTa/yY1
         EpbSRFLJ4/dJlFwH9XYznT3Tb6JEhwGeK4d9VTpB7p+WxSTyOAs30fr3R98gH6c2IwnK
         hC/ye4Yudy2ile1CawAYA4efko3r4bC2/nFhuqnuaP6LJGIh6iC17LkpGIzJ8SNnqviC
         dktQ==
X-Gm-Message-State: APjAAAWxA6+JsFfG0ToURFF45Uai8vGyFa5pKO9ydZuZTqGylfwe1uPN
        1jayHpm7PsLoVXvlbDBXL00IFNh3bgY=
X-Google-Smtp-Source: APXvYqzlDJs+p7+lHmLvPaIqh7+AzhIFpJlRyvlJ/W3TVENURBpyKur7D9F3PzuD0Ye68XsD7jxAXw==
X-Received: by 2002:a1c:407:: with SMTP id 7mr120943986wme.113.1564646100198;
        Thu, 01 Aug 2019 00:55:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y12sm64199221wrm.79.2019.08.01.00.54.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 00:54:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] reset: meson: update with SPDX Licence identifier
Date:   Thu,  1 Aug 2019 09:54:51 +0200
Message-Id: <20190801075454.23547-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie updates the Amlogic Reset driver and bindings.

Neil Armstrong (3):
  reset: reset-meson: update with SPDX Licence identifier
  dt-bindings: reset: amlogic,meson-gxbb-reset: update with SPDX Licence
    identifier
  dt-bindings: reset: amlogic,meson8b-reset: update with SPDX Licence
    identifier

 drivers/reset/reset-meson.c                   | 51 +------------------
 .../reset/amlogic,meson-gxbb-reset.h          | 51 +------------------
 .../dt-bindings/reset/amlogic,meson8b-reset.h | 51 +------------------
 3 files changed, 3 insertions(+), 150 deletions(-)

-- 
2.22.0

