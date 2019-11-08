Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30765FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B9421D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239697;
	bh=yhwW3OSD4OMkVwZMox1fzcqQYREfFWwiXMt1NWhoEQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eelKvKdzuoVU8O/QaVPMl4bHhhXalBBxCh+S/BpnGK3XTaJrQJ2eIh3yws34vM3sz
	 hAme3Bgb05NAP9iPGB+fE3RoH0GuribZx/7ZTqQHjiAov0fAsjDb8bly61BIF7GSqc
	 rLWINmGWJEIvI83UXdfAp1SRsTVPFHWUQlKnO0EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390243AbfKHTBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732536AbfKHTBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:01:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF43E2067B;
        Fri,  8 Nov 2019 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239691;
        bh=yhwW3OSD4OMkVwZMox1fzcqQYREfFWwiXMt1NWhoEQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vN4oC/pH5ekS2c4cKo9gAAHVq3poayqyazzigxshnEvCWCtWd0Fhtmp+FdlEPzhQM
         gE+XreBCIwln6ICXspVM6oIAOIsiQ3lf3qw+AfgJVPnn1TOjwlyrih0D++LSRWyp86
         81UZ+tQeVX8mfYnkCXy8dNu9+sIVj2Kzi+zI6IpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 28/79] of: unittest: fix memory leak in unittest_data_add
Date:   Fri,  8 Nov 2019 19:50:08 +0100
Message-Id: <20191108174801.485045812@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
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
index 7f42314da6ae3..bac4b4bbc33de 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1159,6 +1159,7 @@ static int __init unittest_data_add(void)
 	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
+		kfree(unittest_data);
 		return -ENODATA;
 	}
 
-- 
2.20.1



