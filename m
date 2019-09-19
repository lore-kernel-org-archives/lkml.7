Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28C8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E5720678
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931374;
	bh=w0mXBtSUrIzsdWESWOJCWbodkrbx6BxZ6vrtYietXXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AG0IzdLr7kHcgYMusXKaVMpk3L43osh/aRjd59gXxMjXmHVNQOujTS6KkdQ/ICRSI
	 pxONyramQJVTvD32t2eXNKs4z3lj2aJZD0LYYnN83xFCHe0LKwlBCuOry7GYpUMfmS
	 67JABgseGazqlTMCL7gVOCi77oNX1s0ALDGIdClQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406290AbfISWQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406259AbfISWQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:16:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72CBE218AF;
        Thu, 19 Sep 2019 22:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931365;
        bh=w0mXBtSUrIzsdWESWOJCWbodkrbx6BxZ6vrtYietXXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s69kvgXa4MJVv7MsQROrpTF+LYgJNJMg+KmDWVJ9USm2GHauqsDWosuw2fCTUdpdZ
         027i0QU/qZ4CR08/Lmjfv5qCqZ/BeN+nm5/3UEEUllGx+/O1Wzp9DcZ4KsW/9Wl4ED
         rf/6W0PikEqxhuXv5yNGb/M+pSxQByHPrRMDXE9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 02/59] Input: elan_i2c - remove Lenovo Legion Y7000 PnpID
Date:   Fri, 20 Sep 2019 00:03:17 +0200
Message-Id: <20190919214756.510013600@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 0c043d70d04711fe6c380df9065fdc44192c49bf upstream.

Looks like the Bios of the Lenovo Legion Y7000 is using ELAN061B
when the actual device is supposed to be used with hid-multitouch.

Remove it from the list of the supported device, hoping that
no one will complain about the loss in functionality.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203467
Fixes: 738c06d0e456 ("Input: elan_i2c - add hardware ID for multiple Lenovo laptops")
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1274,7 +1274,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0618", 0 },
 	{ "ELAN0619", 0 },
 	{ "ELAN061A", 0 },
-	{ "ELAN061B", 0 },
+/*	{ "ELAN061B", 0 }, not working on the Lenovo Legion Y7000 */
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },


