Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD774CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FBA21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1NWmH2z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393955AbfJROCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:02:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40292 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393782AbfJROCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:02:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so6219738wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5CBhhjtiBJtUXHuswumRAbaakqLfJts+720cWrlZy9c=;
        b=1NWmH2z09GHgfCyPShOXPz55FcFZFXlrnCPaYhAZih6ufwpGt+uGcHES/YgS9G7AyD
         TjlWzGp6QSZQ/Plj7Fg6fa1O+o4He8g8mCl4ro2Qf8zYu74l0DlJDuuExcUb634mNFCw
         DflImEbV562DXqYFLZw4V/We6w8h2+tnJ7E0UlfJWYIvCX24zIBTPt9IA5Kb5Qa7yE/S
         JivwaOkaLNSMziiVx06+bCqUhMoX5fjguDJS3XovMLj7wvtFrbVH90QDiqKOEPMPJizh
         yqVC9Afj54xJ/asNWENDEnQNCT1SQnzq0VtWHktFadEnMNCwArFK4iGSXQoR5mBhWwnK
         K1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5CBhhjtiBJtUXHuswumRAbaakqLfJts+720cWrlZy9c=;
        b=J2nd2jwSPZhGLG9y7LUvjkJuT2XpIBn318P8fgCoPY4neJ+G6PP0ZVvegOsQSTSplt
         ipPcCspjDIlng/F9tT/WJmK6svXO7xfmUMM/DSXp3/W6HxxwR/+pCQ4jveMJoHCIENS5
         YjcDKi2mkmm5amWEeBj6NUtj/3xazfgEBbzQyDJ+gMo2O6QqAmSw49Bx76kvCIy7lFK4
         F/3T8vSmOyZyhJ7fCeGB4bpE9g7aBGzWMjagA5vgvF9RWwQKZ4rchNJeQfXBuFRnKBRf
         6TPbtTrjilmSnS0S6YN96T9CL1Dxtq3RSWLekfgO+iLoo33iCif6wbhRUbpz2liUIMn3
         14Ww==
X-Gm-Message-State: APjAAAVzeLP1dXmqCOXfHZuf/jkuhbaN7xkkt6+dQVtFsx5bHCxVr85o
        uDQqfU3ugsILieU0lo6up7HdqA==
X-Google-Smtp-Source: APXvYqyr9cCO6BLTmqktOcB+bPXp/GVMRJ2LggJBrT8KsUPIinP6v+fUvqFypckvyoAm85yxqbHaoA==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr7544842wmj.91.1571407338885;
        Fri, 18 Oct 2019 07:02:18 -0700 (PDT)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.gmail.com with ESMTPSA id w7sm4499671wmd.22.2019.10.18.07.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:02:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH] arm64: dts: meson-g12b-khadas-vim3: add missing frddr_a status property
Date:   Fri, 18 Oct 2019 14:02:16 +0000
Message-Id: <20191018140216.4257-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the process of moving the VIM3 audio nodes to a G12B specific dtsi
for enabling the SM1 based VIM3L, the frddr_a status = "okay" property
got dropped.
This re-enables the frddr_a node to fix audio support.

Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 554863429aa6..e2094575f528 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -152,6 +152,10 @@
 	clock-latency = <50000>;
 };
 
+&frddr_a {
+	status = "okay";
+};
+
 &frddr_b {
 	status = "okay";
 };
-- 
2.17.1

