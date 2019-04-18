Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791FBC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAD520643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612340;
	bh=EiZ4LZDBeIVEjirXHvURXYS3Qc1t+Mxc082fGfl/nkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wL5KVB0XKH/A/Yxd3gFewkVmkWuN4p6Yh1vjwcUiGn9BsBUagJP/DFUaTrzrYjG2r
	 800ORey10kIv0hOIG9gDVFIYPFwdhJNBi90kFIwutHdJolZUWVMeuOQ3kKX24pd8rw
	 V+76/kKetPOcdFsJtMFkXGPjXh1ciIrQi2sXs+ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbfDRScT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390365AbfDRSA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:00:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75A9206B6;
        Thu, 18 Apr 2019 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610427;
        bh=EiZ4LZDBeIVEjirXHvURXYS3Qc1t+Mxc082fGfl/nkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnsNe0tj8B1y28WiCBEeOCb8qI3UgZCMqj4/H2pNli1VZJUkqhYD93D88fq5JvWNZ
         GNoOd2+2gzUqcHh0LroKWB059NJGx19rwtlq2JldtWQz9lo8J/y/rPkylydABrABRA
         NT5ZXqMeVc4ocOn0PcGfIypSX596KrBPouKMmX10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/110] sched/core: Fix buffer overflow in cgroup2 property cpu.max
Date:   Thu, 18 Apr 2019 19:56:14 +0200
Message-Id: <20190418160440.360399010@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4c47acd824aaaa8fc6dc519fb4e08d1522105b7a ]

Add limit into sscanf format string for on-stack buffer.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified hierarchy")
Link: https://lkml.kernel.org/r/155189230232.2620.13120481613524200065.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a4f57d7e931..d7f409866cdf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6930,7 +6930,7 @@ static int __maybe_unused cpu_period_quota_parse(char *buf,
 {
 	char tok[21];	/* U64_MAX */
 
-	if (!sscanf(buf, "%s %llu", tok, periodp))
+	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
 		return -EINVAL;
 
 	*periodp *= NSEC_PER_USEC;
-- 
2.19.1



