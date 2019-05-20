Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF6DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8311216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GL1kPF/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391842AbfETOle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:41:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36986 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389518AbfETOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:41:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so14927179wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyDz/kU6Wjim2biRU2q8CqgWCCB8KF6iAcPXPEhI4iE=;
        b=GL1kPF/zUzZXKB5Un27WiEJQ0HNwcqqnlgkMiO94zM4OnjMJI1m+TNzvxK4Yn+Gx/8
         5O8+gBuLemwUJVEipgg/GahnWgcjh0WLtWb0wr61aGUmUtQopw70+M3+d5YBam07vBvP
         ooVf8RaJCsspmSiwvNglwLoisdmIU4WgXxqjHO3jt/BzyV0M4bBrMlx7gLFStGfEPh8k
         FP6DpQyiBbQf80owDtMzoOOv0DRnv/0FMnhZUSG8Dn9+Dwucxn9Xotr9GoZ9AzOJ/Fte
         a7SJQMwvLQPrdlFVrmy02dW86PGusTvFGXn0n8frBI/zylHHeuBpPZG9eloWHuoydEm6
         8KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyDz/kU6Wjim2biRU2q8CqgWCCB8KF6iAcPXPEhI4iE=;
        b=YReZNzZ9H20d86ATyxQFia4novdyqZ1COwgLAOS4ro474XS0bpelik2msKItzWn1bR
         WudNda8hLNyrsQWAdiK6NwuU352III5Ez39F6ij+pvdOamSwCaBw/+kKro5sAkS6qYO+
         ml8/ArFKqARCN6OXaagaHReS8ikWdANAuVKqdN/SRhM0Uzq0/JcBseneTmWeOyAqcfdO
         ybfFloo/JliRKQRZdeeYv0wNMZAloVJREljZNfmgPhq6UVvaaMs//kjc3SX2q4VkH77f
         8NfEETLSfVFBHxUZCQ6XMKHsyzx0voYp7IAAPXQXhQEWfYfZdm8dVUUCuayeGBgXrfet
         1NRA==
X-Gm-Message-State: APjAAAUSd/mox2+XGJMU7poIUzpBodbPrn3PuvDi2L4IA/y98iDpDdnx
        ckRSRn9o43Q4WBNER/TulVXkPw==
X-Google-Smtp-Source: APXvYqwNFE1d2hRxTr4yNHyu/Qt22C88efwwzfb2tPMpnZSFiu3ODusoG5pkwtkQFTWj5bADDe/gBw==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr36194064wrn.209.1558363284655;
        Mon, 20 May 2019 07:41:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w3sm6743679wrv.25.2019.05.20.07.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:41:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/5] dt-bindings: gpio: meson8b-gpio: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:41:08 +0200
Message-Id: <20190520144108.3787-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520144108.3787-1-narmstrong@baylibre.com>
References: <20190520144108.3787-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/gpio/meson8b-gpio.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/dt-bindings/gpio/meson8b-gpio.h b/include/dt-bindings/gpio/meson8b-gpio.h
index bf0d76fa0e7b..e75d09b6087b 100644
--- a/include/dt-bindings/gpio/meson8b-gpio.h
+++ b/include/dt-bindings/gpio/meson8b-gpio.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * GPIO definitions for Amlogic Meson8b SoCs
  *
  * Copyright (C) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _DT_BINDINGS_MESON8B_GPIO_H
-- 
2.21.0

