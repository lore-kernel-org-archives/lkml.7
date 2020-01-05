Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9753C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB8B206E6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB1EOi43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgAETuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 14:50:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38675 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgAETuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:50:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so47454458wrh.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 11:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iij3qjxWkQG+3uOoAuJWUOMDKz1pzUhkPrQmnHM7jWE=;
        b=TB1EOi43+oLzttIYXmzTrmW2QNAvo/lt+JbCbNg1yYzODu/WAGIN8+0Lk/SGfEyzD5
         ZzW59GMyZYoJSknuGE6thHCY1Qp1BBpQsbjAh2WcNNtBcaftxvb9E6kxOvagz/c8lJHK
         W4JmnYF2B2EsAFI6JjrjF+VIhXLXfil1IYyuXgs63lYLNOBNu2DNs/Yu0eQwLJiEBVO4
         gRX7BWesWgPpsduvZc9i6TZykShpgIm1iB6R8p7BT4RogrjOpsZq6s6JZQn73Fvzz0nl
         fnsxp2/ABLW4UTl9DJsEqahmw24MeIbdiUQlM1G8IPfiNudpbPfTdvFHydCm5ek4AmTi
         gW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iij3qjxWkQG+3uOoAuJWUOMDKz1pzUhkPrQmnHM7jWE=;
        b=oCuVhI8veTOQYBq1Ef5bs3mxwY080c8KGQAUHXUwG+utaOrGnJKR9qWLva3csuB3hQ
         IUHPKeaO5P7ArLbl8nx3epY1rjPWLeZucQ8pMor+oH+UKeFIY7+CedWn3hTL5k/wyn37
         pPlOiun9833hdGAMl0bc6RElpOs7/2M8QGOv22z+LLdLsHo2FBTVlvUmHvcU6axDIQKo
         fYUihTpyF4VWMlM6gRFjW4JWrTEI5tJZ7GcLkNppmkJT2a1l67i9KSFMLDYF64/48RZk
         Yp9KZtrXoloM1tl28Nk+JfnhAOS3QP5i+sWjMf0WaQoykK2Lz3BdJ+yipm5AstkDEP7+
         ckEw==
X-Gm-Message-State: APjAAAV/FIgncnE57XHnef2UntksTYTmNXvVZVa57K/vJ124lP6V9r5F
        AL6wk40xzMxzLIeZQ4HtlYMN7HJuB1I=
X-Google-Smtp-Source: APXvYqx/LBmFIx3aKR6e+BIKFe0NmngTQ+O2YW74Hev1r14oqUV5TL5+5GmXsLpNPUdbf+XlHZZqjg==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr102874539wro.216.1578253806638;
        Sun, 05 Jan 2020 11:50:06 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-140-065.002.204.pools.vodafone-ip.de. [2.204.140.65])
        by smtp.gmail.com with ESMTPSA id s3sm20549653wmh.25.2020.01.05.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 11:50:06 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove else after return
Date:   Sun,  5 Jan 2020 20:49:35 +0100
Message-Id: <20200105194936.5477-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove else after return in rtl88eu_dm_antenna_diversity() to improve
readability and clear a checkpatch warning.

WARNING: else is not generally useful after a break or return

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 26 +++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index 251bd8aba3b1..7bfba7692ab8 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -303,6 +303,7 @@ void rtl88eu_dm_antenna_diversity(struct odm_dm_struct *dm_odm)
 
 	if (!(dm_odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
+
 	if (!dm_odm->bLinked) {
 		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
 			     ("ODM_AntennaDiversity_88E(): No Link.\n"));
@@ -318,19 +319,20 @@ void rtl88eu_dm_antenna_diversity(struct odm_dm_struct *dm_odm)
 			dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
 		}
 		return;
-	} else {
-		if (!dm_fat_tbl->bBecomeLinked) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-				     ("Need to Turn on HW AntDiv\n"));
-			phy_set_bb_reg(adapter, ODM_REG_IGI_A_11N, BIT(7), 1);
-			phy_set_bb_reg(adapter, ODM_REG_CCK_ANTDIV_PARA1_11N,
-				       BIT(15), 1);
-			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
-				phy_set_bb_reg(adapter, ODM_REG_TX_ANT_CTRL_11N,
-					       BIT(21), 1);
-			dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
-		}
 	}
+
+	if (!dm_fat_tbl->bBecomeLinked) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+			     ("Need to Turn on HW AntDiv\n"));
+		phy_set_bb_reg(adapter, ODM_REG_IGI_A_11N, BIT(7), 1);
+		phy_set_bb_reg(adapter, ODM_REG_CCK_ANTDIV_PARA1_11N,
+			       BIT(15), 1);
+		if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
+			phy_set_bb_reg(adapter, ODM_REG_TX_ANT_CTRL_11N,
+				       BIT(21), 1);
+		dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
+	}
+
 	if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ||
 	    (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV))
 		rtl88eu_dm_hw_ant_div(dm_odm);
-- 
2.24.1

