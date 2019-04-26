Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF351C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B678C206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfDZUKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:10:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDZUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:10:10 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:9080:8461:642a:3a75:dbc6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 971D426C476;
        Fri, 26 Apr 2019 21:10:06 +0100 (BST)
From:   Helen Koike <helen.koike@collabora.com>
To:     dm-devel@redhat.com
Cc:     kernel@collabora.com, Helen Koike <helen.koike@collabora.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>
Subject: [PATCH] dm: init: fix max devices/targets checks
Date:   Fri, 26 Apr 2019 17:09:55 -0300
Message-Id: <20190426200955.17886-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm-init should allow up to DM_MAX_{DEVICES,TARGETS} for devices/targets,
and not DM_MAX_{DEVICES,TARGETS} - 1.

Fix the checks and also fix the error message when the number of devices
is surpassed.

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hi,

This patch was tested by manipulating DM_MAX_TARGETS and DM_MAX_DEVICES
macros and making sure the test cases in the following test script[1] was
passing or failing when they should.

[1] https://gitlab.collabora.com/koike/dm-cmdline-test

Thanks
Helen

 drivers/md/dm-init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index 4b76f84424c3..352e803f566e 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -160,7 +160,7 @@ static int __init dm_parse_table(struct dm_device *dev, char *str)
 
 	while (table_entry) {
 		DMDEBUG("parsing table \"%s\"", str);
-		if (++dev->dmi.target_count >= DM_MAX_TARGETS) {
+		if (++dev->dmi.target_count > DM_MAX_TARGETS) {
 			DMERR("too many targets %u > %d",
 			      dev->dmi.target_count, DM_MAX_TARGETS);
 			return -EINVAL;
@@ -242,9 +242,9 @@ static int __init dm_parse_devices(struct list_head *devices, char *str)
 			return -ENOMEM;
 		list_add_tail(&dev->list, devices);
 
-		if (++ndev >= DM_MAX_DEVICES) {
-			DMERR("too many targets %u > %d",
-			      dev->dmi.target_count, DM_MAX_TARGETS);
+		if (++ndev > DM_MAX_DEVICES) {
+			DMERR("too many devices %lu > %d",
+			      ndev, DM_MAX_DEVICES);
 			return -EINVAL;
 		}
 
-- 
2.20.1

