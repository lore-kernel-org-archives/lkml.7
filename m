Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22264C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30A4218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353982;
	bh=GqacdbbgpNQ4mS1hYtHfnHKJiMJqbmFVFFLz56Fi1mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QZTGjTMf1zqYHzZ7MC7865gUnynQCbvWJgKHGHNsSkTKjDfbqHPubbpVCBXbtRBxp
	 +lOW0eR1tpzcOQ7cKlZamp3s9ZCyWhGGWGEK6+5ERgnYxasFzoGZ4f5XQMnLqrcNl3
	 oyAs7wawqRPeZF3x1v8GZPrCffjsp6+o1qSrYLlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfDOSqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbfDOSqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8922087C;
        Mon, 15 Apr 2019 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353976;
        bh=GqacdbbgpNQ4mS1hYtHfnHKJiMJqbmFVFFLz56Fi1mM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7cu3VAzuDvGyFjqrVek3MB58a4/+Sz8vazseSSge/RHPY0nDacqt1que6yew/L2W
         5xb3fKZqfWyVjOkWHzAK441OsLs3kyON8yUVrPG9/cXXP3a88pAvE5fS5ZSElEn2OQ
         w8DmMXgIJllBxBnUW39pr9Dr0ODUI4s8xL0MtnJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 40/76] powerpc/fsl: Enable runtime patching if nospectre_v2 boot arg is used
Date:   Mon, 15 Apr 2019 20:44:04 +0200
Message-Id: <20190415183717.917308685@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3bc8ea8603ae4c1e09aca8de229ad38b8091fcb3 upstream.

If the user choses not to use the mitigations, replace
the code sequence with nops.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/setup-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d5a128f54537..5e7d70c5d065 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -919,6 +919,7 @@ void __init setup_arch(char **cmdline_p)
 		ppc_md.setup_arch();
 
 	setup_barrier_nospec();
+	setup_spectre_v2();
 
 	paging_init();
 
-- 
2.19.1



