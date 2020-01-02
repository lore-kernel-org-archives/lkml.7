Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E5C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF61222525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V9mfQO+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgABPvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:51:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42612 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgABPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:51:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so17955776plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l8GiNbTzB0gxgqSfCeGUqR2N+xB9TfANszBuH6xbhVk=;
        b=V9mfQO+lvFeoyC1d29u4/iGjL9H5Kx7299Phh07rMp8378POUNc83NRtQwgB6UuNE4
         wtTjq8Hj7hmFN0IAZhc0+Q6SA1+BGLFrNK/ItlzwXNL+LTB4iFpQ4ntD8lbhXlaz1Y+T
         AvUAqBz/N/bI0m2byK+NEugJ5lI+wCFqTmQjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l8GiNbTzB0gxgqSfCeGUqR2N+xB9TfANszBuH6xbhVk=;
        b=k/ksdsHU0eozwg95CFtX/zsX3cahm5cqVpoTWQtY6FYij7syiD+OHU58GAF8o8OKwo
         8AX9+PB4L9hZfIvshTNbhokNCuY+KS7Zh3NCWR94Vumb7ippIing6iLuOyoIArR8wobN
         mw1R0NCW2DamjujI6YuZj9EByUBGGlHP+PNJl74xHyCt1sB24bcYF/iw9Xh+SvwN0Gky
         RxaAkxAgdTysjh1qW8clP0SMh3Ze7aOG+7iYv0ao69a3QLgNZMnS2fvoV0M1bPKUzpJt
         VwUisl4X+AXsB9DcrrM5YzpdTDtxtFvgRwwamPGuPLwq8HBqvE+RDMs7fTLUVFMcCcrl
         XYww==
X-Gm-Message-State: APjAAAWDofGo3JpPS6wrSk8Cm4qlaLABPfRZKk1KXg9zwCy3pMGFa80x
        9UaXeVGYgV2PK248+TTXhrlakw==
X-Google-Smtp-Source: APXvYqw1oN4gWnsrwdlNQQB/kqEr/Ia2EGgZDAwGDeuYjFRcd01TGnYijs/cVowvM9nEGABw5DYJlw==
X-Received: by 2002:a17:902:b10d:: with SMTP id q13mr77923301plr.14.1577980280225;
        Thu, 02 Jan 2020 07:51:20 -0800 (PST)
Received: from Ninja.ibn.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2sm11499420pjv.18.2020.01.02.07.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 07:51:19 -0800 (PST)
From:   Vikas Gupta <vikas.gupta@broadcom.com>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vasundhara-v.volam@broadcom.com, vikram.prakash@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH v1 3/3] bnxt_en: Call recovery done after reset is successfully done
Date:   Thu,  2 Jan 2020 21:18:11 +0530
Message-Id: <1577980091-25118-4-git-send-email-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577980091-25118-1-git-send-email-vikas.gupta@broadcom.com>
References: <1577980091-25118-1-git-send-email-vikas.gupta@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return EINPROGRESS to devlink health reporter recover as we are not yet
done and call devlink_health_reporter_recovery_done once reset is
successfully completed from workqueue context.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 14 ++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b0fe19..39d4309 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10822,6 +10822,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		smp_mb__before_atomic();
 		clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 		bnxt_ulp_start(bp, rc);
+		bnxt_dl_health_recovery_done(bp);
 		bnxt_dl_health_status_update(bp, true);
 		rtnl_unlock();
 		break;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 3eedd44..0c3d224 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -89,7 +89,7 @@ static int bnxt_fw_reset_recover(struct devlink_health_reporter *reporter,
 		return -EOPNOTSUPP;
 
 	bnxt_fw_reset(bp);
-	return 0;
+	return -EINPROGRESS;
 }
 
 static const
@@ -116,7 +116,7 @@ static int bnxt_fw_fatal_recover(struct devlink_health_reporter *reporter,
 	else if (event == BNXT_FW_EXCEPTION_SP_EVENT)
 		bnxt_fw_exception(bp);
 
-	return 0;
+	return -EINPROGRESS;
 }
 
 static const
@@ -262,6 +262,16 @@ void bnxt_dl_health_status_update(struct bnxt *bp, bool healthy)
 	health->fatal = false;
 }
 
+void bnxt_dl_health_recovery_done(struct bnxt *bp)
+{
+	struct bnxt_fw_health *hlth = bp->fw_health;
+
+	if (hlth->fatal)
+		devlink_health_reporter_recovery_done(hlth->fw_fatal_reporter);
+	else
+		devlink_health_reporter_recovery_done(hlth->fw_reset_reporter);
+}
+
 static const struct devlink_ops bnxt_dl_ops = {
 #ifdef CONFIG_BNXT_SRIOV
 	.eswitch_mode_set = bnxt_dl_eswitch_mode_set,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
index 6db6c3d..08aaa44 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
@@ -58,6 +58,7 @@ struct bnxt_dl_nvm_param {
 
 void bnxt_devlink_health_report(struct bnxt *bp, unsigned long event);
 void bnxt_dl_health_status_update(struct bnxt *bp, bool healthy);
+void bnxt_dl_health_recovery_done(struct bnxt *bp);
 void bnxt_dl_fw_reporters_create(struct bnxt *bp);
 void bnxt_dl_fw_reporters_destroy(struct bnxt *bp, bool all);
 int bnxt_dl_register(struct bnxt *bp);
-- 
2.7.4

