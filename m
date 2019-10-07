Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6D0C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E452B2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JShsrn52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfJGFQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 01:16:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36775 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfJGFQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:16:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so13529844wrd.3;
        Sun, 06 Oct 2019 22:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wc8zArjUNgVy/s50wiyO1NvyueOi4Jj56svA15IfJrM=;
        b=JShsrn52XpdHu4hzqho33vlm/BLTIB0ivbt2uiZYxukY3K1yVykXHD0hQV2AtMlVrx
         x4/ZJz+IX+gDOClpbBgREe5FW11lbD2bbYNh08gfeCdYssDP7b9P+VomVnt0sOQoXXSK
         4lYhsb8kc/DrS2+j92/giE0aFuTkP79hFCrIoVk/sSpv5+YpsLmiunm6L3SEae8+y+aR
         UPLxTLhFfhF67xPlW+kFrYaX6HzPyl9zWAKc1ogJtTZ1JRm+qOGaEs1TKP01dTZHdgpg
         WOLyWa23VwUJZZisFOoh0eQ13smEMog1px57lMXij29uhjpxAjj/R+d2ipurGHDpXcoE
         jPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wc8zArjUNgVy/s50wiyO1NvyueOi4Jj56svA15IfJrM=;
        b=e4pwR0505lEANUEYcUW9IcvNkAsV783+UV5FckdrgAT5jVRken4YeevUyf5rLzDcGz
         5c11tFONDGo2kzfdDeAzZB1u6o84qn1ddz2PrQ1tdY9EuEQH31CbS6fEyZZyT2QA5700
         TF1NigCxHjpzWSSAfuVZpmp4oqX89rxi7lZGSfSziSJ84srPseRNsWfV+t0/RsO1w97M
         2dz93TlLLlXIST0Lcx7vKmpmCgCRgWpDfwMmq4xdB3xMqdDlP3/irgXO956kJlMoP1SN
         1QgUN+uIzkBXD+vFzTTeX2K1a6Xg4n4EGqczr4ODjuEz2a0C70bErERMuaZNiG+E+czI
         Sd0w==
X-Gm-Message-State: APjAAAV4puwXG6XababbB+/LksGCs877Q0YZ32WPF0d0Wwds1mJsN/xU
        j6BRdFfo+j0Lbr7kYRALDKFUlu6Z
X-Google-Smtp-Source: APXvYqwzo0yTz3gSyrODu8GSaSVC/7ZRDoAU4U46fMeNIkG2Z/7Iqe/R78CRVGTLZSok+sa49AnwLQ==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr19624526wru.12.1570425358185;
        Sun, 06 Oct 2019 22:15:58 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s12sm26655859wra.82.2019.10.06.22.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Oct 2019 22:15:57 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] soc: amlogic: meson-gx-socinfo: Add S905X3 ID for VIM3L
Date:   Mon,  7 Oct 2019 09:15:07 +0400
Message-Id: <1570425307-3231-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[    0.086470] soc soc0: Amlogic Meson SM1 (S905X3) Revision 2b:c (b0:2) Detected

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 6d0d04f..dc744f1 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -68,6 +68,8 @@ static const struct meson_gx_package_id {
 	{ "S922X", 0x29, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
 	{ "S905X3", 0x2b, 0x5, 0xf },
+	{ "S905X3", 0x2b, 0xb0, 0xf2 },
+	{ "A113L", 0x2c, 0x0, 0xf8 },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
-- 
2.7.4

