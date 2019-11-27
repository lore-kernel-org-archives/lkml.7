Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071DD20665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890206;
	bh=OS/5XB3eSaY5RKOQ6B/n+XCJ2R6bB2P+uS/f2k4ORzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+eqRF4Ny6D0l1i8ck9moSC4kh0vYxLlyYPx8AGwMoUKN4YUbdY63E6QQfMOwg4A9
	 65jyh7TRjur9sBFoWGga/fboNmIVwZnegeBSgbUblrhs+HZzy7HMR5jg+zZx6JEFKD
	 qtyuEg2ytQbyuDiPKag5hpdLLkuK4lV9gHhBunh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfK0VaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfK0U4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:56:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CFD2154A;
        Wed, 27 Nov 2019 20:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888177;
        bh=OS/5XB3eSaY5RKOQ6B/n+XCJ2R6bB2P+uS/f2k4ORzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOy/pBi1JtH0H6tGCHDTXcciCSDRHbLE7kOhbW6svNcmE6vlom+AmrYtYk3WyCr6L
         g61LLmKXQhGS/6kB1krG9A5xaKz6NIY/EygEGdysPhnTzyKkr05Megn6z0Rz5lOToF
         XbrnsXwnHb/y/c1+VjdbGNvJhTTJmirIQZ/M5oZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/306] powerpc/eeh: Fix null deref for devices removed during EEH
Date:   Wed, 27 Nov 2019 21:28:04 +0100
Message-Id: <20191127203117.281953759@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



