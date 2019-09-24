Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C5C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8392054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344146;
	bh=j8Ts51ouzUORb/g+SI+XF3GofZDMGyDqpfF2SFwJASg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZxrWT6pChBCV1F0JQ05oFi/g+TN5A/JV1xA6NQkkawZJhUoyYneQaXCYLML+4yXa
	 3NKAeTNXvPJxQ/FCofglZVjekS+umYJvUALlua6sNaTcwwHSQgOR5c4uB6lq8cnI6O
	 V0pQodR1LzSW5LHmEEG/B99kocYYQTTzvW7NFl/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389719AbfIXQu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410713AbfIXQuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:50:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158C721971;
        Tue, 24 Sep 2019 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343813;
        bh=j8Ts51ouzUORb/g+SI+XF3GofZDMGyDqpfF2SFwJASg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcfK9cVBU3hU5drkUWzVgKfQ0Fh8FZ5Ljo7xp4dj9ImUkmjSGZxVMR3FhTmlAd0B0
         AGmDLxXuEC0Os2ynn2YlpQGg5li7YWx557A6djRY4MfyqSCu9FWEnO7QLPJbTojH4U
         KXheBX/GtAuXJPud7+M+7/hemi810dP7V9C68g+c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 41/50] powerpc/pseries: correctly track irq state in default idle
Date:   Tue, 24 Sep 2019 12:48:38 -0400
Message-Id: <20190924164847.27780-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index ba1791fd3234d..67f49159ea708 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -325,6 +325,9 @@ static void pseries_lpar_idle(void)
 	 * low power mode by ceding processor to hypervisor
 	 */
 
+	if (!prep_irq_for_idle())
+		return;
+
 	/* Indicate to hypervisor that we are idle. */
 	get_lppaca()->idle = 1;
 
-- 
2.20.1

