Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E502064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZznNJAtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfCSQgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:36:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44468 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfCSQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:36:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so730240pgj.11;
        Tue, 19 Mar 2019 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o/hu19s9IE7P/1X2IZsAaNo1mAHXce/eUIJAnIIL4nw=;
        b=ZznNJAtSuS8zs3O9UxyG7Tg6zio0hm57xVWXvvuQ1Uqb37ViJHuF7E43AVLturz/Rw
         vnd6ozm1Ode0yQUKkfsDsnLf5C/GbRcmDYgmv3mdtgUYAC3OwhKKDafQ2bffhj8rqMeu
         i+xjwUD2o14y7GPeGkZS/ddWxDzN/Y76tY5Cneu4SblU5QGSe5mzABBWVTL1/6wOgEMG
         kgUY7OoDnusLnCKZCrebEC+uEGGgOj5VvKr0SNhdWjd7EeokMMEo+CA47m9Cok2KGImX
         k5a1ckQxtLAfpXrusnstyxD++O1TTAkIpCrj4VV+9GM5sw07KwZEnyc/Sz72N9Qq4N8V
         ZgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o/hu19s9IE7P/1X2IZsAaNo1mAHXce/eUIJAnIIL4nw=;
        b=CLBxonmYK/VWvAQMfDrkE33ny1YnHyCrjDoNbj8lHrEYTIuKD+nhZb7+H+qY4AQKIz
         QT3IBFdCDrVVypX2S+ixVFHmM19Ff+8fumUvpWvQwCX+iVHf9ELoWCF1+f5xY0chjZLO
         7eGU4btSo+tGzkc7j4rLd0uK/CapemDDtLXojNW28+8EDWkW8809keeQAuryBUh6OsPF
         bUy+3TDEya1IlDJIxLKuRSodlQ+tFlYcWfLJwr8dNwZ4KCFMnhpPmDAVBxWY475SpSib
         E3No51muS43TV2t+xgkHVhxKQg8zd66Xb5WP+fcLABp3hbmV871RYccP05GdrDj9+gUP
         eLPQ==
X-Gm-Message-State: APjAAAXX6M3TfshQn65eyZ+VaL7YHnjcT6OaUe/AmMMuQJDrqzTnf4IE
        PrUvL+mxhWQ+aLAh9cOZGSc=
X-Google-Smtp-Source: APXvYqxL5gpZRRUhom2v85PXQDxti0OlQMd0MKaTKP5vG/fimfKSt8R77CK43KmksJ9/GBDyZKYPkA==
X-Received: by 2002:a17:902:b404:: with SMTP id x4mr3475338plr.232.1553013407823;
        Tue, 19 Mar 2019 09:36:47 -0700 (PDT)
Received: from localhost.localdomain ([47.91.249.165])
        by smtp.gmail.com with ESMTPSA id x6sm11238198pfm.140.2019.03.19.09.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Mar 2019 09:36:47 -0700 (PDT)
From:   Jeff Xie <chongguiguzi@gmail.com>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com
Cc:     somnath.kotur@broadcom.com, chongguiguzi@gmail.com,
        sriharsha.basavapatna@broadcom.com, dledford@redhat.com,
        jgg@ziepe.ca, nux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband:qplib_fp:move spin_lock_bh to spin_lock in tasklet
Date:   Wed, 20 Mar 2019 00:36:37 +0800
Message-Id: <1553013397-29263-1-git-send-email-chongguiguzi@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unnecessary to call spin_lock_bh in a tasklet.

Signed-off-by: Jeff Xie <chongguiguzi@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 71c34d5..e2541c9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -273,14 +273,14 @@ static void bnxt_qplib_service_nq(unsigned long data)
 						     << 32;
 			cq = (struct bnxt_qplib_cq *)(unsigned long)q_handle;
 			bnxt_qplib_arm_cq_enable(cq);
-			spin_lock_bh(&cq->compl_lock);
+			spin_lock(&cq->compl_lock);
 			atomic_set(&cq->arm_state, 0);
 			if (!nq->cqn_handler(nq, (cq)))
 				num_cqne_processed++;
 			else
 				dev_warn(&nq->pdev->dev,
 					 "cqn - type 0x%x not handled\n", type);
-			spin_unlock_bh(&cq->compl_lock);
+			spin_unlock(&cq->compl_lock);
 			break;
 		}
 		case NQ_BASE_TYPE_SRQ_EVENT:
-- 
2.7.4

