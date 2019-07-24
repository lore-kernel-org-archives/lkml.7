Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E23C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD11F22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033498;
	bh=x5cBvB+ePUbEneL3+6RDnFsAOd6tOD2Z+cdqbyRCV1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UxtR75X+9JGnaPCXlGWmKrqBnT/Piz6scLQXEOQHbcBfOqinDew/BLcg3kGBwuNLT
	 kmv9cEbBd3GvxXJgDreGIk+xNChVJIfIyq6arQvTf8v8NKqtXkvKeLO/7RdQVyxt74
	 2kMt8r+21uGaDZjaPNVoGvJ0b3xdeabflghCSzUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbfGYFo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389267AbfGYFoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:44:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C0421880;
        Thu, 25 Jul 2019 05:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033494;
        bh=x5cBvB+ePUbEneL3+6RDnFsAOd6tOD2Z+cdqbyRCV1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/A76aSmEf6vQoHOT3Mz0ISW/0CXLXH+/POUGgsh1McHfGOOs4Wnr9CZWiA4nDa9l
         s62ViNTpgZdvB0WZx5zbo4gKXGtpBK/oYym5NtWmbubi6/7eCTh6Ceb01nL4LJh+Bw
         51z3nuS1rndMinZUIxlB6cmHfCQrvIjPsds8A6J8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 211/271] media: videobuf2-core: Prevent size alignment wrapping buffer size to 0
Date:   Wed, 24 Jul 2019 21:21:20 +0200
Message-Id: <20190724191713.170404340@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit defcdc5d89ced780fb45196d539d6570ec5b1ba5 upstream.

PAGE_ALIGN() may wrap the buffer size around to 0. Prevent this by
checking that the aligned value is not smaller than the unaligned one.

Note on backporting to stable: the file used to be under
drivers/media/v4l2-core, it was moved to the current location after 4.14.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/common/videobuf2/videobuf2-core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -207,6 +207,10 @@ static int __vb2_buf_mem_alloc(struct vb
 	for (plane = 0; plane < vb->num_planes; ++plane) {
 		unsigned long size = PAGE_ALIGN(vb->planes[plane].length);
 
+		/* Did it wrap around? */
+		if (size < vb->planes[plane].length)
+			goto free;
+
 		mem_priv = call_ptr_memop(vb, alloc,
 				q->alloc_devs[plane] ? : q->dev,
 				q->dma_attrs, size, q->dma_dir, q->gfp_flags);


