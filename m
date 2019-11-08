Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE37FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8852196F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240052;
	bh=UqFlpraDJaXRjMuRU9H3HABmoY0nCuDWN0BpkO5x+OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d0ugp0+6MJ+PY4BQwCiOnVh8cQWRug8rRR0JrDDLBLI/7ZAnmqtLRdQ2OPElz4Yny
	 egNTStFKgoOCkNMPhmDh9QVhoQp1UpRQIbWbeZPS1S7zc++dGH2ITjt1CntfiMOnw5
	 QcGnOLcSAWR3KaihLvCuRy+i8FCVoaW5P8r80xDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbfKHTHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391452AbfKHTH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:07:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0420D2196F;
        Fri,  8 Nov 2019 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240046;
        bh=UqFlpraDJaXRjMuRU9H3HABmoY0nCuDWN0BpkO5x+OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REXUrYAuY6iT/nQNZhBgMhAz2v2bEKWSmCgNycVeO2SuQ5oXkByI47aToe7MO8Er3
         OjZ96r886wLY1zwYRhKLFU/iIcPtu/PKMP/fwDXkDRpd/CRKbGOzekoOv8dVUF8aVX
         D6pr26N2sbS7niYYfyVdqMVOUYvKmJggKMdxrCZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 068/140] of: unittest: fix memory leak in unittest_data_add
Date:   Fri,  8 Nov 2019 19:49:56 +0100
Message-Id: <20191108174909.481189005@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
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
index e6b175370f2eb..8b7bd48224657 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1205,6 +1205,7 @@ static int __init unittest_data_add(void)
 	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
+		kfree(unittest_data);
 		return -ENODATA;
 	}
 
-- 
2.20.1



