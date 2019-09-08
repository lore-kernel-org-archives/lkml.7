Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7509AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 11:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF24207FC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 11:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfIHLFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 07:05:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbfIHLFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 07:05:45 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D635C00A172
        for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2019 11:05:45 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id q12so12587051qkm.22
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 04:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mJ79VyQiPMiGxBu7/NgWOAdwnTdH8zf8E/dxV83oJIQ=;
        b=fbEE39ZFqz4yRfD4msnBIQxDNJLdYjah2QHF54GLVUpIucX/Q+MC9gFx6cXCzB/n5P
         DcD/6yLHsPYC5HiQZEw0jlxaciYVbeyjaqBIinJZX4raSmFs5zBru0iDHCq/JdhaWx6M
         5wmNHbsZ2mxlq1c0dn3+W3bqHOKuf+L4woiLTT5HwmooU9lzZnXnc8TSs4Bl1YmAufuU
         I9I8KxHa1HLHonjwoOpzr7FXyLOhmWfI/6Z40DpU+lj6Y0Allyy2BBCxkmO8wWH66jTD
         9ylmvWT5E0X7EZNRFRUeVK+USlO8xsmNyuOrk+bBrEO8u2RPMDpjZM1H0a5j7xbVZplI
         viuQ==
X-Gm-Message-State: APjAAAUCmbdsbP2irI5WQ/AkyUMOqzYA/Nd305m+Y7WfyCUNIBiP4n2V
        zpyUg9ZldwsYHRScCuk6qkYGQsv9dYhFuGGIVcd8cHWjqas5H1Q6+ZYHscop4uVii2Gpd7TkQhu
        lv9mN2TovmIAVEivGbv2hN0pM
X-Received: by 2002:ac8:845:: with SMTP id x5mr18054487qth.42.1567940744062;
        Sun, 08 Sep 2019 04:05:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWSBaHX6xbj2IMf12T1d2jOLe4XYAW+o7heTvxil6hRKkUH9dOz/sVHUORF99wcOY9BFlSSQ==
X-Received: by 2002:ac8:845:: with SMTP id x5mr18054478qth.42.1567940743938;
        Sun, 08 Sep 2019 04:05:43 -0700 (PDT)
Received: from redhat.com ([212.92.124.241])
        by smtp.gmail.com with ESMTPSA id 139sm5217532qkf.14.2019.09.08.04.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 04:05:43 -0700 (PDT)
Date:   Sun, 8 Sep 2019 07:05:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC PATCH untested] vhost: block speculation of translated
 descriptors
Message-ID: <20190908110521.4031-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iovec addresses coming from vhost are assumed to be
pre-validated, but in fact can be speculated to a value
out of range.

Userspace address are later validated with array_index_nospec so we can
be sure kernel info does not leak through these addresses, but vhost
must also not leak userspace info outside the allowed memory table to
guests.

Following the defence in depth principle, make sure
the address is not validated out of node range.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5dc174ac8cac..0ee375fb7145 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2072,7 +2072,9 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 		size = node->size - addr + node->start;
 		_iov->iov_len = min((u64)len - s, size);
 		_iov->iov_base = (void __user *)(unsigned long)
-			(node->userspace_addr + addr - node->start);
+			(node->userspace_addr +
+			 array_index_nospec(addr - node->start,
+					    node->size));
 		s += size;
 		addr += size;
 		++ret;
-- 
MST
