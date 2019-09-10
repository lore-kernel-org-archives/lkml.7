Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81B3C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A4C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIcQYf/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393179AbfIJL5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:57:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47010 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733236AbfIJL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so6860478wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVQ7Tct8tU0DJx5s8h1k7biDl9I5KG0OFqo1Lpd86hc=;
        b=lIcQYf/amVBtQDfTxCxyvYoyuo7sxkZenk0YeowuFnzDH6o8iHr3Ldayw8ch8W5+Fa
         dRQYIkfrm5mFDKNUvGJOYCBnZmxaTxgckK4gIyg2wybSvUgyFr4Qyup1A5rGGxMnbdAf
         TujF0G6HNz/U56ZKm3MxmHZ9PCEw9y/TPRj+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVQ7Tct8tU0DJx5s8h1k7biDl9I5KG0OFqo1Lpd86hc=;
        b=KWC5jEAk03V2U9nE6PYuI9SFgeovjv/rcUAeO1VdLpbEBP4GMmwEQgCWh63bWMXSoK
         XERnyVhMIxvfRfQSQ5vM3f6L+vJnviT5C1o143zmBLgvhZQ+4gX5zMfNSMrUeyPtha/A
         bYfYTDzsI89rqy6C0aVo5t1eeT3vyL8i4WY0tQztdDE4RMJZ49+qRPL1k7u9toUam+mY
         bXRRTwYnBfwGDRe4ggmAruEFep+8wgGl/bGasjSoxUn2uSXrb3LYtAbKaXL0MHHKV54j
         +ew8rz1uiKlAOYQLqcW/ePpK5iHukFfy8JMq4NVl/CjWPxJw/9VOY4jOEOVIs1jmDYez
         JdOQ==
X-Gm-Message-State: APjAAAX2h6HUGzSw6rdJJqiG1xob3u+CGKReVjOnPk5csHfMr23eeEYY
        ussNLl3LhEdXdo7C4Xgbwj21iRGBuHw=
X-Google-Smtp-Source: APXvYqxsMV7T7MYZDqZj7+zf1X42YUxNEluEUNSWA8evGhzEfC93r4n95G3TeHM62hd43tXfDYT1jw==
X-Received: by 2002:adf:e947:: with SMTP id m7mr26846741wrn.178.1568116596374;
        Tue, 10 Sep 2019 04:56:36 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:35 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 08/14] krsi: Show attached program names in hook read handler.
Date:   Tue, 10 Sep 2019 13:55:21 +0200
Message-Id: <20190910115527.5235-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

For inspectability the system administrator should be able to view the
list of active KRSI programs:

   bash # cat /sys/kernel/security/krsi/process_execution
   bpf_prog1

Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/krsi/krsi_fs.c | 76 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/security/krsi/krsi_fs.c b/security/krsi/krsi_fs.c
index 3ba18b52ce85..0ebf4fabe935 100644
--- a/security/krsi/krsi_fs.c
+++ b/security/krsi/krsi_fs.c
@@ -6,6 +6,7 @@
 #include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/filter.h>
+#include <linux/seq_file.h>
 #include <linux/bpf.h>
 #include <linux/security.h>
 
@@ -16,8 +17,81 @@ extern struct krsi_hook krsi_hooks_list[];
 
 static struct dentry *krsi_dir;
 
+static void *seq_start(struct seq_file *m, loff_t *pos)
+	__acquires(rcu)
+{
+	struct krsi_hook *h;
+	struct dentry *dentry;
+	struct bpf_prog_array *progs;
+	struct bpf_prog_array_item *item;
+
+	/*
+	 * rcu_read_lock() must be held before any return statement
+	 * because the stop() will always be called and thus call
+	 * rcu_read_unlock()
+	 */
+	rcu_read_lock();
+
+	dentry = file_dentry(m->file);
+	h = dentry->d_fsdata;
+	if (WARN_ON(!h))
+		return ERR_PTR(-EFAULT);
+
+	progs = rcu_dereference(h->progs);
+	if ((*pos) >= bpf_prog_array_length(progs))
+		return NULL;
+
+	item = progs->items + *pos;
+	if (!item->prog)
+		return NULL;
+
+	return item;
+}
+
+static void *seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct bpf_prog_array_item *item = v;
+
+	item++;
+	++*pos;
+
+	if (!item->prog)
+		return NULL;
+
+	return item;
+}
+
+static void seq_stop(struct seq_file *m, void *v)
+	__releases(rcu)
+{
+	rcu_read_unlock();
+}
+
+static int show_prog(struct seq_file *m, void *v)
+{
+	struct bpf_prog_array_item *item = v;
+
+	seq_printf(m, "%s\n", item->prog->aux->name);
+	return 0;
+}
+
+static const struct seq_operations seq_ops = {
+	.show	= show_prog,
+	.start	= seq_start,
+	.next	= seq_next,
+	.stop	= seq_stop,
+};
+
+static int hook_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &seq_ops);
+}
+
 static const struct file_operations krsi_hook_ops = {
-	.llseek = generic_file_llseek,
+	.open		= hook_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
 int krsi_fs_initialized;
-- 
2.20.1

