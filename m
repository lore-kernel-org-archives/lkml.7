Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DF3C32756
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A99217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs2P4uNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfHJMjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:39:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52262 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfHJMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:39:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so8175000wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bsEgVRLilZpMJmDk8tN/d8V/M/8ytsFn3fTDRc8CIjQ=;
        b=Hs2P4uNvl1t1qLYfgjzzZxrO4DM7XamFPKdzwJTPpKHX2D54Q57TdBSiRCwC3aZvD0
         2GgKdORuyS268rUuZsFdjuKA2085CySDmrBPDIBRKSEZwd2bGePidllc8pGWbHBEBAt2
         JClCtEoMvNNwg+s2Gs3L4b+LHO50nDfsKYPOGv/7I5/2ZmAyZFxnCUyMxybTqTdR8ukM
         9khBg97yqLhVGjsqtoSdhorxCKOMx7dSY2JdDlxEe55c9Q2uG8V6iiz899NIDOUlrJq+
         McplTpY+Rax/GfoPcvln0ZeEVDanWx8JqtM15MftdJCjuVDfgxiIg42KNwCAAInllist
         EXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bsEgVRLilZpMJmDk8tN/d8V/M/8ytsFn3fTDRc8CIjQ=;
        b=jnkjnxasoPXJldmV+Sg7a0JOWW5N0kGKLuR30HuPaE7rnZlQO7XBe3FRRtMILEnSLe
         9HHi1Nl/tBadf3/6IjW11UM4R04VeYWnGSrZyDg3sMfF9gEQqEL/E9Shqz4+g6sMHy67
         k/1gf8cxgwFH5e24z01HnJQ0N+ZP5tIB4cX1SjEN8klaO6mVmle0CKFVhwjB7W1U1YwN
         kdmICybxyYzh/Nj8VxQpTA5WzexOOKa5wrzJ4IRwrxgV/FrGZCbI4nlHcvCuK9+x8JD3
         hfpYDFGfi6mfctlZIwxvhNggTAS6PmLIxDTg/qYNdaK33I3118YK1LCJ3NfKZOVb+x/f
         m6Xg==
X-Gm-Message-State: APjAAAWEQ6rDei/5uUqCTxLtwSOWMYv4BV9nnwVg1TkvViwyJDKq9YQY
        U/W1CfqNKZ5eznCHidXRb3ZMKbftjpc=
X-Google-Smtp-Source: APXvYqwvYfURTs4GCWOhlw7ti4y0DdxxM0xRgMcNVoEsGtXxzhoUJSyhpUbJh8fZRTxA1KHYGK3rag==
X-Received: by 2002:a1c:6c14:: with SMTP id h20mr17504545wmc.168.1565440778996;
        Sat, 10 Aug 2019 05:39:38 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c1sm224106318wrh.1.2019.08.10.05.39.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 05:39:38 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, bpsegal20@gmail.com
Subject: [PATCH 2/2] habanalabs: replace __le32_to_cpu with le32_to_cpu
Date:   Sat, 10 Aug 2019 15:39:35 +0300
Message-Id: <20190810123935.14011-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810123935.14011-1-oded.gabbay@gmail.com>
References: <20190810123935.14011-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some files the driver uses __le32_to_cpu while in other it uses
le32_to_cpu. Replace all __le32_to_cpu instances with le32_to_cpu for
consistency.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c | 2 +-
 drivers/misc/habanalabs/hw_queue.c         | 2 +-
 drivers/misc/habanalabs/hwmon.c            | 6 +++---
 drivers/misc/habanalabs/irq.c              | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 589324ac19d0..d894873ca2d1 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -65,7 +65,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.num_of_events = prop->num_of_events;
 	memcpy(hw_ip.armcp_version,
 		prop->armcp_info.armcp_version, VERSION_MAX_LEN);
-	hw_ip.armcp_cpld_version = __le32_to_cpu(prop->armcp_info.cpld_version);
+	hw_ip.armcp_cpld_version = le32_to_cpu(prop->armcp_info.cpld_version);
 	hw_ip.psoc_pci_pll_nr = prop->psoc_pci_pll_nr;
 	hw_ip.psoc_pci_pll_nf = prop->psoc_pci_pll_nf;
 	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 509c6cb14d71..f6766f1de623 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -267,7 +267,7 @@ static void ext_hw_queue_schedule_job(struct hl_cs_job *job)
 
 	hdev->asic_funcs->add_end_of_cb_packets(hdev, cb->kernel_address, len,
 						cq_addr,
-						__le32_to_cpu(cq_pkt.data),
+						le32_to_cpu(cq_pkt.data),
 						q->hw_queue_id);
 
 	q->shadow_queue[hl_pi_2_offset(q->pi)] = job;
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index a4319c6fabe6..6c60b901e375 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -26,7 +26,7 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 	int rc, i, j;
 
 	for (i = 0 ; i < ARMCP_MAX_SENSORS ; i++) {
-		type = __le32_to_cpu(sensors_arr[i].type);
+		type = le32_to_cpu(sensors_arr[i].type);
 
 		if ((type == 0) && (sensors_arr[i].flags == 0))
 			break;
@@ -58,10 +58,10 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 	}
 
 	for (i = 0 ; i < arr_size ; i++) {
-		type = __le32_to_cpu(sensors_arr[i].type);
+		type = le32_to_cpu(sensors_arr[i].type);
 		curr_arr = sensors_by_type[type];
 		curr_arr[sensors_by_type_next_index[type]++] =
-				__le32_to_cpu(sensors_arr[i].flags);
+				le32_to_cpu(sensors_arr[i].flags);
 	}
 
 	channels_info = kcalloc(num_active_sensor_types + 1,
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index 2c3dbfdf2722..cbca36896f3d 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -161,7 +161,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 
 	while (1) {
 		bool entry_ready =
-			((__le32_to_cpu(eq_base[eq->ci].hdr.ctl) &
+			((le32_to_cpu(eq_base[eq->ci].hdr.ctl) &
 				EQ_CTL_READY_MASK) >> EQ_CTL_READY_SHIFT);
 
 		if (!entry_ready)
@@ -195,7 +195,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 skip_irq:
 		/* Clear EQ entry ready bit */
 		eq_entry->hdr.ctl =
-			cpu_to_le32(__le32_to_cpu(eq_entry->hdr.ctl) &
+			cpu_to_le32(le32_to_cpu(eq_entry->hdr.ctl) &
 							~EQ_CTL_READY_MASK);
 
 		eq->ci = hl_eq_inc_ptr(eq->ci);
-- 
2.17.1

