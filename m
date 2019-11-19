Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A14FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92BA20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143289;
	bh=KmV30vfzaz3Zgwoqs9ty1PdCpMMPsXaQ232gg+9G3SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m4RxxEg38OtyTGnrY/+yLNnCJkEqYhWNGoD9z5wwoWzVqGSvE3ptPsl8GEsbrp8zd
	 vvbEi1cj0UPkWUDhnVMu88blwS4jMCdbC1OWa3LMHifkiI3gGGEQn69i4iyW9jZk6J
	 aff5KUNR3uxc6dSKDWKVsf+flEqJ0fR63uz7dA60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfKSGB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbfKSFn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:43:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54E12075E;
        Tue, 19 Nov 2019 05:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142238;
        bh=KmV30vfzaz3Zgwoqs9ty1PdCpMMPsXaQ232gg+9G3SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajFhIdC+f5eEfCddybifMW/9q4nq4HawPHKMUh+dgV06kcuqBK1qg6DBXuMeMDfsk
         y6ABFn8OV3NXcSJpSXm35Qet7PXEqeKWyOdgNRkmIBZESYiIBzrO0/OygrzFlaVc6N
         7tgFQKR21i3/b2hbmpq6H38XCNBIZTcfWuFwGLgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 014/239] Input: synaptics-rmi4 - fix video buffer size
Date:   Tue, 19 Nov 2019 06:16:54 +0100
Message-Id: <20191119051300.525947402@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

commit 003f01c780020daa9a06dea1db495b553a868c29 upstream.

The video buffer used by the queue is a vb2_v4l2_buffer, not a plain
vb2_buffer. Using the wrong type causes the allocation of the buffer
storage to be too small, causing a out of bounds write when
__init_vb2_v4l2_buffer initializes the buffer.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191104114454.10500-1-l.stach@pengutronix.de
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/rmi4/rmi_f54.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -362,7 +362,7 @@ static const struct vb2_ops rmi_f54_queu
 static const struct vb2_queue rmi_f54_queue = {
 	.type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
 	.io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ,
-	.buf_struct_size = sizeof(struct vb2_buffer),
+	.buf_struct_size = sizeof(struct vb2_v4l2_buffer),
 	.ops = &rmi_f54_queue_ops,
 	.mem_ops = &vb2_vmalloc_memops,
 	.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC,


