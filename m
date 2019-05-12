Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349C7C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B422173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfFp3mD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfELRqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:46:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36871 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfELRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so5533571wmo.2;
        Sun, 12 May 2019 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/WO/ffKN1nR7MAqYGhQYYeumvZlvKqHgg+H3sUnXZQ=;
        b=BfFp3mD1gJ83voX20yOdlNujQc4iP8GMJNSAhGKW9J+ieaGZrQZm70MlVwNRlAovJf
         cLFpPO4p3cCkiMwLKCMP3iIR2kpy2CwY88bzuvwuI29Rj1cxv6j36TrXibdYc/wS972g
         LokaEdxI8LH8sUVepVtWfShY3al33AYxz9wlelH2iHOQxrIUS7JQLWyjX+SBd/NT1JqG
         kh1JzmOkAKJLN4hcDplcv95TbVrzyCJiKzjHKPHo04KeZhCtZ+Q4/gkuu3KYJ/JUORGv
         D1fuidpRei9PjrnLRshDSoDfeqvNshBjQT3U9hUX6owqSSoRPARUTEn6Wo6xab5CBHev
         lMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/WO/ffKN1nR7MAqYGhQYYeumvZlvKqHgg+H3sUnXZQ=;
        b=H8et32e9XiRdKIk+lQLcnJQrMg4wkGYoKJSl5b5DaGubsMDc0/duwq3y65EEkK0whs
         eH51yxiJkmAsn8+A+Bj+oOaKxlCVOpxBPPfbuAxGV/McthC6I91llh5Btyrozoui/f7m
         h71lvldFteyftCYG4IUrq8WQvIHa6ktNgJgDXzPY+XB9p5peARJm8JcT1mIxxtmeOIkh
         1L2wVdGE9jbPBi70LF8UTGdS82zQiTmNRjMk3gI60WqATTHyBJg0zbdMlBa76IYGI8xM
         wetz585moZu63x2973VUsyFgWJUKXwetUrtA0v5BzQQbkTAPkBmigOjqX5K354Ycrtdq
         QqNg==
X-Gm-Message-State: APjAAAVxUWGlvFAe9WCw0743ACFEsKP3rxdPXlqLv6RcdOj/hB0WRyaj
        PTfB5cIbip1u0ffWeRCp+So=
X-Google-Smtp-Source: APXvYqzi9o0UaKC2uI0n2gwk41XjsRknm8NfjHda1nCX7OznFRIL6qrFRg5m6GcNJ+2ExgmPPAPjqQ==
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr12838376wmf.132.1557683183110;
        Sun, 12 May 2019 10:46:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:22 -0700 (PDT)
From:   peron.clem@gmail.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 7/8] arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
Date:   Sun, 12 May 2019 19:46:07 +0200
Message-Id: <20190512174608.10083-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512174608.10083-1-peron.clem@gmail.com>
References: <20190512174608.10083-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Péron <peron.clem@gmail.com>

Enable and add supply to the Mali GPU node on the
Orange Pi One Plus and Lite2 boards.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 62e27948a3fa..bd13297555ab 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -55,6 +55,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-- 
2.17.1

