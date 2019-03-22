Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD48C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57D0218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfCVWli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:41:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfCVWli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:41:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMfCvc755433
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:41:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMfBk3755430;
        Fri, 22 Mar 2019 15:41:11 -0700
Date:   Fri, 22 Mar 2019 15:41:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-ee7a112fbcc8edb4cf2f84ce5fcc2da7818fd4b8@git.kernel.org>
Cc:     songliubraving@fb.com, jolsa@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, peterz@infradead.org, namhyung@kernel.org,
        mingo@kernel.org, ast@kernel.org, sdf@google.com,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, acme@redhat.com
Reply-To: daniel@iogearbox.net, acme@redhat.com, namhyung@kernel.org,
          mingo@kernel.org, ast@kernel.org, hpa@zytor.com, sdf@google.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, songliubraving@fb.com, jolsa@kernel.org
In-Reply-To: <20190312053051.2690567-11-songliubraving@fb.com>
References: <20190312053051.2690567-11-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Add option --no-bpf-event
Git-Commit-ID: ee7a112fbcc8edb4cf2f84ce5fcc2da7818fd4b8
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

Commit-ID:  ee7a112fbcc8edb4cf2f84ce5fcc2da7818fd4b8
Gitweb:     https://git.kernel.org/tip/ee7a112fbcc8edb4cf2f84ce5fcc2da7818fd4b8
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:46 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:07 -0300

perf top: Add option --no-bpf-event

This patch adds option --no-bpf-event to 'perf top', which is the same
as the option of 'perf record'.

The following patches will use this option.

Committer testing:

  # perf top -vv 2> /tmp/perf_event_attr.out
  # cat  /tmp/perf_event_attr.out
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  #

After this patch:

  # perf top --no-bpf-event -vv 2> /tmp/perf_event_attr.out
  # cat  /tmp/perf_event_attr.out
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
  ------------------------------------------------------------
  #

Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-11-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 77e6190211d2..c2ea22c4ea67 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1469,6 +1469,7 @@ int cmd_top(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
+	OPT_BOOLEAN(0, "no-bpf-event", &top.record_opts.no_bpf_event, "do not record bpf events"),
 	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
