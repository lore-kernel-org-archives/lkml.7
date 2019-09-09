Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD48C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F282086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFAKdO2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbfIIPCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:02:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33331 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfIIPCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:02:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so14266953wrr.0;
        Mon, 09 Sep 2019 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PZPdLQeLOEyJtkoSAS2YhSEAdoTAaUvZCMb2Qa3U3f4=;
        b=QFAKdO2+MqvIwbO2LZ8+o2T69rCPUwEqSgPmIkPR9J08dm02Y84WAZidtVqsBtLIxd
         /fIKRGSbKAkpWXv3JMLBUGprFPFZVhI1aSVS/VCa8IVxMWoET8/5PaZZF3p97MMWn3lZ
         2sw+5tlyHn7fv1pH7nGrj5e0luBJtq4a3x3QHsp0xXiomSEKj7LVJ4+PC8KwAyHMLTAA
         hMF/eo+znis+fYXcM/HkLLbLCe7CMqKiAs5t7r5Pg03rJuulmXXGEs9qPLuTzOssKN1F
         yl9jpIzXnl/soAYoonErCvjQfwHRQlegZgQHo6nuCUyQlnGH3MhCjzFaPf8yc5TLevc/
         /KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PZPdLQeLOEyJtkoSAS2YhSEAdoTAaUvZCMb2Qa3U3f4=;
        b=TrcpmAVQMER9shCEgASg8OECup81Q+klhnGvgu0dWWT5U0bWsNcVXmmP94lEE38gyA
         KT2QrC6q5TRdiq/y1Iz7YQxs+/KaPh3u9WjQrIxTkUySbucZy1VtQPT3BXdNpM/6KgNb
         VBT41mYXcLLXly46Pt0xKokkXJTYJFuMoYL4UB48SiFsx/flWUfOAansdb3BvfO2ie8E
         zc4jhi83R8w4CgFEKWo5WZiaczTzKKB/uGw6lJLWSc7U6fbifyTjCMuMA5YKpCiQw8HI
         2/xGT0WBTOKfNExmt8ZA+/a3+B9soI8CVQcbWTujn8bnXOuUoJgrE3uyjLXIs602AbmB
         np3A==
X-Gm-Message-State: APjAAAVxvrM68jkwC1H7o1x7cPXB3cCIJm2dZsqm4BpkLXrRbb+kP3PX
        uqw4BH4oXdeJqsPMxb27s68=
X-Google-Smtp-Source: APXvYqwkXa05gD+0n/Wm1U/GTv1nqjlBkf/38URHAZzWapXaKegLzhdiBoCJMBhOXltgJda6pNiYzA==
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr10269237wrp.58.1568041352095;
        Mon, 09 Sep 2019 08:02:32 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s26sm27755397wrs.63.2019.09.09.08.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 08:02:31 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 6/6] arm64: dts: meson: libretech-cc: update model and compatible
Date:   Mon,  9 Sep 2019 19:01:27 +0400
Message-Id: <1568041287-7805-7-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
References: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the model description to improve readability in some app GUIs
that show the string. Update compatible to be more descriptive, using
the format of the LaFrite board in meson-gxl-s805x-libretech-ac.dts.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 4b8ce73..e8348b2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -12,8 +12,9 @@
 #include "meson-gxl-s905x.dtsi"
 
 / {
-	compatible = "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
-	model = "Libre Computer Board AML-S905X-CC";
+	compatible = "libretech,aml-s905x-cc", "amlogic,s905x",
+		     "amlogic,meson-gxl";
+	model = "Libre Computer AML-S905X-CC";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
2.7.4

