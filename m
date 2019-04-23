Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4BDC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859C4218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfDWPqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:46:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfDWPq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:46:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38CD33D965;
        Tue, 23 Apr 2019 15:46:29 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-226.ams2.redhat.com [10.36.116.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A5D95C296;
        Tue, 23 Apr 2019 15:46:24 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, James Feeney <james@nurealm.net>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] HID: input: make sure the wheel high resolution multiplier is set
Date:   Tue, 23 Apr 2019 17:46:14 +0200
Message-Id: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 23 Apr 2019 15:46:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some old mice have a tendency to not accept the high resolution multiplier.
They reply with a -EPIPE which was previously ignored.

Force the call to resolution multiplier to be synchronous and actually
check for the answer. If this fails, consider the mouse like a normal one.

Fixes: 2dc702c991e377 ("HID: input: use the Resolution Multiplier for
       high-resolution scrolling")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1700071
Reported-and-tested-by: James Feeney <james@nurealm.net>
Cc: stable@vger.kernel.org  # v5.0+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c  |  7 +++-
 drivers/hid/hid-input.c | 81 +++++++++++++++++++++++++----------------
 include/linux/hid.h     |  2 +-
 3 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 76464aabd20c..92387fc0bf18 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1637,7 +1637,7 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
  * Implement a generic .request() callback, using .raw_request()
  * DO NOT USE in hid drivers directly, but through hid_hw_request instead.
  */
-void __hid_request(struct hid_device *hid, struct hid_report *report,
+int __hid_request(struct hid_device *hid, struct hid_report *report,
 		int reqtype)
 {
 	char *buf;
@@ -1646,7 +1646,7 @@ void __hid_request(struct hid_device *hid, struct hid_report *report,
 
 	buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
-		return;
+		return -ENOMEM;
 
 	len = hid_report_len(report);
 
@@ -1663,8 +1663,11 @@ void __hid_request(struct hid_device *hid, struct hid_report *report,
 	if (reqtype == HID_REQ_GET_REPORT)
 		hid_input_report(hid, report->type, buf, ret, 0);
 
+	ret = 0;
+
 out:
 	kfree(buf);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__hid_request);
 
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 1fce0076e7dc..fadf76f0a386 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1542,52 +1542,71 @@ static void hidinput_close(struct input_dev *dev)
 	hid_hw_close(hid);
 }
 
-static void hidinput_change_resolution_multipliers(struct hid_device *hid)
+static bool __hidinput_change_resolution_multipliers(struct hid_device *hid,
+		struct hid_report *report, bool use_logical_max)
 {
-	struct hid_report_enum *rep_enum;
-	struct hid_report *rep;
 	struct hid_usage *usage;
+	bool update_needed = false;
 	int i, j;
 
-	rep_enum = &hid->report_enum[HID_FEATURE_REPORT];
-	list_for_each_entry(rep, &rep_enum->report_list, list) {
-		bool update_needed = false;
+	if (report->maxfield == 0)
+		return false;
 
-		if (rep->maxfield == 0)
-			continue;
+	/*
+	 * If we have more than one feature within this report we
+	 * need to fill in the bits from the others before we can
+	 * overwrite the ones for the Resolution Multiplier.
+	 */
+	if (report->maxfield > 1) {
+		hid_hw_request(hid, report, HID_REQ_GET_REPORT);
+		hid_hw_wait(hid);
+	}
 
-		/*
-		 * If we have more than one feature within this report we
-		 * need to fill in the bits from the others before we can
-		 * overwrite the ones for the Resolution Multiplier.
+	for (i = 0; i < report->maxfield; i++) {
+		__s32 value = use_logical_max ?
+			      report->field[i]->logical_maximum :
+			      report->field[i]->logical_minimum;
+
+		/* There is no good reason for a Resolution
+		 * Multiplier to have a count other than 1.
+		 * Ignore that case.
 		 */
-		if (rep->maxfield > 1) {
-			hid_hw_request(hid, rep, HID_REQ_GET_REPORT);
-			hid_hw_wait(hid);
-		}
+		if (report->field[i]->report_count != 1)
+			continue;
 
-		for (i = 0; i < rep->maxfield; i++) {
-			__s32 logical_max = rep->field[i]->logical_maximum;
+		for (j = 0; j < report->field[i]->maxusage; j++) {
+			usage = &report->field[i]->usage[j];
 
-			/* There is no good reason for a Resolution
-			 * Multiplier to have a count other than 1.
-			 * Ignore that case.
-			 */
-			if (rep->field[i]->report_count != 1)
+			if (usage->hid != HID_GD_RESOLUTION_MULTIPLIER)
 				continue;
 
-			for (j = 0; j < rep->field[i]->maxusage; j++) {
-				usage = &rep->field[i]->usage[j];
+			*report->field[i]->value = value;
+			update_needed = true;
+		}
+	}
+
+	return update_needed;
+}
 
-				if (usage->hid != HID_GD_RESOLUTION_MULTIPLIER)
-					continue;
+static void hidinput_change_resolution_multipliers(struct hid_device *hid)
+{
+	struct hid_report_enum *rep_enum;
+	struct hid_report *rep;
+	int ret;
 
-				*rep->field[i]->value = logical_max;
-				update_needed = true;
+	rep_enum = &hid->report_enum[HID_FEATURE_REPORT];
+	list_for_each_entry(rep, &rep_enum->report_list, list) {
+		bool update_needed = __hidinput_change_resolution_multipliers(hid,
+								     rep, true);
+
+		if (update_needed) {
+			ret = __hid_request(hid, rep, HID_REQ_SET_REPORT);
+			if (ret) {
+				__hidinput_change_resolution_multipliers(hid,
+								    rep, false);
+				return;
 			}
 		}
-		if (update_needed)
-			hid_hw_request(hid, rep, HID_REQ_SET_REPORT);
 	}
 
 	/* refresh our structs */
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ac0c70b4ce10..5a24ebfb5b47 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -894,7 +894,7 @@ struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
 __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
 void hid_output_report(struct hid_report *report, __u8 *data);
-void __hid_request(struct hid_device *hid, struct hid_report *rep, int reqtype);
+int __hid_request(struct hid_device *hid, struct hid_report *rep, int reqtype);
 u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
 struct hid_device *hid_allocate_device(void);
 struct hid_report *hid_register_report(struct hid_device *device,
-- 
2.19.2

