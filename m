Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436F6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151FC206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKRN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:28:16 -0500
Received: from smtp2.axis.com ([195.60.68.18]:53795 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfKRN2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:28:15 -0500
IronPort-SDR: 0Rkb0DNuF4Q/NWH1HFcE1NdG5P8yB4M5t3f1tixIcoFWmmoSZxm+4o5+zxlluF95mC3SySB9Ja
 EV/OkLxsEJEVrfiKkTjL6oxZQIyjzwo4bhpqQIbi6fiyFPm7hD95pYSmjkFNbA8RYPdKhRLoKM
 u1yTo8ThpERI65msIOUZiVADldBaOWt1xYcN1tIDOn1ZoDomzGx96JW+aVUcOb5lr1gwjcv46j
 NjdsmLOWIExT8xRmDE4K9/+cgI7q1Z6nTpu9sSGYgMonVbKak0nxo3X0b9ry+cYHLybvHOCSjg
 BEE=
X-IronPort-AV: E=Sophos;i="5.68,320,1569276000"; 
   d="scan'208";a="2543774"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     pantelis.antoniou@konsulko.com, frowand.list@gmail.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 2/2] of: overlay: fix target_path memory leak
Date:   Mon, 18 Nov 2019 14:28:09 +0100
Message-Id: <20191118132809.30127-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191118132809.30127-1-vincent.whitchurch@axis.com>
References: <20191118132809.30127-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

target_path is used as a temporary buffer in dup_and_fixup_symbol_prop()
and should be freed even in the success path.

This was detected by kmemleak.

 unreferenced object 0x8598f6c0 (size 64):
   backtrace:
     __kmalloc_track_caller+0x17d/0x228
     kvasprintf+0x2b/0x64
     kasprintf+0x15/0x20
     add_changeset_property+0x225/0x364
     of_overlay_fdt_apply+0x42d/0x6b4
     ...

Fixes: e0a58f3e08d4b7fa ("of: overlay: remove a dependency on device node full_name")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/of/overlay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 5f8869e2a8b3..59455322a130 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -261,6 +261,8 @@ static struct property *dup_and_fixup_symbol_prop(
 
 	of_property_set_flag(new_prop, OF_DYNAMIC);
 
+	kfree(target_path);
+
 	return new_prop;
 
 err_free_new_prop:
-- 
2.20.0

