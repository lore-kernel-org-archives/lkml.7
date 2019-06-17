Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83700C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC282084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LAJWnc16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfFQTvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:51:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQTvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:51:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJpVbx3570683
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:51:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJpVbx3570683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560801092;
        bh=ajPtP+hrKGqTFCy298+Rb6XDfngvQ5oKq5u+w3yWbh8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LAJWnc16uGR+NFDXtp2NvquBM+xeRaYulB5gYxiIzelLvPduL0EXdpDBQ8LelgfY7
         H7QEwPsrquqlbqPYCAZBt2/XchFdDaI8sNNrmpFKPLRgj8bss8Nr4cWpHOmRabEz5b
         SVaX1oLpgGxVYzopxSO1HhhD+WayXJIiyn5CUYPAVJPzSzlb1kcwcHxiPfE1f9zH4H
         L/Y92hc6rA13L3S3VjbLjg/hR2Vn6TsQKvfiSWUAVqPL23PCtvHGjbwclBdg5sCG1q
         KUqbCue8dgtmyd7cOEj5/VHJgwOGzlsBOaPjN+KW3abqYb5OFldvRo/VfVpeAgj2cs
         pCgY2+BAyxPzw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJpVqk3570680;
        Mon, 17 Jun 2019 12:51:31 -0700
Date:   Mon, 17 Jun 2019 12:51:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-53fe307dfd309e425b171f6272d64296a54f4dff@git.kernel.org>
Cc:     tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        mingo@kernel.org, borntraeger@de.ibm.com, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: brueckner@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          tmricht@linux.ibm.com, acme@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
          mingo@kernel.org
In-Reply-To: <20190604053504.43073-1-tmricht@linux.ibm.com>
References: <20190604053504.43073-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test 6: Fix missing kvm module load for s390
Git-Commit-ID: 53fe307dfd309e425b171f6272d64296a54f4dff
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

Commit-ID:  53fe307dfd309e425b171f6272d64296a54f4dff
Gitweb:     https://git.kernel.org/tip/53fe307dfd309e425b171f6272d64296a54f4dff
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Tue, 4 Jun 2019 07:35:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:13 -0300

perf test 6: Fix missing kvm module load for s390

Command

   # perf test -Fv 6

fails with error

   running test 100 'kvm-s390:kvm_s390_create_vm' failed to parse
    event 'kvm-s390:kvm_s390_create_vm', err -1, str 'unknown tracepoint'
    event syntax error: 'kvm-s390:kvm_s390_create_vm'
                         \___ unknown tracepoint

when the kvm module is not loaded or not built in.

Fix this by adding a valid function which tests if the module
is loaded. Loaded modules (or builtin KVM support) have a
directory named
  /sys/kernel/debug/tracing/events/kvm-s390
for this tracepoint.

Check for existence of this directory.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190604053504.43073-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4a69c07f4101..8f3c80e13584 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -18,6 +18,32 @@
 #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
 
+#if defined(__s390x__)
+/* Return true if kvm module is available and loaded. Test this
+ * and retun success when trace point kvm_s390_create_vm
+ * exists. Otherwise this test always fails.
+ */
+static bool kvm_s390_create_vm_valid(void)
+{
+	char *eventfile;
+	bool rc = false;
+
+	eventfile = get_events_file("kvm-s390");
+
+	if (eventfile) {
+		DIR *mydir = opendir(eventfile);
+
+		if (mydir) {
+			rc = true;
+			closedir(mydir);
+		}
+		put_events_file(eventfile);
+	}
+
+	return rc;
+}
+#endif
+
 static int test__checkevent_tracepoint(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__first(evlist);
@@ -1642,6 +1668,7 @@ static struct evlist_test test__events[] = {
 	{
 		.name  = "kvm-s390:kvm_s390_create_vm",
 		.check = test__checkevent_tracepoint,
+		.valid = kvm_s390_create_vm_valid,
 		.id    = 100,
 	},
 #endif
