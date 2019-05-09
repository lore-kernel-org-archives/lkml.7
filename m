Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282B9C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED183217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557436122;
	bh=A2KlR4tg2BhBXTfCzsQuGbwT0RVrYjIIugnnkl+JVAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c6yYI6ortGfYZMu+oMrEcNik/hXvX2Y7w/6Iy9fD2tLzycq8anJRzY1GpyAwU4aPB
	 pz+07HxDOvcguM+AG2/0IbILxj9khHB2pGEBAhLnEGQmA2LUfl32yYDqpEXsX/Cou/
	 IIxcSpbgwMS2lf0TyjSmM4pr0hlUU/KW4+cGglMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfEIVIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfEIVIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:08:36 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34513217F5;
        Thu,  9 May 2019 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436115;
        bh=A2KlR4tg2BhBXTfCzsQuGbwT0RVrYjIIugnnkl+JVAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9wfyHob1Brg0UK3vjRJ8iO/B6s1DMf1UfQ9PMSKL7dp69cF0Rkd9QhEIjt1XlKOJ
         b5qjMdTmzbze1iqYRdK5QOcwBkTq89zZQaSnHYxbsDANuVgLtKtmYaZQlch1b1sSUV
         M6YFWAR7sSb4veSEZJnZ08+XEe28xkLpbVXRfGH4=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Wen Yang <wen.yang99@zte.com.cn>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 1/4] fpga: stratix10-soc: fix use-after-free on s10_init()
Date:   Thu,  9 May 2019 16:08:26 -0500
Message-Id: <20190509210829.31815-2-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509210829.31815-1-atull@kernel.org>
References: <20190509210829.31815-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

The refcount of fw_np has already been decreased by of_find_matching_node()
so it shouldn't be used anymore.
This patch adds an of_node_get() before of_find_matching_node() to avoid
the use-after-free problem.

Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/stratix10-soc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 13851b3d1c56..215d33789c74 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -507,12 +507,16 @@ static int __init s10_init(void)
 	if (!fw_np)
 		return -ENODEV;
 
+	of_node_get(fw_np);
 	np = of_find_matching_node(fw_np, s10_of_match);
-	if (!np)
+	if (!np) {
+		of_node_put(fw_np);
 		return -ENODEV;
+	}
 
 	of_node_put(np);
 	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
+	of_node_put(fw_np);
 	if (ret)
 		return ret;
 
-- 
2.21.0

