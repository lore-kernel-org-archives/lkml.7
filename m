Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C71CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A762083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451011;
	bh=38h9OxLbGYMEfB6eiKf0+8nZ0bNWOcuSd0cJSLAwGVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXMwC32l4LjGgmg2ULxZn8k1Iz5eH8EALAcVrgck+xgrjsJStlzNYqqdrB//mls4R
	 ijlZmsUewxM4/Nphtcs0F9nOXToFLSb0kdR4JK9NbXNRI7GF8aQyryErMmdCGCamX2
	 66zpFttgJ0ubmNdyvuc+x1qhYb0Xo2Q6WX5zfroo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfJ3P4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfJ3P4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:56:44 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AA420874;
        Wed, 30 Oct 2019 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572451003;
        bh=38h9OxLbGYMEfB6eiKf0+8nZ0bNWOcuSd0cJSLAwGVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3SsEymsgbO+DznJW0DRJ2lc9RWq72F18Wqa7foPG5z1KJp8f2uO8/KUN+Ay0evwC
         XUgGPF/N58JgAQ36a8zJ/lUA2Nx+jCaNgQ7fiDn2TZljmzKpHyrHp7brJo02Y9oi38
         k3aDZx1WP17gyetYfNHkVIqmMTDr+DWZEzmMvWSk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/24] of: unittest: fix memory leak in unittest_data_add
Date:   Wed, 30 Oct 2019 11:55:50 -0400
Message-Id: <20191030155555.10494-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155555.10494-1-sashal@kernel.org>
References: <20191030155555.10494-1-sashal@kernel.org>
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
index 7c6aff7618009..87650d42682fc 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1002,6 +1002,7 @@ static int __init unittest_data_add(void)
 	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
+		kfree(unittest_data);
 		return -ENODATA;
 	}
 	of_node_set_flag(unittest_data_node, OF_DETACHED);
-- 
2.20.1

