Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B995C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE31214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410726;
	bh=p3738Kx8O6z5iV89iKeffvDmCG+AAxnzFXWAYdsTb8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V3aevm/8Hq9Ia8qUIBurUkCr1DOaNFKi1OYUdGX2/RKcaGeWc4IIKgJ7OBb0nCcME
	 fesMDwKWO0yVMDUPeT0UhZ7ivLmO6NYPfoWy1PIzN7hcGrpNR//Uu9wpM5+rIw2Tkv
	 Nr96Vf2BFk1DF44Umec0D8NMh61fzjakyaxwj4VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCLRME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfCLRLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:53 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A83D2173C;
        Tue, 12 Mar 2019 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410713;
        bh=p3738Kx8O6z5iV89iKeffvDmCG+AAxnzFXWAYdsTb8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrgzKiJLyqEcmj9fr8+cgG8JCPypB6ZZ0mqsKf9qcfX0IcWxo3yMU7eM89TvTdz/k
         iRskqPvEbK1vFETUDDerC2KXnmi5KEsBthkCCeb1ktXFxzmFWeIqpQndPJVEW52byz
         52BfpSy/s49LvhjRuXFJg1W+sccelzOHtQbjgFog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 027/171] xtensa: SMP: mark each possible CPU as present
Date:   Tue, 12 Mar 2019 10:06:47 -0700
Message-Id: <20190312170350.300339794@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8b1c42cdd7181200dc1fff39dcb6ac1a3fac2c25 ]

Otherwise it is impossible to enable CPUs after booting with 'maxcpus'
parameter.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index c9fc2c4f71b3..80be6449c497 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -83,7 +83,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned i;
 
-	for (i = 0; i < max_cpus; ++i)
+	for_each_possible_cpu(i)
 		set_cpu_present(i, true);
 }
 
-- 
2.19.1



