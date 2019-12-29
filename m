Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9349CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4F207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642455;
	bh=/2cofFv4jiQcCenMb/O5CQ05iDJ500lxRiBNuVyfjP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OeWSyKRw5qPQzu5IYB8NMVUieki5JS2OdFznx0GN91tuZVODlCr3TKvZYgCaef8yz
	 U255Wafl2u4RixDQz1cSsU+nWyVM1ofe2iV9KKYj80wW/7EACDChrTP0txsQEW7NvD
	 vYB8eWQb3tvfAfmK9aknpEw4NRnsiK9VriQEVqJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfL2R4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733116AbfL2R4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:56:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6638B206DB;
        Sun, 29 Dec 2019 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642203;
        bh=/2cofFv4jiQcCenMb/O5CQ05iDJ500lxRiBNuVyfjP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwa+dyV1VOf8vhYlik9FrdgO1SAXWFKMhjGKWsWrCRr4Vrpcepvn9cQkFimmGTAi2
         QPMnJih1MwbTKCCbGdltwAh9v/togH2Dk704nIb1A0FhZqqUlUPgxQq8SstfxNORyd
         ZRvx0p78nXrML9iVMS2GS4JR+rLRBM2KbJybNqAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 386/434] s390/ftrace: fix endless recursion in function_graph tracer
Date:   Sun, 29 Dec 2019 18:27:19 +0100
Message-Id: <20191229172727.853730954@linuxfoundation.org>
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

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 6feeee8efc53035c3195b02068b58ae947538aa4 ]

The following sequence triggers a kernel stack overflow on s390x:

mount -t tracefs tracefs /sys/kernel/tracing
cd /sys/kernel/tracing
echo function_graph > current_tracer
[crash]

This is because preempt_count_{add,sub} are in the list of traced
functions, which can be demonstrated by:

echo preempt_count_add >set_ftrace_filter
echo function_graph > current_tracer
[crash]

The stack overflow happens because get_tod_clock_monotonic() gets called
by ftrace but itself calls preempt_{disable,enable}(), which leads to a
endless recursion. Fix this by using preempt_{disable,enable}_notrace().

Fixes: 011620688a71 ("s390/time: ensure get_clock_monotonic() returns monotonic values")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/timex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 0f12a3f91282..2dc9eb4e1acc 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -195,9 +195,9 @@ static inline unsigned long long get_tod_clock_monotonic(void)
 {
 	unsigned long long tod;
 
-	preempt_disable();
+	preempt_disable_notrace();
 	tod = get_tod_clock() - *(unsigned long long *) &tod_clock_base[1];
-	preempt_enable();
+	preempt_enable_notrace();
 	return tod;
 }
 
-- 
2.20.1



