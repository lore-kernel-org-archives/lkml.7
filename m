Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB79C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBD92075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OJ4KXkdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfE1V1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:27:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfE1V1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:27:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLRbo12240590
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:27:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLRbo12240590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078858;
        bh=eB6S3JZsatiKfk2iegX2c11Iq0DU+iBJPXyPdC2IlsA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OJ4KXkdUwK3dwiTY2DHtwvWWANRoFR89rYzSQMny0HXrSPacoYLUvAYKc7Rhj1mPg
         GnIQir5DkkVhzYtGZM1ACzLcfQArWthxi1mlU1EtwgAvOyoASNBK0EAtyodcuOgIh2
         j1SguRgu0u8Jegq1ZNrViakHk6PBdxlOCRT0AcRCWCdNhLK50No4jPMEx2Ci5ivMxF
         iC4PVNYomVlNJVwzGUq6FC5xSmh3WZwuhwqif/MCcCrcL5ou9ANe9Xc0Ut1T05k8Yf
         kYlEY98kFNvMhfPcKAZJp2nJRdX+zUXQzFYaa9H86YTI9YX3xiMvaXDgjU3XrxgKxR
         inxLr/Sd1Q7VA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLRbNv2240587;
        Tue, 28 May 2019 14:27:37 -0700
Date:   Tue, 28 May 2019 14:27:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Namhyung Kim <tipbot@zytor.com>
Message-ID: <tip-6584140ba9e6762dd7ec73795243289b914f31f9@git.kernel.org>
Cc:     hbathini@linux.vnet.ibm.com, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        kjlx@templeofstupid.com, jolsa@redhat.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: hbathini@linux.vnet.ibm.com, mingo@kernel.org,
          namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, kjlx@templeofstupid.com,
          jolsa@redhat.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190522053250.207156-2-namhyung@kernel.org>
References: <20190522053250.207156-2-namhyung@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf namespace: Protect reading thread's
 namespace
Git-Commit-ID: 6584140ba9e6762dd7ec73795243289b914f31f9
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

Commit-ID:  6584140ba9e6762dd7ec73795243289b914f31f9
Gitweb:     https://git.kernel.org/tip/6584140ba9e6762dd7ec73795243289b914f31f9
Author:     Namhyung Kim <namhyung@kernel.org>
AuthorDate: Wed, 22 May 2019 14:32:48 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:52:23 -0300

perf namespace: Protect reading thread's namespace

It seems that the current code lacks holding the namespace lock in
thread__namespaces().  Otherwise it can see inconsistent results.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Link: http://lkml.kernel.org/r/20190522053250.207156-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 403045a2bbea..b413ba5b9835 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -133,7 +133,7 @@ void thread__put(struct thread *thread)
 	}
 }
 
-struct namespaces *thread__namespaces(const struct thread *thread)
+static struct namespaces *__thread__namespaces(const struct thread *thread)
 {
 	if (list_empty(&thread->namespaces_list))
 		return NULL;
@@ -141,10 +141,21 @@ struct namespaces *thread__namespaces(const struct thread *thread)
 	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
 }
 
+struct namespaces *thread__namespaces(const struct thread *thread)
+{
+	struct namespaces *ns;
+
+	down_read((struct rw_semaphore *)&thread->namespaces_lock);
+	ns = __thread__namespaces(thread);
+	up_read((struct rw_semaphore *)&thread->namespaces_lock);
+
+	return ns;
+}
+
 static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 				    struct namespaces_event *event)
 {
-	struct namespaces *new, *curr = thread__namespaces(thread);
+	struct namespaces *new, *curr = __thread__namespaces(thread);
 
 	new = namespaces__new(event);
 	if (!new)
