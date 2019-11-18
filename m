Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D53C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A119206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKRN2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:28:20 -0500
Received: from smtp2.axis.com ([195.60.68.18]:53795 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfKRN2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:28:19 -0500
IronPort-SDR: bs9+P0Lias7qQgUZjcfe6XsQmJVbm3KCbjy1lVFY1UmOks7hXisFSoWmeXtHRep6TdDl3MQvmP
 uFZ+N+rPQrGnFfVzu/Xe7X1kQjvOpMUeiyy/TmSF7tLZSBByavFQKlZzDC1bzypvAraIj5SIWn
 Adj94MkmoFBeuIZUgq9HYzi15LrtckTobI6LD+xip87mvZSxn5UXeywbBBt02Ad8ANXSioOkdo
 LQ9sVcoie3ylGdyshqgc46bOujZ+s2Q3QPI3XPsD7XqwqY1LqZtPGAnYigG6HQxXSm0hmaMFuu
 bqQ=
X-IronPort-AV: E=Sophos;i="5.68,320,1569276000"; 
   d="scan'208";a="2543781"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     pantelis.antoniou@konsulko.com, frowand.list@gmail.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 1/2] of: overlay: fix properties memory leak
Date:   Mon, 18 Nov 2019 14:28:08 +0100
Message-Id: <20191118132809.30127-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changeset entries are created for #address-cells and #size-cells
properties, but the duplicated properies are never freed.  This results
in a memory leak which is detected by kmemleak:

 unreferenced object 0x85887180 (size 64):
   backtrace:
     kmem_cache_alloc_trace+0x1fb/0x1fc
     __of_prop_dup+0x25/0x7c
     add_changeset_property+0x17f/0x370
     build_changeset_next_level+0x29/0x20c
     of_overlay_fdt_apply+0x32b/0x6b4
     ...

Fixes: 6f75118800acf77f8 ("of: overlay: validate overlay properties #address-cells and #size-cells")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c423e94baf0f..5f8869e2a8b3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -360,7 +360,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
 		       target->np, new_prop->name);
 
-	if (ret) {
+	if (ret || !check_for_non_overlay_node) {
 		kfree(new_prop->name);
 		kfree(new_prop->value);
 		kfree(new_prop);
-- 
2.20.0

