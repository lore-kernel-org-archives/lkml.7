Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B389DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2B421D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="i1OFqRe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbfJDNJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:09:26 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:60220 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387545AbfJDNJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:09:26 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1ED7D2E0A1C;
        Fri,  4 Oct 2019 16:09:23 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id VpcdspqVFC-9MNGcrnJ;
        Fri, 04 Oct 2019 16:09:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570194563; bh=yAPYaJ3oJgwpDyUBZu6nyxA51pk4jSRQtkpSzJ5+NBA=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=i1OFqRe1V+4wqbQRoJPNi2tgjj9/yhnp69XlwSBAqiTBuAgTNCBXXAPCOLY6clB0Z
         mJg18K6W3/PprBqB3uDMD79kCGuJn107RDoWkcX39kx64Keqzmc+TPhIIrGFJ0W37a
         OMLt9TEj0iSCJu35iUCfASNFufVFQk75bxkUMvls=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id GTiLEDP0fi-9MHuZTQ6;
        Fri, 04 Oct 2019 16:09:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2] mm/swap: piggyback lru_add_drain_all() calls
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Date:   Fri, 04 Oct 2019 16:09:22 +0300
Message-ID: <157019456205.3142.3369423180908482020.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very slow operation. There is no reason to do it again if somebody
else already drained all per-cpu vectors while we waited for lock.

Piggyback on drain started and finished while we waited for lock:
all pages pended at the time of our enter were drained from vectors.

Callers like POSIX_FADV_DONTNEED retry their operations once after
draining per-cpu vectors when pages have unexpected references.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/swap.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 38c3fa4308e2..5ba948a9d82a 100644
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
@@ -719,7 +720,19 @@ void lru_add_drain_all(void)
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
+	seq = raw_read_seqcount_latch(&seqcount);
+
 	mutex_lock(&lock);
+
+	/*
+	 * Piggyback on drain started and finished while we waited for lock:
+	 * all pages pended at the time of our enter were drained from vectors.
+	 */
+	if (__read_seqcount_retry(&seqcount, seq))
+		goto done;
+
+	raw_write_seqcount_latch(&seqcount);
+
 	cpumask_clear(&has_work);
 
 	for_each_online_cpu(cpu) {
@@ -740,6 +753,7 @@ void lru_add_drain_all(void)
 	for_each_cpu(cpu, &has_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
 
+done:
 	mutex_unlock(&lock);
 }
 #else

