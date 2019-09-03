Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C166C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D3621883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwjoZ5Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfICI4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:56:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32863 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfICI4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:56:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id t11so1510389plo.0;
        Tue, 03 Sep 2019 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NldgxnsZ6M2ztsQm0ZpSpTggTGNIlMKLrBp6UoMhx+E=;
        b=uwjoZ5DxUlQpMUOpvblKZVWKf7iM9E5/PK19EJnQ9Jr7n5+VUpAbrANzt6Vi9a38ne
         /WvIzf1xvYsQi5GPyQFBc6uQ1Hj7/YOTicfggebc6pVT7mT9DJYfEY8XMwsuCQjcWHb3
         7vsqkHy8RlFRXRnxeuo9yOcAxupoi69101QWIEwhMatXqx/u0LBeVtP+j7aQThvr/O85
         gkOcEdPDw6tM+8ALTrT7CCZxeB7ddVx1Qgtjrqoy0vGAtkPOyuciXV10kR3UphklRyM1
         A6tCPSNPhZgyXvehgg+Xn5LYnrSzd52oBO8h5aTL9E+DWsuEJHTXAnTQVYV8BUz4cpgm
         PVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NldgxnsZ6M2ztsQm0ZpSpTggTGNIlMKLrBp6UoMhx+E=;
        b=iqM1a70IAesDMGAjVmiMvsdMkvJkXbnpvTqV++taT4C+TOZguwZw7TJkK54PnJGnXe
         DYYFOeVc0y9HdZEoyYIJF7TQV/LwQfnf4hDqnuCqiNxM/eKliZ/LhqKkDbcYgFFTZGG8
         7WDV5KrwaK8+UO36D0IlaDSjqDCUfLtGXBLejLyaq62Xf9CLqzMxPssZLhpSj/zp3oj0
         P5RmGznhw7z4+oFOwt0RfOPTli6nsgV6N4o0v2OK0vt0DsZ8FRtOXh1YqB04e1MD1h83
         LKj6KPpEq4YAp4Vsq8isegnNoRfPOSPd5h38f0+c9Axe80bcUjMPfBYCtYuIqvBqXh7L
         i+RA==
X-Gm-Message-State: APjAAAWm+k9LRtFgCYlrauGb1C1JQHJik7n0T5bhZjZR1ck7bnxRvpQM
        ZteEcFItFVE0gtmOCF75980=
X-Google-Smtp-Source: APXvYqzoEgvsapMOq2ULpT8hsMWSnO/0WVaRR5ofPIghpYY2CrtPjm0jKaAbM+Ki97Pytd1DCyzqaA==
X-Received: by 2002:a17:902:4303:: with SMTP id i3mr35681874pld.30.1567500965221;
        Tue, 03 Sep 2019 01:56:05 -0700 (PDT)
Received: from ins-4z32rhqw.localdomain ([49.51.38.96])
        by smtp.googlemail.com with ESMTPSA id v43sm9464636pjb.1.2019.09.03.01.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 01:56:04 -0700 (PDT)
From:   yuzhoujian <ufo19890607@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com,
        arnaldo.melo@gmail.com, windyu@tencent.com,
        adrian.hunter@intel.com, wangnan0@huawei.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: [PATCH] Add input file_name support for perf sched {map|latency|replay|timehist}
Date:   Tue,  3 Sep 2019 16:55:35 +0800
Message-Id: <20190903085535.23913-1-ufo19890607@gmail.com>
X-Mailer: git-send-email 2.23.0.37.g745f681
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YuZhoujian <windyu@tencent.com>

Just add '-i' option for perf sched {map|latency|replay|timehist}

Signed-off-by: YuZhoujian <windyu@tencent.com>
---
 tools/perf/Documentation/perf-sched.txt | 7 +++++++
 tools/perf/builtin-sched.c              | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 63f938b887dd..182c223d3d9b 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -80,6 +80,9 @@ OPTIONS
 
 OPTIONS for 'perf sched map'
 ----------------------------
+-i::
+--input=<file>::
+        Input file name. (default: perf.data unless stdin is a fifo)
 
 --compact::
 	Show only CPUs with activity. Helps visualizing on high core
@@ -96,6 +99,10 @@ OPTIONS for 'perf sched map'
 
 OPTIONS for 'perf sched timehist'
 ---------------------------------
+-i::
+--input=<file>::
+        Input file name. (default: perf.data unless stdin is a fifo)
+
 -k::
 --vmlinux=<file>::
     vmlinux pathname
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 025151dcb651..8e51fbb88549 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3374,6 +3374,7 @@ int cmd_sched(int argc, const char **argv)
 	const struct option latency_options[] = {
 	OPT_STRING('s', "sort", &sched.sort_order, "key[,key2...]",
 		   "sort by key(s): runtime, switch, avg, max"),
+	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_INTEGER('C', "CPU", &sched.profile_cpu,
 		    "CPU to profile on"),
 	OPT_BOOLEAN('p', "pids", &sched.skip_merge,
@@ -3381,11 +3382,13 @@ int cmd_sched(int argc, const char **argv)
 	OPT_PARENT(sched_options)
 	};
 	const struct option replay_options[] = {
+	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
 		     "repeat the workload replay N times (-1: infinite)"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option map_options[] = {
+	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_BOOLEAN(0, "compact", &sched.map.comp,
 		    "map output in compact mode"),
 	OPT_STRING(0, "color-pids", &sched.map.color_pids_str, "pids",
@@ -3397,6 +3400,7 @@ int cmd_sched(int argc, const char **argv)
 	OPT_PARENT(sched_options)
 	};
 	const struct option timehist_options[] = {
+	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
-- 
2.23.0.37.g745f681

