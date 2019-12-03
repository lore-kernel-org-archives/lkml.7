Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B147C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E383220656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413314;
	bh=F3GGm7t3WHwYNXVgUb+L8W3UBg8MBtvEOZG23w1T2JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kOkh0OVmahIEW7li5ou58G/6vsyqRJ6Uyu5AyT7V4OhDniRDQim/Md3ByxbyY/gL9
	 vEF2GTp1Db9fkUyntpf5UiC1gVrF1pju79iJ94tCgC/Enkzi20nCGETMfU5sRpREi7
	 h8nrDFR3qUzk/spt1epC5QDjR/IpH6w33q00YB10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfLCWsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbfLCWsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:48:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4408620656;
        Tue,  3 Dec 2019 22:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413310;
        bh=F3GGm7t3WHwYNXVgUb+L8W3UBg8MBtvEOZG23w1T2JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl7lHzGhQWi6J0muWDdGF+u6TfD2r6g+1b/efJbX/LhihUeR5CYmjKzBlq21C3hwa
         vzaZwZHHSNOmNAzkIU6IOGDmbbhxJYm1ixml+9X0kaUid1AXUTSUkaxZyFnNwVrwkV
         aPnSb8PbygggqEIywvT4wiArLlmluePU2BrS6Gzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adit Ranadive <aditr@vmware.com>,
        Gal Pressman <galpress@amazon.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/321] RDMA/vmw_pvrdma: Use atomic memory allocation in create AH
Date:   Tue,  3 Dec 2019 23:32:24 +0100
Message-Id: <20191203223431.218277366@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gal Pressman <galpress@amazon.com>

[ Upstream commit a276a4d93bf1580d737f38d1810e5f4b166f3edd ]

Create address handle callback should not sleep, use GFP_ATOMIC instead of
GFP_KERNEL for memory allocation.

Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Cc: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index b65d10b0a8759..f4cb5cf26006f 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -555,7 +555,7 @@ struct ib_ah *pvrdma_create_ah(struct ib_pd *pd, struct rdma_ah_attr *ah_attr,
 	if (!atomic_add_unless(&dev->num_ahs, 1, dev->dsr->caps.max_ah))
 		return ERR_PTR(-ENOMEM);
 
-	ah = kzalloc(sizeof(*ah), GFP_KERNEL);
+	ah = kzalloc(sizeof(*ah), GFP_ATOMIC);
 	if (!ah) {
 		atomic_dec(&dev->num_ahs);
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1



