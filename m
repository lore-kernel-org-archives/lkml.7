Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E47AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DFC2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p5hiQFsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfHNO3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:29:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39609 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbfHNO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so21186078wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzfWUBTNkEnWlc/VJanAk2xvxB7vKc+KwpDyTNdWOJA=;
        b=p5hiQFsis2UOLe0K/BxWbyG2jH2KpPMoLOyQ6Wnpl2Vf4HynbFCg5JOK+5/OGZOdO6
         TD39yapvQPrIo5Lz59swex+tSvYHaP+IXOznPBSYGjgC63mJoqcgi4iH1UdkV7thNEZE
         m3e0FrJJm7nBZncFEwy4Lg8aIBMBobRWYbpGR37WT+OA2o7el3TwYZDXa7Zd+1wdBtaA
         KVPSw8PCICD5UKZt0KAVH8BiS5cpO0Bo/NJIfDrWou0PbQtp2utaTlithYQkRUgTB62N
         WvGoQgaXXo1C8ShR26EPl1AoPgi6bMliW4KSWvti+mKnVBJc2+/kzU0keu+1D+eU1pCB
         bTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzfWUBTNkEnWlc/VJanAk2xvxB7vKc+KwpDyTNdWOJA=;
        b=YqVNMTz8G0MyRDZlmrIwajtSeKzf5kD3GVzS4nsjHW5FLitsqKn4GbtCHxsdNSJOJs
         vCxoLsoOCtkk6vPzQ9p+13HTMuHN3RpuWAcgqERkORTaOVjvAPgn0/T3/DOHkMOSxmbA
         lznzaYIHKKytkAIe3cXmUM5M1P4DQIdFLUpcMPYsSHSwhOq5OY2F7Eh32jqsyrb85PKy
         /snXHbDNU2RiuHQ6I8U0+omIiyaejku9i6yl9lZM/eFZQ5zIZ+CYyxHKGVhzkeg5RUoJ
         TMaFqsfPGba3XSH+Whrnls3eL9OT/yGctbKCb8BWWNtdPfkzvzjNeA4h1PJKGyVuXeVB
         E3AA==
X-Gm-Message-State: APjAAAVTw5iZP0yRyQWUs2T4g3h8/1lCPIA4kjz6BGCVb2ZS0fMuNZNZ
        iDV1Oz+N6Yw9CnyizTXBXll3Hw==
X-Google-Smtp-Source: APXvYqya2qNpy+swsErluAaX47OA7iL89LWY5IPgQpfrGkRoHlZUInIbqmt2sfzJ+IqY9mAjDKk4uQ==
X-Received: by 2002:adf:e941:: with SMTP id m1mr54057504wrn.279.1565792972051;
        Wed, 14 Aug 2019 07:29:32 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 09/14] arm64: dts: meson-axg: fix MHU compatible
Date:   Wed, 14 Aug 2019 16:29:13 +0200
Message-Id: <20190814142918.11636-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814142918.11636-1-narmstrong@baylibre.com>
References: <20190814142918.11636-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-axg-s400.dt.yaml: mailbox@ff63c404: compatible:0: 'amlogic,meson-gx-mhu' is not one of ['amlogic,meson-gxbb-mhu']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 4a134d29491d..ed59a9e8ebb8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1116,7 +1116,7 @@
 		};
 
 		mailbox: mailbox@ff63c404 {
-			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
+			compatible = "amlogic,meson-gxbb-mhu";
 			reg = <0 0xff63c404 0 0x4c>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
-- 
2.22.0

