Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7696C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D84E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998622;
	bh=ozT8akG8Obk+Ucl0aRTQI0020wq3t4w5Lc05Fu/oo9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/Z192bcGqkM0qGuSTBgzUcyQGvbQSO0ElB6AyAPpaePCm7qFRYdEyI759ig5tCXn
	 53i/8dO4LiOwNaJwbgtsvDLO/hyGa49tUSajJ5LunN0hIz6M5MR22KU8fGfI6CPYUH
	 Y6mcnUXQVtPQbJlzm5zX5SFxUAtmgJHaqBwAnvUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392284AbfGXUDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405859AbfGXUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:03:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454292147A;
        Wed, 24 Jul 2019 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998612;
        bh=ozT8akG8Obk+Ucl0aRTQI0020wq3t4w5Lc05Fu/oo9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/vKtbph5QVck84MVHo8gqRmevLKe9UnahIbxEs0Nn9EZT6e9UmseYMHjq26NSXAR
         Q43/E01tE8y6Mys51dV/yughCdWThwllRllLEKs3i+u4Kx1oK2pw5lN6fy7JuCsb46
         2JrvPpM1/R7LnPWhuf3LviiDmKhwX70dtP/Uw4FE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/271] perf test 6: Fix missing kvm module load for s390
Date:   Wed, 24 Jul 2019 21:18:44 +0200
Message-Id: <20190724191659.859189284@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 53fe307dfd309e425b171f6272d64296a54f4dff ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/parse-events.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 3b97ac018d5a..532c95e8fa6b 100644
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
@@ -1622,6 +1648,7 @@ static struct evlist_test test__events[] = {
 	{
 		.name  = "kvm-s390:kvm_s390_create_vm",
 		.check = test__checkevent_tracepoint,
+		.valid = kvm_s390_create_vm_valid,
 		.id    = 100,
 	},
 #endif
-- 
2.20.1



