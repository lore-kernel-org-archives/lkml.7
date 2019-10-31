Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF44CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462532086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZHC0k1GY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfJaKJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:09:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36987 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfJaKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:09:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so5551161wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FgmJFc69aJGBfN43Lu4UDpX3eu2jhzY+mRsGnXR2dN8=;
        b=ZHC0k1GYUbegvQPvHD4Xf19RSbmdOsmEtTOavJGxcZ+j5rqNyIcxQBxfljefzbXnN+
         1Xzx6DkNI7/ZL5N3l58JRsc/uvaGc16UeZxniGRD40zpEC6amGSI60kL5ZuAKuHRau0N
         SB2akz6Cb0d4UcZSsyfiRxS+E4JgcAdWmNCVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FgmJFc69aJGBfN43Lu4UDpX3eu2jhzY+mRsGnXR2dN8=;
        b=ErjcrYWKPcfWjSHwY5M3QfMDxufjO3YSKxXHlGGPF4DAOg//julnrnYs5a3jUl5T7j
         BRvuQG6Pfn+Xb2v7Ct+2hI2tEkUfoiWpi7jWRO6X+gp6P6TD+kxGOKv/d9aAuK0NWWVX
         KB7C5oWbQUZQsgmv4oJII042u51Ym0GW8IqjajbpG55rzVll7khGD0b0KPCMS3h4s+YX
         rIll1AHRluWOy/Ja1oBt3FGfzRA0Yboi1TZi4Mcwl9E2drDEaz/bF393XVjwZRHpHV7i
         q6CRb8znR1RTlWEObfiLy1yahHHFK2rWQONdiE3ixKjhIMQE5jDvgR7Ka2iuAVKnWUwt
         D7Kg==
X-Gm-Message-State: APjAAAUCQxpx9SRdO+cZYQSLsf8/BjtGZKByKQUxxQZsCmZjiJK0InGB
        h1dgivBKWFfQxH9MecVWZwdIJw==
X-Google-Smtp-Source: APXvYqzn2VJmEXK7aYh4V+/yj10YOCdzf2dq2vOBaRTSRlfhZymHmmM6N7YE5R47IJV6pLoo05VoZA==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr4795882wru.54.1572516548159;
        Thu, 31 Oct 2019 03:09:08 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w8sm3719609wrr.44.2019.10.31.03.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 03:09:07 -0700 (PDT)
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
Subject: [PATCH net-next V5 3/3] bnxt_en: Add support to collect crash dump via ethtool
Date:   Thu, 31 Oct 2019 15:38:52 +0530
Message-Id: <1572516532-5977-4-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572516532-5977-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1572516532-5977-1-git-send-email-sheetal.tigadoli@broadcom.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 37 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  2 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 09437150f818..3e7d1fb1b0b1 100644
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
index 51c140476717..f2220b826d61 100644
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
@@ -3446,6 +3478,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.set_phys_id		= bnxt_set_phys_id,
 	.self_test		= bnxt_self_test,
 	.reset			= bnxt_reset,
+	.set_dump		= bnxt_set_dump,
 	.get_dump_flag		= bnxt_get_dump_flag,
 	.get_dump_data		= bnxt_get_dump_data,
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
index b5b65b3f8534..01de7e79d14f 100644
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
2.17.1

