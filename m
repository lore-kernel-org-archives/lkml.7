Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD29C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE0720803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381380;
	bh=UTt0p+fZln3ylcuVLjbpg84Jj+jDRzeu4DqVYohTfac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=idA99NsxqyIKaXct6amBZ3o3h0bLU3acckPQFxkZBbhPoxTJAkzwHa8FYCPJPcfb/
	 MVy7QcEkAvTcJJ+OpM2VLWoGXTlch4oWU2Ue5+s6/IhQOAGOLeiyyfDpyylD7ryq/A
	 pBoEevt0phvosgR368cwqWP7n+GEE6pDpTJz+iJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLCN4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfLCN4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:56:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 174F3206DF;
        Tue,  3 Dec 2019 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381377;
        bh=UTt0p+fZln3ylcuVLjbpg84Jj+jDRzeu4DqVYohTfac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mr5yeL9mQMjy9JYx1DLKF/XBlU6gOdwQp1ThEH7xrEwaXsajZorAItFM3Q+7mqmFE
         d48xtYIFmO5DW1ECPiveKp8Kd9UHJ8q+WgW+uxcxsjJwph4z/bggh005PkjEfKNr7S
         xrSKP5S6Er5L+0IvwIipkZtVUR7YwvF1D1iw041I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/23] perf cpumap: Maintain cpumaps ordered and without dups
Date:   Tue,  3 Dec 2019 10:55:44 -0300
Message-Id: <20191203135606.24902-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Enforce this in _trim()

Needed for followon change.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 2ca1fafa620d..d81656b4635e 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -68,14 +68,28 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 	return cpus;
 }
 
+static int cmp_int(const void *a, const void *b)
+{
+	return *(const int *)a - *(const int*)b;
+}
+
 static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 {
 	size_t payload_size = nr_cpus * sizeof(int);
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
+	int i, j;
 
 	if (cpus != NULL) {
-		cpus->nr = nr_cpus;
 		memcpy(cpus->map, tmp_cpus, payload_size);
+		qsort(cpus->map, nr_cpus, sizeof(int), cmp_int);
+		/* Remove dups */
+		j = 0;
+		for (i = 0; i < nr_cpus; i++) {
+			if (i == 0 || cpus->map[i] != cpus->map[i - 1])
+				cpus->map[j++] = cpus->map[i];
+		}
+		cpus->nr = j;
+		assert(j <= nr_cpus);
 		refcount_set(&cpus->refcnt, 1);
 	}
 
-- 
2.21.0

