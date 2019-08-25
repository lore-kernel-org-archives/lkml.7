Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F1BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFD021744
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNUzb656"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfHYEC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 00:02:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40473 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfHYEC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 00:02:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id c5so12490525wmb.5;
        Sat, 24 Aug 2019 21:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pvW2fAe5qKhI+32AuCLAPIq8InayZWwjBPViLCnooBA=;
        b=YNUzb656fRAp02e6EEjNCbourwaslTMlBfdnBZy5wc53xGSYuZGIQs7JrIlbea2Ugd
         JCJaKvCjo33MT3ZkPK7p4hvKqnrDLmPtCkIX1skl3nPAS2pm28ktEL1cGvtLu5gUuCTL
         SpeCPIfLBsDnp24rwx7ZvHv2QHx+oxy7oKISEvsBR5nq0JXelIrFASyD6L/xW+orfsCs
         4XjG1JvF5NHvvPv51TgA8lFj0SQSVfAECmw8InYZkiLgWZpoOa9/I8HJGPTU2pJixc0T
         9F70iMW+nudCwXOtIT40A/Gw2g8ZMiNPfh6W0y7vfwxzsKrJ7mDWdJdmAoC+VrZyYvCV
         1rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pvW2fAe5qKhI+32AuCLAPIq8InayZWwjBPViLCnooBA=;
        b=MYvHJYaQekYADocXzlP+SSQ325FLCW6t/EHSTkkxy3yGosS9+jYoLQbKmViF5kZLIr
         GRuydr0v/W9w+z4C9Dod1FFcAw92fmrPJNMuISUvRHGKmvEw3oi7fAQsxzG0/uOKPL7G
         GzfBPtx6CWWfP/tx63eKla+LpOA0um6n/GXhgwMFDlp6YWzMrXnLpS6NyTa1jG1BKX6M
         UEUWRBlBKB3xeZiTsMXEySW6xJjO8Bq0zdC5qWohiaFurHuQoMfY1wzCSXlnBdWOxR88
         xWait3FiV4ahztiydNUsx6SpMQVy3+YwKb0L0hJCmjGLlPsc11LGuBXPDbMLjsa5Uzay
         +dow==
X-Gm-Message-State: APjAAAVrPWzopqINhb6GcKFpUIM4j/Zf8CQtqZihax8lwL9dSp6FiUiF
        6scT5TD6wK2CzS/Lh2buqb1M2wf4rEsFLw==
X-Google-Smtp-Source: APXvYqztzIJKlySFmdH9BdFnbtrF+f7KI5MphOF2Nh6m250q3lZ/+sKv+4qCnuRAgmm6p/IffKy0hA==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr14162802wme.130.1566705743964;
        Sat, 24 Aug 2019 21:02:23 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a6sm6820985wmj.15.2019.08.24.21.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 21:02:23 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/7] arm64: dts: meson-g12a-x96-max: add rc-x96max keymap
Date:   Sun, 25 Aug 2019 08:01:23 +0400
Message-Id: <1566705688-18442-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the rc-x96max keymap to the ir node

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index fe4013c..357d7dc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -277,6 +277,7 @@
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
 	pinctrl-names = "default";
+	linux,rc-map-name = "rc-x96max";
 };
 
 &ext_mdio {
-- 
2.7.4

