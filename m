Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0664AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD76221783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119524;
	bh=2RCEg7l97LRwKRzZakcVXzs9bT+W5NfSG1bK1ShynnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xoJI8Kxsk20m+1xaCYfjz3kzFTkw3UuwmZo+9HfG42x12ZCVPJ6MNq/5jMmrDKumW
	 jgCwcJu97XaxWf5APKIE74ZNjP86H/hAdUYjRQFZKSk7jxLSC0fnEgOA3M515As52T
	 XFqWCwyJ8DVzrYeiJ5pJmfC1CB+IGf8VBxF49BrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbfJCQSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388699AbfJCQSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:18:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94FF121783;
        Thu,  3 Oct 2019 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119520;
        bh=2RCEg7l97LRwKRzZakcVXzs9bT+W5NfSG1bK1ShynnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1SH7jgcqdh1GhHsAfZn6W3ioQMYJCeaLjd1OGexssiYgIVpOK98spcGgBADZxKyE
         /F6+c0lYzKMC0+wMJwFSLNGWeKymA7m7uA3HsMVnIhSFLI1hQjfRCDbat1AWhC9XBW
         8relT58mU/dB9MwQHpsRnzfALkFfGUsOq7PRMnxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/211] EDAC/amd64: Recognize DRAM device type ECC capability
Date:   Thu,  3 Oct 2019 17:52:41 +0200
Message-Id: <20191003154508.721172968@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit f8be8e5680225ac9caf07d4545f8529b7395327f ]

AMD Family 17h systems support x4 and x16 DRAM devices. However, the
device type is not checked when setting mci.edac_ctl_cap.

Set the appropriate capability flag based on the device type.

Default to x8 DRAM device when neither the x4 or x16 bits are set.

 [ bp: reverse cpk_en check to save an indentation level. ]

Fixes: 2d09d8f301f5 ("EDAC, amd64: Determine EDAC MC capabilities on Fam17h")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20190821235938.118710-3-Yazen.Ghannam@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/amd64_edac.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e2addb2bca296..1613df20774f9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3101,12 +3101,15 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 static inline void
 f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 {
-	u8 i, ecc_en = 1, cpk_en = 1;
+	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
 
 	for (i = 0; i < NUM_UMCS; i++) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
 			cpk_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
+
+			dev_x4  &= !!(pvt->umc[i].dimm_cfg & BIT(6));
+			dev_x16 &= !!(pvt->umc[i].dimm_cfg & BIT(7));
 		}
 	}
 
@@ -3114,8 +3117,15 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 	if (ecc_en) {
 		mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
 
-		if (cpk_en)
+		if (!cpk_en)
+			return;
+
+		if (dev_x4)
 			mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
+		else if (dev_x16)
+			mci->edac_ctl_cap |= EDAC_FLAG_S16ECD16ED;
+		else
+			mci->edac_ctl_cap |= EDAC_FLAG_S8ECD8ED;
 	}
 }
 
-- 
2.20.1



