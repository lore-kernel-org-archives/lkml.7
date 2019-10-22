Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4121CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF59921D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv9TZUON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfJVEFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:05:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44699 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJVEFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:05:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so9763838pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvDsvRwPfcgldx1LeklB7J/5Yzxu9yHwJdbavvwR4Wo=;
        b=nv9TZUONTfn2dSraMbNzPS6RYqeRWCDRij1vxog1Qym35FvjMVPkawBQFmZECv0PZb
         Lz266mg1REaBVhlL7/fqjDNfLk8gplYJ8WvmcjIGorKnWkO4j+f9ogIN5E9IKnEdF5HI
         SvSULYCChllQY+fA0n/PQQEStsaHgagJVMlDvEosG5K/P70MkVT2gp12VpjAVAO/kB7P
         y/4Raa2exKmFP4WMEDyX91JODQboDbigbv1kcK7r9hVlv9X50FolOFrQFSNmcV5BVjFk
         HMrEMiEBjD26G+RKQIjw+B2l0BvB5rUKUDzx+seq7G3QcGdQx+KQyICqLInwEvnNI6wN
         Aveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvDsvRwPfcgldx1LeklB7J/5Yzxu9yHwJdbavvwR4Wo=;
        b=CnKcjV19HesfH8/UMXv0qJ42KhN0e62PPKv91iylkk3TIS1ngljmBUmhxTEE3Dar2v
         RUjZWzvs+8VdbcI7OLweH7A4lFd20PIPPC4SZjpDTupc7/qsto7UYnOd6mmk+50zg7Zd
         zLBK5xJeYywUgocVsISBfc/XKoCHU2dDipm8OqfzRchqL086TtwRkgNY1Le4yUVeS8Gz
         3q0W/NHuU5jWR5aFrRnUtlSgcUErogO6GIy1ckQFnn1wnmfFxpU/zLpK4jnTw7uCiltt
         dq1EEXor2UgEPHLOrHdvxtbpfLgVUlKiiQfI2u18N4qlM/+VxpJ6VVaFQPtSGV+HLUrk
         ggRw==
X-Gm-Message-State: APjAAAVFzBP07qx+F3ABBQB9aXZy8PBGCaE6IbvdwXkpg11gzHJk7UA/
        8gpJiLK62jmh0yrOiKEeA+aCB8+1
X-Google-Smtp-Source: APXvYqzqe1MXlja2x8rhvx2cmcIDk27akdvPynUOLWps4bFjuSxrtOBiL9KkmR2fjxDn4c5DsI4aQA==
X-Received: by 2002:a62:a50b:: with SMTP id v11mr1766600pfm.164.1571717120413;
        Mon, 21 Oct 2019 21:05:20 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id n3sm18778738pff.102.2019.10.21.21.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 21:05:19 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: imx6qdl-zii-rdu2: Specify supplies for accelerometer
Date:   Mon, 21 Oct 2019 21:05:00 -0700
Message-Id: <20191022040500.18548-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022040500.18548-1-andrew.smirnov@gmail.com>
References: <20191022040500.18548-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify 'vdd' and 'vddio' supplies for accelerometer to avoid warnings
during boot.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index a8c86e621b49..42c0a728216d 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -360,6 +360,8 @@
 		interrupt-parent = <&gpio1>;
 		interrupt-names = "INT2";
 		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&reg_3p3v>;
+		vddio-supply = <&reg_3p3v>;
 	};
 
 	hpa2: amp@60 {
-- 
2.21.0

