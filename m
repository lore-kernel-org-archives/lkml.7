Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF030C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF45C2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xsWgE9CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFVGnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:43:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39095 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFVGnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:43:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6h0So2006591
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:43:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6h0So2006591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185781;
        bh=Sy2b//ftiVFa6GY08kM/EaOTEda5cU/aLKqAQtJy4hI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xsWgE9CF9Wm6YfoCieFUMISv13j8kjxMNPHWTJkSJx1qKmGE8ghhdH5oiYh6S5irV
         OB/OgSrVDN7DmCDLijMaNlaiylfR1hiZhO1f5D7hJUXs08K72qXKu3fAg+3eP3E/iO
         Vb+wuLpcKBMvuCDNerWNDuaMkckhR8D17OaB1QtVQQZ/ZVeXH0LoCvHofHE+eRBGX5
         qrLO64rIL52PP4ReUc1N5WBB4s9lUjidbkf3MSgFMRkEbaO0CJgiyHS5l56RSVDUaJ
         1OQpPv6/7MSEYXOGqrJczan/mv134+2MuoTos81xkOcEJgwnZaSFEH8f0YCGUU/uGL
         1G+KcXTJe7+yw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6h0e02006585;
        Fri, 21 Jun 2019 23:43:00 -0700
Date:   Fri, 21 Jun 2019 23:43:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-e01f0ef509ea7e76929f24a074d241de52c6f82a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, tglx@linutronix.de, acme@redhat.com,
        jolsa@redhat.com, mingo@kernel.org
Reply-To: jolsa@redhat.com, mingo@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com
In-Reply-To: <20190610072803.10456-12-adrian.hunter@intel.com>
References: <20190610072803.10456-12-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add callchain to synthesized PEBS
 sample
Git-Commit-ID: e01f0ef509ea7e76929f24a074d241de52c6f82a
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

Commit-ID:  e01f0ef509ea7e76929f24a074d241de52c6f82a
Gitweb:     https://git.kernel.org/tip/e01f0ef509ea7e76929f24a074d241de52c6f82a
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:28:03 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:18 -0300

perf intel-pt: Add callchain to synthesized PEBS sample

Like other synthesized events, if there is also an Intel PT branch
trace, then a call stack can also be synthesized.  Add that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index bf7647897e8a..550db6e77968 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1730,6 +1730,14 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
 	}
 
+	if (sample_type & PERF_SAMPLE_CALLCHAIN &&
+	    pt->synth_opts.callchain) {
+		thread_stack__sample(ptq->thread, ptq->cpu, ptq->chain,
+				     pt->synth_opts.callchain_sz, sample.ip,
+				     pt->kernel_start);
+		sample.callchain = ptq->chain;
+	}
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR &&
 	    items->mask[INTEL_PT_GP_REGS_POS]) {
 		u64 regs[sizeof(sample.intr_regs.mask)];
