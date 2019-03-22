Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8C1218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253813;
	bh=FQm5p6VRF6Hrs39Azz1XFAqZIlJss/d9zS5xkb1kGdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYczfxzVZGR7mRY2++c0R3REAu11Md5qlXnDODqRYt8OiuqPp2O/9ZAcGD67HvfmC
	 xo9RkEkSzf2PV/b8Zhwp6ZEiVU47WMOqidcS18D5tL4OEMgbgGvt5NfuusmeFBVNvl
	 bgMswyGnrwtLbnwraesmRS8HTppCnwIVZdiNCXak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfCVLXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbfCVLX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:23:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEB12190A;
        Fri, 22 Mar 2019 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253808;
        bh=FQm5p6VRF6Hrs39Azz1XFAqZIlJss/d9zS5xkb1kGdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kng6jOXT3PxW+7Rzqf5IpIFlmnxNo+0+ltNKyEC7jmXGY1/Vc4fUYZqC6eHVSeKMb
         hGi+mNCcKB6gNJKWrXKH2BkF3A3yJsKaKV4MLrHpG/suK0uCm8zjxyrj3GSQ+CqS16
         kf2svvwdv6idDRBEenHRi8yHIVNQzZbRBXlksYaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 061/134] xtensa: SMP: mark each possible CPU as present
Date:   Fri, 22 Mar 2019 12:14:34 +0100
Message-Id: <20190322111214.440355160@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8b1c42cdd7181200dc1fff39dcb6ac1a3fac2c25 ]

Otherwise it is impossible to enable CPUs after booting with 'maxcpus'
parameter.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 545144d1431d..0e34c1ed4aa8 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -80,7 +80,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned i;
 
-	for (i = 0; i < max_cpus; ++i)
+	for_each_possible_cpu(i)
 		set_cpu_present(i, true);
 }
 
-- 
2.19.1



