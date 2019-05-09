Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA9BC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771402177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DgXofduM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEISKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:10:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37058 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfEISJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:09:41 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D59AB1EC0B5A;
        Thu,  9 May 2019 20:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjoT5H/0RHJtPrfKOdxqo1+v6wrnm32aUYqpwZ/kErQ=;
        b=DgXofduM+JsO1k/SIyrJAIC9UJHeiRLyUe6qVanWa2jE26LniFpEyJzHoAe87isvcvKakp
        j2ja5hCLcPe2KLOl4jlr8fFMoN6xQ6PGpWJrVGPvnudzB/wzP4uKzobKSKP356CBS2i1/r
        bOXGkNMF6vK5J7nOWukUTfC0sm2yPNI=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] RAS/CEC: Dump the different array element sections
Date:   Thu,  9 May 2019 20:09:24 +0200
Message-Id: <20190509180926.31932-10-bp@alien8.de>
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

When dumping the array elements, print them in the following format:

  [ PFN | generation in binary | count ]

to be perfectly clear what all those sections are.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 1cbc1ed82afe..71f3e14c35d8 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -429,6 +429,8 @@ static int action_threshold_set(void *data, u64 val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, pfn_get, action_threshold_set, "%lld\n");
 
+static const char * const bins[] = { "00", "01", "10", "11" };
+
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
@@ -440,7 +442,8 @@ static int array_dump(struct seq_file *m, void *v)
 	for (i = 0; i < ca->n; i++) {
 		u64 this = PFN(ca->array[i]);
 
-		seq_printf(m, " %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
+		seq_printf(m, " %3d: [%016llx|%s|%03llx]\n",
+			   i, this, bins[DECAY(ca->array[i])], COUNT(ca->array[i]));
 	}
 
 	seq_printf(m, "}\n");
-- 
2.21.0

