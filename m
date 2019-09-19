Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB32C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484621907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931253;
	bh=Ts8e8Hns3t4/ykTZIfN892InRBKDgKoLX54YAaNvoyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0XWpcOxjcI3ojTauT8Krzlq7IsySFMmyBTpKqwb0F3dwSQdRRISgyEECCuTaMNjnR
	 u2aY//1A6XP2mXpJUXGD6ZsyJ6c4YwcQT9scqsoe+6hF8JN4tUcPtYaeRaCgjG4FB4
	 zAMSbgacMXxL/U1VlEmIg5nsK7BAaB+VY03cYQZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392204AbfISWOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392166AbfISWOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:14:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0233621920;
        Thu, 19 Sep 2019 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931249;
        bh=Ts8e8Hns3t4/ykTZIfN892InRBKDgKoLX54YAaNvoyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0kEbRSXD4wtRzFPMqixUeU3Av2pguI+/hInbjRAgtw2zQi3uQsjUXDlKFmaJIb0d
         KrokxpH+X+0vT7z3WZNxy4YXCEV48Kzw0E7XZ1I+63gOGpE/+bA0NwJXopgJ103ASK
         cFvbpntyZL8N91L8Vz+Zq3YhU0GsBSYlJZDLy4fY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 40/79] xdp: unpin xdp umem pages in error path
Date:   Fri, 20 Sep 2019 00:03:25 +0200
Message-Id: <20190919214811.273100959@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

[ Upstream commit fb89c39455e4b49881c5a42761bd71f03d3ef888 ]

Fix mem leak caused by missed unpin routine for umem pages.

Fixes: 8aef7340ae9695 ("xsk: introduce xdp_umem_page")
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xdp_umem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index a3b037fbfecde..8cab91c482ff5 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -322,7 +322,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->pages = kcalloc(umem->npgs, sizeof(*umem->pages), GFP_KERNEL);
 	if (!umem->pages) {
 		err = -ENOMEM;
-		goto out_account;
+		goto out_pin;
 	}
 
 	for (i = 0; i < umem->npgs; i++)
@@ -330,6 +330,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 
 	return 0;
 
+out_pin:
+	xdp_umem_unpin_pages(umem);
 out_account:
 	xdp_umem_unaccount_pages(umem);
 	return err;
-- 
2.20.1



