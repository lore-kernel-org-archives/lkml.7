Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C4C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228072063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560807437;
	bh=fwr27nbyLR8cixJMufn3KrmACVWcc6NROmLVUchmjQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=As+eKU4h3WrXhM9UlI75tQJVCXqCrqO2nZEZCO7bYQQlitpXm+EHcd9mvsetILdMm
	 gze8q70PLd60C3lwUtjLe5kxGYkHHL8023WE1uOZFB0TMg8YngqVCmCr9e14YXAsg/
	 Bd4C4Gs7VhT46+uPVGGy4hwbQ0CCHrN4rpO3Ar7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfFQVU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbfFQVUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:20:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B5F21881;
        Mon, 17 Jun 2019 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806424;
        bh=fwr27nbyLR8cixJMufn3KrmACVWcc6NROmLVUchmjQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4cFRTjS/SGtsMJRkBRM5LcV4kzSh/6GVz6Ra4z4F/vbA2Nj6aV0143ss0NjTcCPk
         CIGSeK2JBypf1w3NmDo8HKfgcWJQ05vsVDHLx3OzhkWqegK/OyOnQgBzFj6SvJCVwP
         Au8W/dJfMv0reugYWrk54DaQlZEC+s33ffEvkOZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Aaron Skomra <aaron.skomra@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5.1 009/115] HID: wacom: Send BTN_TOUCH in response to INTUOSP2_BT eraser contact
Date:   Mon, 17 Jun 2019 23:08:29 +0200
Message-Id: <20190617210800.382847392@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gerecke <jason.gerecke@wacom.com>

commit fe7f8d73d1af19b678171170e4e5384deb57833d upstream.

The Bluetooth reports from the 2nd-gen Intuos Pro have separate bits for
indicating if the tip or eraser is in contact with the tablet. At the
moment, only the tip contact bit controls the state of the BTN_TOUCH
event. This prevents the eraser from working as expected. This commit
changes the driver to send BTN_TOUCH whenever either the tip or eraser
contact bit is set.

Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: <stable@vger.kernel.org> # 4.11+
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Aaron Skomra <aaron.skomra@wacom.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1301,7 +1301,7 @@ static void wacom_intuos_pro2_bt_pen(str
 						 range ? frame[7] : wacom->features.distance_max);
 			}
 
-			input_report_key(pen_input, BTN_TOUCH, frame[0] & 0x01);
+			input_report_key(pen_input, BTN_TOUCH, frame[0] & 0x09);
 			input_report_key(pen_input, BTN_STYLUS, frame[0] & 0x02);
 			input_report_key(pen_input, BTN_STYLUS2, frame[0] & 0x04);
 


