Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A96C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCBB2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="paZd7erJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGMLDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:03:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34529 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfGMLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:03:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB3Aoj3839074
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:03:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB3Aoj3839074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015791;
        bh=3xOcDZE4Dn3I3GEUK1XwtHkmYbrhnwlVEsFY+1Bxv/Q=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=paZd7erJjb5q+ZrNsIqZcSh0Hn0L/h0GyAhU86VzkxhbqA0BNWUa/2gGVr+vXaaCU
         KBVN7TepaxB8yf0h+XlN1gXYbnjql/dRM7CZRsiVJq9fWGhTuj5NmSXp2G2qYxHNK+
         xcTok/pdg54L7vE+nuIpf8rCYjjfiem4ZVZQrK6rKG6fyNRdHvpCcpMMRhnCIuCdyf
         6TBB5ccC2Kii7jaOJiMOD+io6z+KNGbuSHQvmOJ9JjqliYErWKlXeT6hkPXVVHRT/1
         zC4YRvMXjhDZlb5gEDNFrSkSshinMdvGOkyiFNwUgxc+dAUXnDwClyy8ohW2nQcaob
         eAjtwHMMLlQwA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB39aS3839071;
        Sat, 13 Jul 2019 04:03:09 -0700
Date:   Sat, 13 Jul 2019 04:03:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dxzj1ah350fy9ec0xbhb15b6@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, ak@linux.intel.com
Reply-To: mingo@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          ak@linux.intel.com, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf metricgroup: Add missing list_del_init()
 when flushing egroups list
Git-Commit-ID: acc7bfb3db9744c4a18c96fd6536069e8647cb11
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  acc7bfb3db9744c4a18c96fd6536069e8647cb11
Gitweb:     https://git.kernel.org/tip/acc7bfb3db9744c4a18c96fd6536069e8647cb11
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 4 Jul 2019 12:20:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:27 -0300

perf metricgroup: Add missing list_del_init() when flushing egroups list

So that at the end each of the entries have its list node struct cleared
and the egroup list head ends emptied.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dxzj1ah350fy9ec0xbhb15b6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0d8c840f88c0..416a9015405e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -492,6 +492,7 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 		for (i = 0; i < eg->idnum; i++)
 			zfree(&eg->ids[i]);
 		zfree(&eg->ids);
+		list_del_init(&eg->nd);
 		free(eg);
 	}
 }
