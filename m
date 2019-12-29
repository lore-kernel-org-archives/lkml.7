Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFD0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0CC206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641791;
	bh=pY5RMKT8cgvlRPtL4xg+luLIwlAVdWKVgAjk5DNaUYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JK6gI7ebHiscaO4CdK6CTAvY/1q1zWv5oOrMScZxrJonSjk+rf6S+Ep46DGtiiuiY
	 Kcr0weMpQ3R/lDEAVji6TfbGXi0agwXMx2uhjkR2cU/hV/dwHp4RQevrecDJpvztMX
	 9wpjh2TxUjbWN/r78J2a4l1UaXNAn6zk4tEHpG20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfL2Rtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbfL2Rtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:49:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926F1206A4;
        Sun, 29 Dec 2019 17:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641785;
        bh=pY5RMKT8cgvlRPtL4xg+luLIwlAVdWKVgAjk5DNaUYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bgnyl2QiF72bnma+jwfGkhU3JZQsx4A3vVoN6hI2XncgXwcUeYmd7urIPGP4ehIN9
         cPZp/ta5jiLQVo+qgAvV7+By58cT+e8azpNNdATi+TmdLfTv79mxH3t5tm7ZIqz8DH
         cO5polCKxFQDniAfPyk6aDLPlvgI1+pvaWeVXBQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 210/434] s390: add error handling to perf_callchain_kernel
Date:   Sun, 29 Dec 2019 18:24:23 +0100
Message-Id: <20191229172715.778459235@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit effb83ccc83a97dbbe5214f4c443522719f05f3a ]

perf_callchain_kernel stops neither when it encounters a garbage
address, nor when it runs out of space. Fix both issues using x86
version as an inspiration.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_event.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index fcb6c2e92b07..1e75cc983546 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -224,9 +224,13 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
 	struct unwind_state state;
+	unsigned long addr;
 
-	unwind_for_each_frame(&state, current, regs, 0)
-		perf_callchain_store(entry, state.ip);
+	unwind_for_each_frame(&state, current, regs, 0) {
+		addr = unwind_get_return_address(&state);
+		if (!addr || perf_callchain_store(entry, addr))
+			return;
+	}
 }
 
 /* Perf definitions for PMU event attributes in sysfs */
-- 
2.20.1



