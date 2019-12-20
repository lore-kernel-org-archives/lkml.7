Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548FCC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A8924684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576816426;
	bh=YmXCrgCwEwY8/QrWk0sPDC4MZVmbjP+WKJ3cPBUsN08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z3+y/qv/xlA23OTThv3rPENPAWDgeuCAzrIqxf9qycMNe5Kmbm+KOVTN+TSo0tHcU
	 6fssbWMFCuWiG7DQdDuLIAR2R2VkvbN8r3VYk6OHIF9h4zrVlKSZh3iaib9wAZZCXr
	 I1sLvUh/YuRxZ6EjuJE2wzyvVlBlXQRPSS6zqjkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLTEdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:33:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33937 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLTEdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:33:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so4316626pgf.1;
        Thu, 19 Dec 2019 20:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xnigVaaCqW8/KBuzAXnuhlbsCoW2U384fK9hdVaYC0=;
        b=R/OiVxjm/Y/JDHLknDBx/f4Zb+ywmfrYJD41EUrkuR1O0n/4y++KDmd1AIpoIYjEbx
         2eKuQFRVM54OaszipYBy7lMe0LhnbxJKJSMEQy0mOoo6Ue0km/xzonXm+PHqjfIfj+TW
         Fd1tUTbSyOlL47As/88Vlv2KMeSDT5/bS0Nv9Y/O1vMmO72VFcjagdimGOJOZ/1wY9oy
         RzPjdFvZchBAsz+EOjbs8jtb+FD4f7BuxOex99hPq7Oq9QQ3H/Nng3spos4p3/tksyi4
         E4kA7VxXLjNUQOs6PVmfDQ0EcYbSxI2oKI9Jx11O047VRfXxYwBlUG+mNQb/0vxiTJkk
         gWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0xnigVaaCqW8/KBuzAXnuhlbsCoW2U384fK9hdVaYC0=;
        b=YizSwZ0PfO6l7mr2Mu9pt0WzZpv5jTlH14Y2zYY4gfMkBcTdjCBuN2f6HLArzd4k4X
         x2L2lTtAvPabm45s2oepwKtM83XHevrXkwLxsVHJaqLR9H/cGX7QYOmRaFrsfR84myc7
         lHGza2YQtrjXb8AKznw1Uo4EqsPUP/EJW4SG8kAECCOE9NJWjH061Ykv1+Bpv6C1tklw
         kwlfvycsIVAV+yHmFcwbcUy6KstARVEvucXmKj+7o7eDUTDwjdcGDxNUtAfL5h4v5fnv
         eXZ6IjTkhq4GIdGlZPb6Sfhhtvvv2K7JzorSr3H0qYgGqU9EH+Y0270bsRNU9ib+9o7u
         50Pw==
X-Gm-Message-State: APjAAAXL2XEzU6QQ58EDPp/QiJgpYkVcqMlbDlCt1yx2tX+16nNPHvpa
        23opO1Lg2BdZzSGJLVOj/5s=
X-Google-Smtp-Source: APXvYqyMosecVttXGEllcRJKiXFGthzY6HsW7QoBbE/iV58dfzJeRL2+gNdJzuad+HNGbRvHb6PyaA==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr13250527pgj.119.1576816420752;
        Thu, 19 Dec 2019 20:33:40 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id z30sm11013982pfq.154.2019.12.19.20.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 20:33:40 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 8/9] perf top: Add --all-cgroups option
Date:   Fri, 20 Dec 2019 13:32:52 +0900
Message-Id: <20191220043253.3278951-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191220043253.3278951-1-namhyung@kernel.org>
References: <20191220043253.3278951-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --all-cgroups option is to enable cgroup profiling support.  It
tells kernel to record CGROUP events in the ring buffer so that perf
report can identify task/cgroup association later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-top.txt | 4 ++++
 tools/perf/builtin-top.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 5596129a71cf..c75507f50071 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -266,6 +266,10 @@ Default is to monitor all CPUS.
 	Record events of type PERF_RECORD_NAMESPACES and display it with the
 	'cgroup_id' sort key.
 
+--cgroup::
+	Record events of type PERF_RECORD_CGROUP and display it with the
+	'cgroup' sort key.
+
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index dc80044bc46f..1aaa1b34feca 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1244,6 +1244,8 @@ static int __cmd_top(struct perf_top *top)
 
 	if (opts->record_namespaces)
 		top->tool.namespace_events = true;
+	if (opts->record_cgroup)
+		top->tool.cgroup_events = true;
 
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
@@ -1251,6 +1253,11 @@ static int __cmd_top(struct perf_top *top)
 	if (ret < 0)
 		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
 
+	ret = perf_event__synthesize_cgroups(&top->tool, perf_event__process,
+					     &top->session->machines.host);
+	if (ret < 0)
+		pr_debug("Couldn't synthesize cgroup events.\n");
+
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->core.threads, false,
 				    top->nr_threads_synthesize);
@@ -1539,6 +1546,8 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
+		    "Record cgroup events"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-- 
2.24.1.735.g03f4e72817-goog

