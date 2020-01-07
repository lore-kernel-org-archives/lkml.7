Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93454C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578AD2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431786;
	bh=kHWeVqFe+m0kkb4VihQ/ZQA4wtRTqA+ReUP+mQlbl0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oyhz7DcF5MBsZccJXl4mDAAFgcOAzfgb6bonbTxQ/Fe3shq09dVz/gmY4v28HVrLL
	 wTVxi55n4iwqhJC4TAe8caj59Y5mO5yWiQgOlX0YouA7/Jb0+n5BYl163lPmJ6eyIE
	 cVyrkRZtRH4OaX4csak56Zf6SD5JU7BcUXeDE+Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgAGVQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbgAGVHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:07:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D65A20678;
        Tue,  7 Jan 2020 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431236;
        bh=kHWeVqFe+m0kkb4VihQ/ZQA4wtRTqA+ReUP+mQlbl0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFfDfLWzNN+yw+L3+t4utARzaihDboTm6Y8bAHjHffBttSwhK/8n2SkUoVYJ07Y5R
         YVfBxGcJ7yOLJxYGCgK3pjQySPOvfFwCSPA2kDUmF+3Y+8Yx/48KEJP8LKC/xtNa9f
         Eiq2d+64gReBXu1gNzuaGn60FGNUj8e1RrxDDL/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 082/115] HID: i2c-hid: Reset ALPS touchpads on resume
Date:   Tue,  7 Jan 2020 21:54:52 +0100
Message-Id: <20200107205305.171742306@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit fd70466d37bf3fe0118d18c56ddde85b428f86cf upstream.

Commit 52cf93e63ee6 ("HID: i2c-hid: Don't reset device upon system
resume") fixes many touchpads and touchscreens, however ALPS touchpads
start to trigger IRQ storm after system resume.

Since it's total silence from ALPS, let's bring the old behavior back
to ALPS touchpads.

Fixes: 52cf93e63ee6 ("HID: i2c-hid: Don't reset device upon system resume")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/i2c-hid/i2c-hid-core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -51,6 +51,7 @@
 #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
 #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
 #define I2C_HID_QUIRK_BOGUS_IRQ			BIT(4)
+#define I2C_HID_QUIRK_RESET_ON_RESUME		BIT(5)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -182,6 +183,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID,
 		 I2C_HID_QUIRK_BOGUS_IRQ },
+	{ USB_VENDOR_ID_ALPS_JP, HID_ANY_ID,
+		 I2C_HID_QUIRK_RESET_ON_RESUME },
 	{ 0, 0 }
 };
 
@@ -1290,8 +1293,15 @@ static int i2c_hid_resume(struct device
 	 * solves "incomplete reports" on Raydium devices 2386:3118 and
 	 * 2386:4B33 and fixes various SIS touchscreens no longer sending
 	 * data after a suspend/resume.
+	 *
+	 * However some ALPS touchpads generate IRQ storm without reset, so
+	 * let's still reset them here.
 	 */
-	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
+	if (ihid->quirks & I2C_HID_QUIRK_RESET_ON_RESUME)
+		ret = i2c_hid_hwreset(client);
+	else
+		ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
+
 	if (ret)
 		return ret;
 


