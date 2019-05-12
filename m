Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D043BC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5CD2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abLKdOs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfELRqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:46:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39220 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfELRqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id w8so10278668wrl.6;
        Sun, 12 May 2019 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p98bYKaDXcVUZuwnIBPZ/FdFvePGsYF2RuZMRuVjYxs=;
        b=abLKdOs0RFabo5GEND0zTOZyfkPDvhghjZxq2fsWLSpwzFrhJicR9jyufdbk1CDU9L
         J3wFEG29swfiDgIU8/+h9f3ipbmM27+bznSj7jQ2/s8qArm1YJxI8X0FV78uFY2Ny4xE
         zSXX3yClrh1AF+gwiUi9rla0gY5dVKSoDl75x7sy8/GmgVjfASsokQRovThYJ+kEGeZp
         sQwZb/Ex5wZXFcwJPGqgvyBmMShzFYfMsZ2EDZWzYzYfSwZvhtGn0jinqrK4dB3L+ZB7
         x8NKbN8VeSeE77qlo4ybhdLzsmJINDE9YjebAyaAZmMUYzjSA2H1FQP98ssvV0VPA7UC
         AwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p98bYKaDXcVUZuwnIBPZ/FdFvePGsYF2RuZMRuVjYxs=;
        b=s/FansWRMPI0+SNU7M3dVapJtNAF/4QdkP3jiJX/sRZnD0nMA3QfTJ5AXDGCJCfkpC
         OwnNv8l3pI7PiXka2jkxliq5WoXylf9qAA4aoRdpCC5z/DDIUe9NZi/tjDdw1uuwn12C
         sheTsyx2b/tAlQj2GSTD+Ch0R/ftWyd1/Gu4+ZhvaimJoCJxWArDI9XVg2DstvSfQWO/
         6ZKwdJlXe//DW6t51Qm1wTEF1bbnbppJ0ZAm6InQxu87I04v1DfPS88ZSVCwpkALMXid
         PBbQDKmA6xcGRf/YF0g+9FWQimryqFskT9sP5RAc25Yl8Bpm2mgZUtLUQvL8K7lzaoxB
         UQcA==
X-Gm-Message-State: APjAAAX6yuvcJdqgwq7nD2+vV0T3esvLelwp4Diz2BzOui5YFE+I/0t/
        Dq0ncjSBbAQJUcDszcnMEzQ=
X-Google-Smtp-Source: APXvYqxmVJMgR22Rrgiw76ZfkUKo9ruVzTo1GiQnpLImqxaLzFzVd7hGG/AexLVI7T+n/wNN3jTc9Q==
X-Received: by 2002:adf:c788:: with SMTP id l8mr9151728wrg.143.1557683181952;
        Sun, 12 May 2019 10:46:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:21 -0700 (PDT)
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
Subject: [PATCH v4 6/8] arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
Date:   Sun, 12 May 2019 19:46:06 +0200
Message-Id: <20190512174608.10083-7-peron.clem@gmail.com>
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
Beelink GS1 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..21440d572f0a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -70,6 +70,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.17.1

