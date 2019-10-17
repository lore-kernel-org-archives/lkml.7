Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D660FFA3736
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FB120854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tqlujk3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502293AbfJQMCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:02:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34572 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502254AbfJQMBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:01:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so6874563wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tX0Ftqak4R2nBwIJhEYcSRn89ISdRNtAIBGqgcMm9qk=;
        b=Tqlujk3TKIxQUIZQEQPDYzgjH8DnuJg3YtB6UepNiVhCWYfT2x3WcBMnc6H5n8TD2f
         VyK+xUK6v3ztl59U8d0b2lFLI2UeeQRpkwyEXkNzdDm/mbIb0iazCm5nKausHG8SodMO
         85pRPNh3gBWT5kJvYkXRV6U+iyQcO3R806HV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tX0Ftqak4R2nBwIJhEYcSRn89ISdRNtAIBGqgcMm9qk=;
        b=MHT3HLDoyAfUM0n4RIdgwaWQkqPthpC60kw5TfYZFmCDGgB8oTPrff0l4Xje1TpEpT
         bFv1s34HALNfHYJhe1inbl7LRc/XgPzoWhQCOKmHq/YXEahLLD0LZn85sl2+eyaPIn73
         x757PNuPzoJm7VtFWzB0dWWsILEBXi8nv8lgR3BFvKAZN95SwJqHUuRp4Hnv4pQsW4Cj
         WEdYTZxW6KQQQIevJdHhv5iBRXtRVUws30XZMZec3H3K6cOY2a4TD3NHLTR/gHFpoNF+
         JZi7v0FnFRNWsv73lilqxw/h1E9xmbtR/AsZPnghH5CaqERlAVJwZ2ZoF/IIU8LfkyuY
         p0gw==
X-Gm-Message-State: APjAAAXhTsYFIqo+Dvg8vbTeL1wsKVNc3xMqpBxS5JkEIdnCH4d+Xv4Z
        pKAp41o9m+dsECs6XEyefUTYmw==
X-Google-Smtp-Source: APXvYqxHJGWsW5gK/1BlwQml0teEZNX2wvdoEc1ob5b9+4KfNI39J6WVOq52SMPMq0qJpm1Tl6uQNg==
X-Received: by 2002:a05:600c:2481:: with SMTP id 1mr2454420wms.98.1571313707563;
        Thu, 17 Oct 2019 05:01:47 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y1sm2317949wrw.6.2019.10.17.05.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 05:01:45 -0700 (PDT)
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
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 3/3] bnxt_en: Add support to collect crash dump via ethtool
Date:   Thu, 17 Oct 2019 17:31:22 +0530
Message-Id: <1571313682-28900-4-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571313682-28900-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1571313682-28900-1-git-send-email-sheetal.tigadoli@broadcom.com>
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

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 36 +++++++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  2 ++
 3 files changed, 39 insertions(+), 2 deletions(-)

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
index 51c1404..1596221 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3311,6 +3311,23 @@ static int bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
 	return rc;
 }
 
+static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+#ifndef CONFIG_TEE_BNXT_FW
+	return -EOPNOTSUPP;
+#endif
+
+	if (dump->flag > BNXT_DUMP_CRASH) {
+		netdev_err(dev, "Supports only Live(0) and Crash(1) dumps.\n");
+		return -EINVAL;
+	}
+
+	bp->dump_flag = dump->flag;
+	return 0;
+}
+
 static int bnxt_get_dump_flag(struct net_device *dev, struct ethtool_dump *dump)
 {
 	struct bnxt *bp = netdev_priv(dev);
@@ -3323,7 +3340,12 @@ static int bnxt_get_dump_flag(struct net_device *dev, struct ethtool_dump *dump)
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
@@ -3336,7 +3358,16 @@ static int bnxt_get_dump_data(struct net_device *dev, struct ethtool_dump *dump,
 
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
@@ -3446,6 +3477,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
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

