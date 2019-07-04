Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB17EC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC21D2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsTkiQvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfGDPgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:36:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46673 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfGDPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:36:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id r4so5776528qkm.13;
        Thu, 04 Jul 2019 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdH/Nk62kEL52wkv2n3J5rEQY3EHxaipdQyu7HMvNx8=;
        b=dsTkiQvc5z3LvtqOIo/E5XpuO0y+r0xouyfc4SpEEyq4tyJdiSQqcQoF9tRJP6KWwr
         IU2ngTaeT8j/i+kavc8vDHHrZoES79xrjFV1Ejc4GogSJbWYqIeFnAWSstSlocbkO3c5
         kR/ejo3uA6H4jRafN7ocX/GyXDAdnuo9P7/jLYe9nG1Dz6DpxHRLKX44obELtWrzsBC0
         t4K6LZBKziKsxIhWa/G5GdCL9YhlV0xsYW5wxXr66TqYrnSpnVH6cyK7mAXLTR+aWmGc
         rbTGKQ0jNq9nNtKfPrvgR9IeKNrtbamOPWO6WG9g6QO7PHHZMeeTeMYZE/KfLAalKuH2
         nR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdH/Nk62kEL52wkv2n3J5rEQY3EHxaipdQyu7HMvNx8=;
        b=C7VDCVZ8Ex78HKhUyccZ8AxGl2lq3IDJTSD3yOlRicdzkMEoLb92FA9pFMkpKYgonU
         DGXH8b/oWb6OZqCCYIrnoQdlwdxSxrp8NfY7B3SyUBVSwT0/YpFe9s/GhN984Gduj+Qd
         0G5lBH3hRPMFx3JJ0XQ3fk7o3JMMp4lDC/AYEmfQIQj8Ez93upIpS1ZcOe8XjhVET240
         9GA7f12GphL18kl9XYGJeG3AfpAWc1QC5o5Evg/3e60M8SBrMXENb923canXF2zPO8PF
         QydrRypVZDyHEviSoy338Q5UYWGIuqZnNvX5R80BWW6i1X5KJuPAtYGzCSR0n6Gvt8nt
         zZDA==
X-Gm-Message-State: APjAAAVNwQqPyiVlmx01sExRgG69p/u3Xk8pnfJTFSBhUkuJT/NYnfZV
        dVt9oHww4HlXjk1cwYx8qeM=
X-Google-Smtp-Source: APXvYqyYASVKOYHGKKBv6jxb2GRtOf6mOpXCxU8NUE8PWj/FbACFF9T8Tlo+NO4O7kexdICzfrLFSQ==
X-Received: by 2002:a37:62cd:: with SMTP id w196mr1832076qkb.373.1562254571536;
        Thu, 04 Jul 2019 08:36:11 -0700 (PDT)
Received: from localhost.localdomain (pool-72-93-241-64.bstnma.fios.verizon.net. [72.93.241.64])
        by smtp.gmail.com with ESMTPSA id 67sm2087140qkh.108.2019.07.04.08.36.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 08:36:11 -0700 (PDT)
From:   Ryan Kennedy <ryan5544@gmail.com>
To:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Kennedy <ryan5544@gmail.com>
Subject: [PATCH 1/2] usb: pci-quirks: Correct AMD PLL quirk detection
Date:   Thu,  4 Jul 2019 11:35:28 -0400
Message-Id: <20190704153529.9429-2-ryan5544@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704153529.9429-1-ryan5544@gmail.com>
References: <20190704153529.9429-1-ryan5544@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD PLL USB quirk is incorrectly enabled on newer Ryzen
chipsets. The logic in usb_amd_find_chipset_info currently checks
for unaffected chipsets rather than affected ones. This broke
once a new chipset was added in e788787ef. It makes more sense
to reverse the logic so it won't need to be updated as new
chipsets are added. Note that the core of the workaround in
usb_amd_quirk_pll does correctly check the chipset.

Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
---
 drivers/usb/host/pci-quirks.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 3ce71cbfbb58..ad05c27b3a7b 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -205,7 +205,7 @@ int usb_amd_find_chipset_info(void)
 {
 	unsigned long flags;
 	struct amd_chipset_info info;
-	int ret;
+	int need_pll_quirk = 0;
 
 	spin_lock_irqsave(&amd_lock, flags);
 
@@ -219,21 +219,28 @@ int usb_amd_find_chipset_info(void)
 	spin_unlock_irqrestore(&amd_lock, flags);
 
 	if (!amd_chipset_sb_type_init(&info)) {
-		ret = 0;
 		goto commit;
 	}
 
-	/* Below chipset generations needn't enable AMD PLL quirk */
-	if (info.sb_type.gen == AMD_CHIPSET_UNKNOWN ||
-			info.sb_type.gen == AMD_CHIPSET_SB600 ||
-			info.sb_type.gen == AMD_CHIPSET_YANGTZE ||
-			(info.sb_type.gen == AMD_CHIPSET_SB700 &&
-			info.sb_type.rev > 0x3b)) {
+	switch (info.sb_type.gen) {
+	case AMD_CHIPSET_SB700:
+		need_pll_quirk = info.sb_type.rev <= 0x3B;
+		break;
+	case AMD_CHIPSET_SB800:
+	case AMD_CHIPSET_HUDSON2:
+	case AMD_CHIPSET_BOLTON:
+		need_pll_quirk = 1;
+		break;
+	default:
+		need_pll_quirk = 0;
+		break;
+	}
+
+	if (!need_pll_quirk) {
 		if (info.smbus_dev) {
 			pci_dev_put(info.smbus_dev);
 			info.smbus_dev = NULL;
 		}
-		ret = 0;
 		goto commit;
 	}
 
@@ -252,7 +259,7 @@ int usb_amd_find_chipset_info(void)
 		}
 	}
 
-	ret = info.probe_result = 1;
+	need_pll_quirk = info.probe_result = 1;
 	printk(KERN_DEBUG "QUIRK: Enable AMD PLL fix\n");
 
 commit:
@@ -263,7 +270,7 @@ int usb_amd_find_chipset_info(void)
 
 		/* Mark that we where here */
 		amd_chipset.probe_count++;
-		ret = amd_chipset.probe_result;
+		need_pll_quirk = amd_chipset.probe_result;
 
 		spin_unlock_irqrestore(&amd_lock, flags);
 
@@ -277,7 +284,7 @@ int usb_amd_find_chipset_info(void)
 		spin_unlock_irqrestore(&amd_lock, flags);
 	}
 
-	return ret;
+	return need_pll_quirk;
 }
 EXPORT_SYMBOL_GPL(usb_amd_find_chipset_info);
 
-- 
2.21.0

