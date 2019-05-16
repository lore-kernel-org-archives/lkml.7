Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197BCC46460
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF412082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfEPJml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:42:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38307 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfEPJmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:42:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so2604953wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ec97xsumF3Pkv1YQN1NPRzLcPj4UDGH/s6YIE0YJh6Q=;
        b=pZk1HUhC+Sfmx7Supuy6Y6w7t5hCaFsRfKRneKFnMwiQR+b0glmhm3Ajv9QUI8CugG
         FGnE5YVljeR25mcj/sAe7szvIQxmSV4fswoQdFfzAoDpZMJpQjpF/WYQTMCgBdAfy0Ui
         QBXEmT4I0HdnCfA51OEr2RdLLCbJAnhVQ1VxBPmEGv6Bf6+BT1+hzRZorupGzGUXj7mi
         /B+DmN5MJkr03UGaf8d+apTDKvFVv3xo+fw8GT1gvFiE1N3PaWIRigKzY6g87lGkCvL+
         CFn3d4sK666VX7hwaX2y4RcpXjSdGD1CugDk7cJIEqhK0PQdrRaoX7/uWlAPS1rV7i7Z
         U9yg==
X-Gm-Message-State: APjAAAXOox9W0RaxrK1TX90FggluG7t2v5dHKH6sSs8aDD6v3GqEjapP
        2hE0Y3uv0iX3jifG1OF+Dap8Sv6C8PMt0w==
X-Google-Smtp-Source: APXvYqzL4YP+rxRXtwxz4lhwPcqqtNNojy1+KdB1FfWoc/WFzJDav/U0UgURDFche4Hrog/mqIRD1A==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr24112266wrs.280.1557999758291;
        Thu, 16 May 2019 02:42:38 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t18sm7663093wrg.19.2019.05.16.02.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:37 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH RFC 1/5] proc: introduce madvise placeholder
Date:   Thu, 16 May 2019 11:42:30 +0200
Message-Id: <20190516094234.9116-2-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a write-only /proc/<pid>/madvise file to handle remote madvise
operations.

For now, this is just a soother that does nothing.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 fs/proc/base.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a803a0b75df..f69532d6b74f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2957,6 +2957,25 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_STACKLEAK_METRICS */
 
+static ssize_t madvise_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct task_struct *task;
+
+	task = get_proc_task(file_inode(file));
+	if (!task)
+		return -ESRCH;
+
+	put_task_struct(task);
+
+	return count;
+}
+
+static const struct file_operations proc_madvise_operations = {
+	.write		= madvise_write,
+	.llseek		= noop_llseek,
+};
+
 /*
  * Thread groups
  */
@@ -3061,6 +3080,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_STACKLEAK_METRICS
 	ONE("stack_depth", S_IRUGO, proc_stack_depth),
 #endif
+	REG("madvise", S_IRUGO|S_IWUSR, proc_madvise_operations),
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
-- 
2.21.0

