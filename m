Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427D8C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FF721773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738480;
	bh=C3IWzlRtRf4b6O3G4UKsS5i+1WN40DdoSwQNpZ1eJLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HK7hYA65mjeb5X0et6V/gj1idO1btF4tmDPOdwDjgjSDDP5Qb9KIsMU1lB0pLI4AS
	 rKKT7hDIQa8VMlfDMtkaNqez4nTrKGlcuAjhhTGNPDdZ3u0s+QDJCJX31VRFv9Mz2r
	 paTGE7C2ag9FO0tlZHgqdCTwdVNWKGx38TZldRZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391363AbfHBJei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390754AbfHBJef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:34:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF3721773;
        Fri,  2 Aug 2019 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738474;
        bh=C3IWzlRtRf4b6O3G4UKsS5i+1WN40DdoSwQNpZ1eJLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNDdlWCdnjmewhw76JjtGScwcJbYSYPmI0NEAD/Z3IGtYVgdvgxmomDH0yUDR+I/l
         v57E//9rY2JYu33JbuC7KyU6k5LDpZH+w0jFXeohNKXnKIqOsH8RXt43fjxKPhOCGg
         ncs0i6lmLUrSx2utSNaCpfuQLuifg4r60BOvWWeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 118/158] usb: gadget: Zero ffs_io_data
Date:   Fri,  2 Aug 2019 11:28:59 +0200
Message-Id: <20190802092227.978374303@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 508595515f4bcfe36246e4a565cf280937aeaade ]

In some cases the "Allocate & copy" block in ffs_epfile_io() is not
executed. Consequently, in such a case ffs_alloc_buffer() is never called
and struct ffs_io_data is not initialized properly. This in turn leads to
problems when ffs_free_buffer() is called at the end of ffs_epfile_io().

This patch uses kzalloc() instead of kmalloc() in the aio case and memset()
in non-aio case to properly initialize struct ffs_io_data.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 4800bb22cdd6..4cb1355271ec 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -912,11 +912,12 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	ENTER();
 
 	if (!is_sync_kiocb(kiocb)) {
-		p = kmalloc(sizeof(io_data), GFP_KERNEL);
+		p = kzalloc(sizeof(io_data), GFP_KERNEL);
 		if (unlikely(!p))
 			return -ENOMEM;
 		p->aio = true;
 	} else {
+		memset(p, 0, sizeof(*p));
 		p->aio = false;
 	}
 
@@ -948,11 +949,12 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 	ENTER();
 
 	if (!is_sync_kiocb(kiocb)) {
-		p = kmalloc(sizeof(io_data), GFP_KERNEL);
+		p = kzalloc(sizeof(io_data), GFP_KERNEL);
 		if (unlikely(!p))
 			return -ENOMEM;
 		p->aio = true;
 	} else {
+		memset(p, 0, sizeof(*p));
 		p->aio = false;
 	}
 
-- 
2.20.1



