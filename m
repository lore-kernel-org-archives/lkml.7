Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6194CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918A92245C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436583;
	bh=Omud9UZmBtqGj7SrMm7Par2Ho2glxFczkFyI3U1glN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vF4C6BWcNN6ABqLk0c6JpccniEn8UnUAH4wkqRPCo0qWdlzeNr1PVE008VsBtCpaQ
	 9MofeEdIOhh9AZ2CSSi8ZzRsGR1y3t5ID2+HxISD+NdeZalkKRuOe/btVovBuMtW2A
	 qZyw5Sn0BwQ3risrgt5VAwmKhC7Dg7BMt9erHbaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389164AbfJRWJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388696AbfJRWJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:09:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06A972245D;
        Fri, 18 Oct 2019 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436554;
        bh=Omud9UZmBtqGj7SrMm7Par2Ho2glxFczkFyI3U1glN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eaXCw7Eiwa/ojNJ1u00MQ4YpteNdxOhCFK35joQWbpRDSGCFBBZevbvf8udCJMFxM
         0eM/3Uedq6jh0+cIMei4XMjTo91slfbAGovlucE9bR0HtUpJlbFFiKS9NCY2bIUBKo
         AelI3v7HxCl2GylOtN797YngmmZXouk8PmkGDNo8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 52/56] USB: usb-skeleton: fix use-after-free after driver unbind
Date:   Fri, 18 Oct 2019 18:07:49 -0400
Message-Id: <20191018220753.10002-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6353001852776e7eeaab4da78922d4c6f2b076af ]

The driver failed to stop its read URB on disconnect, something which
could lead to a use-after-free in the completion handler after driver
unbind in case the character device has been closed.

Fixes: e7389cc9a7ff ("USB: skel_read really sucks royally")
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191009170944.30057-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/usb-skeleton.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index bb0bd732e29ab..2af5a9a0e189e 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -576,6 +576,7 @@ static void skel_disconnect(struct usb_interface *interface)
 	dev->interface = NULL;
 	mutex_unlock(&dev->io_mutex);
 
+	usb_kill_urb(dev->bulk_in_urb);
 	usb_kill_anchored_urbs(&dev->submitted);
 
 	/* decrement our usage count */
-- 
2.20.1

