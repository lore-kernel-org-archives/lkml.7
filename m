Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEC0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E83C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414258;
	bh=QXJ1pg1/fHdxPQl6fb9NAqpJaoxvlOq1jUKRH540lMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iEnMdID5BdRRqa59XNgMZoAnZt+jkxcX+jfG/QpMLSYpHd4hLmIetfPzk9k4kHfpb
	 jkfTlWvMGA0CYRbLeEXC0xe3UlBbLU7U99btoUw98evsi4MEjdZcZzudxJRkE5PKFY
	 mkvrvmjVekfRwKadeH/iyvWP5sn9BdI1ejmhzwIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfCLSK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfCLRLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:48 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F276921773;
        Tue, 12 Mar 2019 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410708;
        bh=QXJ1pg1/fHdxPQl6fb9NAqpJaoxvlOq1jUKRH540lMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uN9MmGaQaSM8Tpgpds0xPR/WBOY81T9JBLNUdX1y8oMFOj2N1Iq8fj7fqb1LzpU96
         Emc0RENIVm+KMkEpFyvJihsUgZBN/dYSOFxNCkaZ5AwBqFwmRESQ03NNRjJmBSijva
         qZ5cLZ5tlDt9+RYjiCodeDaiGP1H0xh1+1d9WTzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 007/171] perf script: Fix crash with printing mixed trace point and other events
Date:   Tue, 12 Mar 2019 10:06:27 -0700
Message-Id: <20190312170348.493693009@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 96167167b6e17b25c0e05ecc31119b73baeab094 ]

'perf script' crashes currently when printing mixed trace points and
other events because the trace format does not handle events without
trace meta data. Add a simple check to avoid that.

  % cat > test.c
  main()
  {
      printf("Hello world\n");
  }
  ^D
  % gcc -g -o test test.c
  % sudo perf probe -x test 'test.c:3'
  % perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
  % perf script
  <segfault>

Committer testing:

Before:

  # perf probe -x /lib64/libc-2.28.so malloc
  Added new event:
    probe_libc:malloc    (on malloc in /usr/lib64/libc-2.28.so)

  You can now use it in all perf tools, such as:

	perf record -e probe_libc:malloc -aR sleep 1

  # perf probe -l
  probe_libc:malloc    (on __libc_malloc@malloc/malloc.c in /usr/lib64/libc-2.28.so)
  # perf record -e '{cpu/cpu-cycles,period=10000/,probe_libc:*}:S' sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.023 MB perf.data (40 samples) ]
  # perf script
  Segmentation fault (core dumped)
  ^C
  #

After:

  # perf script | head -6
     sleep 2888 94796.944981: 16198 cpu/cpu-cycles,period=10000/: ffffffff925dc04f get_random_u32+0x1f (/lib/modules/5.0.0-rc2+/build/vmlinux)
     sleep 2888 [-01] 94796.944981: probe_libc:malloc:
     sleep 2888 94796.944983:  4713 cpu/cpu-cycles,period=10000/: ffffffff922763af change_protection+0xcf (/lib/modules/5.0.0-rc2+/build/vmlinux)
     sleep 2888 [-01] 94796.944983: probe_libc:malloc:
     sleep 2888 94796.944986:  9934 cpu/cpu-cycles,period=10000/: ffffffff922777e0 move_page_tables+0x0 (/lib/modules/5.0.0-rc2+/build/vmlinux)
     sleep 2888 [-01] 94796.944986: probe_libc:malloc:
  #

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190117194834.21940-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a7b4d3f611c5..5c070a600233 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1746,7 +1746,7 @@ static void process_event(struct perf_script *script,
 		return;
 	}
 
-	if (PRINT_FIELD(TRACE)) {
+	if (PRINT_FIELD(TRACE) && sample->raw_data) {
 		event_format__fprintf(evsel->tp_format, sample->cpu,
 				      sample->raw_data, sample->raw_size, fp);
 	}
-- 
2.19.1



