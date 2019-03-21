Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6C221917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194500;
	bh=7RjhC2ijFeUOwSTVCOIHO8wy9BKKFKGIFVIIeXt6hAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oz0e4qZfnk3yqdrQvHMbt9LxPrMj7Qh6Rz4RICIvRIRb5gIVrp8YnuzAK8xz3/W0P
	 KlmkBj5hy4CF7htTtFFAEoElC9s4deNN9l4heNmdZAke5WoPDxsvTrMHh/DslDnp2I
	 YCiTAO74ep7WXOSFdCJ5zYTxuKYnLfUHoYmD6Wb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfCUSy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfCUSy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:56 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C07221925;
        Thu, 21 Mar 2019 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194495;
        bh=7RjhC2ijFeUOwSTVCOIHO8wy9BKKFKGIFVIIeXt6hAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0M7Y7CXMpVvLCV4RIA4ah4TjOure7LkrAAevP08GgIlw6hgVs20bOPrFvwucadwz6
         j6Sh2XnKEdOFEYuNkaKU70E3wyQmdEYTHaYeLZO4kmSAWpRjXlPawX0FVdA3WuLJHf
         aUwHh1Vg1MuG3vBynQaKdBumkZgrqvqhwb5TWTx0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>, kernel-team@fb.com
Subject: [PATCH 35/44] perf top: Add option --no-bpf-event
Date:   Thu, 21 Mar 2019 15:51:33 -0300
Message-Id: <20190321185142.11441-36-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

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
-- 
2.20.1

