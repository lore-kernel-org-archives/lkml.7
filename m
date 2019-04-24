Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5428D21907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127410;
	bh=D0wtS1wfNcAyQ1/alBeQcMQWGJVTA4+qLceu7y7b4Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yE77676u3OG/kRwHFoWr8yrXR+ujnHyjAZ1CNhHicaIe3UcNotDScTf6ojVffhVXL
	 n5/xj5fXm33vnNeWhnp5q3YtdIYrxPZiYbEGFbvJN6ty4U2UHkmXFgDeqQQHuny1Q9
	 lB4ACrOOLNOJM9lubkdHvZifZ7jUEuBsHnbk8qfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392175AbfDXRgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392096AbfDXRgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:43 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2542054F;
        Wed, 24 Apr 2019 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127402;
        bh=D0wtS1wfNcAyQ1/alBeQcMQWGJVTA4+qLceu7y7b4Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmXMTKHVrzqo64PiSAtAVQ/gff54ZJuaV7AAHK8XyXLy7gnA4po3JMBpeAXfYnZ9Z
         lrhn5UOmziRVdvxCQgG6ZssC20wjg+LE7tXgjSc1A5ut5ov5EhYZQ7r5AE6wKuQJy5
         K8gZGlQrjBPxVgGce5Z4NxFOYn7pl1OAHi4q/rhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Brezillon <bbrezillon@kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 5.0 079/115] i3c: Fix the verification of random PID
Date:   Wed, 24 Apr 2019 19:10:15 +0200
Message-Id: <20190424170929.616582237@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitor Soares <vitor.soares@synopsys.com>

commit 9752c37cc89f43675e70cf9acff23519fa84b48c upstream.

The validation of random PID should be done by checking the
boardinfo->pid instead of info.pid which is empty.

Doing the change the info struture declaration is no longer necessary.

Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <stable@vger.kernel.org>
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i3c/master.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1980,7 +1980,6 @@ of_i3c_master_add_i3c_boardinfo(struct i
 {
 	struct i3c_dev_boardinfo *boardinfo;
 	struct device *dev = &master->dev;
-	struct i3c_device_info info = { };
 	enum i3c_addr_slot_status addrstatus;
 	u32 init_dyn_addr = 0;
 
@@ -2012,8 +2011,8 @@ of_i3c_master_add_i3c_boardinfo(struct i
 
 	boardinfo->pid = ((u64)reg[1] << 32) | reg[2];
 
-	if ((info.pid & GENMASK_ULL(63, 48)) ||
-	    I3C_PID_RND_LOWER_32BITS(info.pid))
+	if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
+	    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
 		return -EINVAL;
 
 	boardinfo->init_dyn_addr = init_dyn_addr;


