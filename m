Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5714C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FC1214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997120;
	bh=90uT0hQzl2ry1AVARiOZO395TTaUxfa8Y/uH8XxG6uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sjo6GZdYYJuOIFGsG5IhFPpkV/4MGXJJbTIQ8NiVDFv1Dy5EkVhVlKQgOplyYcBHH
	 6f5+I0fFWL90YNEyzOv1SwrIPKvf3CG2cnRqCDB/QF4wkAbRoc420YMCUPwh92QM4v
	 itNuU51+r++KrCnuQNSsrwTJtwfc/628Sp8fSxIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389659AbfGXTij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389786AbfGXTig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:38:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A560214AF;
        Wed, 24 Jul 2019 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997115;
        bh=90uT0hQzl2ry1AVARiOZO395TTaUxfa8Y/uH8XxG6uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wiokfxlZO0Fej6KELXuICW9XjxaY2+59ySFgv8iXIbRTkTNvF6PCkaOv083d4jUr7
         QGHyM9MibMlljWgDqIgerGUydpUAzMqbKKCMLmOHKqC2jxO28C1M1d1JXzTcaI/sL3
         5aHQyYwnj9pzruuyV1L1J35wnNgfhvi3RaunionM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.2 325/413] media: videobuf2-dma-sg: Prevent size from overflowing
Date:   Wed, 24 Jul 2019 21:20:16 +0200
Message-Id: <20190724191759.125108615@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 14f28f5cea9e3998442de87846d1907a531b6748 upstream.

buf->size is an unsigned long; casting that to int will lead to an
overflow if buf->size exceeds INT_MAX.

Fix this by changing the type to unsigned long instead. This is possible
as the buf->size is always aligned to PAGE_SIZE, and therefore the size
will never have values lesser than 0.

Note on backporting to stable: the file used to be under
drivers/media/v4l2-core, it was moved to the current location after 4.14.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -59,7 +59,7 @@ static int vb2_dma_sg_alloc_compacted(st
 		gfp_t gfp_flags)
 {
 	unsigned int last_page = 0;
-	int size = buf->size;
+	unsigned long size = buf->size;
 
 	while (size > 0) {
 		struct page *pages;


