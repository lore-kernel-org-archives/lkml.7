Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D6BC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D0E207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbfFJSxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:53:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388109AbfFJSxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:53:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F20FABD5;
        Mon, 10 Jun 2019 18:53:50 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     dmitry.torokhov@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: input: fix a4tech horizontal wheel custom usage id
Date:   Mon, 10 Jun 2019 20:53:43 +0200
Message-Id: <20190610185343.27614-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some a4tech mice use the 'GenericDesktop.00b8' usage id to inform
whether the previous wheel report was horizontal or vertical. Before
c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key") this
usage id was being mapped to 'Relative.Misc'. After the patch it's
simply ignored (usage->type == 0 & usage->code == 0). Checking the HID
Usage Tables it turns out it's a reserved usage_id, so it makes sense to
map it the way it was. Ultimately this makes hid-a4tech ignore the
WHEEL/HWHEEL selection event, as it has no usage->type.

The patch reverts the handling of the usage id back to it's previous
behavior.

Fixes: c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/hid/hid-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 63855f275a38..6a956d5a195e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -671,7 +671,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		if ((usage->hid & 0xf0) == 0xb0) {	/* SC - Display */
 			switch (usage->hid & 0xf) {
 			case 0x05: map_key_clear(KEY_SWITCHVIDEOMODE); break;
-			default: goto ignore;
+			default: goto unknown;
 			}
 			break;
 		}
-- 
2.21.0

