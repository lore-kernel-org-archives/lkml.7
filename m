Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A830C17448
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6CF206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610889;
	bh=ZxkIgG+Oa+kY1HAulN5VVJ7/HOzwWg4gtRjfk+JdGC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZQ7nTCKvMMCa05ky2/JOkh0ID8/G3ZS1OkFgtS4dhXhKgWj/5K7tLSKEwZe/jRRJF
	 JSGF3Y11gsDFN5GnUDjHdFBnLclbp3bE4Qa3NBSfhZC+LxisJZJo3+ZXN/iBiVSxwf
	 lswvHoqImztV3E64tx/HtmI7Hwam71xYVoTw2/QY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfKMCAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbfKMCAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:00:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5412053B;
        Wed, 13 Nov 2019 02:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610404;
        bh=ZxkIgG+Oa+kY1HAulN5VVJ7/HOzwWg4gtRjfk+JdGC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUx/Twj8ujOA6mNG/pcQLbUGk5gN2SJsuym/ZqF6pTeCZHSGIgFFrs+kingUFarnY
         WG0wN7X5WL1+EeEUjcilB/SPq4pT9m8C7uLze+ble7xF5uu32b0D7oaJXv3rxwgVZc
         awo7EQUN4WaItWj8tgdO0vGNTMASi8vu6sN8kZts=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 20/68] powerpc/pseries: Fix how we iterate over the DTL entries
Date:   Tue, 12 Nov 2019 20:58:44 -0500
Message-Id: <20191113015932.12655-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit 9258227e9dd1da8feddb07ad9702845546a581c9 ]

When CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set, we look up dtl_idx in
the lppaca to determine the number of entries in the buffer. Since
lppaca is in big endian, we need to do an endian conversion before using
this in our calculation to determine the number of entries in the
buffer. Without this, we do not iterate over the existing entries in the
DTL buffer properly.

Fixes: 7c105b63bd98 ("powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config option.")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/dtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 37de83c5ef172..7a4d172c93765 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -185,7 +185,7 @@ static void dtl_stop(struct dtl *dtl)
 
 static u64 dtl_current_index(struct dtl *dtl)
 {
-	return lppaca_of(dtl->cpu).dtl_idx;
+	return be64_to_cpu(lppaca_of(dtl->cpu).dtl_idx);
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
-- 
2.20.1

