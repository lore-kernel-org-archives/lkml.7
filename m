Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB2C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0C1216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EeFetSQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391910AbfETOl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:41:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45879 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388595AbfETOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:41:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so14865704wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30PJ+hCzDjQrVZsjGcZ/FXod6I84WDUG4kPyRzhauWE=;
        b=EeFetSQar48eOERqadrJy/r1TMYWe3tvZZ9D73uAfTEe7xVlG9kEpGi8cKF+fZimcE
         vm0msi4QvsnBhRfGIWhN5NNnIwMhd93/3iJtEhj5AL3iIQrATygF4+gQuTFsMqLYlFLN
         K8lCV0yr+e+dSMqXTPM60wWxKOFL0s5xNJRlB/AXELJESu2AnSF2NWxHl/PjfcHkluhC
         BRI320Yx0G12ddsNFsbrCxYlX3WgQFy9wj/vrNsVbEp4AfInuuV5cspNpMkKwhQHM4DR
         PcO6080P3WqMfMpZxg0SuTR/h8UMnUQRpCWASqneD6F01V0xT4DLrhqhv9+ip0oEoCqT
         OwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30PJ+hCzDjQrVZsjGcZ/FXod6I84WDUG4kPyRzhauWE=;
        b=b8zTaWRML8MFJyj0OvOsdDbR6DRXlfd0GmUIfriyqS2r73+A6TqJ2NVz+LcCaHITwh
         2msg7q1q2y+jmF3yJT5MXpZ3MXxdWZd2mOhqEnjWCEwNBQC263QFstvK20A38lX13Z7H
         RztqrNTDan5ras6CxACu5VOhJl7pYY+NqmC23VfDaw8x9YYGE8eBOmFLqt8cWFSVjJfw
         ltyAWkf3DCpXaKxdTywAbSudLPV2BimFXJgsnks5PowsU1cQthOZfW4eBkMSN/40UNwh
         Xn3J4OfBY/p2scnXrjXG8Bw1TmdZ6e6grXnNJXj5VbfACT1a/8cGywYUwtmwl5NV9su0
         Bmhw==
X-Gm-Message-State: APjAAAXahiKBmlMsdhQVMcFKXEynoNiwO5yeZfTkHsLB6f0iHcJh5Njb
        AW0fH9aKX+nbr0v+PK3Hgp+foA==
X-Google-Smtp-Source: APXvYqwy0QdFmLf4P0q3Gllfwk9oesu78IlGZ97TtHhp2ZY2oBw/SZe5fTVEuzIPvAu1zn35uG6lRA==
X-Received: by 2002:adf:c60e:: with SMTP id n14mr14278140wrg.255.1558363281892;
        Mon, 20 May 2019 07:41:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w3sm6743679wrv.25.2019.05.20.07.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:41:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/5] dt-bindings: gpio: meson-gxbb-gpio: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:41:05 +0200
Message-Id: <20190520144108.3787-3-narmstrong@baylibre.com>
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
 include/dt-bindings/gpio/meson-gxbb-gpio.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/dt-bindings/gpio/meson-gxbb-gpio.h b/include/dt-bindings/gpio/meson-gxbb-gpio.h
index 43a68a1110f0..c93274d7e108 100644
--- a/include/dt-bindings/gpio/meson-gxbb-gpio.h
+++ b/include/dt-bindings/gpio/meson-gxbb-gpio.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * GPIO definitions for Amlogic Meson GXBB SoCs
  *
  * Copyright (C) 2016 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _DT_BINDINGS_MESON_GXBB_GPIO_H
-- 
2.21.0

