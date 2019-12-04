Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B42C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BED20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482838;
	bh=ahGw9jj1bgc2R6YpDVM+vcCzvPCOLLd12SQ1T1FgOBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uw1/fJFohq/GGfLTyqH3vfcSGonp80CccJChoXtythly12Q4Usrj8i5USp/+0Tvxh
	 hCrO7XbVC094cM9HwruQgMLtyiWqgltSm/NtMV0kzEuar8FAqRDPkU53OXP0ehbUg4
	 89tuLaJx2j7suFYabLS8kQxKoQYT60zkg4jTcrIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfLDSHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730735AbfLDSHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:07:15 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489EF20675;
        Wed,  4 Dec 2019 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482834;
        bh=ahGw9jj1bgc2R6YpDVM+vcCzvPCOLLd12SQ1T1FgOBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBa13yPIyYF7M9XdJW749oxOg/v9WceDMUZqj2O7fAtodXJBkysGfNAfjTm9zbsPk
         xPraFtwM5yZEeIhWlw5CpT5ermtqnruNBIKsvellJhpL24gGyfeGkMngQ7cvI0GdbS
         hoGgPfTCRIag0ZfC97UuHu+AFeNaRaW0faSX6eVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Brezillon <bbrezillon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 154/209] mtd: Remove a debug trace in mtdpart.c
Date:   Wed,  4 Dec 2019 18:56:06 +0100
Message-Id: <20191204175334.090160032@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

[ Upstream commit bda2ab56356b9acdfab150f31c4bac9846253092 ]

Commit 2b6f0090a333 ("mtd: Check add_mtd_device() ret code") contained
a leftover of the debug session that led to this bug fix. Remove this
pr_info().

Fixes: 2b6f0090a333 ("mtd: Check add_mtd_device() ret code")
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdpart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 27d9785487d69..45626b0eed643 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -698,7 +698,6 @@ err_remove_part:
 	mutex_unlock(&mtd_partitions_mutex);
 
 	free_partition(new);
-	pr_info("%s:%i\n", __func__, __LINE__);
 
 	return ret;
 }
-- 
2.20.1



