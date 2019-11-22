Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7E7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72820637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418838;
	bh=38CvKTUEfYqjatSWeb66xhp68C1ENMnN+gyu0nGU6rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eHXfgtHbKEUACqsDCxz3UMFAPxPVo97qQwu3/DV5tyLAUFmi0tLGvA575ijg2gzkt
	 MqDOUBaU40+z3jDzd1b1kXBNLdPy3LtF/7cj5dgPClP+XNiYqTyah7mjYKoGkx8I4+
	 uMVMpbxgJCxis0t4vUUFp1FxX6ZM1VsJ/vFt1H6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfKVKd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbfKVKdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:33:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D55720656;
        Fri, 22 Nov 2019 10:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418832;
        bh=38CvKTUEfYqjatSWeb66xhp68C1ENMnN+gyu0nGU6rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlcxc2MhU66FP/Pe5AF/9V4vFoEkLYn0PL2c84R/3n3sf+QN5rG0xOp4e2wWrJTMg
         W1QA7taGY2gfHLGaGQ+eB+SAzJMnd6vlu/9Yem1+390dFBvpa4HiXpmnIj3JDmy7rV
         BZJWZQAkENP9PBpxsnYXDQKAcbj1WXslMKyFaI3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 030/159] of: make PowerMac cache node search conditional on CONFIG_PPC_PMAC
Date:   Fri, 22 Nov 2019 11:27:01 +0100
Message-Id: <20191122100727.662574228@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit f6707fd6241e483f6fea2caae82d876e422bb11a ]

Cache nodes under the cpu node(s) is PowerMac specific according to the
comment above, so make the code enforce that.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index c6e019208d171..27783223ca5cd 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2125,7 +2125,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 	/* OF on pmac has nodes instead of properties named "l2-cache"
 	 * beneath CPU nodes.
 	 */
-	if (!strcmp(np->type, "cpu"))
+	if (IS_ENABLED(CONFIG_PPC_PMAC) && !strcmp(np->type, "cpu"))
 		for_each_child_of_node(np, child)
 			if (!strcmp(child->type, "cache"))
 				return child;
-- 
2.20.1



