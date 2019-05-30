Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04FCC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687724F8D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188904;
	bh=5ElLYnLfkLhauHZub2TH9Ya+NEKWLjkjJYPVLRslO9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a+e6qJEYjg1ogOvmFH3Yi3+6fjX7TfXuX1t6sE2u/XVxwl9xeDtcG/YXnqpwbh2lm
	 bJB/4KC5HHpEP7YifVcwFO+O4gww1LGa2aQCvfVzY0Y7s/OUm46cy+lSX24uCyvBvz
	 VfR6WIsBz+EDhEE7Sm6vWN/2fwSKE7T+t3Fb0NJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfE3EBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731423AbfE3DSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:08 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA3C24771;
        Thu, 30 May 2019 03:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186287;
        bh=5ElLYnLfkLhauHZub2TH9Ya+NEKWLjkjJYPVLRslO9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jbz0LiDGeJWTcF0/OVQGwvZAesVGUsP8KGmDxU6sEAVQBaiM7RNDytP0QeH4SJPYG
         45jn7t7OJ3fFFGdwye5ZMvMAbxEmTYAECwaQS6KtKt8qfFWLoffqR2SgQ64jeemwMn
         FfCOYv7wqnKAP87Tf0de3FGzlMfOQvagirlkql4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 242/276] thunderbolt: Fix to check return value of ida_simple_get
Date:   Wed, 29 May 2019 20:06:40 -0700
Message-Id: <20190530030540.267984249@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9aabb68568b473bf2f0b179d053b403961e42e4d ]

In enumerate_services, ida_simple_get on failure can return an error and
leaks memory. The patch ensures that the dev_set_name is set on non
failure cases, and releases memory during failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/xdomain.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index db8bece633270..befe754906979 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -743,6 +743,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 	struct tb_service *svc;
 	struct tb_property *p;
 	struct device *dev;
+	int id;
 
 	/*
 	 * First remove all services that are not available anymore in
@@ -771,7 +772,12 @@ static void enumerate_services(struct tb_xdomain *xd)
 			break;
 		}
 
-		svc->id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
+		id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
+		if (id < 0) {
+			kfree(svc);
+			break;
+		}
+		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
 		svc->dev.parent = &xd->dev;
-- 
2.20.1



