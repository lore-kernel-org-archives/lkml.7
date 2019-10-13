Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD6ECE596
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EC22084D
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfJMIIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:08:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbfJMIIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 04:08:19 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22BDFC0568FD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 08:08:19 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id b67so13794113qkc.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 01:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CYitd93iDHtPl2boSl3Eyofj0PvtzXYhyw7uXbmPmo=;
        b=OZBN9alIHs8/HWXKKwWmMtBWOJ61ejcMypG505I6c1FJAGp0KbLHkDQOUBBvpo6M0U
         rJHaVD2dqc6qFlETnP3R1fkr89sHpteHLcUb+jsYVVhvu75wSpbNBkzJe7yP+xHfYlYx
         arOC0GII2FcOe9MPu8Ex+a42kFPOmgyYqXRv/4bGT5JzOP6XXqhlk9dKKcFwIrIwJB9t
         K15bYFxu5D1L5LYnUG0m0uuRe7unZjzXeWHZQhY7pxF61kHqBrF7WroPl0X3b2JdGEBM
         TJuOsaQZsgqRymoLP2gczchVO56TW1IV31WQ9tADRSyrPaZiEkuK9VqQ9u0DJJHmEkYe
         Hscw==
X-Gm-Message-State: APjAAAVPNyC3z5KFOjNoXx7QFACbytNfv4clqX5G10ZtSeYHBVMTPWxU
        parT8T1kRNFMVELqavCYiM7C+isDV6WOYw0WHw1Cg0Ur3KYHBPwc+ittcQgQhfSdlL+Abzq5VSq
        pznBV3SFI7oehwsgNHoqOTAac
X-Received: by 2002:a37:9d10:: with SMTP id g16mr24681937qke.29.1570954098118;
        Sun, 13 Oct 2019 01:08:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyaJ+QpLI1pMBCIJvuv7x0tuYvQpGl6FL4TAAJwm3gJXchv9/ST+/UasjDNh9TYNk8GtdJuXQ==
X-Received: by 2002:a37:9d10:: with SMTP id g16mr24681925qke.29.1570954097874;
        Sun, 13 Oct 2019 01:08:17 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id f10sm6455018qtj.3.2019.10.13.01.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 01:08:17 -0700 (PDT)
Date:   Sun, 13 Oct 2019 04:08:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC v3 4/4] vhost/net: add an option to test new code
Message-ID: <20191013080742.16211-5-mst@redhat.com>
References: <20191013080742.16211-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013080742.16211-1-mst@redhat.com>
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
 drivers/vhost/net.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 1a2dd53caade..122b666ec1f2 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -35,6 +35,9 @@
 
 #include "vhost.h"
 
+static int newcode = 0;
+module_param(newcode, int, 0644);
+
 static int experimental_zcopytx = 0;
 module_param(experimental_zcopytx, int, 0444);
 MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
@@ -565,8 +568,14 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 	struct vhost_virtqueue *rvq = &rnvq->vq;
 	struct vhost_virtqueue *tvq = &tnvq->vq;
 
-	int r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
-				  out_num, in_num, NULL, NULL);
+	int r;
+
+	if (newcode)
+		r = vhost_get_vq_desc_batch(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
+					    out_num, in_num, NULL, NULL);
+	else
+		r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
+				      out_num, in_num, NULL, NULL);
 
 	if (r == tvq->num && tvq->busyloop_timeout) {
 		/* Flush batched packets first */
@@ -575,8 +584,12 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 
 		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
 
-		r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
-				      out_num, in_num, NULL, NULL);
+		if (newcode)
+			r = vhost_get_vq_desc_batch(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
+						    out_num, in_num, NULL, NULL);
+		else
+			r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
+					      out_num, in_num, NULL, NULL);
 	}
 
 	return r;
@@ -1046,9 +1059,14 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 			r = -ENOBUFS;
 			goto err;
 		}
-		r = vhost_get_vq_desc(vq, vq->iov + seg,
-				      ARRAY_SIZE(vq->iov) - seg, &out,
-				      &in, log, log_num);
+		if (newcode)
+			r = vhost_get_vq_desc_batch(vq, vq->iov + seg,
+						    ARRAY_SIZE(vq->iov) - seg, &out,
+						    &in, log, log_num);
+		else
+			r = vhost_get_vq_desc(vq, vq->iov + seg,
+					      ARRAY_SIZE(vq->iov) - seg, &out,
+					      &in, log, log_num);
 		if (unlikely(r < 0))
 			goto err;
 
-- 
MST

