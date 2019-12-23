Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F28C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC538206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="olLbObS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLWNCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:02:46 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:40734 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfLWNCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:02:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577106166; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/YMggVbc7M6CjZVE5kCb7Ofg44zujSw7jl0Io5iU98k=; b=olLbObS2Q+kQQkjq79FRixkMP7L6yYXDlHkOo4T+RoHn8WrshCzCAFCI5Iv5UQj2ZPlDzhnU
 HYEu3XzGBBEjLgKP/vVLSlAA2z0J/HuxVSZp0kvUL7Kyt1y1Y420FbhpDrAcNu8zQAHqacgX
 VabEtoVJkpLC9duBGQhufnMfjmI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e00baf0.7f77e91640a0-smtp-out-n02;
 Mon, 23 Dec 2019 13:02:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6541BC3D694; Mon, 23 Dec 2019 13:02:40 +0000 (UTC)
Received: from sramana-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sramana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 548BDC3D68C;
        Mon, 23 Dec 2019 13:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 548BDC3D68C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sramana@codeaurora.org
From:   Srinivas Ramana <sramana@codeaurora.org>
To:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Ramana <sramana@codeaurora.org>
Subject: [PATCH] arm64: Set SSBS for user threads while creation
Date:   Mon, 23 Dec 2019 18:32:26 +0530
Message-Id: <1577106146-8999-1-git-send-email-sramana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current SSBS implementation takes care of setting the
SSBS bit in start_thread() for user threads. While this works
for tasks launched with fork/clone followed by execve, for cases
where userspace would just call fork (eg, Java applications) this
leaves the SSBS bit unset. This results in performance
regression for such tasks.

It is understood that commit cbdf8a189a66 ("arm64: Force SSBS
on context switch") masks this issue, but that was done for a
different reason where heterogeneous CPUs(both SSBS supported
and unsupported) are present. It is appropriate to take care
of the SSBS bit for all threads while creation itself.

Fixes: 8f04e8e6e29c ("arm64: ssbd: Add support for PSTATE.SSBS rather than trapping to EL3")
Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
---
 arch/arm64/kernel/process.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 71f788cd2b18..a8f05cc39261 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -399,6 +399,13 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		 */
 		if (clone_flags & CLONE_SETTLS)
 			p->thread.uw.tp_value = childregs->regs[3];
+
+		if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE) {
+			if (is_compat_thread(task_thread_info(p)))
+				set_compat_ssbs_bit(childregs);
+			else
+				set_ssbs_bit(childregs);
+		}
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
