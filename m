Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C306BC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D59F21823
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920911;
	bh=QxKfCyVgcTd31Jg08AbzORDVuP+QIgFWO6/9Nc98H1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxJz/dR53neAPzJ19QGjpp+uzdFPvIE/2o7BBvtmYOcLW3eMS4MkNMi8h/3P3S3nF
	 KqBV9Q43LJQtEYFZRe4SVsgwbsdPUDsIy1NsjDDkF796QGEYEm8+UnL6aLLzMyY+nM
	 L15GTGRnW6UJgCXSOfSEwClHyOn7x7ZLOVPs45vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfKPQPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbfKPPrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:47:36 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F263208CE;
        Sat, 16 Nov 2019 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919255;
        bh=QxKfCyVgcTd31Jg08AbzORDVuP+QIgFWO6/9Nc98H1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dh+I+le3oNaezNcXT49iak0jUhUmFA+4ja8rWvnL1NvCS2nYGFAjnK3JNJ3yIXjYk
         H+deafg1VoOLSgLhqCZh7XImLin2llaKPQ9Tg/IypJq9DwCuWPi7C1SziWhTf323rM
         JMpnIocip4U1nuryIAg+JAU6EGCGz7DP4eQ9ulTk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 008/150] powerpc/eeh: Fix use of EEH_PE_KEEP on wrong field
Date:   Sat, 16 Nov 2019 10:45:06 -0500
Message-Id: <20191116154729.9573-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit 473af09b56dc4be68e4af33220ceca6be67aa60d ]

eeh_add_to_parent_pe() sometimes removes the EEH_PE_KEEP flag, but it
incorrectly removes it from pe->type, instead of pe->state.

However, rather than clearing it from the correct field, remove it.
Inspection of the code shows that it can't ever have had any effect
(even if it had been cleared from the correct field), because the
field is never tested after it is cleared by the statement in
question.

The clear statement was added by commit 807a827d4e74 ("powerpc/eeh:
Keep PE during hotplug"), but it didn't explain why it was necessary.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh_pe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 8545a9523b9bc..7339ca4fdc19e 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -381,7 +381,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		while (parent) {
 			if (!(parent->type & EEH_PE_INVALID))
 				break;
-			parent->type &= ~(EEH_PE_INVALID | EEH_PE_KEEP);
+			parent->type &= ~EEH_PE_INVALID;
 			parent = parent->parent;
 		}
 
-- 
2.20.1

