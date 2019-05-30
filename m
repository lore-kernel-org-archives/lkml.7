Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CEC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA42724BB9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187583;
	bh=I5csH4V8mLaYJl8pLwmMuS2+jOoRE1fhsLHCEUi8Cps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kiBiswBaDgyZonqigDYW2O4mVttZs8+REhQt1g1Kz4xzeQOC+cGpHEBlvaz4fJFkx
	 N2+p21fPc4kopUTirNAL4sv0fioi6zHp+CuNXoA8jqWWWvB4xT1jcpgKfz3k256AhS
	 xoYWyaVJVRExgNHLzGpHGdzwx4S1LxaG88Eu5OCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfE3DV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbfE3DQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:32 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B156924590;
        Thu, 30 May 2019 03:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186191;
        bh=I5csH4V8mLaYJl8pLwmMuS2+jOoRE1fhsLHCEUi8Cps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKtZ+p4Lt9EKoRX+h5zCNGLwGKFdrlIGTN1z9YXHKdTmMGaJyknl5bLv+/ddqXjBQ
         CtpgbMFFhuOCHc0HmrwDTvBYQyjgqtQrbTTLtVk26CEURiCihUnGqHJEdabCGVMtkQ
         /4hDmQsosuHVBhGNxVHxV112xXsN5OISJG71OYPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/276] powerpc/perf: Return accordingly on invalid chip-id in
Date:   Wed, 29 May 2019 20:03:40 -0700
Message-Id: <20190530030529.658403050@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



