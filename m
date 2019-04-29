Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D2C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB51B21670
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZTXwB3qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfD2UQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:16:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36123 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbfD2UQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:16:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so922304wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3D2hgpqHMF7kzr2+nWYXGMvBMFX9zuYhDVKkxyQa+jY=;
        b=ZTXwB3qQ3O7GgJpoToBUHpQ/1MjEQUYs6ONq7YMdNVpznk/xHw0iTQZgXhtw4H5bzj
         OpteffM67ha2r2JufThqCE1IJdb2vlnl1HYfvU8Nh/T7d1wzyYZoQF64jz2jwpwhw89i
         QwrP3wAzWWOQ2n4ka4fbW0Ulv+5+mukpZEJiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3D2hgpqHMF7kzr2+nWYXGMvBMFX9zuYhDVKkxyQa+jY=;
        b=jrhQqz6gg4N65qSAFA2m0LTf2AtvZVcgG146TrNnWMDnPwvLkqOpzxyPAoc2ptbsSF
         jLmq+eXRJXebxG4uUF6BIVqc5CYBgmj0pjrBu8JWeNjgTFHlp+ni8rRnxy0Wn7hUomTL
         Nmy5jaYMUlnFoe9omClYMXW+KDfmaTUbJYoAK4UOj3LzoTnOHpC1LARRgqDQ5PdfX5ep
         eLFFoYM4arfcA/1Cl2ZejY/sVOQN9gXKJm6JrVKCfiOkfkV46fKKx+zI/CJiSKXY0HJ7
         Eh+64OJhjj9Ub4GTmsJkJhzSGm/BP8VGdVDmYxKZgM1i0ig8DZAx5IESUQCWyB58w/4B
         X9Vg==
X-Gm-Message-State: APjAAAUYHQaulcZNTrA4Yh3DtbCiS1gWtBwUPYtZbtHJaaPX0r/6Rb/4
        zTZkYK2UBqwsLZ/mGyYcb8Czr4lcBfk=
X-Google-Smtp-Source: APXvYqwVu1h/SWFMhK3gj/aqga6R6hNG9QoPKzFnGoYB3o3Vj5sVqISj0973gLaYlYbSFD7vEzOusw==
X-Received: by 2002:a1c:a384:: with SMTP id m126mr487272wme.99.1556568966933;
        Mon, 29 Apr 2019 13:16:06 -0700 (PDT)
Received: from localhost.localdomain (ip-93-97.sn2.clouditalia.com. [83.211.93.97])
        by smtp.gmail.com with ESMTPSA id k6sm22864019wrd.20.2019.04.29.13.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 13:16:06 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        stable@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 5/5] IB/hfi1: Fix improper uses of smp_mb__before_atomic()
Date:   Mon, 29 Apr 2019 22:15:01 +0200
Message-Id: <1556568902-12464-6-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This barrier only applies to the read-modify-write operations; in
particular, it does not apply to the atomic_read() primitive.

Replace the barrier with an smp_mb().

Fixes: 856cc4c237add ("IB/hfi1: Add the capability for reserved operations")
Cc: stable@vger.kernel.org
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/rdmavt/qp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index a34b9a2a32b60..b64fd151d31fb 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1863,11 +1863,11 @@ static inline int rvt_qp_is_avail(
 	u32 reserved_used;
 
 	/* see rvt_qp_wqe_unreserve() */
-	smp_mb__before_atomic();
+	smp_mb();
 	reserved_used = atomic_read(&qp->s_reserved_used);
 	if (unlikely(reserved_op)) {
 		/* see rvt_qp_wqe_unreserve() */
-		smp_mb__before_atomic();
+		smp_mb();
 		if (reserved_used >= rdi->dparms.reserved_operations)
 			return -ENOMEM;
 		return 0;
@@ -1882,7 +1882,7 @@ static inline int rvt_qp_is_avail(
 		avail = slast - qp->s_head;
 
 	/* see rvt_qp_wqe_unreserve() */
-	smp_mb__before_atomic();
+	smp_mb();
 	reserved_used = atomic_read(&qp->s_reserved_used);
 	avail =  avail - 1 -
 		(rdi->dparms.reserved_operations - reserved_used);
-- 
2.7.4

