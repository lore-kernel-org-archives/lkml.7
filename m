Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77930C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F45C21871
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596098;
	bh=ot/6uJw/B4UWi3+CoLxc+GP6vTTK+Bxizzmegvr2GrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0TeRSW8mheuF/srdWFXrhlVMigLxOQTh+pqrX8EQlYFbI7q1tmVn4kKKyQZ4f+Dhy
	 GeJbhZ0rflQwl88folOV/TFzDvSqoaJbeuvyvh0X3RNEWk0WcqemmxI438nJG+O++4
	 QS72vNEtdVjLoeuWUrHUIDq6mERQBAVmm8zkWzIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfF0Alf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbfF0Ald (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:41:33 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BAA21852;
        Thu, 27 Jun 2019 00:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596092;
        bh=ot/6uJw/B4UWi3+CoLxc+GP6vTTK+Bxizzmegvr2GrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrQAEM47pN/EZ/DYSyGGL44pZMzgeSARN0PuiMNkVNZstGXRV3PNk7Zm56CUOJoLu
         mxADS84vUNvLDFWQ+4gSRPrIP919tzKSFipZykr2lv32Bp0Kb2KFAzerOVsFa7BOpF
         sT7ztyFA1kSkhXMNlfLeSrbpjbIef0f9mQmjRAvo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chang-Hsien Tsai <luke.tw@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/21] samples, bpf: fix to change the buffer size for read()
Date:   Wed, 26 Jun 2019 20:41:02 -0400
Message-Id: <20190627004122.21671-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627004122.21671-1-sashal@kernel.org>
References: <20190627004122.21671-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chang-Hsien Tsai <luke.tw@gmail.com>

[ Upstream commit f7c2d64bac1be2ff32f8e4f500c6e5429c1003e0 ]

If the trace for read is larger than 4096, the return
value sz will be 4096. This results in off-by-one error
on buf:

    static char buf[4096];
    ssize_t sz;

    sz = read(trace_fd, buf, sizeof(buf));
    if (sz > 0) {
        buf[sz] = 0;
        puts(buf);
    }

Signed-off-by: Chang-Hsien Tsai <luke.tw@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/bpf_load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index 97913e109b14..99e5a2f63e76 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -369,7 +369,7 @@ void read_trace_pipe(void)
 		static char buf[4096];
 		ssize_t sz;
 
-		sz = read(trace_fd, buf, sizeof(buf));
+		sz = read(trace_fd, buf, sizeof(buf) - 1);
 		if (sz > 0) {
 			buf[sz] = 0;
 			puts(buf);
-- 
2.20.1

