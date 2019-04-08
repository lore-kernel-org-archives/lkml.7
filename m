Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3FAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C372148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MhNsOP+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfDHVrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:47:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52624 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbfDHVrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:47:10 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LWlj3004870
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:47:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=PeE9Rwo7wGOWQ5q9OAqfNdhcUhps+PHukzw37s+pWWU=;
 b=MhNsOP+MRfkIrNIaqiAHzdp0fdKp6DRltSzGP2He0iJnV9QGWfHatu+4xGZBL6Mi+beM
 gg6zzRafbnNPUCUg/lfKa3/BvfIYL9UKl91oXdYV9n4uhgMe38zi64c/qqK5GLC/fQ2J
 B1wPlZ6idY8iKtHEpc/Umtl5ZaZmTdA4nP8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rra0ph85b-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:47:09 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 8 Apr 2019 14:46:07 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 94CAF62E1F66; Mon,  8 Apr 2019 14:46:02 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <tglx@linutronix.de>,
        <morten.rasmussen@arm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 3/7] cgroup: introduce cgroup_parse_percentage
Date:   Mon, 8 Apr 2019 14:45:35 -0700
Message-ID: <20190408214539.2705660-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408214539.2705660-1-songliubraving@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a helper to parse percentage string to long
integer, with user selected scale:

   long cgroup_parse_percentage(char *tok, unsigned long base)

Valid tok could be integer 0 to 100, decimal 0.00 to 100.00, or "max".
A tok of "max"is same as "100".

Base is the desire output scale for input "1".

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 81f58b4a5418..b28f8a41c970 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -110,6 +110,7 @@ int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
 void cgroup_file_notify(struct cgroup_file *cfile);
+long cgroup_parse_percentage(char *tok, unsigned long base);
 
 int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen);
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b0df96132476..2e48840ff613 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3967,6 +3967,43 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
 
+/**
+ * cgroup_parse_percentage - parse percentage number
+ * @tok: input string contains the token. Valid values are "00.00" to
+ *       "100.00", or "max"
+ * @base: number "1" in desired output scale
+ *
+ * Returns:
+ *    @base * 100 for "max";
+ *    @base * <0.00 to 100.00> for valid inputs;
+ *    -EINVAL for invalid input.
+ */
+long cgroup_parse_percentage(char *tok, unsigned long base)
+{
+	unsigned long val_int, val_frag;
+
+	if (strcmp(tok, "max") == 0) {
+		return base * 100;
+	} else if (sscanf(tok, "%lu.%02lu", &val_int, &val_frag) == 2) {
+		/* xx.1 yields val_frag = 1, while it should be 10 */
+		if (val_frag < 10 && strstr(tok, ".0") == NULL)
+			val_frag *= 10;
+		goto calculate_output;
+	} else if (sscanf(tok, "%lu", &val_int) == 1) {
+		val_frag = 0;
+		goto calculate_output;
+	} else {
+		return -EINVAL;
+	}
+
+calculate_output:
+	if (val_int > 100 || (val_int == 100 && val_frag > 0))
+		return -EINVAL;
+
+	/* round up val_frag by 0.5, to avoid repeated rounding down */
+	return (val_int * base) + div_u64((val_frag * 10 + 5) * base, 1000);
+}
+
 /**
  * css_next_child - find the next child of a given css
  * @pos: the current position (%NULL to initiate traversal)
-- 
2.17.1

