Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F50C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B962082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053958;
	bh=HJaYIRQbEsz5NDstb/O2VfR5UOkNscug82Nvcx9Puqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MtBbE5jQr1ElC5q5VWWFtN3+0O5S1hqaL1csSIhwdvcsXjY5ka4YUblWC9Rt5F/GJ
	 nNq1KeA541P9zgxafmUBtNvOUxwjHC3igYeRpZmbQe4ko7c/wHitrSlSQ8UxHm+y0q
	 vIQS3O0X3DTiETYdcOcb65qJ4HP5ZymEzHFmLv/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfFTSF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfFTSFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:05:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134BB204FD;
        Thu, 20 Jun 2019 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053953;
        bh=HJaYIRQbEsz5NDstb/O2VfR5UOkNscug82Nvcx9Puqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFNWdPex0b/3IzYLHHfi1MuBgZlAWhbi2nZA759vV6y5T1o/xDSXkmJ1Dybnm5ywn
         lqBWbWP+U+phu7Mm4SNBB1Gq4sDqoe8EVUz2OSYDryCiRFedVmojenmj/TzrYTU884
         SKeqYj5aLgbcG7QpN7tQ2+cD5F3sZT0YqT+gml+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 4.9 085/117] USB: usb-storage: Add new ID to ums-realtek
Date:   Thu, 20 Jun 2019 19:56:59 +0200
Message-Id: <20190620174357.302728119@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 1a6dd3fea131276a4fc44ae77b0f471b0b473577 upstream.

There is one more Realtek card reader requires ums-realtek to work
correctly.

Add the device ID to support it.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_realtek.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/storage/unusual_realtek.h
+++ b/drivers/usb/storage/unusual_realtek.h
@@ -29,6 +29,11 @@ UNUSUAL_DEV(0x0bda, 0x0138, 0x0000, 0x99
 		"USB Card Reader",
 		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
 
+UNUSUAL_DEV(0x0bda, 0x0153, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
 UNUSUAL_DEV(0x0bda, 0x0158, 0x0000, 0x9999,
 		"Realtek",
 		"USB Card Reader",


