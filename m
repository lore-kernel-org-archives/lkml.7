Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1543DC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205923400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620233;
	bh=Q0AghjGYEW8gpI/1NW+PF1mfec5wXa2psBdGkgErjhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IweW7YWQdlebTIxdB3JIPOhbYVRaiFlMujBcRjjidFOaX0kLcAYGlen1bLjbKmzop
	 /K8vIIUNgu9PJiQIGNEgCtk3F1u8TrnFDcYncOldommscRjxiz+cJxlz/WMp3LrIS8
	 Fm2tBU3EiNgREPbbCGe4SM3msBov3NxrbEIxE/z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389023AbfIDSDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387901AbfIDSDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:03:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4758E22CF7;
        Wed,  4 Sep 2019 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620230;
        bh=Q0AghjGYEW8gpI/1NW+PF1mfec5wXa2psBdGkgErjhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJSiMN+5l4w/3YZPs86SSc6vTt7keHwrqYDEia5RT2EQ99wHIjEWdzsPhDTfinzCS
         8CazQnZFILp6rGKJTtDUArp7l/I5ZtDpxeMgr8INL0qOmm68xBqFiKWptTF14D4A2G
         u5nCd6qMHVAAYaW31FHzrKLbFyJMH2HQUxnZghaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.14 37/57] USB: storage: ums-realtek: Whitelist auto-delink support
Date:   Wed,  4 Sep 2019 19:54:05 +0200
Message-Id: <20190904175305.684917773@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 1902a01e2bcc3abd7c9a18dc05e78c7ab4a53c54 upstream.

Auto-delink requires writing special registers to ums-realtek devices.
Unconditionally enable auto-delink may break newer devices.

So only enable auto-delink by default for the original three IDs,
0x0138, 0x0158 and 0x0159.

Realtek is working on a patch to properly support auto-delink for other
IDs.

BugLink: https://bugs.launchpad.net/bugs/1838886
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190827173450.13572-2-kai.heng.feng@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/realtek_cr.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -1009,12 +1009,15 @@ static int init_realtek_cr(struct us_dat
 			goto INIT_FAIL;
 	}
 
-	if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
-	    CHECK_FW_VER(chip, 0x5901))
-		SET_AUTO_DELINK(chip);
-	if (STATUS_LEN(chip) == 16) {
-		if (SUPPORT_AUTO_DELINK(chip))
+	if (CHECK_PID(chip, 0x0138) || CHECK_PID(chip, 0x0158) ||
+	    CHECK_PID(chip, 0x0159)) {
+		if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
+				CHECK_FW_VER(chip, 0x5901))
 			SET_AUTO_DELINK(chip);
+		if (STATUS_LEN(chip) == 16) {
+			if (SUPPORT_AUTO_DELINK(chip))
+				SET_AUTO_DELINK(chip);
+		}
 	}
 #ifdef CONFIG_REALTEK_AUTOPM
 	if (ss_en)


