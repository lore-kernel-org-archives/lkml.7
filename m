Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7EEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D477C22CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VwfExEy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392505AbfHWHDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:03:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35144 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405031AbfHWHDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so8038952wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYS/jLJ5SnTBfvUO73YfQ/qZMgKSxQ0+sfqUXBWxFgE=;
        b=VwfExEy20yJXYNxH8LKSGd6Mc3F55oX0J7Yva343vW5KwrjHbcdmyjuoNkCU/Zm7P9
         jzK7TUODE2Onk7XXbzt2FkZE06iQnI0ME3K7CPJh8ywR2ZKnubK+Xg/6kZOEe8q4Zmt2
         F0JyeHph/zSHkuFZfaDQippYQWw9HRrWgM+NEneHXMwN0p7mih38B/WvFxlgnLb/WBVy
         mLyK8tgI2Vu5NL+T4jFyOofLadOGW92CHCx0dI7qnga28Hij/IVDL55UraU7h8sgtNpa
         HzcHRqGlHigHegh5c5QFXnkrctrRhqqrm/xm//OhwuVxQ0fDj9hUV9yd+DrNLOJJT4jN
         8X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYS/jLJ5SnTBfvUO73YfQ/qZMgKSxQ0+sfqUXBWxFgE=;
        b=omvQa0SSbL6sUR9CYp0Q2DnQyE84PUpSmn00l5JfpggrtXWRkxjJXgGNxH4lcRCt0X
         KxXm+pibISF6Us3tCOjKpQbMw2k29F/nsVb37EtDODARVXQLWsK56SssIMAtoEY04Mst
         ak21zGoGgnEmkxNzyIwQk1PUD/oeqk9PN/E/l6+5MFeTAaQ4VgTZ3ZxMYMYPNubh8UlR
         nvbAkJaNoRzNsxCYFgU8rOe8iQZftgvtPbI4VNFhBvug/ZOD/S/N8d6cGNJf3K1MOq0Z
         L5XG9sRk1ul5HJNWkk/me7ckjR2MyTfBWqvo93WWMEVGJ4jfUlZvugIHY5Snu7m99fD6
         F5Ag==
X-Gm-Message-State: APjAAAUpEuhfFguLYQ5LtswD03E/0E2c/rk0Ft83W9wZriCScK5P+InO
        y/Xdw9yJfXM87Gy6IOQ6aYaE2ApvDDEXDQ==
X-Google-Smtp-Source: APXvYqxDBCBALfUY1roCUtb5nFCGs8ULUeZhn4O/3BvnRzigx377XPNv7t8/+DlNYXkU7+9hRiHjCQ==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr3334208wmg.63.1566543783727;
        Fri, 23 Aug 2019 00:03:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:03:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 10/14] arm64: dts: meson-g12a: fix reset controller compatible
Date:   Fri, 23 Aug 2019 09:02:44 +0200
Message-Id: <20190823070248.25832-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823070248.25832-1-narmstrong@baylibre.com>
References: <20190823070248.25832-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-g12a-u200.dt.yaml: reset-controller@1004: compatible:0: 'amlogic,meson-g12a-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']
meson-g12a-sei510.dt.yaml: reset-controller@1004: compatible:0: 'amlogic,meson-g12a-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 1a5efa2e16c5..d09c7a5cccb4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2187,8 +2187,7 @@
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
 
 			reset: reset-controller@1004 {
-				compatible = "amlogic,meson-g12a-reset",
-					     "amlogic,meson-axg-reset";
+				compatible = "amlogic,meson-axg-reset";
 				reg = <0x0 0x1004 0x0 0x9c>;
 				#reset-cells = <1>;
 			};
-- 
2.22.0

