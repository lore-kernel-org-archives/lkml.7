Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618EC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158C2205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbfGOOaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:30:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391643AbfGOOaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:30:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22189B084;
        Mon, 15 Jul 2019 14:30:07 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     preid@electromag.com.au, nishadkamdar@gmail.com,
        bhanusreemahesh@gmail.com, leobras.c@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] Staging: fbtft: Fix wrong check in fbtft_write_wmem16_bus8()
Date:   Mon, 15 Jul 2019 16:30:02 +0200
Message-Id: <20190715143003.12819-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually want to set the gpio pin if it's avilable, not the other way
around.

Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor interface")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/fbtft/fbtft-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 2ea814d0dca5..63c65dd67b17 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -135,7 +135,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
-	if (!par->gpio.dc)
+	if (par->gpio.dc)
 		gpiod_set_value(par->gpio.dc, 1);
 
 	/* non buffered write */
-- 
2.22.0

