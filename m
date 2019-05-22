Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DBFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00BC21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553227;
	bh=HlgZszRBqITc682hadmHsNjfh2I4x2bG2RWFh2Vvu1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CCZhzSxyiDDYAvMEpJ6V81Bz+Zp0Bii/QuOqyMGAzkcCvIoP1ykX5vtqMF/hD1w+B
	 U7uGNlGqNvDPM5D7fj/rqfiGLRaMPd8ZTDyPTL+UvIzMlf/thA8i1tIXV1gC4/lhym
	 LVJHddUWGSxAK57VSd75KvyP9tNNdSG6Le6QmNsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfEVT1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732231AbfEVT1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:27:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C476221473;
        Wed, 22 May 2019 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553223;
        bh=HlgZszRBqITc682hadmHsNjfh2I4x2bG2RWFh2Vvu1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/3X5gS8Bx/xTJGt8qaUmoBiU5UT2E2BlQtuKXWujsmdZsY5FUs/K0mFQYCzsS5aC
         aZSTYw68/0xhgkIg+ylBkFIPIBFMyQv6mgVLGglSL83LG2ySXRfdQtfqUhPfY/V2cl
         QVc6Pme49cIvmGjgOSEblnF9enSn3K9zXQ9oFaVs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 022/244] powerpc/perf: Return accordingly on invalid chip-id in
Date:   Wed, 22 May 2019 15:22:48 -0400
Message-Id: <20190522192630.24917-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

[ Upstream commit a913e5e8b43be1d3897a141ce61c1ec071cad89c ]

Nest hardware counter memory resides in a per-chip reserve-memory.
During nest_imc_event_init(), chip-id of the event-cpu is considered to
calculate the base memory addresss for that cpu. Return, proper error
condition if the chip_id calculated is invalid.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 885dcd709ba91 ("powerpc/perf: Add nest IMC PMU support")
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/imc-pmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 1fafc32b12a0f..3cebfdf362116 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -496,6 +496,11 @@ static int nest_imc_event_init(struct perf_event *event)
 	 * Get the base memory addresss for this cpu.
 	 */
 	chip_id = cpu_to_chip_id(event->cpu);
+
+	/* Return, if chip_id is not valid */
+	if (chip_id < 0)
+		return -ENODEV;
+
 	pcni = pmu->mem_info;
 	do {
 		if (pcni->id == chip_id) {
-- 
2.20.1

