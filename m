Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E254C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D44205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbfC0KS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:18:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731904AbfC0KS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:18:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BA91AD2F;
        Wed, 27 Mar 2019 10:18:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     oneukum@suse.de, Terry.Junge@plantronics.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] HID: core: move Usage Page concatenation to Main item
Date:   Wed, 27 Mar 2019 11:18:48 +0100
Message-Id: <20190327101848.25477-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As seen on some USB wireless keyboards manufactured by Primax, the HID
parser was using some assumptions that are not always true. In this case
it's s the fact that, inside the scope of a main item, an Usage Page
will always precede an Usage.

The spec is not pretty clear as 6.2.2.7 states "Any usage that follows
is interpreted as a Usage ID and concatenated with the Usage Page".
While 6.2.2.8 states "When the parser encounters a main item it
concatenates the last declared Usage Page with a Usage to form a
complete usage value." Being somewhat contradictory it was decided to
match Window's implementation, which follows 6.2.2.8.

In summary, the patch moves the Usage Page concatenation from the local
item parsing function to the main item parsing function.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

v3->v4: - Use u8 instead of __u8
        - Remove overly complex usage size calculation

v2->v3: - Update patch title

v1->v2: - Add usage concatenation to hid_scan_main()
        - Rework tests in hid-tools, making sure no-one is failing

 drivers/hid/hid-core.c | 36 ++++++++++++++++++++++++------------
 include/linux/hid.h    |  1 +
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9993b692598f..852bbd303d9a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
  * Add a usage to the temporary parser table.
  */
 
-static int hid_add_usage(struct hid_parser *parser, unsigned usage)
+static int hid_add_usage(struct hid_parser *parser, unsigned usage, u8 size)
 {
 	if (parser->local.usage_index >= HID_MAX_USAGES) {
 		hid_err(parser->device, "usage index exceeded\n");
 		return -1;
 	}
 	parser->local.usage[parser->local.usage_index] = usage;
+	parser->local.usage_size[parser->local.usage_index] = size;
 	parser->local.collection_index[parser->local.usage_index] =
 		parser->collection_stack_ptr ?
 		parser->collection_stack[parser->collection_stack_ptr - 1] : 0;
@@ -486,10 +487,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 			return 0;
 		}
 
-		if (item->size <= 2)
-			data = (parser->global.usage_page << 16) + data;
-
-		return hid_add_usage(parser, data);
+		return hid_add_usage(parser, data, item->size);
 
 	case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
 
@@ -498,9 +496,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 			return 0;
 		}
 
-		if (item->size <= 2)
-			data = (parser->global.usage_page << 16) + data;
-
 		parser->local.usage_minimum = data;
 		return 0;
 
@@ -511,9 +506,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 			return 0;
 		}
 
-		if (item->size <= 2)
-			data = (parser->global.usage_page << 16) + data;
-
 		count = data - parser->local.usage_minimum;
 		if (count + parser->local.usage_index >= HID_MAX_USAGES) {
 			/*
@@ -533,7 +525,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 		}
 
 		for (n = parser->local.usage_minimum; n <= data; n++)
-			if (hid_add_usage(parser, n)) {
+			if (hid_add_usage(parser, n, item->size)) {
 				dbg_hid("hid_add_usage failed\n");
 				return -1;
 			}
@@ -547,6 +539,22 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 	return 0;
 }
 
+/*
+ * Concatenate Usage Pages into Usages where relevant:
+ * As per specification, 6.2.2.8: "When the parser encounters a main item it
+ * concatenates the last declared Usage Page with a Usage to form a complete
+ * usage value."
+ */
+
+static void hid_concatenate_usage_page(struct hid_parser *parser)
+{
+	int i;
+
+	for (i = 0; i < parser->local.usage_index; i++)
+		if (parser->local.usage_size[i] <= 2)
+			parser->local.usage[i] += parser->global.usage_page << 16;
+}
+
 /*
  * Process a main item.
  */
@@ -556,6 +564,8 @@ static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
 	__u32 data;
 	int ret;
 
+	hid_concatenate_usage_page(parser);
+
 	data = item_udata(item);
 
 	switch (item->tag) {
@@ -765,6 +775,8 @@ static int hid_scan_main(struct hid_parser *parser, struct hid_item *item)
 	__u32 data;
 	int i;
 
+	hid_concatenate_usage_page(parser);
+
 	data = item_udata(item);
 
 	switch (item->tag) {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index f9707d1dcb58..ac0c70b4ce10 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -417,6 +417,7 @@ struct hid_global {
 
 struct hid_local {
 	unsigned usage[HID_MAX_USAGES]; /* usage array */
+	u8 usage_size[HID_MAX_USAGES]; /* usage size array */
 	unsigned collection_index[HID_MAX_USAGES]; /* collection index array */
 	unsigned usage_index;
 	unsigned usage_minimum;
-- 
2.21.0

