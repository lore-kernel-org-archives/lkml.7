Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C18C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 03:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C39206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 03:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLDDfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 22:35:31 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:59837 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfLDDfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 22:35:31 -0500
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d59 with ME
        id ZfbS2100A3xPcdm03fbSuu; Wed, 04 Dec 2019 04:35:29 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 04 Dec 2019 04:35:29 +0100
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        masaki.ota@jp.alps.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] HID: alps: Fix an error handling path in 'alps_input_configured()'
Date:   Wed,  4 Dec 2019 04:35:25 +0100
Message-Id: <20191204033525.10871-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are issues:
   - if 'input_allocate_device()' fails and return NULL, there is no need
     to free anything and 'input_free_device()' call is a no-op. It can
     be axed.
   - 'ret' is known to be 0 at this point, so we must set it to a
     meaningful value before returning

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index ae79a7c66737..fa704153cb00 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -730,7 +730,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	if (data->has_sp) {
 		input2 = input_allocate_device();
 		if (!input2) {
-			input_free_device(input2);
+			ret = -ENOMEM;
 			goto exit;
 		}
 
-- 
2.20.1

