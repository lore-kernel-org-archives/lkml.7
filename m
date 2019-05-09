Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0426C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD092177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RPoiZNWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfEISKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:10:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37010 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfEISJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:09:37 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1AF71EC0AE4;
        Thu,  9 May 2019 20:09:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wlA3AUjKxPUdgXu7p6jOrxoqJInesTzTmEv+gXf1fBQ=;
        b=RPoiZNWy3G027TSALy9ZJWLAPVBiZ3Bs17ngVtvs9Y0wjEZzUPO+0LFq3Ksb8CTfeDAiel
        d/PmzoyIzU58sSUk0JR7Aw574P0bE5b9xhT7yh/e72EX+EhJXrf1dq7I6MNTcU99nwZcxA
        wJSxOSU7foAdYx7pid4TWJ/lKvIJyXg=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] RAS/CEC: Do not set decay value on error
Date:   Thu,  9 May 2019 20:09:20 +0200
Message-Id: <20190509180926.31932-6-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509180926.31932-1-bp@alien8.de>
References: <20190509180926.31932-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

When the value requested doesn't match the allowed (min,max) range,
the @data buffer should not be modified with the invalid value because
reading "decay_interval" shows it otherwise.

Move the data write after the check.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 73216b7f67be..667a126f39f1 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -371,17 +371,17 @@ DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, pfn_get, pfn_set, "0x%llx\n");
 
 static int decay_interval_set(void *data, u64 val)
 {
-	*(u64 *)data = val;
-
 	if (val < CEC_DECAY_MIN_INTERVAL)
 		return -EINVAL;
 
 	if (val > CEC_DECAY_MAX_INTERVAL)
 		return -EINVAL;
 
+	*(u64 *)data   = val;
 	decay_interval = val;
 
 	cec_mod_work(decay_interval);
+
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, pfn_get, decay_interval_set, "%lld\n");
-- 
2.21.0

