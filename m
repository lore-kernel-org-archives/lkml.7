Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF64CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F28C21848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392808AbfIFI75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbfIFI75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:59:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 040D7883820;
        Fri,  6 Sep 2019 08:59:57 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-26.brq.redhat.com [10.40.204.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 525CE5C1D8;
        Fri,  6 Sep 2019 08:59:53 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input - elan_i2c: remove Lenovo Legion Y7000 PnpID
Date:   Fri,  6 Sep 2019 10:59:48 +0200
Message-Id: <20190906085948.27470-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 06 Sep 2019 08:59:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the Bios of the Lenovo Legion Y7000 is using ELAN061B
when the actual device is supposed to be used with hid-multitouch.

Remove it from the list of the supported device, hoping that
no one will complain about the loss in functionality.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203467
Fixes: Fixes: 738c06d0e456 ("Input: elan_i2c - add hardware ID for multiple Lenovo laptops")
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Note to self: once this gets in, we need to send a similar patch
to stable, as there are a few stable branches with this PnpID.


 include/linux/input/elan-i2c-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/input/elan-i2c-ids.h b/include/linux/input/elan-i2c-ids.h
index ceabb01a6a7d..1ecb6b45812c 100644
--- a/include/linux/input/elan-i2c-ids.h
+++ b/include/linux/input/elan-i2c-ids.h
@@ -48,7 +48,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0618", 0 },
 	{ "ELAN0619", 0 },
 	{ "ELAN061A", 0 },
-	{ "ELAN061B", 0 },
+/*	{ "ELAN061B", 0 }, not working on the Lenovo Legion Y7000 */
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },
-- 
2.21.0

