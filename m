Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E33C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1802133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120578;
	bh=RluXyseXMQYFzo+kd6pyD1sdBCaQFakvt+G1DrV2/6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EqAa2AMxF1RD9Nij5O33QWnAT7zHJ9O1GHsO4qOvy4aChTGOIJJgozfUtHyj1ogin
	 zrougCQok/CvLOv6ZWknJ4PBq+dZU7yVKea21xatxdQcvVWRVusRRt4hcrIyGv8s4e
	 nYxrwMeU0ZW0gYh2KwQzC+Vp7831JpXpRnl+m6So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404404AbfJCQgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404384AbfJCQgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:36:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D71520830;
        Thu,  3 Oct 2019 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120572;
        bh=RluXyseXMQYFzo+kd6pyD1sdBCaQFakvt+G1DrV2/6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzuoZkwbJksAuwT7hWrq8dFOFOglZ0kiVWYHykKCjqgV3Gzya0UjadKa6prV8GZsD
         DtiIPvxpvfhT3kEOo435YUT7sL2hDti50Mzrx6xwGnXfiMBKlCT6vSi8cFHEcmtxH8
         cy8fkjYxlInImB2eChkSDmq7/DzBQYyE8RpuGJ+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.2 245/313] media: videobuf-core.c: poll_wait needs a non-NULL buf pointer
Date:   Thu,  3 Oct 2019 17:53:43 +0200
Message-Id: <20191003154557.160513583@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 6f51fdfd8229d5358c2d6e272cf73478866e8ddc upstream.

poll_wait uses &buf->done, but buf is NULL. Move the poll_wait to later
in the function once buf is correctly set and only call it if it is
non-NULL.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: bb436cbeb918 ("media: videobuf: fix epoll() by calling poll_wait first")
Cc: <stable@vger.kernel.org>      # for v5.1 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/videobuf-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/videobuf-core.c
+++ b/drivers/media/v4l2-core/videobuf-core.c
@@ -1123,7 +1123,6 @@ __poll_t videobuf_poll_stream(struct fil
 	struct videobuf_buffer *buf = NULL;
 	__poll_t rc = 0;
 
-	poll_wait(file, &buf->done, wait);
 	videobuf_queue_lock(q);
 	if (q->streaming) {
 		if (!list_empty(&q->stream))
@@ -1143,7 +1142,9 @@ __poll_t videobuf_poll_stream(struct fil
 		}
 		buf = q->read_buf;
 	}
-	if (!buf)
+	if (buf)
+		poll_wait(file, &buf->done, wait);
+	else
 		rc = EPOLLERR;
 
 	if (0 == rc) {


