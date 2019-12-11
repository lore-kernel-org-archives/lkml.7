Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB63C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3834D2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079935;
	bh=U2C69MNLaSO6Y0NTKcM6QCvHTZjD6tMLoLQs47BJnaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YblIrb4oKjcjVunWKebsRhoVIuq6y6iqTFdOxWOGeIAsDxm1rtX7lX/KROsxPPagE
	 VkxK7OF/HVa4W6I/RJX+i108zATPcpp/PUAURqEppYoxbvhy47PIbZZ2fqTuL37n6c
	 mCvo5AWcRkznBYBBzDUNUB4/8vz4GbFuyeBvyZgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbfLKP6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbfLKPOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288032467A;
        Wed, 11 Dec 2019 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077253;
        bh=U2C69MNLaSO6Y0NTKcM6QCvHTZjD6tMLoLQs47BJnaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZ5bRElAQ6JsBbMvVmYfpWBL0DG67DE9/xkVo9ZiMfbskIpX37iyfEYe/fbtlbtWA
         eaW7Umiq8Fi9kWCaIEZBVS02/7iH+DDXkNqW2FFB+jOPTN7WZomSTbdebTcSjJbVvF
         qrDLh5mL23Wl/gMQBm5g+G+PwfRZzPnB2ANkHr+8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 130/134] s390: disable preemption when switching to nodat stack with CALL_ON_STACK
Date:   Wed, 11 Dec 2019 10:11:46 -0500
Message-Id: <20191211151150.19073-130-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 7f28dad395243c5026d649136823bbc40029a828 ]

Make sure preemption is disabled when temporary switching to nodat
stack with CALL_ON_STACK helper, because nodat stack is per cpu.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/machine_kexec.c |  2 ++
 arch/s390/mm/maccess.c           | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 444a19125a815..dcaadceaf6efc 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -164,7 +164,9 @@ static bool kdump_csum_valid(struct kimage *image)
 #ifdef CONFIG_CRASH_DUMP
 	int rc;
 
+	preempt_disable();
 	rc = CALL_ON_STACK(do_start_kdump, S390_lowcore.nodat_stack, 1, image);
+	preempt_enable();
 	return rc == 0;
 #else
 	return false;
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index 1864a8bb9622f..88d5fcf67a2f1 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -115,9 +115,15 @@ static unsigned long _memcpy_real(unsigned long dest, unsigned long src,
  */
 int memcpy_real(void *dest, void *src, size_t count)
 {
-	if (S390_lowcore.nodat_stack != 0)
-		return CALL_ON_STACK(_memcpy_real, S390_lowcore.nodat_stack,
-				     3, dest, src, count);
+	int rc;
+
+	if (S390_lowcore.nodat_stack != 0) {
+		preempt_disable();
+		rc = CALL_ON_STACK(_memcpy_real, S390_lowcore.nodat_stack, 3,
+				   dest, src, count);
+		preempt_enable();
+		return rc;
+	}
 	/*
 	 * This is a really early memcpy_real call, the stacks are
 	 * not set up yet. Just call _memcpy_real on the early boot
-- 
2.20.1

