Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B4C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B6A217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d76qSptb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfEIVOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44663 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfEIVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so1824294pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QabCw1HIkztYdYez4gT+jeQCWJg/9Fy/MseoqvwA5w=;
        b=d76qSptbPyEpZ/SiDgxkYt/Z8s1G7N6Lifv3aHzOa89rU7G42rsPv77OqJJ9CPNpDH
         5vJDmJ130eppYZ68kdDVURNskJ9p/ySNEHCiwNFdTJbUdAIpkFyezS9EejW7RdmVcUbv
         APyJ+V3DaqTZwYMWaglFs6t3jjFhpajfoXebw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QabCw1HIkztYdYez4gT+jeQCWJg/9Fy/MseoqvwA5w=;
        b=c0iefcq95tXsvf1tsmJ3ZEbjsEzpElTK8g0mkSB8VkbHItga2/e+0nGgB5l+7f7Txf
         v7wr05042r2wEkcamrsGZw4264otM8IrMILurFXNf+1Ea15IiZWSbvowCuilWepeYCnQ
         X05jPv06VRMIzoN5+GgfK1r3r+RNodsFWeuoR5tq/5JOPiWSu+F69piCKtcY2DMm0zK3
         EfrjDFpM4Dnzpc2smRjDBiNGeV0xQbKwbFWN2TD7pxvkA98PTEJKpNqn8QiwWo8UAytU
         64SWaemb/jVPxIzer9eko+PHMZ6Ph9bJ+gqTHSt9yjAqbwaHez0Hfyt3zRAK9N7FlI05
         NwCQ==
X-Gm-Message-State: APjAAAXc6GNRUd/NFG1NPhksZ81/TLZP7TWKfkJy+QLeUU6/2mIVZTTr
        8WgLqd9V2rvFz0Ib001FAMgbbA==
X-Google-Smtp-Source: APXvYqzZtLGUzqv0mQx+N5pyoUMEaNksuYUR3NfF4xLggGy8/ThtNc9Tu/K5gunI7JBCe3pbA389vQ==
X-Received: by 2002:a63:682:: with SMTP id 124mr8810308pgg.243.1557436484408;
        Thu, 09 May 2019 14:14:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j35sm3461511pgj.60.2019.05.09.14.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:43 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 27/30] mfd: cros_ec: Add API for rwsig
Date:   Thu,  9 May 2019 14:13:50 -0700
Message-Id: <20190509211353.213194-28-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command to retrieve signature of image stored in the RW memory
slot(s).

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 4a9ac3861bdd..3d3a37b11002 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5043,6 +5043,32 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/* Run RW signature verification and get status */
+#define EC_CMD_RWSIG_CHECK_STATUS	0x011C
+
+struct ec_response_rwsig_check_status {
+	uint32_t status;
+} __ec_align4;
+
+/* For controlling RWSIG task */
+#define EC_CMD_RWSIG_ACTION	0x011D
+
+enum rwsig_action {
+	RWSIG_ACTION_ABORT = 0,		/* Abort RWSIG and prevent jumping */
+	RWSIG_ACTION_CONTINUE = 1,	/* Jump to RW immediately */
+};
+
+struct ec_params_rwsig_action {
+	uint32_t action;
+} __ec_align4;
+
+/* Run verification on a slot */
+#define EC_CMD_EFS_VERIFY	0x011E
+
+struct ec_params_efs_verify {
+	uint8_t region;		/* enum ec_flash_region */
+} __ec_align1;
+
 /*****************************************************************************/
 /* Fingerprint MCU commands: range 0x0400-0x040x */
 
-- 
2.21.0.1020.gf2820cf01a-goog

