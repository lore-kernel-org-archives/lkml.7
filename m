Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAD6C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585B1207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfJMLmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 07:42:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfJMLmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 07:42:14 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1B2883F3E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:42:13 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id z12so14904596qtn.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 04:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ls+7nvLzVD/C5D5VX4czbgip7cBCYdFDThqPFhQtYcU=;
        b=Dma/46RoyE/SRFXCGUw0SNOyBBaUFWmoGgwSrwKGSro6x6umMvXxlUEsEcnFrjEJmn
         x0QCzO9gd/CIEatD0JUOUsyatd/j3EdU08dySlF9MHb9VPXVVRzToviTGcS5ZV6NzF9o
         2TxxT1agko6HCK92iMiLA5uOJNcrLbfPIKW82cY284gtuuCO9B1z93mt8eSQgWpiJ71c
         C4SbIrs6UMNC9na9zH9AK55k7vaaajJLsihnjCAyqDjkdgmEGLBnQ7CFQzLNES2OL8pb
         jkGKWktptW5basBNkla4Phtd7kB45/zyb4n+YkthstBhs9jbezBR9y0X/1FYm+s/nVpo
         N57w==
X-Gm-Message-State: APjAAAV/wepV4Fp4QPzr/Nocm2RG83/8HxKZW/rW4A0l1cQNIDD5wntl
        MszUJlmhpFZ3MLEX+lHHOigoyAKu+/Sxo6raJF1UyWGVhn7TsC/5HG60V6c0w3OTta7VrVcLFa9
        1DIYc/4Rngj8xAmmrXQvIlAye
X-Received: by 2002:a0c:fc4a:: with SMTP id w10mr26413622qvp.46.1570966932888;
        Sun, 13 Oct 2019 04:42:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzk+MzrwJBp1s36w10kcHkZ3zHXuqofxfxn+xexQgdtQjVvG9LWQNytw8VUoM650ZyCDUjTNw==
X-Received: by 2002:a0c:fc4a:: with SMTP id w10mr26413597qvp.46.1570966932473;
        Sun, 13 Oct 2019 04:42:12 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id g33sm6728182qtd.12.2019.10.13.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 04:42:11 -0700 (PDT)
Date:   Sun, 13 Oct 2019 07:42:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC v4 2/5] vhost/test: add an option to test new code
Message-ID: <20191013113940.2863-3-mst@redhat.com>
References: <20191013113940.2863-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013113940.2863-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a writeable module parameter that tests
the new code. Note: no effort was made to ensure
things work correctly if the parameter is changed
while the device is open. Make sure to
close the device before changing its value.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 056308008288..39a018a7af2d 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -18,6 +18,9 @@
 #include "test.h"
 #include "vhost.h"
 
+static int newcode = 0;
+module_param(newcode, int, 0644);
+
 /* Max number of bytes transferred before requeueing the job.
  * Using this limit prevents one virtqueue from starving others. */
 #define VHOST_TEST_WEIGHT 0x80000
@@ -58,10 +61,16 @@ static void handle_vq(struct vhost_test *n)
 	vhost_disable_notify(&n->dev, vq);
 
 	for (;;) {
-		head = vhost_get_vq_desc(vq, vq->iov,
-					 ARRAY_SIZE(vq->iov),
-					 &out, &in,
-					 NULL, NULL);
+		if (newcode)
+			head = vhost_get_vq_desc_batch(vq, vq->iov,
+						       ARRAY_SIZE(vq->iov),
+						       &out, &in,
+						       NULL, NULL);
+		else
+			head = vhost_get_vq_desc(vq, vq->iov,
+						 ARRAY_SIZE(vq->iov),
+						 &out, &in,
+						 NULL, NULL);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
-- 
MST

