Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA6C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD8C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfDWPqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:46:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbfDWPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:46:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CB45307D987;
        Tue, 23 Apr 2019 15:46:32 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-226.ams2.redhat.com [10.36.116.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01EDF5C269;
        Tue, 23 Apr 2019 15:46:30 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, James Feeney <james@nurealm.net>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] HID: input: fix assignment of .value
Date:   Tue, 23 Apr 2019 17:46:15 +0200
Message-Id: <20190423154615.18257-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
References: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 23 Apr 2019 15:46:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value field is actually an array of .maxfield. We should assign the
correct number to the correct usage.

Not that we never encounter a device that requires this ATM, but better
have the proper code path.

Fixes: 2dc702c991e377 ("HID: input: use the Resolution Multiplier for
       high-resolution scrolling")
Cc: stable@vger.kernel.org  # v5.0+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index fadf76f0a386..6dd0294e1133 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1580,7 +1580,7 @@ static bool __hidinput_change_resolution_multipliers(struct hid_device *hid,
 			if (usage->hid != HID_GD_RESOLUTION_MULTIPLIER)
 				continue;
 
-			*report->field[i]->value = value;
+			report->field[i]->value[j] = value;
 			update_needed = true;
 		}
 	}
-- 
2.19.2

