Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D7C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1259218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947142;
	bh=qOH17Mx2wNpe6Xc+FAHIf4Z6likbmzKYix05DTI5m6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F58ol2pKskodSQLnoq6GiBPOx4uAgY5s2ucSKSNihxeVyjj1OOYIl0BY5E1tm4X0/
	 xcu9Xr0xfVi4NxjUygwgNEzFmsUwECCP14Dq184IkkOzfmIMQJ/2V/M0Worn1i4lp4
	 YuGrA357+2wXmkBbNkUg4a7fAymBC/m/jd5/7fvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfIHMwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732922AbfIHMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:52:11 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE79F218AC;
        Sun,  8 Sep 2019 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947131;
        bh=qOH17Mx2wNpe6Xc+FAHIf4Z6likbmzKYix05DTI5m6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkUVXFCwyhip1v9Xsxnjj9NCTUURWoU5J35HsiIaQt+FD5kREkpq7ivCzxWP69hje
         HWTgHWO7d1rLyYYsQ/s9786E9dBOjLdSAd1v9i4TAZHCfo0NWrZpjJ4OjizdhCcI0R
         CIY6CxJySuBr5AqPMn+cCKIhPa9ak3GKdluJNGqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Parav Pandit <parav@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 73/94] RDMA/cma: fix null-ptr-deref Read in cma_cleanup
Date:   Sun,  8 Sep 2019 13:42:09 +0100
Message-Id: <20190908121152.523231583@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a7bfb93f0211b4a2f1ffeeb259ed6206bac30460 ]

In cma_init, if cma_configfs_init fails, need to free the
previously memory and return fail, otherwise will trigger
null-ptr-deref Read in cma_cleanup.

cma_cleanup
  cma_configfs_exit
    configfs_unregister_subsystem

Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Link: https://lore.kernel.org/r/1566188859-103051-1-git-send-email-zhengbin13@huawei.com
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 19f1730a4f244..a68d0ccf67a43 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4724,10 +4724,14 @@ static int __init cma_init(void)
 	if (ret)
 		goto err;
 
-	cma_configfs_init();
+	ret = cma_configfs_init();
+	if (ret)
+		goto err_ib;
 
 	return 0;
 
+err_ib:
+	ib_unregister_client(&cma_client);
 err:
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
-- 
2.20.1



