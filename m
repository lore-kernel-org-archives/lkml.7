Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EEBFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79E62067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy6idP8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393624AbfJPNZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:25:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38383 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbfJPNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:25:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id y18so18616335wrn.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LRLu4A11zfU8KGwAdVgqHkptRBqIj1bDJ9MbP4ApwzY=;
        b=Hy6idP8WsiZczQOU+0DFljKnF+Ij3Pr2psfHjQ3L5wewdp0jkSE9aR1Vl1efQkol06
         ibzmUxUdZqbbUTbUuxoPzokqm335wzwiL2MRKgLmeicDKfmn4tbwrh7sDcs1a7PsOHPw
         T8sd5Q0V79Ncd2PKLPGvWNvmIGahl0ZJ6iCtw0564QBFDiW25NE5fxVefa/FnvbqfRGy
         Cw/lWRfkso3SyPYyChHUHQlcezNXvdjE+qkDgWWCa5/aUdDgMo+pP5h+zNBg+RYY5NI3
         7vaEBnpZzZkjrWC8yMauxU6kNN9/ksEnJX776D230eSvNo2lBue9dKi+563g5GnrlVF9
         LrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LRLu4A11zfU8KGwAdVgqHkptRBqIj1bDJ9MbP4ApwzY=;
        b=nPfxdzCdGcW46/dCBwiAy0bkxRoca5lqPvY4X+V7x395E/j/Gq2M205JjmCK9W0Jbd
         GziLFc7XNjm9y48ANpEXkB5HrbnqPmLvSSiDPeBmbHuEtdv0tELQcicTGWFe7n5hSXNI
         WPiPa524hjO/4aLQ7GB0HO6kXczVhkofp5W9LiRlY8r4zNjtdsXtw7NgRAnKP9vceWCu
         3UMM1k35ztfZJkKhQkC1GCuFIA5bIPnbJDL5gEr+olVrcKjLQcXUgWnkV57c//QWYDfo
         fpB9KDVyzNU8dDMbYb6zXDwMhOcf/GjWj754Bh+Mn/Ww7KkPBOfR3WIy7U/gcw6QxlTh
         bGLg==
X-Gm-Message-State: APjAAAXA+Dbp+bN4tpC5SGrsTEHsU3w3ECRyeRcEiOp4bIrybZOEp5YL
        xrCKlXl68y6Wo6YycdulP7PVQTmMVnY=
X-Google-Smtp-Source: APXvYqwAYuCb8pRWzypFXpMxx1FDAzOK+Bt1JVowOlSG7Wpg0WsXtJXtXVp/rZQ68DJwGlYOV9oYBA==
X-Received: by 2002:a05:6000:1621:: with SMTP id v1mr2910776wrb.62.1571232341235;
        Wed, 16 Oct 2019 06:25:41 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id y3sm8676071wmg.2.2019.10.16.06.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:25:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: expose card name in INFO IOCTL
Date:   Wed, 16 Oct 2019 16:25:38 +0300
Message-Id: <20191016132538.20746-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable userspace processes, e.g. management utilities, to display the
card name to the user, add the card name property to the HW_IP
structure that is copied to the user in the INFO IOCTL.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c        | 3 +++
 drivers/misc/habanalabs/habanalabs_ioctl.c | 9 +++++++--
 include/uapi/misc/habanalabs.h             | 2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e8812154343f..d3ee9e2aa57e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -396,6 +396,9 @@ void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
 	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
+
+	strncpy(prop->armcp_info.card_name, GOYA_DEFAULT_CARD_NAME,
+		CARD_NAME_MAX_LEN);
 }
 
 /*
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index cd4b5a9ceac1..02d7491fa28f 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -63,8 +63,13 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	if (hw_ip.dram_size > 0)
 		hw_ip.dram_enabled = 1;
 	hw_ip.num_of_events = prop->num_of_events;
-	memcpy(hw_ip.armcp_version,
-		prop->armcp_info.armcp_version, VERSION_MAX_LEN);
+
+	memcpy(hw_ip.armcp_version, prop->armcp_info.armcp_version,
+		min(VERSION_MAX_LEN, HL_INFO_VERSION_MAX_LEN));
+
+	memcpy(hw_ip.card_name, prop->armcp_info.card_name,
+		min(CARD_NAME_MAX_LEN, HL_INFO_CARD_NAME_MAX_LEN));
+
 	hw_ip.armcp_cpld_version = le32_to_cpu(prop->armcp_info.cpld_version);
 	hw_ip.psoc_pci_pll_nr = prop->psoc_pci_pll_nr;
 	hw_ip.psoc_pci_pll_nf = prop->psoc_pci_pll_nf;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 783793c8be1c..e387d9e560b3 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -109,6 +109,7 @@ enum hl_device_status {
 #define HL_INFO_CLK_RATE		8
 
 #define HL_INFO_VERSION_MAX_LEN	128
+#define HL_INFO_CARD_NAME_MAX_LEN	16
 
 struct hl_info_hw_ip_info {
 	__u64 sram_base_address;
@@ -127,6 +128,7 @@ struct hl_info_hw_ip_info {
 	__u8 dram_enabled;
 	__u8 pad[2];
 	__u8 armcp_version[HL_INFO_VERSION_MAX_LEN];
+	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
 };
 
 struct hl_info_dram_usage {
-- 
2.17.1

