Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3BACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052BE21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="acbquuhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408430AbfJXFc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:32:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45737 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406900AbfJXFcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:32:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so13503746pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v582loW3B/j4+z4/0GJKiDOR1iezQv3feI66heKTvmA=;
        b=acbquuhTwK4hsVu3UE333LaUzRRqCo60tooGxnY1Qqn5udkGsz6KfSWZvroWEdBK9q
         YGs8AKB3VmTy99uVNemksfEmsZHuFTLFAH5TtuM+OECnQi+qbt7KwD1VQj1IupG/hmZO
         Ro6vQ3rf+KwJBOG4DfdJ0kE9y9L1qLrkkT+4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v582loW3B/j4+z4/0GJKiDOR1iezQv3feI66heKTvmA=;
        b=QsPi3z7+JvW0S3PIYYDMLOKrHcpAiQO2yYsEaN4SV/8ZXpHVBpYXAXn7DKkHF6mRKL
         glZWr2eAayGgkPZEq/zXPli4egQs/Q57Oyya9BUB7lIzopHyrLImhjflOTYzBFuxT5BV
         lTC1CfqkcXb0kCkVWVgL53X9PwUVLrrsWRwMw4A9aw2goLLo1pHQjLccxrYUuOvnvNjU
         txryQgU7yS3B/h7KIh14RWHNA86EkVwJZQSs7//+HHQYRIH0AGyrfa6P6PDjUEKTW3vS
         xb57bD67hcBBUjFVk3pOC8iLbwhAgQScxI4r+uIwC2S/Sb4FAJXZEOQJNacgF9ZBq7hd
         bBiA==
X-Gm-Message-State: APjAAAXY15/OrMKzN4CMnsdmxTHLbGB67FJnByNaQnmIR7997jl3Qexw
        mq24beUaogGZidPb5pbjbL09kA==
X-Google-Smtp-Source: APXvYqyvo7eaDGiYLvTwzC/o4GE/IZ2cxP/lEcaNZXT0C2iPQr0bUNsCdtYMydC6mmHB4phlLDApfw==
X-Received: by 2002:a63:4b54:: with SMTP id k20mr14689032pgl.70.1571895174760;
        Wed, 23 Oct 2019 22:32:54 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id e17sm29491331pfl.40.2019.10.23.22.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 22:32:53 -0700 (PDT)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V3 3/3] bnxt_en: Add support to collect crash dump via ethtool
Date:   Thu, 24 Oct 2019 11:02:41 +0530
Message-Id: <1571895161-26487-4-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571895161-26487-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1571895161-26487-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

Driver supports 2 types of core dumps.

1. Live dump - Firmware dump when system is up and running.
2. Crash dump - Dump which is collected during firmware crash
                that can be retrieved after recovery.
Crash dump is currently supported only on specific 58800 chips
which can be retrieved using OP-TEE API only, as firmware cannot
access this region directly.

User needs to set the dump flag using following command before
initiating the dump collection:

    $ ethtool -W|--set-dump eth0 N

Where N is "0" for live dump and "1" for crash dump

Command to collect the dump after setting the flag:

    $ ethtool -w eth0 data Filename

v3: Modify set_dump to support even when CONFIG_TEE_BNXT_FW=n.
Also change log message to netdev_info().

Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 37 +++++++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  2 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 0943715..3e7d1fb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1807,6 +1807,9 @@ struct bnxt {
 
 	u8			num_leds;
 	struct bnxt_led_info	leds[BNXT_MAX_LED];
+	u16			dump_flag;
+#define BNXT_DUMP_LIVE		0
+#define BNXT_DUMP_CRASH		1
 
 	struct bpf_prog		*xdp_prog;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 51c1404..f2220b8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3311,6 +3311,24 @@ static int bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
 	return rc;
 }
 
+static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+	if (dump->flag > BNXT_DUMP_CRASH) {
+		netdev_info(dev, "Supports only Live(0) and Crash(1) dumps.\n");
+		return -EINVAL;
+	}
+
+	if (!IS_ENABLED(CONFIG_TEE_BNXT_FW) && dump->flag == BNXT_DUMP_CRASH) {
+		netdev_info(dev, "Cannot collect crash dump as TEE_BNXT_FW config option is not enabled.\n");
+		return -EOPNOTSUPP;
+	}
+
+	bp->dump_flag = dump->flag;
+	return 0;
+}
+
 static int bnxt_get_dump_flag(struct net_device *dev, struct ethtool_dump *dump)
 {
 	struct bnxt *bp = netdev_priv(dev);
@@ -3323,7 +3341,12 @@ static int bnxt_get_dump_flag(struct net_device *dev, struct ethtool_dump *dump)
 			bp->ver_resp.hwrm_fw_bld_8b << 8 |
 			bp->ver_resp.hwrm_fw_rsvd_8b;
 
-	return bnxt_get_coredump(bp, NULL, &dump->len);
+	dump->flag = bp->dump_flag;
+	if (bp->dump_flag == BNXT_DUMP_CRASH)
+		dump->len = BNXT_CRASH_DUMP_LEN;
+	else
+		bnxt_get_coredump(bp, NULL, &dump->len);
+	return 0;
 }
 
 static int bnxt_get_dump_data(struct net_device *dev, struct ethtool_dump *dump,
@@ -3336,7 +3359,16 @@ static int bnxt_get_dump_data(struct net_device *dev, struct ethtool_dump *dump,
 
 	memset(buf, 0, dump->len);
 
-	return bnxt_get_coredump(bp, buf, &dump->len);
+	dump->flag = bp->dump_flag;
+	if (dump->flag == BNXT_DUMP_CRASH) {
+#ifdef CONFIG_TEE_BNXT_FW
+		return tee_bnxt_copy_coredump(buf, 0, dump->len);
+#endif
+	} else {
+		return bnxt_get_coredump(bp, buf, &dump->len);
+	}
+
+	return 0;
 }
 
 void bnxt_ethtool_init(struct bnxt *bp)
@@ -3446,6 +3478,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
 	.set_phys_id		= bnxt_set_phys_id,
 	.self_test		= bnxt_self_test,
 	.reset			= bnxt_reset,
+	.set_dump		= bnxt_set_dump,
 	.get_dump_flag		= bnxt_get_dump_flag,
 	.get_dump_data		= bnxt_get_dump_data,
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
index b5b65b3..01de7e7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
@@ -59,6 +59,8 @@ struct hwrm_dbg_cmn_output {
 	#define HWRM_DBG_CMN_FLAGS_MORE	1
 };
 
+#define BNXT_CRASH_DUMP_LEN	(8 << 20)
+
 #define BNXT_LED_DFLT_ENA				\
 	(PORT_LED_CFG_REQ_ENABLES_LED0_ID |		\
 	 PORT_LED_CFG_REQ_ENABLES_LED0_STATE |		\
-- 
1.9.1

