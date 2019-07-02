Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3505EC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C5320836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ro1aoZiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGBKeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:34:46 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36174 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:34:46 -0400
Received: by mail-ot1-f47.google.com with SMTP id r6so16668142oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yh67xhQ9He3y+H6kFlc9MYFUOr0G7P/w8hL/0JLG7q0=;
        b=ro1aoZiLphx5ycNYHWZ/hgdw2qioib3lO2AZziumfOIaMeEw6KWC4sZ6B8gnbf1KJ5
         EUwfsAVZCki/ptHXFJ4Djy/3fjdSUjT8fJOOWZ1CnYePdlhaC8j6AMXvhmtT7W8GyMzp
         Y+ww71ZYjgY0drfqEjpWvHlVUE6L0dO5MDtPmO+Xl7pnCEK/QYIIZOykA9UXFkzL20O3
         tIEf3G4WALElbBB96b59GPnU/I+yf8J6ci66dTxRaLAyXB3K0GvS6Jf/FdA6qeeC1/ZX
         S0OAd8HIfgBqG/2R4MYbXrZKm4l9xDFAqGHZPsywSswKeUEpTs0GwOeY0qEYDlXXUB49
         F+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yh67xhQ9He3y+H6kFlc9MYFUOr0G7P/w8hL/0JLG7q0=;
        b=acw3zlPtrxNbEvRSOLBJMM2nYxMjfJYGR//nOqVvkj+cKJBV8816Tm8+XWrp+h/92u
         ANLTRtMvKtNlhgfqH9i5kDFBZnYL3I0To6GhTLaL98QiOCG2OpDhD87/yOIjat5F5JPB
         Kcayqo3Dbguhjj+U0ZbfbUBrWaluvnPoua/zhSxNj4HXiMRAnrDqpB20pptvHiNYRkhT
         Xukafl2vqxLDglqYd+Rdf7ne1no/nMyYUPLPqRVy1cD4Nysw5Np4X5TGtUwk16EZhGKP
         BS9NvtaP7OTZ75hwq5AC6RjIazRnzBpDE/XQOUnp+QwuJvWVLrGhxysvwpJpkAJBsge5
         EAtg==
X-Gm-Message-State: APjAAAW2Gv5QTR+j0Vv6YS6NIc3PRIq6kLCeCbwRO4sAv/7LsDMgeSdE
        yujHRTsvDMkJwg4lH+d1sK3o5Q==
X-Google-Smtp-Source: APXvYqz0F+LZR7w7Za1W/0SVbgXXPE/RHIsbrL7w+y9m0fjgqj+wEs08VL2EYmN2ulht4JSPGawjew==
X-Received: by 2002:a9d:eb7:: with SMTP id 52mr22187581otj.70.1562063685693;
        Tue, 02 Jul 2019 03:34:45 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:34:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 00/11] perf: Fix errors detected by Smatch
Date:   Tue,  2 Jul 2019 18:34:09 +0800
Message-Id: <20190702103420.27540-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I used static checker Smatch for perf building, the main target is
to check if there have any potential issues in Arm cs-etm code.  So
finally I get many reporting for errors/warnings.

I used below command for using static checker with perf building:

  # make VF=1 CORESIGHT=1 -C tools/perf/ \
    CHECK="/root/Work/smatch/smatch --full-path" \
    CC=/root/Work/smatch/cgcc | tee smatch_reports.txt

I reviewed the errors one by one, if I understood some of these errors
so changed the code as I can, this patch set is the working result; but
still leave some errors due to I don't know what's the best way to fix
it.  There also have many inconsistent indenting warnings.  So I firstly
send out this patch set and let's see what's the feedback from public
reviewing.

Leo Yan (11):
  perf report: Smatch: Fix potential NULL pointer dereference
  perf stat: Smatch: Fix use-after-freed pointer
  perf top: Smatch: Fix potential NULL pointer dereference
  perf annotate: Smatch: Fix dereferencing freed memory
  perf trace: Smatch: Fix potential NULL pointer dereference
  perf hists: Smatch: Fix potential NULL pointer dereference
  perf map: Smatch: Fix potential NULL pointer dereference
  perf session: Smatch: Fix potential NULL pointer dereference
  perf intel-bts: Smatch: Fix potential NULL pointer dereference
  perf intel-pt: Smatch: Fix potential NULL pointer dereference
  perf cs-etm: Smatch: Fix potential NULL pointer dereference

 tools/perf/builtin-report.c    |  4 ++--
 tools/perf/builtin-stat.c      |  2 +-
 tools/perf/builtin-top.c       |  8 ++++++--
 tools/perf/builtin-trace.c     |  5 +++--
 tools/perf/ui/browsers/hists.c | 13 +++++++++----
 tools/perf/util/annotate.c     |  6 ++----
 tools/perf/util/cs-etm.c       |  2 +-
 tools/perf/util/intel-bts.c    |  5 ++---
 tools/perf/util/intel-pt.c     |  5 ++---
 tools/perf/util/map.c          |  7 +++++--
 tools/perf/util/session.c      |  3 +++
 11 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.17.1

