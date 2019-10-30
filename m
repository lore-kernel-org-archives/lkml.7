Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86AFCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967C2217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451107;
	bh=GBXGhSu9YMWsJKSnb1S6V/LLVcauS+SavzVE3JSUGhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HWDz0+z4Kyz4FOVmdG8sx+GJyg9vWB3XDd4fOi8muyAQtbJQ+fhZRD3UwhQ20KKvr
	 F9IicXVRIHUXY7nOUlDBNhMv5yR5WZ88CV++FYhFp24W/vAE8nizko8G9IKN8TlOTS
	 OWJb7HGWH7rjZwtdmZZKxK8uLz4EcSwXQ1kt1pAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfJ3P60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbfJ3P6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:58:19 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D9021925;
        Wed, 30 Oct 2019 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572451098;
        bh=GBXGhSu9YMWsJKSnb1S6V/LLVcauS+SavzVE3JSUGhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eox2BekyTCc70GA3YE5zvFC4FqJpvLsogEUaV0Ee162OmD4MiNMhyNSLtiz1HdCQ0
         JK8xwW4ExnJtLfvKUb57KTRob8TKytC3lLhrMSgYwDegiitK3HAxjIp0fsnraHKGEr
         cH3trGCTy3TDJb61QmiQ5D4LFVR+ZHimaSYPHOP8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 11/13] of: unittest: fix memory leak in unittest_data_add
Date:   Wed, 30 Oct 2019 11:57:49 -0400
Message-Id: <20191030155751.10960-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155751.10960-1-sashal@kernel.org>
References: <20191030155751.10960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit e13de8fe0d6a51341671bbe384826d527afe8d44 ]

In unittest_data_add, a copy buffer is created via kmemdup. This buffer
is leaked if of_fdt_unflatten_tree fails. The release for the
unittest_data buffer is added.

Fixes: b951f9dc7f25 ("Enabling OF selftest to run without machine's devicetree")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 2eac3df7dd290..af9e4785b7a6e 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -924,6 +924,7 @@ static int __init unittest_data_add(void)
 	of_fdt_unflatten_tree(unittest_data, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
+		kfree(unittest_data);
 		return -ENODATA;
 	}
 	of_node_set_flag(unittest_data_node, OF_DETACHED);
-- 
2.20.1

