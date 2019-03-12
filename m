Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D223C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5395D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413409;
	bh=mtQIKaLnU+KIxKh3ea1kSdS5zkmucnpfTilaEy9VMSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NXVZEQdRXNSVKURtfskrk831m8wWvqrVfi5brEQ95iQ7U2Q/AvCY/ccPI9hiVjXZb
	 6QubBl7hUFI9CafJLJHKw+psKE45NOAFvboOiTAyvkz6JboeO+e9wQTnMFyUgq52Sn
	 LOK7x0U/ZjDQ9A0WveTB7FK9dVSG+kfUsK2psUfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfCLR4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfCLRNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:53 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E163B2171F;
        Tue, 12 Mar 2019 17:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410833;
        bh=mtQIKaLnU+KIxKh3ea1kSdS5zkmucnpfTilaEy9VMSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7uFgqSpFLmaaeEytN0dMuCvdxSBE0+b9dQooT+exfp+eGT4L1IFy87h70yxcXNMT
         dqfVMMPvpzAcs4qs2ly08/7JgUfHmwY24MIhVtyaaNkPwjGBfWbBFi/Djc4vJyx6OY
         B4gnwFzI+JPAVHA7ubjbPHrmMEbwTMaHx9rYDEnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/149] xtensa: SMP: mark each possible CPU as present
Date:   Tue, 12 Mar 2019 10:07:19 -0700
Message-Id: <20190312170351.423368967@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index c9fc2c4f71b3..80be6449c497 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -83,7 +83,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned i;
 
-	for (i = 0; i < max_cpus; ++i)
+	for_each_possible_cpu(i)
 		set_cpu_present(i, true);
 }
 
-- 
2.19.1



