Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED2FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24462178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239398;
	bh=OnSXf/TO5gzZ3Qt2oWZ815odtj/2blHs/uJeW0mdbrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qsMU3Sq/NmmGaswbxMtRnHbCEvrk2QPfw+UJCg4ENZHNS2lIerDVq4tj7jJhMl3MW
	 39AIW0I8ev4L0d+HydFPUa/vluuVN1/l4/Cy0s4IMFV+wRYzj7Q9iB2RHVO/sCKuuQ
	 pMdYO73nKqVmVIcY+UJu+yZY9e8moWH87B51DH1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfKHS4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbfKHS4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:56:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A63214DB;
        Fri,  8 Nov 2019 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239391;
        bh=OnSXf/TO5gzZ3Qt2oWZ815odtj/2blHs/uJeW0mdbrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEt4E2zmitVAy8t1ZQjK5vf88gyxdCFDr++HUjA3hpcoOtAuudHb5QyuBL6sYaUNw
         2BfVW+dU3REzSXdmDwnTsSU8C67O302RmCI31A+HIHPj+qSga47bsUDn2rv3ALhC1W
         UW0YkMHiOd6Dep4MZ+GRuNGcsBs74CkFqpdau+Eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 24/34] net: dsa: fix switch tree list
Date:   Fri,  8 Nov 2019 19:50:31 +0100
Message-Id: <20191108174645.613968861@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivien Didelot <vivien.didelot@gmail.com>

[ Upstream commit 50c7d2ba9de20f60a2d527ad6928209ef67e4cdd ]

If there are multiple switch trees on the device, only the last one
will be listed, because the arguments of list_add_tail are swapped.

Fixes: 83c0afaec7b7 ("net: dsa: Add new binding implementation")
Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/dsa2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -59,7 +59,7 @@ static struct dsa_switch_tree *dsa_add_d
 	dst->tree = tree;
 	dst->cpu_switch = -1;
 	INIT_LIST_HEAD(&dst->list);
-	list_add_tail(&dsa_switch_trees, &dst->list);
+	list_add_tail(&dst->list, &dsa_switch_trees);
 	kref_init(&dst->refcount);
 
 	return dst;


