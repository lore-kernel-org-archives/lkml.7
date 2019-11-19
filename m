Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C7C33C9D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A302241E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hwh9vxCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfKSS6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:58:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35798 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfKSS6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:58:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so12264104plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCrU7kMtOhnJwNIZxfz0SZJ0AKq1g5JZVrjQTxHcuS4=;
        b=hwh9vxCU2MJkwDgYPUI84hzOt7qhmc+CdovSRIV3pSu7WrmNbWx60wYUeYsB1Kaw5j
         Vkozznd7ocVPn2yiTH/c/09in9bcd1n2P6s/+xRlNGog+zIVuJ4ZcHFh+FU9ML+L00RO
         7trPFH1QWPt3v2pZhWacMpyA2S+kLOvMSczd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCrU7kMtOhnJwNIZxfz0SZJ0AKq1g5JZVrjQTxHcuS4=;
        b=R9BAllzE5pgpc6eMD4HOLCfvuJepxMTqxJ+BJ0FY7CpjaDp6X8tdOaPt8hKLwps4i8
         04rPQ81q4FqPub7feoaIZ2E/abAN0lYeU7cnP0N4BK0kpxVdTr0LNev3EL2qQQTgGN2N
         Y6AKUvDvIPhdw1wfVBmtdKCsmm2guIFdFIP/+u/t2XCIEJaH8EkVvQxAr/FwKSuJ/R2G
         B/7A/LfA9lgXHb6DILiVZVGGYbzx/5ZCcdJteVBLi2/8j7q+yX/K/q53lww4zsGLcrNv
         b9XeDd91kFY8n3Wa164Pa+LGQpFrUwjKeOplNjpGIjoX8LrVME4N0Nom3FQ70fRnRbau
         FTyg==
X-Gm-Message-State: APjAAAVoejoSJOGa+GGi17Trlu1KCiUD7t/olTqsMNNwqfvw4uhJec4D
        jNIcPk8PGJgPRm4Qmexat6MjJA==
X-Google-Smtp-Source: APXvYqw3ksX3/scZkZrClNcQI4wINkcNVOzF9sTBjirib0yItcf3MYqd2S8L7QGc6k8nAcGm7H1WcA==
X-Received: by 2002:a17:90a:8995:: with SMTP id v21mr8517928pjn.109.1574189914762;
        Tue, 19 Nov 2019 10:58:34 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id y24sm28017581pfr.116.2019.11.19.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:58:34 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Add libretech compatible for ROC-PC
Date:   Wed, 20 Nov 2019 00:28:17 +0530
Message-Id: <20191119185817.11216-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191119185817.11216-1-jagan@amarulasolutions.com>
References: <20191119185817.11216-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though the ROC-PC is manufactured by firefly, it is co-designed
by libretch like other Libretech computer boards from allwinner,
amlogic does.

So, it is always meaningful to keep maintain those vendors who
are part of design participation so append the compatible
"libretech,roc-rk3399-pc" to existing roc-pc dts file.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
index cd4195425309..6a909e4eefd2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
@@ -8,5 +8,6 @@
 
 / {
 	model = "Firefly ROC-RK3399-PC Board";
-	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
+	compatible = "libretech,roc-rk3399-pc", "firefly,roc-rk3399-pc",
+		     "rockchip,rk3399";
 };
-- 
2.18.0.321.gffc6fa0e3

