Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE6C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F4421852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508805;
	bh=kWl7ki8gD50y+AFBXm5vB+yb+O7/3/NGsP6VegL2F0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VZvUhmmsxol3sXcGZmE0OMG+18f/ADt6/23g2Q1MzE6w7rSXAJNK6q8UWmcFhP0Wc
	 TxmFO2kLDTifTfcMaq493TCSs/DuD6x7P4ZDV8GZyryMdOoU1K/uTXvgsXh7HHFJp/
	 P4zr+/qLMZSOcMStpRoyYWYjnfkUv/CPum7/zcM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfGSEAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbfGSD77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:59:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877E021897;
        Fri, 19 Jul 2019 03:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508798;
        bh=kWl7ki8gD50y+AFBXm5vB+yb+O7/3/NGsP6VegL2F0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cp1Rb85DBhJArJstpDhveczPT0w23hE4wch7TE6I+wnphX8WFYmf2wI62l707iBTD
         Cn1dScaQ3JKqyhqhVocjvT7MEd/6RKDVY0pp6PcyXG3WY3FCoyidjUntzvauuzo9Et
         usZMQPC1MHNajFvlUnCGIE/fIEHSRiqGCutBlTMw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.2 094/171] powerpc/rtas: retry when cpu offline races with suspend/migration
Date:   Thu, 18 Jul 2019 23:55:25 -0400
Message-Id: <20190719035643.14300-94-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit 9fb603050ffd94f8127df99c699cca2f575eb6a0 ]

The protocol for suspending or migrating an LPAR requires all present
processor threads to enter H_JOIN. So if we have threads offline, we
have to temporarily bring them up. This can race with administrator
actions such as SMT state changes. As of dfd718a2ed1f ("powerpc/rtas:
Fix a potential race between CPU-Offline & Migration"),
rtas_ibm_suspend_me() accounts for this, but errors out with -EBUSY
for what almost certainly is a transient condition in any reasonable
scenario.

Callers of rtas_ibm_suspend_me() already retry when -EAGAIN is
returned, and it is typical during a migration for that to happen
repeatedly for several minutes polling the H_VASI_STATE hcall result
before proceeding to the next stage.

So return -EAGAIN instead of -EBUSY when this race is
encountered. Additionally: logging this event is still appropriate but
use pr_info instead of pr_err; and remove use of unlikely() while here
as this is not a hot path at all.

Fixes: dfd718a2ed1f ("powerpc/rtas: Fix a potential race between CPU-Offline & Migration")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/rtas.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index b824f4c69622..fff2eb22427d 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -980,10 +980,9 @@ int rtas_ibm_suspend_me(u64 handle)
 	cpu_hotplug_disable();
 
 	/* Check if we raced with a CPU-Offline Operation */
-	if (unlikely(!cpumask_equal(cpu_present_mask, cpu_online_mask))) {
-		pr_err("%s: Raced against a concurrent CPU-Offline\n",
-		       __func__);
-		atomic_set(&data.error, -EBUSY);
+	if (!cpumask_equal(cpu_present_mask, cpu_online_mask)) {
+		pr_info("%s: Raced against a concurrent CPU-Offline\n", __func__);
+		atomic_set(&data.error, -EAGAIN);
 		goto out_hotplug_enable;
 	}
 
-- 
2.20.1

