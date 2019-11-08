Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC1BFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC78F2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239147;
	bh=GBXGhSu9YMWsJKSnb1S6V/LLVcauS+SavzVE3JSUGhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PckQpfqAn6Hl0TKOrV36ie1VHjjjUtzc0Wnd8o1aN2azG5L9Cwbg6F7SVvLQOv5xp
	 UJKvc8CKj5UutqLOC88xtG02pVJnowO9JuMdw7RAfCYzSirS1sOT1zqeQDBFxMw58E
	 GmqjNxK300fXaGr9pYbcPRpCmvsrPN9rt70YHRJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfKHSwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbfKHSwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:52:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C1A214DB;
        Fri,  8 Nov 2019 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239133;
        bh=GBXGhSu9YMWsJKSnb1S6V/LLVcauS+SavzVE3JSUGhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPVSdCYzfXo2mG21YjlTjKNAvaugii4nQpLA241i4VbNZ7I4W/HMj1XIWzq4yU/yb
         9fpAayGgbWbJRGECWjQWc+/yYwZExOnjTvMwTyCYZyS6VIfNH/Exy9BS1DeyvBGep/
         NSznFgpjt+qFNXCx5cTn7Xd5rj6LF2l3VxyufC68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 11/75] of: unittest: fix memory leak in unittest_data_add
Date:   Fri,  8 Nov 2019 19:49:28 +0100
Message-Id: <20191108174718.602115181@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
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



