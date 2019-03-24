Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1204222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdBVv/xY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfCXMMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:12:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45631 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXMMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:12:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so3616709pfi.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yHuINi4sCN1IqPYdZ4saS31vDOVSP80fewe1X4iki/s=;
        b=vdBVv/xYt0WIBOille6OPDJMlSW16Rt10xhntoLZLpTcBzHchVBneMs21WxK/APw1L
         VXCWe+zyYqy0wCVwjY0yntzX0ikNimBZ3wysGV7/IYBChHUE+A3j4VzGEli/Bkz854NQ
         zo+jlDoQTkaouZVtHGKNlJinuv0QvXxU6JNiO1ZLXRE4AcFvw5epmLs4nQJrxuExJTkY
         Y+ymX8B3ISugocvMLAFZLvun/LGsjZAm3Zq9KY1rlVX5lTDdh7C9wybm/WfEuxOJiZvv
         DxMCmSpFG6Aqw5ihwl/xmaIYTUf+abG15yy4NV0K3cmxFm5yIXBrK0R68mQunISGPW2b
         gMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yHuINi4sCN1IqPYdZ4saS31vDOVSP80fewe1X4iki/s=;
        b=bxuJvtehjRAAYASldqe16VemnfHIynYbuGfegwrCGHD8oNywOhuQmxGC69dvV8OhaB
         CgTsCq+uvy9rDdrRY8GdsGt46W+OdoUCIfcfxpeaUL+r/4zZvBKjKVx27M5Gk8GuOP9v
         bqqI/J4roUToS8j2VlGNLL+7huWl+qNuCYKNAccnC2VCZnQaYpF2RJMoqGwJKzJYg22y
         tq48Ued8HYZsAxMmROgGVtvdfSE2xIUFFj1mL2KeRKpG2Qc1p6PM+9395oruvESLtjG1
         iKAMXxk1zajC8cXf0eZEhpnJR8n6SCT8h24ymRIlXptztZ68fJuuJznJ+ypAcppkavcH
         rS3A==
X-Gm-Message-State: APjAAAX1tw6qhTHpuaRyoX1wSNDAnjVT5MphqMUere1GdSk6Uv/Ho3G7
        nCMayfUUXLAbe+8O8PQ15RQ=
X-Google-Smtp-Source: APXvYqwsr2ntEVM+yeeL01P/4FMtGU5jfwMA93FsRmVavFTuwD7axz/d6EiUzkMcoJoxC0lWAs5vKQ==
X-Received: by 2002:aa7:938b:: with SMTP id t11mr11698607pfe.67.1553429535263;
        Sun, 24 Mar 2019 05:12:15 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id v2sm19366067pfg.118.2019.03.24.05.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 05:12:14 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:42:08 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, jfrederich@gmail.com, dsd@laptop.org,
        jon.nettleton@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] staging: olpc_dcon: Use WARN_ON instead of BUG_ON
Message-ID: <20190324121208.GA24213@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is with respect to a checkpatch.pl CHECK: "Avoid crashing the
kernel. Use WARN_ON instead of BUG_ON". But I maybe wrong here. Is a
kernel crash desired if olpc_board_at_least(olpc_board(0xc2)) fails,
will there be inconsistent results if execution continues?

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 6b714f7..900baab7 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -138,7 +138,7 @@ static int dcon_bus_stabilize(struct dcon_priv *dcon, int is_powered_down)
 	}
 	if (x < 0) {
 		pr_err("unable to stabilize dcon's smbus, reasserting power and praying.\n");
-		BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
+		WARN_ON(olpc_board_at_least(olpc_board(0xc2)));
 		pm = 0;
 		olpc_ec_cmd(EC_DCON_POWER_MODE, &pm, 1, NULL, 0);
 		msleep(100);
-- 
2.7.4

