Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D058C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5712084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDCOhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfDCOhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:37:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA3CD8666D;
        Wed,  3 Apr 2019 14:37:41 +0000 (UTC)
Received: from krava (unknown [10.40.205.239])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7DB5E60144;
        Wed,  3 Apr 2019 14:37:39 +0000 (UTC)
Date:   Wed, 3 Apr 2019 16:37:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [BUG] perf: intel_pt won't display kernel function
Message-ID: <20190403143738.GB32001@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Apr 2019 14:37:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
perf script --call-trace stop working for me recently,
and displays only user space functions

I bisected that to:
  7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF programs

data from following comands will display user space functions only:
  # perf-with-kcore record pt -e intel_pt// -- ls
  # perf-with-kcore script pt --call-trace

when I disable the bpf synthesizing (patch below), kernel functions are back

I guess the new events mess up with intel_pt decoder somehow


thanks,
jirka


---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4e2d953d4bc5..3daa78bc6549 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1114,10 +1114,12 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
+#if 0
 	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
 						machine, opts);
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
+#endif
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,
