Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21136C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77D820867
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="sG3VQOPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfJDKLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:11:10 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:46706 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729193AbfJDKLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:11:10 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 7E3762E1545;
        Fri,  4 Oct 2019 13:11:07 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id i8ZLUyF8I0-B7V04XEn;
        Fri, 04 Oct 2019 13:11:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570183867; bh=PEYRkN66e68K53kXPyUEIyZkiKjZur7yGuoDnwzr2F0=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=sG3VQOPvxmc61Ka4gpqd4ZNGBXMx2iWNPnajqO8tOJyWFjb7NDC9oNS7ECkObE2LU
         g3bGdWuYKQwj8HfJRhUhvIR9XjB5YPgEtpku4uq9SDA3saUrZi2aybCuzhO9/aiqTB
         g32O9UizWQeKHikZd5aw4lMPm8D1+emShyu0DISs=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2MUv2d990q-B6I0fpBf;
        Fri, 04 Oct 2019 13:11:06 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/swap: piggyback lru_add_drain_all() calls
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 04 Oct 2019 13:11:06 +0300
Message-ID: <157018386639.6110.3058050375244904201.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very slow operation. There is no reason to do it again if somebody
else already drained all per-cpu vectors after we waited for lock.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/swap.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 38c3fa4308e2..6203918e1316 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -708,9 +708,10 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
  */
 void lru_add_drain_all(void)
 {
+	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
 	static DEFINE_MUTEX(lock);
 	static struct cpumask has_work;
-	int cpu;
+	int cpu, seq;
 
 	/*
 	 * Make sure nobody triggers this path before mm_percpu_wq is fully
@@ -719,7 +720,16 @@ void lru_add_drain_all(void)
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
+	seq = raw_read_seqcount_latch(&seqcount);
+
 	mutex_lock(&lock);
+
+	/* Piggyback on drain done by somebody else. */
+	if (__read_seqcount_retry(&seqcount, seq))
+		goto done;
+
+	raw_write_seqcount_latch(&seqcount);
+
 	cpumask_clear(&has_work);
 
 	for_each_online_cpu(cpu) {
@@ -740,6 +750,7 @@ void lru_add_drain_all(void)
 	for_each_cpu(cpu, &has_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
 
+done:
 	mutex_unlock(&lock);
 }
 #else

