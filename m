Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6210AC43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B04320718
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573918893;
	bh=OS/5XB3eSaY5RKOQ6B/n+XCJ2R6bB2P+uS/f2k4ORzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z6K1+k6dru3OIXHXIbRqdFxAlp7eOHhTbSjfdUHTmWQlNKPbsQjD2D2Xs8mRcjdU2
	 3UWa9I8i8NoL9Wgy3UDTvozrpzrJvNNjsS+TXFDrDj8YTtl7BWiGEBc7Um2l3+565b
	 ZdBlUSLdHaOXfyhUMmCf6f54Lch+tiVpwxYL9bH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfKPPlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:41:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfKPPlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:41:25 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB6B20748;
        Sat, 16 Nov 2019 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918885;
        bh=OS/5XB3eSaY5RKOQ6B/n+XCJ2R6bB2P+uS/f2k4ORzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vT80DI2Ifn5+zhwS3dR3RXRmzyu6iyHbpxkaCoDnW5Hrhzb33g2kA1lL1c/BROmAb
         mRNaeEZT9Aok1HpEhO6H8skE1e3WsDj/Dpb/wMr0x0h5HFWuU7Y6LZibcRoZlIDCTp
         Oy1sAuwjbBwLVibV2LDGc5az1ptKy2YULYfI93W4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 013/237] powerpc/eeh: Fix null deref for devices removed during EEH
Date:   Sat, 16 Nov 2019 10:37:28 -0500
Message-Id: <20191116154113.7417-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit bcbe3730531239abd45ab6c6af4a18078b37dd47 ]

If a device is removed during EEH processing (either by a driver's
handler or as part of recovery), it can lead to a null dereference
in eeh_pe_report_edev().

To handle this, skip devices that have been removed.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh_driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 110eba400de7c..af1f3d5f9a0f7 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -281,6 +281,10 @@ static void eeh_pe_report_edev(struct eeh_dev *edev, eeh_report_fn fn,
 	struct pci_driver *driver;
 	enum pci_ers_result new_result;
 
+	if (!edev->pdev) {
+		eeh_edev_info(edev, "no device");
+		return;
+	}
 	device_lock(&edev->pdev->dev);
 	if (eeh_edev_actionable(edev)) {
 		driver = eeh_pcid_get(edev->pdev);
-- 
2.20.1

