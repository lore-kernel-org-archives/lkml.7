Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC0F22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033528;
	bh=+SOm2GP64ol7LdusIEc1ruqk5JMEVzMl6CLf2mVi3yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GR8r+F1cOqiA929qp1LvWDHDIPFLGRs61V48syncOhCs6Mt9Tls8Y4+bGIFutzORm
	 FdXZiYs0RmPAjlChcuannuOh9wMKVpJvEvUdxSM6V456PZdQgHxN9tW2fH2pIUX66Z
	 KDf5NR2FTmTFuo2T2O+9isgmDA9xjgSV8udCWXuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405183AbfGYFp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405170AbfGYFpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:45:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8388822C7C;
        Thu, 25 Jul 2019 05:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033522;
        bh=+SOm2GP64ol7LdusIEc1ruqk5JMEVzMl6CLf2mVi3yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sN+q5aZN0kIbJeyDHDmQAAj/vS2P8NDrVZOPVlaR3lq2/r7P8GGEQJT5/rFaXNShE
         dRHJQQpfkHryvRpxkb0ofz4WvmSLM3lqmaHy/WGqkIyCwvQuYcx2TvTZwRxvREMWBR
         BcivxVc9uhoMJXYbOGIqcRc/ERVl/B0awT+dvME4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 237/271] HID: wacom: generic: Correct pad syncing
Date:   Wed, 24 Jul 2019 21:21:46 +0200
Message-Id: <20190724191715.468938498@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Armstrong Skomra <skomra@gmail.com>

commit d4b8efeb46d99a5d02e7f88ac4eaccbe49370770 upstream.

Only sync the pad once per report, not once per collection.
Also avoid syncing the pad on battery reports.

Fixes: f8b6a74719b5 ("HID: wacom: generic: Support multiple tools per report")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2119,14 +2119,12 @@ static void wacom_wac_pad_report(struct
 	bool active = wacom_wac->hid_data.inrange_state != 0;
 
 	/* report prox for expresskey events */
-	if ((wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY) &&
-	    wacom_wac->hid_data.pad_input_event_flag) {
+	if (wacom_wac->hid_data.pad_input_event_flag) {
 		input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
 		input_sync(input);
 		if (!active)
 			wacom_wac->hid_data.pad_input_event_flag = false;
 	}
-
 }
 
 static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
@@ -2723,9 +2721,7 @@ static int wacom_wac_collection(struct h
 	if (report->type != HID_INPUT_REPORT)
 		return -1;
 
-	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
-		wacom_wac_pad_report(hdev, report, field);
-	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
+	if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		wacom_wac_pen_report(hdev, report);
 	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		wacom_wac_finger_report(hdev, report);
@@ -2739,7 +2735,7 @@ void wacom_wac_report(struct hid_device
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct hid_field *field;
 	bool pad_in_hid_field = false, pen_in_hid_field = false,
-		finger_in_hid_field = false;
+		finger_in_hid_field = false, true_pad = false;
 	int r;
 	int prev_collection = -1;
 
@@ -2755,6 +2751,8 @@ void wacom_wac_report(struct hid_device
 			pen_in_hid_field = true;
 		if (WACOM_FINGER_FIELD(field))
 			finger_in_hid_field = true;
+		if (wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY)
+			true_pad = true;
 	}
 
 	wacom_wac_battery_pre_report(hdev, report);
@@ -2778,6 +2776,9 @@ void wacom_wac_report(struct hid_device
 	}
 
 	wacom_wac_battery_report(hdev, report);
+
+	if (true_pad && wacom->wacom_wac.pad_input)
+		wacom_wac_pad_report(hdev, report, field);
 }
 
 static int wacom_bpt_touch(struct wacom_wac *wacom)


