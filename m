Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006FA20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="inqEST1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfJUMMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:12:55 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36221 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfJUMMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:12:54 -0400
Received: by mail-wr1-f41.google.com with SMTP id w18so13153111wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ug6kgZ8QOW8p9olYnlxtYa3obtNRGbiAcS8//CDGv28=;
        b=inqEST1a6rdLKa1B/0C6T6R0CsruEN5vy5ukFVnUdzLBKUp/4JTrjWv0mAGz89BedA
         UfXx6IW4sL/v0AzcWIyTz48nmyHNp2bqnjc017MUG0p3d7XtdhyjkBmH+5tShdJznjOo
         Svq1/pXyzlDefQwr9OXm0J2MecluaH9LuHi+18Pah73Sf5Wjr++d6AV44FEqVst8C0ZY
         QRcDLZ7uNoojfiUfIwhrii9U6FRuFfo/15MK/qfC4E1uj5OXC3H1YJccfWRO2cO5o3XS
         wgw34x+TQL1OH3qPUlkT/gDgsRwo5aQ84ROFkzZxZTQinobFTQKyAe5u6DORlVIB2xtr
         W0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ug6kgZ8QOW8p9olYnlxtYa3obtNRGbiAcS8//CDGv28=;
        b=O4yd7zd0FJMZMg6vVqC2zwaQm0zs9gQ99nq2uWTY2m9QRlLSTlrgtzz+YaZhoCc0AY
         DHyu0Nyx7uk9WP9b13QPuaZlkNuP6glyT/vOD6OiKY7NwFv20fDE1Zir0SAH5I9m8SKw
         JYy0aDkOWe56fTa/SYGlXrwxEjTRqgkYNAvQgARPQVb5KpnwF9F1GITC6lTEyg0BQm3A
         gbvkMOjSQuyFPKtgn1ayeeXD2S3avpmr8ZoDGbig9SkLHuOc0D6yHRNsPuQAApOEd0n0
         gRpZIp4MbX605FV/Y7AhmO0hdAi1J7YEs93d1uqB4wtIfCfCb+kH4r9d9p4bwU0JSSx6
         5b0g==
X-Gm-Message-State: APjAAAUVF9ecVVPD7+k2jA5vlkwDmpyKhg4AzL27WgXIogNln2dORJRJ
        Hl2DYqS2YRSyPYmdBeSLyDi3Aw==
X-Google-Smtp-Source: APXvYqwkOWiFa1GyuBns3ZT8QnSnTQywnuj2+o19cc6w/MTd9XbSaN0GEL7me6vG9IS86KoDyMHnLw==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr3138677wrw.155.1571659971007;
        Mon, 21 Oct 2019 05:12:51 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n205sm1958905wmf.22.2019.10.21.05.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:12:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] media: dt-bindings: media: add new rc map names
Date:   Mon, 21 Oct 2019 14:12:49 +0200
Message-Id: <20191021121249.25143-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new entries for linux,rc-map-name:
- rc-khadas
- rc-odroid
- rc-tanix-tx3mini
- rc-wetek-hub
- rc-wetek-play2
- rc-x96max

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/media/rc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
index 3d5c154fd230..e83db8559443 100644
--- a/Documentation/devicetree/bindings/media/rc.yaml
+++ b/Documentation/devicetree/bindings/media/rc.yaml
@@ -83,6 +83,7 @@ properties:
           - rc-it913x-v1
           - rc-it913x-v2
           - rc-kaiomy
+          - rc-khadas
           - rc-kworld-315u
           - rc-kworld-pc150u
           - rc-kworld-plus-tv-analog
@@ -100,6 +101,7 @@ properties:
           - rc-nec-terratec-cinergy-xs
           - rc-norwood
           - rc-npgtech
+          - rc-odroid
           - rc-pctv-sedna
           - rc-pinnacle-color
           - rc-pinnacle-grey
@@ -120,6 +122,7 @@ properties:
           - rc-streamzap
           - rc-su3000
           - rc-tango
+          - rc-tanix-tx3mini
           - rc-tbs-nec
           - rc-technisat-ts35
           - rc-technisat-usb2
@@ -139,7 +142,10 @@ properties:
           - rc-videomate-k100
           - rc-videomate-s350
           - rc-videomate-tv-pvr
+          - rc-wetek-hub
+          - rc-wetek-play2
           - rc-winfast
           - rc-winfast-usbii-deluxe
+          - rc-x96max
           - rc-xbox-dvd
           - rc-zx-irdec
-- 
2.22.0

