Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85CCC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B1E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E7OJ647N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfDLIhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:37:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34384 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfDLIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:37:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so3765936wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=ZKz/3nG67GwzsaV3N/YB/TEMllMIJbbub9F4fg+aT+k=;
        b=E7OJ647NESDimD3WKwbgRxMKtoGjQWH/13iE09HHdhS1NjNGM5sC+NKvZ6wo3f6hqo
         CxmgWTTURAyXJbOealiDSnk44TQ3JBtVa/QN5zI5yb+uYN9lJFS4WXhXxsyRysCuFNHl
         v5Y4D5TQE8DKVC+PqN8adRVATAuBWDryP9ooWLv8cJLyaDvrajRbxAd9f6alWe+kfVF1
         y1jW0UBWNPcRShpSlaGWrbx/vC9SPBM6XLL4QKxLG/lZxVpFe09MtNTy9dk8lPaeFfn4
         VOYCecqvu8sjAM4hWIggsDd64SrgSUF39uTVSreVTz3n/WqX92ynejAUMLDmZc/pkD4j
         f9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ZKz/3nG67GwzsaV3N/YB/TEMllMIJbbub9F4fg+aT+k=;
        b=RMXS9QdgpzRqHwYq08T2y+F9MZkrPHS+tlaW5tNUGoglgdQSxBeZFZwNadEYdgXysR
         /8xLaHCO4YONFAFAaM+3vZHqNbL9cVN+qp1oj2A0tQVsvZKjKyFveYXacuHqhIh5rhln
         Mc1T20Pt7p1neKJtnHFoXYG3C7tee1WjzKYbZO4cg7nKKayzeaPNJU8TuY3sCm/dtGiY
         47f/BiLvjrIE3XuG18o4FQrezOCvyrypF1tmLsxuNfAFkPNmBM7o2NC2hn7tIKadmAuW
         7ors8ruB8UHFl3LtRxdTesCGf7rGQlP3URv4kbjpply1COYNi8bngOumgBhgNks5jJci
         ypDg==
X-Gm-Message-State: APjAAAUpF9A569S2oZtax8qi4uA6gWd6sMwdFXYkFQVIsu5+CybUEv8T
        HZ/LeRL4uzbZdIRUzrfVAOLXbw==
X-Google-Smtp-Source: APXvYqy4rYbzVamG2wJvJxJQyRgXoKvrpKngk2aUZpY2KevlOpHB4AqVU/KMioKi6uLemMfT9m/wzw==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr10133283wmg.70.1555058249935;
        Fri, 12 Apr 2019 01:37:29 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y125sm12124318wmc.39.2019.04.12.01.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 01:37:29 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Add support of Temperature sensor Clock for G12 SoC
Date:   Fri, 12 Apr 2019 10:37:26 +0200
Message-Id: <20190412083728.21029-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support of Clock for temperature sensor
on Amlogic G12a SoC.

Guillaume

changes since v1:
- fix .width value

Guillaume La Roque (2):
  dt-bindings: clk: g12a-clkc: add Temperature Sensor clock ID
  clk: meson-g12a: Add Temperature Sensor clock

 drivers/clk/meson/g12a.c              | 31 +++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |  3 ++-
 include/dt-bindings/clock/g12a-clkc.h |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.17.1

