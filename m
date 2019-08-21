Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF51C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F7122D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yAV/e+ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfHUOVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45387 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbfHUOVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so2199347wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzfWUBTNkEnWlc/VJanAk2xvxB7vKc+KwpDyTNdWOJA=;
        b=yAV/e+ekrtyY9b4Eo/9OoN6c4F9k3cky7Ppfmh+cFTmeKeONj6ZJ74ecLJxhulStGj
         X/UCEnUusPmkQBnpY+HOUwrNdgOUnYNCu4SNpmOSqGRezfihUL3q5Hcx/abHOk4l+AV/
         Y7NxzwQbllJ89qte9l19hRPxZPk5gJ5ujCagUrbgJC9oO8b7s36RYBr1YwIxm4Eozgau
         3e3Hb1j9o289OpLpamqQDWAEWZ5u2Op68CPfPm1eU/hg5fYq4oU3hWop1bOJ2a/zGoLM
         91ai8qV3xmScEG+hAQ2qQAusJGc4z5zcB4Md+AY9v4S0VRJRnXkyutZTrS7oSOIqkEl2
         fnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzfWUBTNkEnWlc/VJanAk2xvxB7vKc+KwpDyTNdWOJA=;
        b=e1/hVVOoCwUXemZkIaZKu1wFSAtrkbUkqouSdyyWp3D4s4otmukDKgwU9dcl8Mwhh1
         GD3ceOMDPfNxf2fE0K6UZBbDO1+n5uMs0p3pMZcO924kGtHYx66ZsnDN2q6DRU8OEsq0
         zkqTxpB8sh2RQZoS1FIDbu0cqAhBKy6RYqmfquEDPwgXT19eWeKXX5yqA+OhYU2HDZQs
         p579869i/rGz2ro08ytRqDMkF1m93FUfmAbfOmwNfMRmaSE2DIC6SL7/EhMgFc8zwcKJ
         FgxXI7MKTb8HltSigBMeaLB9N/JP2iq7xbu9rZQjodJkM6c/79uzffUQgePaxuuGExeI
         tuvw==
X-Gm-Message-State: APjAAAWgQcKKUU/ECM8aX2qSWXBrbaNdABIpSM07RymtozUlsh1yJ1Ll
        l6WykOYMswgIWT4DcHvGM4EOdA==
X-Google-Smtp-Source: APXvYqw/9/lvzwJGbzm3g+KqS1vmKr5c1QmUBOI25jsJfI2RDtvNeSZJuII68ytG/TAUfRcleVO0Pw==
X-Received: by 2002:adf:e452:: with SMTP id t18mr2159313wrm.0.1566397262783;
        Wed, 21 Aug 2019 07:21:02 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:21:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 09/14] arm64: dts: meson-axg: fix MHU compatible
Date:   Wed, 21 Aug 2019 16:20:38 +0200
Message-Id: <20190821142043.14649-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
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

