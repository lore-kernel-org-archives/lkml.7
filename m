Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1C5C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289982073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355883;
	bh=PyhwMrJnITfzPlAibmhaLQ2bD6IOiKRq5XsTjLeZGDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=axV+FJ0LAFhoso8i5AWd9u0LkLiYuIzrQ/BORGqoT7ppu9yW2huPdnQuDl5tdunaX
	 GudFqVr5L9JBsT1i0R9fyGAuyKHx1pmPvCiXk8IJCJnX8PyYmkArHoXH6onrgtToC7
	 RpQ+IJGVRD08ETGUWFL2iGtjkI5pkxM1KBzHgFAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfDOTSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbfDOTLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 862BA21902;
        Mon, 15 Apr 2019 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355515;
        bh=PyhwMrJnITfzPlAibmhaLQ2bD6IOiKRq5XsTjLeZGDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qn9nVInnG8h1s94gv+feA/KKyzo+3gfi/k0WAcslbIoxaOJQX5jwRh/3PAcmMLP7n
         X4D+/pWIf6bbMv/fwvEVec2S2nl8MXW+kLfHSTutaIJ8bbv7w197bj3BV+kaYzCPN7
         y1QRzUGVecE9XNSZkr6vC9/arEnUZ0lDZA40yypE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Aimo=20Mets=C3=A4l=C3=A4?= <aimetsal@outlook.com>
Subject: [PATCH 5.0 050/117] HID: logitech: Handle 0 scroll events for the m560
Date:   Mon, 15 Apr 2019 21:00:20 +0200
Message-Id: <20190415183747.522995530@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hutterer <peter.hutterer@who-t.net>

commit fd35759ce32b60d3eb52436894bab996dbf8cffa upstream.

hidpp_scroll_counter_handle_scroll() doesn't expect a 0-value scroll event, it
gets interpreted as a negative scroll direction event. This can cause scroll
direction resets and thus broken scrolling.

Fixes: 4435ff2f09a2fc ("HID: logitech: Enable high-resolution scrolling on Logitech mice")
Cc: stable@vger.kernel.org # v5.0
Reported-and-tested-by: Aimo Metsälä <aimetsal@outlook.com>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-logitech-hidpp.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2608,8 +2608,9 @@ static int m560_raw_event(struct hid_dev
 		input_report_rel(mydata->input, REL_Y, v);
 
 		v = hid_snto32(data[6], 8);
-		hidpp_scroll_counter_handle_scroll(
-				&hidpp->vertical_wheel_counter, v);
+		if (v != 0)
+			hidpp_scroll_counter_handle_scroll(
+					&hidpp->vertical_wheel_counter, v);
 
 		input_sync(mydata->input);
 	}


