Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BE8FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5A221D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239629;
	bh=D4v9sx3RRX0dU7Q3sH3IEQS/k618r0wxMght8d1CSyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STqU69SrzXWi7emiHwFWu/hLH6B8A6n8u55tLR9LPuBTMUV6rIzcpxnaJfF/iVpSp
	 WIw6fFpT4cCXQAceXa5vlMX3KA/fqRbYbT0Vt54AlWbb/B3dLep1hkx1LqVvmCl4xh
	 DSfCcTnMmIpmusj99AvESDUlpx0jJITVFhVzPkSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbfKHTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:00:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389526AbfKHTAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A97321D7B;
        Fri,  8 Nov 2019 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239443;
        bh=D4v9sx3RRX0dU7Q3sH3IEQS/k618r0wxMght8d1CSyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1CGhdQGgfI0iuciqpZYsKrWsYyDtJn3XsaAhlAXZGbGbH5AiZZ4wY+hBi4QpDX6+H
         KCrtnDGbLr0M9BCAMwYOnrWg2vFF1A8ZiHfSPuPZZUvbbWjP8QALFUPDV46Gqis4pZ
         xNYwN9A3YoDB1S6NlCMPwOIk3+ZnvP1sX44Rce9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 15/34] of: unittest: fix memory leak in unittest_data_add
Date:   Fri,  8 Nov 2019 19:50:22 +0100
Message-Id: <20191108174635.453042112@linuxfoundation.org>
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
index 0a1ebbbd3f163..92530525e3556 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -933,6 +933,7 @@ static int __init unittest_data_add(void)
 	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
+		kfree(unittest_data);
 		return -ENODATA;
 	}
 	of_node_set_flag(unittest_data_node, OF_DETACHED);
-- 
2.20.1



