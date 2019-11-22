Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6044C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844B920714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfKVNOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:14:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58585 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:14:35 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iY8l0-0007Zn-Mz; Fri, 22 Nov 2019 13:13:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: cs4236: fix error return comparison of an unsigned integer
Date:   Fri, 22 Nov 2019 13:13:54 +0000
Message-Id: <20191122131354.58042-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The return from pnp_irq is an unsigned integer type resource_size_t
and hence the error check for a positive non-error code is always
going to be true.  A check for a non-failure return from pnp_irq
should in fact be for (resource_size_t)-1 rather than >= 0.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: a9824c868a2c ("[ALSA] Add CS4232 PnP BIOS support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/cs423x/cs4236.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 78dd213589b4..fa3c39cff5f8 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -278,7 +278,8 @@ static int snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
 	} else {
 		mpu_port[dev] = pnp_port_start(pdev, 0);
 		if (mpu_irq[dev] >= 0 &&
-		    pnp_irq_valid(pdev, 0) && pnp_irq(pdev, 0) >= 0) {
+		    pnp_irq_valid(pdev, 0) &&
+		    pnp_irq(pdev, 0) != (resource_size_t)-1) {
 			mpu_irq[dev] = pnp_irq(pdev, 0);
 		} else {
 			mpu_irq[dev] = -1;	/* disable interrupt */
-- 
2.24.0

