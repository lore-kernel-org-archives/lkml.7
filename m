Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9476BC468BC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659AF216C4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560047418;
	bh=UQjHYwpwEpxknOaR7l2kXR4nTBTBcQRRbiviJ8rAIjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oev4o0y7EYmqAQ5E/Zk+AadnBk7ky3wnMNfGg/zl+2bjm62Q8XluBa7H9X9ffEz5C
	 QxOEhVShS7QRHmEXV807ZdQ6g7mp+pEz2evpiaS4BxGHdGqOsXdSjM1svBxVkyL0nU
	 JqPDPtRhuWtQG3RArsL6ch7QvM4NVzqf/oGmQer8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfFIC1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 22:27:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfFIC1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JZ87rVtdmY1eGd95PUVDy3tMWfEEw5cY4NhGsls2pmY=; b=ImsGyEdVwmdY18tprDQ8Qq31ae
        oXykcOQ6QYWkJizsOvePs52za/8CVmfBUfJRsgjzg6SJhR14Blf90U9OL2Hn3rPLFzGdaCXI+pB6u
        94vW6Gu9zcWbXU1qSN2XzXFBZwlJ/IyTDz914oeTFfbLQXBlHZ/v8VLrnmAVWD5j7eP8f3f3Fe7iw
        Dv0jGrii+sa9m1vAzeXx65oLKVo4YG0did7P38Vn0IK5HunLV9YOtlRUhbAlBqC8isOSFy3WnbBJ7
        7cxNyVpPTHxX3Lh+T1aq2QJVQEWNkAxkQ+cvbUgOfsb5tCAcVizTrwZADqrz4l4fmYQ7ugQ9mo5k4
        OlcPOkfA==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYO-0001mi-25; Sun, 09 Jun 2019 02:27:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYK-0000IU-UH; Sat, 08 Jun 2019 23:27:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 06/33] docs: cgroup-v1/blkio-controller.rst: add a note about CFQ scheduler
Date:   Sat,  8 Jun 2019 23:26:56 -0300
Message-Id: <6a36af686f9517d362c28424cfd0d3bd1729155b.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFQ scheduler was removed on this changeset:

  commit f382fb0bcef4c37dc049e9f6963e3baf204d815c
  Author: Jens Axboe <axboe@kernel.dk>
  Date:   Fri Oct 12 10:14:46 2018 -0600

    block: remove legacy IO schedulers

    Retain the deadline documentation, as that carries over to mq-deadline
    as well.

    Tested-by: Ming Lei <ming.lei@redhat.com>
    Reviewed-by: Omar Sandoval <osandov@fb.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

However, the cgroups-v1 documentation still mentions it and points
to a removed file that used to belong to such scheduler.

Add a note about that, as someone needs to fix the document pointing
to another scheduler, if cgroups-v1 blockio is not dependent of
CFQ scheduler.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/cgroup-v1/blkio-controller.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/cgroup-v1/blkio-controller.rst b/Documentation/cgroup-v1/blkio-controller.rst
index 2c1b907afc14..2836c2c31e63 100644
--- a/Documentation/cgroup-v1/blkio-controller.rst
+++ b/Documentation/cgroup-v1/blkio-controller.rst
@@ -17,6 +17,13 @@ one is throttling policy which can be used to specify upper IO rate limits
 on devices. This policy is implemented in generic block layer and can be
 used on leaf nodes as well as higher level logical devices like device mapper.
 
+.. note::
+
+   While this document mentions the CFQ scheduler, it got removed at
+   Kernel 4.20, as there are other schedulers that are more efficient.
+
+   Someone needs to update this file in order to reflect such change.
+
 HOWTO
 =====
 Proportional Weight division of bandwidth
-- 
2.21.0

