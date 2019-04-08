Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11760C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54CB214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1ITXJau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfDHPZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:25:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51280 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfDHPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:24:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so14848848wmf.1;
        Mon, 08 Apr 2019 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7d9VRpeoInofCh/f8L4CRjAOhJNkNjfCgVSpQrToTc=;
        b=p1ITXJaucJjZwfa1H+EFoV+96DZqUUfwEwR/Kb3fUJKjSXwAC9sqEGU5/h8052km+e
         up6eGK5nix/v3RdGK507Z+UNn7z2809ELFImhmj8Vfret6GBQ3KFOAsbVXd5rJe+K9oM
         Xq50StAPpobvdNLn7HkMm12idlK0DI5JpM6ehno7pd90suOxZCBlAK34GBW0ezlsS/Yj
         BH9yt+AxN2KZTkUhm9C44eoFwnqErLEzheyQuA0qNKCguBxZkAvph8dLg+pOTVBxojaC
         /YQ2GtQR9llH5xCNCKSzQ7s1t3gG2XDciaXmaVq1m03Ad97saLJp6aLLt2pJADGKpyj1
         OORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7d9VRpeoInofCh/f8L4CRjAOhJNkNjfCgVSpQrToTc=;
        b=lDM9zbTBN942MIgDfpMQnrGujfJkVwjJRm3s2BlCTVgLuQNabR7+ZzlG5zUSYuV525
         4DayjosGBj0r759zZJQZAbNlWvbVy2D3DOY64bsP4LkQG8RJ42MbnCMJYfU6Ibr6Di90
         IuGPcnumqHjE4dN6OoGQWjZ9w3JvdOAQZgZY5EaczTGLzG/rU6/dPYeKTiU9jhNKuy55
         AQAPF8aZ2bQlV+R/yPVojga8u0wmqjTOzreSIjLAqNFIK+OurSiRRf941x82mrTGx2Ob
         vMVRTxl3X/gL8Xvpmf++5pkt0YU6TALICIXSDrimM8DmiaarP83fDT2Ga3pRGHwYBVaW
         SP3w==
X-Gm-Message-State: APjAAAWzKujfjrPdyX4+0JGNntNAcY6OosMcvbWbXOlhcTHRNtbufKxB
        zYzyEFUTCKa/zb2qDUa5VE0=
X-Google-Smtp-Source: APXvYqwQ4eKNbibPinxF8T4/K1je9la+1o+ZqsPMEYWmnS5XtDvUF14Qd/X7GEAYgkEmtayn+QxC3w==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr17445153wmi.138.1554737074593;
        Mon, 08 Apr 2019 08:24:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id o12sm32137298wrx.92.2019.04.08.08.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:24:33 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 2/6] dt-bindings: vendor-prefixes: add AZW
Date:   Mon,  8 Apr 2019 17:27:51 +0200
Message-Id: <20190408152755.17405-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408152755.17405-1-peron.clem@gmail.com>
References: <20190408152755.17405-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen AZW Technology Co. Ltd. is a manufacturer specialized in Android
smart TV boxes, Intel mini PCs and home cloud TV boxes with NAS.

Add the vendor prefix for AZW.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 208889476a38..4933403c4b57 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -54,6 +54,7 @@ avic	Shanghai AVIC Optoelectronics Co., Ltd.
 avnet	Avnet, Inc.
 axentia	Axentia Technologies AB
 axis	Axis Communications AB
+azw     Shenzhen AZW Technology Co., Ltd.
 bananapi BIPAI KEJI LIMITED
 bhf	Beckhoff Automation GmbH & Co. KG
 bitmain	Bitmain Technologies
-- 
2.17.1

