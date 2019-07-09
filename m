Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70C9C004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EA921537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rScy4376"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfGIL3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:29:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGIL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:29:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BTDZP1892629
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:29:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BTDZP1892629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562671754;
        bh=a4rr3aHPycMg9Fdp0EWBaXBmPabFWa3qDlFKnb3CXtQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rScy4376q8YR6dLmMtq2H+vuQQyqU/Qkzlz4aNbFYC0cCgaAWLd3DzbDDuxnK9yLn
         hY+QMkPKn3W+6fVpLO1/I8s7hz8uKaSBtFGIP3HFN0crHSU/0LmXdSAJPXuJ5lqQfr
         IA6ZVwV6VugPe8PwzDcNdKjvuCr5dLj8pf+pIJ6Vbx6mZf/2alKDcWGWFBSSgTkY28
         VK374muwjoTM8HJdHUPIj81xBMSvnsoPzw165eiy3Y+3Zzrc8G6fUFuZh85eAF/oiW
         fZEfBkzzLj0wvFAiLEwKS1HrT2YsNap06ZBWSMwBqDQ+X6CJ+DSsuXl7laSZpCOY98
         DF+D27kyz5Iyg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BTCax1892626;
        Tue, 9 Jul 2019 04:29:12 -0700
Date:   Tue, 9 Jul 2019 04:29:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-c952b35f4b15dd1b83e952718dec3307256383ef@git.kernel.org>
Cc:     songliubraving@fb.com, hpa@zytor.com, davidca@fb.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, tglx@linutronix.de, acme@redhat.com,
          jolsa@kernel.org, davidca@fb.com, hpa@zytor.com,
          songliubraving@fb.com
In-Reply-To: <20190620010453.4118689-1-songliubraving@fb.com>
References: <20190620010453.4118689-1-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Assign proper ff->ph in
 perf_event__synthesize_features()
Git-Commit-ID: c952b35f4b15dd1b83e952718dec3307256383ef
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

Commit-ID:  c952b35f4b15dd1b83e952718dec3307256383ef
Gitweb:     https://git.kernel.org/tip/c952b35f4b15dd1b83e952718dec3307256383ef
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Wed, 19 Jun 2019 18:04:53 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 6 Jul 2019 14:29:04 -0300

perf header: Assign proper ff->ph in perf_event__synthesize_features()

bpf/btf write_* functions need ff->ph->env.

With this missing, pipe-mode (perf record -o -)  would crash like:

Program terminated with signal SIGSEGV, Segmentation fault.

This patch assign proper ph value to ff.

Committer testing:

  (gdb) run record -o -
  Starting program: /root/bin/perf record -o -
  PERFILE2
  <SNIP start of perf.data headers>
  Thread 1 "perf" received signal SIGSEGV, Segmentation fault.
  __do_write_buf (size=4, buf=0x160, ff=0x7fffffff8f80) at util/header.c:126
  126		memcpy(ff->buf + ff->offset, buf, size);
  (gdb) bt
  #0  __do_write_buf (size=4, buf=0x160, ff=0x7fffffff8f80) at util/header.c:126
  #1  do_write (ff=ff@entry=0x7fffffff8f80, buf=buf@entry=0x160, size=4) at util/header.c:137
  #2  0x00000000004eddba in write_bpf_prog_info (ff=0x7fffffff8f80, evlist=<optimized out>) at util/header.c:912
  #3  0x00000000004f69d7 in perf_event__synthesize_features (tool=tool@entry=0x97cc00 <record>, session=session@entry=0x7fffe9c6d010,
      evlist=0x7fffe9cae010, process=process@entry=0x4435d0 <process_synthesized_event>) at util/header.c:3695
  #4  0x0000000000443c79 in record__synthesize (tail=tail@entry=false, rec=0x97cc00 <record>) at builtin-record.c:1214
  #5  0x0000000000444ec9 in __cmd_record (rec=0x97cc00 <record>, argv=<optimized out>, argc=0) at builtin-record.c:1435
  #6  cmd_record (argc=0, argv=<optimized out>) at builtin-record.c:2450
  #7  0x00000000004ae3e9 in run_builtin (p=p@entry=0x98e058 <commands+216>, argc=argc@entry=3, argv=0x7fffffffd670) at perf.c:304
  #8  0x000000000042eded in handle_internal_command (argv=<optimized out>, argc=<optimized out>) at perf.c:356
  #9  run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:400
  #10 main (argc=3, argv=<optimized out>) at perf.c:522
  (gdb)

After the patch the SEGSEGV is gone.

Reported-by: David Carrillo Cisneros <davidca@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: kernel-team@fb.com
Cc: stable@vger.kernel.org # v5.1+
Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
Link: http://lkml.kernel.org/r/20190620010453.4118689-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 847ae51a524b..fb0aa661644b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3602,6 +3602,7 @@ int perf_event__synthesize_features(struct perf_tool *tool,
 		return -ENOMEM;
 
 	ff.size = sz - sz_hdr;
+	ff.ph = &session->header;
 
 	for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
 		if (!feat_ops[feat].synthesize) {
