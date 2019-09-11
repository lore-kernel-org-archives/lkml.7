Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3127C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40DB222BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfIKMKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:10:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbfIKMKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:10:06 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A31DEAC5F9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 12:10:06 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id c8so9545684qtd.20
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 05:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nO3SYHGDRWEzxT3/abFXM0Gu89GIuWvlxuxu/SDZ8iw=;
        b=NaV3wCE/DPhHR4bkVPOTvmbtXcsFAV6J2C59Ou87gH4y91I+2rVPV1GvlQcyn+aP7I
         3oHszQFjMZ9DhpDFMM+UE62UjlrYJaFq4fiWQn/k1gio+2tu3PQYmzn6ZzRZHR0SdGsx
         Oc2EHiYdP7UuTxjdzHwrdGsh8X1JLAdhBFpnBZdLkPwfOTvq3uoemlELTRS6R+8kv09T
         qzRnE1PtoXfNxsPOlSv32vyQAIf3cQnnAO+fTGmT1SreI6vAYV0j0X3d+VAy52Wr71y6
         XbJkrubSuQjQS77JBAHrFVmVKzg4DbmlRDBD9LRvxlf1PRh9w1gq4YE0jAPahJk56Ey7
         zMQQ==
X-Gm-Message-State: APjAAAU7EzExwGUwsTE1FXWd2VeCRLalg3M2P8A6tVdr8naP5ZiWUu6k
        ustbFKxviTV25/AZMV2odKLPfXwutQssrpKBlQc3lpghFHo9mekdAeUziIsxoyIbojEmuHuWpWw
        YYDFM3IxEHGf2gGMbDlQJVbPs
X-Received: by 2002:ad4:5494:: with SMTP id q20mr21893382qvy.8.1568203805669;
        Wed, 11 Sep 2019 05:10:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpfN8qjonuIyL61v7mAfTW2LcQ+Fqop0jhY4LwumZnvN9ZVZG/z8lBS94ag/ZEibKr7bFsQA==
X-Received: by 2002:ad4:5494:: with SMTP id q20mr21893369qvy.8.1568203805473;
        Wed, 11 Sep 2019 05:10:05 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id h29sm12975276qtb.46.2019.09.11.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 05:10:04 -0700 (PDT)
Date:   Wed, 11 Sep 2019 08:10:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v2] vhost: block speculation of translated descriptors
Message-ID: <20190911120908.28410-1-mst@redhat.com>
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
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Jason Wang <jasowang@redhat.com>
---

changes from v1: fix build on 32 bit

 drivers/vhost/vhost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5dc174ac8cac..34ea219936e3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2071,8 +2071,10 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 		_iov = iov + ret;
 		size = node->size - addr + node->start;
 		_iov->iov_len = min((u64)len - s, size);
-		_iov->iov_base = (void __user *)(unsigned long)
-			(node->userspace_addr + addr - node->start);
+		_iov->iov_base = (void __user *)
+			((unsigned long)node->userspace_addr +
+			 array_index_nospec((unsigned long)(addr - node->start),
+					    node->size));
 		s += size;
 		addr += size;
 		++ret;
-- 
MST
