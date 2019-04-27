Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656E1206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfD0PPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0PPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58C5130BDA05;
        Sat, 27 Apr 2019 15:15:02 +0000 (UTC)
Received: from thuth.com (ovpn-116-26.ams2.redhat.com [10.36.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A3D127CB8;
        Sat, 27 Apr 2019 15:15:00 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] mtd: maps: Make uclinux_ram_map static
Date:   Sat, 27 Apr 2019 17:14:57 +0200
Message-Id: <20190427151457.12776-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 27 Apr 2019 15:15:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture has been removed a while ago, so there is
no more need to declare uclinux_ram_map as a global structure.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 drivers/mtd/maps/uclinux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mtd/maps/uclinux.c b/drivers/mtd/maps/uclinux.c
index aef030ca8601..de4c46318abb 100644
--- a/drivers/mtd/maps/uclinux.c
+++ b/drivers/mtd/maps/uclinux.c
@@ -31,13 +31,7 @@
 #define MAP_NAME "ram"
 #endif
 
-/*
- * Blackfin uses uclinux_ram_map during startup, so it must not be static.
- * Provide a dummy declaration to make sparse happy.
- */
-extern struct map_info uclinux_ram_map;
-
-struct map_info uclinux_ram_map = {
+static struct map_info uclinux_ram_map = {
 	.name = MAP_NAME,
 	.size = 0,
 };
-- 
2.21.0

