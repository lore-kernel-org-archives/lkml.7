Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4A3C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8255E205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Huz9P2sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfF0RiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:38:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38085 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:38:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id 9so896866ple.5;
        Thu, 27 Jun 2019 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I+iB/Ek7XPOsWCoiwnttwGd4M0JRxQfDZCeBlJjisY4=;
        b=Huz9P2sqnrNacozN3fL11H6blvJY6DIfPR+Sthvhudshl9DUdFGxBozdT1vPfNulR9
         9aSgsypiaM7jKtHAesu0CrOpD6xd1FqsnCQ4RoxdzFFBFMovlxemIZuPwHyNd3NLF3kG
         1tQX2J1w/95Y3YiY3tL3BjEWMXgnCQVyHhXEVqAUicgmdBedovyXopa5Jr3Q3LOxcVu4
         aLA+NhU6/2sagq1x9LJAvs6Yvn+mm8oFgk/wq2bJwCOUTlDH4RWGrTA3qupW3FDvqm0w
         7/GQaXDXUzGhQ/SXj99Q2MT7AA1EyCjhiN2krsJSFXVow53KpnoprArXBlSnRTMVLsGx
         cQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+iB/Ek7XPOsWCoiwnttwGd4M0JRxQfDZCeBlJjisY4=;
        b=Ns8sSTj4LgpxBu3OZA6OT8Ql1Bow3YIJXcxPvJe/03gAKIG8YyPbYJ1qHXQa9HU1pi
         sK2zggpmeLio+tXQe/DH+0/W1pJhSW3HQAMMgQbM8MgXcebM0jGtGYJfuQHUui2AIW+E
         ke9RQwc1RcYzSGKu/yn1mcOygAh6Mf9Dbzk1Rlm4uaHps9ECF3T6CE504dOLR+TKBBXa
         w7PLdg0QW2fUrnXtCjQaedsT4e8x/MkLuYhugvw9yX8b0ynLsKtcYzjucP24EthhcP5s
         5gatbbvJZcBdzLkWpn11qayu5zujWVqAb4SCiSvceLmmUIrxJroYoJVM/QXatJnjS1My
         gTGw==
X-Gm-Message-State: APjAAAWW/xIU1kHTfK93MhiRsWLSTRChwcdLfDqCNIXxMHgWK7/g0kDJ
        uD6KuUGxKTL1CgfBDOPgF8nlL5bWfYZ5Wg==
X-Google-Smtp-Source: APXvYqz0L9YzLAVDSv+KdtAwXJ4X1xkjPw9NUHSowbhjoGXrhoO5Ss9E874mFOiVaegUxnTl4Hwt/g==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr5779477plb.314.1561657093632;
        Thu, 27 Jun 2019 10:38:13 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id s17sm2368043pgi.9.2019.06.27.10.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:38:13 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Aaron Knister <aaron.s.knister@nasa.gov>,
        Denis Drozdov <denisd@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/87] infiniband: ulp: remove memset after vzalloc in ipoib_cm.c
Date:   Fri, 28 Jun 2019 01:38:04 +0800
Message-Id: <20190627173806.3307-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vzalloc has already zeroed the memory.
So memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index aa9dcfc36cd3..c59e00a0881f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1153,7 +1153,6 @@ static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
 		ret = -ENOMEM;
 		goto err_tx;
 	}
-	memset(p->tx_ring, 0, ipoib_sendq_size * sizeof(*p->tx_ring));
 
 	p->qp = ipoib_cm_create_tx_qp(p->dev, p);
 	memalloc_noio_restore(noio_flag);
-- 
2.11.0

