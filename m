Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73150C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E552072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431872;
	bh=V1Q3Xuf3lHcY7QWN+8zhItJkKgV8hQvAWN7NdTrbQeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=utBoLlhidPXmcBJKyNvx+6gTfDFXZOOv9fBFmlnsl2laa47StlMMeQfRi6y5+nDqj
	 QNhnLXPt0TJq47UB2///isuC4gtl8VcTxOteR9apaB73Z3+ENKw5xOwObncnay3bAQ
	 U2Ym54NzYzCvBLuw13QmbD81eVi/sQLJ2zHAYdeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAGVRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:17:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgAGVFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:05:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C7DB2081E;
        Tue,  7 Jan 2020 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431136;
        bh=V1Q3Xuf3lHcY7QWN+8zhItJkKgV8hQvAWN7NdTrbQeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1u6ojmKIBVd1lhLhLoes5yurgXlSw7FamyNSOJsnMqSUl5Fu3O006FTRKoqOrRle
         3IWaWHqz54uSuGDr+bS+Jdff9pZ3xR6PXjWhmqfPnIQZrLJp2t+0Po4oVSkczTmujU
         hdeI9HEf9DTfTFQD3nYED0FMRasAO8d1nA044MEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Parav Pandit <parav@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/115] RDMA/cma: add missed unregister_pernet_subsys in init failure
Date:   Tue,  7 Jan 2020 21:53:42 +0100
Message-Id: <20200107205247.577554699@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 44a7b6759000ac51b92715579a7bba9e3f9245c2 ]

The driver forgets to call unregister_pernet_subsys() in the error path
of cma_init().
Add the missed call to fix it.

Fixes: 4be74b42a6d0 ("IB/cma: Separate port allocation to network namespaces")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Link: https://lore.kernel.org/r/20191206012426.12744-1-hslester96@gmail.com
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1f373ba573b6..319bfef00a4a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4658,6 +4658,7 @@ static int __init cma_init(void)
 err:
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
+	unregister_pernet_subsys(&cma_pernet_operations);
 err_wq:
 	destroy_workqueue(cma_wq);
 	return ret;
-- 
2.20.1



