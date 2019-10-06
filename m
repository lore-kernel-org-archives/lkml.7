Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07809C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF5621479
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384544;
	bh=7n+wym7xP2UaLFtaocy+zLj89/hGGwRuD0CgKErsl84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G9H5BavfDXrkRQJExm+tpE5dEtiRG8TGJiIFrJGpEbw2Ubl9QtD/Cm5PjF3I2/4vb
	 TI6pB5YEACeFIYu7OaOZI3LChJF7bcjgDc5lPB0shMeeBHr98g6zDn4zXdhscETp50
	 HbNqrs+Luezf1GQO5tEVIlOLsiTfmo5brz/IErFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfJFRzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfJFRgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:36:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F06A2064A;
        Sun,  6 Oct 2019 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383362;
        bh=7n+wym7xP2UaLFtaocy+zLj89/hGGwRuD0CgKErsl84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8HYbMN+ykRvOwk2hYvRXevlPIIqHbnwKC6ct7D8UP+ftYD3XbgTgBG9ldEy3w0AL
         vWVEB7ViR7ybzmD2nyac6hflEhomfV/zMpi9heQR0hKt2tLAPE70kwOWKdlze6Hbla
         tQWd5Iz4yxakg9fjxgGWlzUJUmfB5Z1X4bLvAcDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 075/137] powerpc/pseries: correctly track irq state in default idle
Date:   Sun,  6 Oct 2019 19:20:59 +0200
Message-Id: <20191006171215.286934954@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit 92c94dfb69e350471473fd3075c74bc68150879e ]

prep_irq_for_idle() is intended to be called before entering
H_CEDE (and it is used by the pseries cpuidle driver). However the
default pseries idle routine does not call it, leading to mismanaged
lazy irq state when the cpuidle driver isn't in use. Manifestations of
this include:

* Dropped IPIs in the time immediately after a cpu comes
  online (before it has installed the cpuidle handler), making the
  online operation block indefinitely waiting for the new cpu to
  respond.

* Hitting this WARN_ON in arch_local_irq_restore():
	/*
	 * We should already be hard disabled here. We had bugs
	 * where that wasn't the case so let's dbl check it and
	 * warn if we are wrong. Only do that when IRQ tracing
	 * is enabled as mfmsr() can be costly.
	 */
	if (WARN_ON_ONCE(mfmsr() & MSR_EE))
		__hard_irq_disable();

Call prep_irq_for_idle() from pseries_lpar_idle() and honor its
result.

Fixes: 363edbe2614a ("powerpc: Default arch idle could cede processor on pseries")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190910225244.25056-1-nathanl@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 8fa012a65a712..cc682759feae8 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -344,6 +344,9 @@ static void pseries_lpar_idle(void)
 	 * low power mode by ceding processor to hypervisor
 	 */
 
+	if (!prep_irq_for_idle())
+		return;
+
 	/* Indicate to hypervisor that we are idle. */
 	get_lppaca()->idle = 1;
 
-- 
2.20.1



