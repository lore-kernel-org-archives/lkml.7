Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D6DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCBC24679
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078083;
	bh=lQByssjgqWaVZWGX1nyIVM5aR1JZ2it8lsG75l/CR1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AshxUJ3Mn2aWzGnWWRsBaf5BXINgIYu76SKhS+MC+Prf5PQzRznAcxb8Jtu6kXr1I
	 liZ9LBkTR9r1HhdfqlvyATNhuy7SewJIMX7FmpTRYFToeF5Og9bPc2KcNOfDTvdSrx
	 pjFfIfeRPkJPMQkR3y+1A86AU7Pcxm2xKadMvK2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbfLKP2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733108AbfLKP1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:27:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C06222C4;
        Wed, 11 Dec 2019 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078057;
        bh=lQByssjgqWaVZWGX1nyIVM5aR1JZ2it8lsG75l/CR1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyEz/ekuPm0VAL/5WLsJHwdJ6Til5jgeiDkmw63ddywzu5+GERJaLs7SR2ksf0ltW
         YJUCtDlAX/L9KNlX69HULSdg4z0ovU9Kc1Xnps+tXzOeRFmnRTNj3T34ZzIV6rK2OO
         vx6vviJSjsh+A19WIYWC0zbcF9HCw7Mwz1mfLb9U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 50/79] ARM: 8937/1: spectre-v2: remove Brahma-B53 from hardening
Date:   Wed, 11 Dec 2019 10:26:14 -0500
Message-Id: <20191211152643.23056-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152643.23056-1-sashal@kernel.org>
References: <20191211152643.23056-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 4ae5061a19b550dfe25397843427ed2ebab16b16 ]

When the default processor handling was added to the function
cpu_v7_spectre_init() it only excluded other ARM implemented processor
cores. The Broadcom Brahma B53 core is not implemented by ARM so it
ended up falling through into the set of processors that attempt to use
the ARM_SMCCC_ARCH_WORKAROUND_1 service to harden the branch predictor.

Since this workaround is not necessary for the Brahma-B53 this commit
explicitly checks for it and prevents it from applying a branch
predictor hardening workaround.

Fixes: 10115105cb3a ("ARM: spectre-v2: add firmware based hardening")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/proc-v7-bugs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 9a07916af8dd2..a6554fdb56c54 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -65,6 +65,9 @@ static void cpu_v7_spectre_init(void)
 		break;
 
 #ifdef CONFIG_ARM_PSCI
+	case ARM_CPU_PART_BRAHMA_B53:
+		/* Requires no workaround */
+		break;
 	default:
 		/* Other ARM CPUs require no workaround */
 		if (read_cpuid_implementor() == ARM_CPU_IMP_ARM)
-- 
2.20.1

