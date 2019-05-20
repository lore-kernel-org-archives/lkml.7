Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DBC216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ecr0J2lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390684AbfETOAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:00:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45532 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbfETOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:00:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so14695746wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9mL4O5UKxgeQ6YgVpvHFfuhwxbNZ5YHPxsK8gfhi68=;
        b=Ecr0J2lDt2WmB+uNkzfbXRDF2lIXqOPdSPEi+quISw8aJCpu/hEJKP37CfN8xM90pe
         rzVEFd+Tzm2bAyEl6wpifclLxw3NffujRuFHLXDRRYia+I5y1IxRM9L49Yxby7G5s1MN
         2PZalXgXFXiht3BlfnASJn8b49sFcV/0p01o9F6ZgCjGZ0e+X0Ii6vyE/ScTE0L7qYuk
         ELp35CNOva/X/T2xbpw5hQOBlnElKoBDK1canzWOAa2Y8Vvu4MMrSuGq8MqOZf5yY3pT
         XqtsEZnrHo1q1MAMwa244hkx4zx8xQjOLZBbDSgzbSdI98vhFwbRuwRNpWSFDH2v+HXw
         ntIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9mL4O5UKxgeQ6YgVpvHFfuhwxbNZ5YHPxsK8gfhi68=;
        b=PL5V8diLSa96FCC+P6nkyAgA4iQBrMBngsMAz23YNW2Xd8NO1LxASUMFHDHRAwh84g
         LLXwN1+ygc7KgSB7zz5wtMT6ftcMqn56gUtdE2lXJfa6sLXRdm+Yy/wKnpWEHHhuAFMR
         +0RhPdwbdPT43r2HzSpGt7TvwyitAcmleAdNhrujYH0xXMnFtM6HUxNVsOBUU51HpFnk
         5JoSTpqvVrIXOrRUma/IH15v2kWHIgD6FsBG3lQtfsuY/00NzGjHr7x0KQxIbRlIPdjO
         sHPVLpgpfMQbBDUT9dQCEKoLj4m/GsMmPAJaSNdutt/yyrvUmKtlJ6fdf69U7VX434Xg
         n5Gw==
X-Gm-Message-State: APjAAAUdj0IVMINK9x9RKngxZpWNJadVVSaYYfbjLuwjjiV/LdXsgdAV
        wNE8vlqzk9rtQVIlbU6AkCA3yw==
X-Google-Smtp-Source: APXvYqxMh33+I8kq6JhPQH8T+UhQDbExP4qPLZU0cohanQu1ilJqgxLnPPggT85p1cjHMhE/I9oTXA==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr36015735wrn.209.1558360848054;
        Mon, 20 May 2019 07:00:48 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x2sm5292076wrs.39.2019.05.20.07.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:00:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] firmware: meson: meson_sm: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:00:45 +0200
Message-Id: <20190520140045.29125-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/meson/meson_sm.c       | 8 +-------
 include/linux/firmware/meson/meson_sm.h | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 29fbc818a573..4ef8c04ef80c 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Secure Monitor driver
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
 
 #define pr_fmt(fmt) "meson-sm: " fmt
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index f98c20dd266e..7b855deb1b15 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -1,13 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
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
 
 #ifndef _MESON_SM_FW_H_
-- 
2.21.0

