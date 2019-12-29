Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0C4207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640924;
	bh=nFsxqlSW5MdU86iOP42+FaKJBOzsfHU8mpAvyNypAEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nw7rnEe3Hp7mL4CZxH6W6kRiI7vBEy4f4BsA/Eu568DXDOzd4P5DyQ6Ty8Ca3dQxq
	 yjMFDq7o+HVbf/qaNBbbu6PoSRilIlO0G7CRP3niL90Em2nc/MuyMDEDlRjg5IsWxp
	 VxMKdIQWKMf3QSSRkgMCsif5xL3mgersiqerP46M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfL2RfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729362AbfL2RfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:35:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7332207FF;
        Sun, 29 Dec 2019 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640917;
        bh=nFsxqlSW5MdU86iOP42+FaKJBOzsfHU8mpAvyNypAEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8tmatJ2ULk4TpY7w12TeOL0OPljzGbhyhrdSxnaFhAfBSCD2aPSEJ3uMTbCQMe6j
         BVoIay4iHghN0YCmzDi7bwuUiJkPSVqwA1CGazpzLwpuriyyaGI2yoneozkF+mPlbZ
         BVQ/RxITy2o3c8CL0QG0Khz/Ov6b9NDDHNrXWWuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 192/219] can: kvaser_usb: kvaser_usb_leaf: Fix some info-leaks to USB devices
Date:   Sun, 29 Dec 2019 18:19:54 +0100
Message-Id: <20191229162538.700059491@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaolong Huang <butterflyhuangxx@gmail.com>

commit da2311a6385c3b499da2ed5d9be59ce331fa93e9 upstream.

Uninitialized Kernel memory can leak to USB devices.

Fix this by using kzalloc() instead of kmalloc().

Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Cc: linux-stable <stable@vger.kernel.org> # >= v4.19
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -608,7 +608,7 @@ static int kvaser_usb_leaf_simple_cmd_as
 	struct kvaser_cmd *cmd;
 	int err;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -1140,7 +1140,7 @@ static int kvaser_usb_leaf_set_opt_mode(
 	struct kvaser_cmd *cmd;
 	int rc;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -1206,7 +1206,7 @@ static int kvaser_usb_leaf_flush_queue(s
 	struct kvaser_cmd *cmd;
 	int rc;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 


