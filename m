Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9FF21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnZWe4g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfCTRfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:35:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36483 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCTRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:35:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id e4so2736883edi.3;
        Wed, 20 Mar 2019 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOntEnwdVMv2nWTdNHFeAl7MkTJs/Nh4RmrIjAmjfx4=;
        b=QnZWe4g7WJ70DLHmylklns8+OWOZLWasrWklAi7FesEPF5iwnBUDuekFH79v3WnVw4
         xQTyL8wXOLU3hsosu0bUSNntmPyxS0pi/fmu2Q1RkbsX81ALG5Ha/k4hJOptkMQ0SHFb
         tZFETcl7VxDa214o2Wdok4C7ikXsz8+LK0fl5ATqKFSRR7e0QdoRW9Pb6lJEdQDfbtPp
         d/TCfxnFxNskWsWKb9ggB687dlFNZ8/z7qQF64ecI43CdI5kTeoqap5XXXqn1vfIcgo+
         KqDPUXtBnnuk0e6zB20GqhOe6SK3w7L7jn/aPhQMBip1I1BHb7ToFa8mS5ZcfYv1GVAd
         7oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gOntEnwdVMv2nWTdNHFeAl7MkTJs/Nh4RmrIjAmjfx4=;
        b=AF31AcAqoIA/sLnhRS041gJtN/vhcz3tj07LwZvBp6tCYsXKmcKgieI4jj2MKlFrP8
         zcwWwZ9y1IR8ss1WxuW++GBORK047JCuocRhRdAwnHqQpDMt/wBz0sNBIWPH+nGiggqF
         UP92HVIjK0WuAWpZc137YI6O+R47Ltak2u7OIxNI21+we4VX0fMFkOazX1nBetTsEfXi
         XHSx2RvVO3bPA53O6to5V1wQaGnPsiS6uYZuWCV+m80PZokT3Xwu7FLKc2j0Ris5/zH/
         2kwe7oGYi5C+aDi0ryCts56MyLq8oBaNaGEMotzXtDbTP5EscnwL7AX2R1DuYF86gOgn
         /pzg==
X-Gm-Message-State: APjAAAXa0z5EiDZzrcOhAinxl8wtr5NhUc5kZaV3BfVdDKKcIdRGGjSF
        s97EF98HpZyantmBwWAVvXE=
X-Google-Smtp-Source: APXvYqwhffRHsxsCi4vtuPGs7X4i1FQaLCLd5IFApXDuOvvIt0jQv44VptL0+vO+CEEy5hCOWOHH6Q==
X-Received: by 2002:a17:906:6d8f:: with SMTP id h15mr17786831ejt.107.1553103344214;
        Wed, 20 Mar 2019 10:35:44 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 5sm828606edp.50.2019.03.20.10.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:35:43 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v1 6/7] tools: bpftool: fix bpffs mount when pinning subdirectories
Date:   Wed, 20 Mar 2019 18:33:31 +0100
Message-Id: <20190320173332.18105-6-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320173332.18105-1-alban@kinvolk.io>
References: <20190320173332.18105-1-alban@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

When trying to pin at a path such as /sys/fs/bpf/subdir/mymap while the
bpffs is mounted at the standard path and the "subdir" directory didn't
exist, bpftool was failing and attempting to mount the bpffs on
/sys/fs/bpf/subdir/. The mount obviously failed, since "subdir" didn't
exist.

Commit 3fc27b71b894 ("tools: bpftool: try to mount bpffs if required for
pinning objects") says:

    The code for mnt_bpffs() is a copy of function bpf_mnt_fs() from
    iproute2 package (under lib/bpf.c, taken at commit 4b73d52f8a81), with
    modifications regarding handling of error messages.

However, the function bpf_mnt_fs() from iproute2 only works when its
parameter is the root of the bpffs (e.g. "/sys/fs/bfs").

iproute2/tc actually only mounts at the standard path "/sys/fs/bfs" or
at the path from the environment variable $TC_BPF_MNT. This patch
implements a similar strategy but uses the environment variable name
$BPFTOOL_BPF_MNT.

This patch still will not do the mkdir automatically. But at least,
there will be no error message about the mount.

Fixes: 3fc27b71b894 ("tools: bpftool: try to mount bpffs if required for pinning objects")
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 tools/bpf/bpftool/common.c | 20 ++++++++++++++++----
 tools/bpf/bpftool/main.h   |  6 ++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e560cd8f66bc..4783cbbe8037 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -168,6 +168,8 @@ int mount_bpffs_for_pin(const char *name)
 	char *file;
 	char *dir;
 	int err = 0;
+	const char *mnt_env = getenv(BPF_DIR_MNT_ENV);
+	static const char *mnt;
 
 	file = malloc(strlen(name) + 1);
 	strcpy(file, name);
@@ -183,13 +185,23 @@ int mount_bpffs_for_pin(const char *name)
 		goto out_free;
 	}
 
-	err = mnt_fs(dir, "bpf", err_str, ERR_MAX_LEN);
+	mnt = mnt_env ? : BPF_DIR_MNT;
+
+	// Don't try to mount if wrong prefix: we don't want a leftover mount that is
+	// not going to help.
+	if (!is_prefix(mnt, dir)) {
+		p_err("refuse to mount BPF file system (%s) to pin the object (%s): wrong directory",
+		      mnt, name);
+		err = -1;
+		goto out_free;
+	}
+
+	err = mnt_fs(mnt, "bpf", err_str, ERR_MAX_LEN);
 	if (err) {
 		err_str[ERR_MAX_LEN - 1] = '\0';
-		p_err("can't mount BPF file system to pin the object (%s): %s",
-		      name, err_str);
+		p_err("can't mount BPF file system (%s) to pin the object (%s): %s",
+		      mnt, name, err_str);
 	}
-
 out_free:
 	free(file);
 	return err;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 7fc2973446d0..a2e28e600b72 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -18,6 +18,12 @@
 
 #define ptr_to_u64(ptr)	((__u64)(unsigned long)(ptr))
 
+/* If bpffs is not mounted, it can be automatically mounted at this location.
+ * The location can be changed with the environment variable $BPFTOOL_BPF_MNT.
+ */
+#define BPF_DIR_MNT	"/sys/fs/bpf"
+#define BPF_DIR_MNT_ENV	"BPFTOOL_BPF_MNT"
+
 #define NEXT_ARG()	({ argc--; argv++; if (argc < 0) usage(); })
 #define NEXT_ARGP()	({ (*argc)--; (*argv)++; if (*argc < 0) usage(); })
 #define BAD_ARG()	({ p_err("what is '%s'?", *argv); -1; })
-- 
2.20.1

