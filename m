Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C65C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67D4214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="csK7yN+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfHNOaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:30:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37599 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfHNO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so9366730wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiVmfKlzhX6+dDL5MvsL5C8YsLLtVButKhe8QPNlosA=;
        b=csK7yN+GeTcXYTnUyWBLpWwT90bVsW9CnrykngjaAFulP+2ph/cZiCA5Iz1qBoOMK6
         QtZKWBNs0LVwpPhx6cq93toXileCBw/kNEFauKOb7n9za7X+5qPaM0rvb5gQc6zx00/1
         jGOUm00Ht2YMj3VZSKONgPAvQBpIKNZmb8IJ8ZFvQ902oAWtO9uc3RIuh2XvdKwp0VJl
         SU88TOqp1Cxftoc3rE6/DK2N144uTnEPa6jfD/gGeFoAT03qv9p1+entlTbLiLJraSXq
         LB5NolkJk9nCAK8K55wFYn0bFlIgrfUvA6gIf8BjqNgElVYI7bwRWKuaackaovIOxiyH
         udMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiVmfKlzhX6+dDL5MvsL5C8YsLLtVButKhe8QPNlosA=;
        b=PcOFFONgfWs9rERsMIcjE9gPOskEyhVsvt62rxtYKu/pdZkarHRN4SDh8Sn9FIm5nv
         zMlLLNxEhFH6q6f3OeMPEm8RkLoc739YHNMUaLZPwRb8CUHK2DMuupp41KclzM8rl1vD
         IdDb1A3fdiRv/XeGYwYX9AYvFufRaVNesKOGUUlYj5odC+HYQ2uEpA5mzeDvzeiKYoUS
         7lcvUm9pwuzKVcqvRf6r/FY3PLkQI7HMo+gh+uu2Z4H0vouYXqwDXrcQdObyKnrm6P6x
         haJ6VykAsR+pKpurSDYc/reXTChL+2AunRmZ2Sqwtppb/cimLZxVKiA4XuKBp25Zomrq
         lOgg==
X-Gm-Message-State: APjAAAVgs0EMS+vUyhvyslJPeCh5oc26nWoGdPtarYUCR6GvCA53B/xO
        7L7EYU6/7183B2Q86WrYPjb6XQ==
X-Google-Smtp-Source: APXvYqzUmQ4NrprEAKzwOd9KP+SVF5yie8a+CcXGRUd2PL2sQJQhOLqGqF9b/mFFsNAf9yfCt7f49A==
X-Received: by 2002:a5d:63d0:: with SMTP id c16mr789wrw.22.1565792969011;
        Wed, 14 Aug 2019 07:29:29 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 06/14] arm64: dts: meson-gx: fix mhu compatible
Date:   Wed, 14 Aug 2019 16:29:10 +0200
Message-Id: <20190814142918.11636-7-narmstrong@baylibre.com>
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
meson-gxbb-nanopi-k2.dt.yaml: mailbox@404: compatible:0: 'amlogic,meson-gx-mhu' is not one of ['amlogic,meson-gxbb-mhu']
meson-gxl-s805x-libretech-ac.dt.yaml: mailbox@404: compatible:0: 'amlogic,meson-gx-mhu' is not one of ['amlogic,meson-gxbb-mhu']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 00215ece17c8..d8127f863b55 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -476,7 +476,7 @@
 			};
 
 			mailbox: mailbox@404 {
-				compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
+				compatible = "amlogic,meson-gxbb-mhu";
 				reg = <0 0x404 0 0x4c>;
 				interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
 					     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
-- 
2.22.0

