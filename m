Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAC020673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfJHNhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJHNhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:37:10 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCB13155E0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 13:37:09 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w10so9163479wrl.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTKU4asFHsQZstw1g0KtKeKGEKBYpbJyZV57QnF+Bfw=;
        b=Z58WAsq07N8HSF/zug/LDMaXT6fd5AOd3Q8IzEbeTJawz/T7EdPlCc+gTExMmNESDJ
         55+fFKNzFCQXmdG+lXMZNbL4kR+JtvJKKwH6gwk+npe99ngr+/NWdDAlSNVR6CKyLouh
         +aeMdGkgoTTvPF0B1UtLCA1ZaRR2QtW7gWczSlPlhoCe1+OdmwWVMSOqCx3MqqP9IfpJ
         pXMKNKlgdN71xxuT+AjiTzvO4P/1Njv13dOAX1txxRx4eO5oOzJxDlP1boB3uCX2UaSG
         2PBCgQi6ykzc8iJtfg9ua0yuAUK3JWeFqAJaRiBLBrZkI0u9ZvPtQteprEkn3USo4uMl
         qzqg==
X-Gm-Message-State: APjAAAXPEl4NkOMwLAWjZfdzZoV+m5m9D0xmglxCmxjWlg0OqtHD27On
        YmtJzcall45SCLYqmtaTunXXj5zYtoizhBWODS24mpr5ja92ABggGO5CRWl1kiVL2SBWfMoZuFi
        D8c2cGFrFJv4iNm3GAbsAg7/Q
X-Received: by 2002:a1c:f01a:: with SMTP id a26mr3795626wmb.84.1570541828210;
        Tue, 08 Oct 2019 06:37:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnuJ7KXIuOAIWb7zFCCpi5VmAl/uLouZSD0mULYcoqsYPeliJmcmZAt53Q76g8awMmTH2vLw==
X-Received: by 2002:a1c:f01a:: with SMTP id a26mr3795602wmb.84.1570541827960;
        Tue, 08 Oct 2019 06:37:07 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id 36sm24791429wrp.30.2019.10.08.06.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:37:07 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] pidfd: show pids for nested pid namespaces in fdinfo
Date:   Tue,  8 Oct 2019 15:36:37 +0200
Message-Id: <20191008133641.23019-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

The fdinfo file for a process file descriptor already contains the
pid of the process in the callers namespaces. Additionally, if pid
namespaces are configured, show the process ids of the process in
all nested namespaces in the same format as in the procfs status
file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
of the processes in nested namespaces.

Signed-off-by: Christian Kellner <christian@kellner.me>
---
 kernel/fork.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5a0fd518e04e..801793789f33 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1685,8 +1685,18 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
 	struct pid *pid = f->private_data;
+#ifdef CONFIG_PID_NS
+	int i;
+#endif
 
 	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
+#ifdef CONFIG_PID_NS
+	seq_puts(m, "\nNSpid:");
+	for (i = ns->level; i <= pid->level; i++) {
+		ns = pid_nr_ns(pid, pid->numbers[i].ns);
+		seq_put_decimal_ull(m, "\t", ns);
+	}
+#endif
 	seq_putc(m, '\n');
 }
 #endif
-- 
2.21.0

