Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD71C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AAE222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078652;
	bh=HpLqA7YodN88GpAC2IbRvhmCOtVCSP2kXuzK96VAEdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qg/3FaHr6xifFjcKjnl8CQGbJuAR5k1LeGm1O/8WyhQ3AAAraJVorQImqW2vhhjU1
	 n0loiWPky48kvjNW4HY6///w1TgAIcDWfZFZwNNxwVWWkRJhCnA3T1+v243eTA59/e
	 7gt+kkfjMxd/JYs/HJn7Ooy786zYyMzHOmI1V3D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbfLKPfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388130AbfLKPfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:35:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5EF24671;
        Wed, 11 Dec 2019 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078523;
        bh=HpLqA7YodN88GpAC2IbRvhmCOtVCSP2kXuzK96VAEdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TT9a3Xn9GyM0CccKNp5csr53f2bOgO6ZEsPtqyZBJIYUPqaHp5ej99YGDjtfHJSz0
         QWjaDs7FUq6deviT4fD6+LsJOjnPCRc89xHE3DWGHNXD64M20Wu+x4vt1lmz2L4udV
         UKCRAumqa2ixrJ25UVJJK0cs4eCnKGvbCHJbk2js=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anthony Steinhauser <asteinhauser@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 12/42] powerpc/security/book3s64: Report L1TF status in sysfs
Date:   Wed, 11 Dec 2019 10:34:40 -0500
Message-Id: <20191211153510.23861-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153510.23861-1-sashal@kernel.org>
References: <20191211153510.23861-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Steinhauser <asteinhauser@google.com>

[ Upstream commit 8e6b6da91ac9b9ec5a925b6cb13f287a54bd547d ]

Some PowerPC CPUs are vulnerable to L1TF to the same extent as to
Meltdown. It is also mitigated by flushing the L1D on privilege
transition.

Currently the sysfs gives a false negative on L1TF on CPUs that I
verified to be vulnerable, a Power9 Talos II Boston 004e 1202, PowerNV
T2P9D01.

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[mpe: Just have cpu_show_l1tf() call cpu_show_meltdown() directly]
Link: https://lore.kernel.org/r/20191029190759.84821-1-asteinhauser@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/security.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 11fff9669cfdf..db66f25c190c9 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -161,6 +161,11 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_l1tf(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_meltdown(dev, attr, buf);
+}
 #endif
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.20.1

