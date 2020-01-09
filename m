Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08772072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ZbAMGnEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgAINN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:13:56 -0500
Received: from mout02.posteo.de ([185.67.36.66]:42989 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgAINN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:13:56 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 865F42400FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jan 2020 14:13:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1578575634; bh=PB9Ej3EWa3+KK+heK71BgEggklKKtpIjN4PVRVkqtVk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZbAMGnEou+EOzFbVrzRChQHS3kQnZOWV2NX3MyxbQvf4Dsoq3+/JR26uifIo8L8K7
         G87ASBQg0ihYFSvkY0cbS4dI+0sp5jGsPhjezA4DTORioPWqK1sHfmytu/a/akp0fh
         CIN43rcMmIGw0CYSTm5B462TQpuWAFOTBh5H8Eb72YPdooxkKiaub4l9S7VYy2wujh
         dK36IQc2yjJnoqj+OybZWOBiK8JK+5Ywolrk2KSb2aA22wj8MGCiOI6rWf0k/uvPXZ
         AEsCDR6gSnItnvo7idlwiiipu/crnqY0W3LOwYdCsWQDKb3QEaMCTpyvbOfhBb+qkK
         nKj0B7dpVD8WQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47tmlk0cqWz9rxN;
        Thu,  9 Jan 2020 14:13:53 +0100 (CET)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] kernel/events: Add a missing prototype for arch_perf_update_userpage()
Date:   Thu,  9 Jan 2020 14:13:51 +0100
Message-Id: <20200109131351.9468-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... in order to fix a -Wmissing-prototype warning.

No functional changes.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 include/linux/perf_event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..de3874271814 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1544,4 +1544,7 @@ int perf_event_exit_cpu(unsigned int cpu);
 #define perf_event_exit_cpu	NULL
 #endif
 
+void __weak arch_perf_update_userpage(
+	struct perf_event *event, struct perf_event_mmap_page *userpg, u64 now);
+
 #endif /* _LINUX_PERF_EVENT_H */
-- 
2.17.1

