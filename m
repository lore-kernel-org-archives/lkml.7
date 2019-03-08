Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FB6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5973020661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050525;
	bh=7RMmnqSuOzL5eunMyPsvrlW/m6GAXpUdyfav0EOWNuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JKASZDXWqnT9vax4q85EyR4HoUEtucRZqtRJq1nXs7cITvUO2mM5zFhVfeqVK/C6V
	 krBYpm9jX6DjU+w8NpHCbAIjZwIIFZT4LjI7HuYkTyqOBqb4UdonkHcVFvzezDzjc1
	 qvT5U2BazacSRuDG2XSMCz5Iut1TgVD6IvxCZtKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfCHNIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:08:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfCHMwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942212087C;
        Fri,  8 Mar 2019 12:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049571;
        bh=7RMmnqSuOzL5eunMyPsvrlW/m6GAXpUdyfav0EOWNuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGJktce8byZ26Iax8yo3VU6k6UBApvsU+A2hW66QNNqOMuwJ5k30Bo8YiX6GiA69+
         katWkTtTk7oVM/kASh1Fqc9jF75WT/xeW/jd5DsMNlw5omk8h03b+CtpbirGRKZ/rP
         2Q2gkTr4M3xVXrrQ7mzLMD2U0Y0RcgyrgAR3Klc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.0 44/46] Bluetooth: btrtl: Restore old logic to assume firmware is already loaded
Date:   Fri,  8 Mar 2019 13:50:17 +0100
Message-Id: <20190308124905.078513087@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 00df214b1faae520880cc5c57e206f21239ef741 upstream.

Realtek bluetooth may not work after reboot:
[   12.446130] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver a99e, hci rev 826c, hci ver 0008

This is a regression introduced by commit 26503ad25de8 ("Bluetooth:
btrtl: split the device initialization into smaller parts"). The new
logic errors out early when no matching IC info can be found, in this
case it means the firmware is already loaded.

So let's assume the firmware is already loaded when we can't find
matching IC info, like the old logic did.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201921
Fixes: 26503ad25de8 ("Bluetooth: btrtl: split the device initialization into smaller parts")
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btrtl.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -552,10 +552,9 @@ struct btrtl_device_info *btrtl_initiali
 					    hdev->bus);
 
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_err(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
+		rtl_dev_info(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
 			    lmp_subver, hci_rev, hci_ver);
-		ret = -EINVAL;
-		goto err_free;
+		return btrtl_dev;
 	}
 
 	if (btrtl_dev->ic_info->has_rom_version) {
@@ -610,6 +609,11 @@ int btrtl_download_firmware(struct hci_d
 	 * standard btusb. Once that firmware is uploaded, the subver changes
 	 * to a different value.
 	 */
+	if (!btrtl_dev->ic_info) {
+		rtl_dev_info(hdev, "rtl: assuming no firmware upload needed\n");
+		return 0;
+	}
+
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8723A:
 	case RTL_ROM_LMP_3499:


