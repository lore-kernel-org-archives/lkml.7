Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FDA24679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPg4tSkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfLTPmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:42:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36232 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfLTPmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so9701830wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HkMzNoMVPiVpqpbSBCK+53bDNIFc61jgux3uZuo+QQ=;
        b=mPg4tSkVAdYB6gDrbbk4elkEX+LPkWpPTJcDyBhaI6hW5XdDtpHApUBN2ptv1uG6ki
         KqAuzf4gGEJnzn33e/H1WO0mEPWb7MbbF52y4qM6hv3VtNiDFd7ytjY5FJmEo5r32kLF
         7CxMEu6iOrStK4WRHGxCEjTrBisvJB9YeIDv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HkMzNoMVPiVpqpbSBCK+53bDNIFc61jgux3uZuo+QQ=;
        b=LrI/GEJJDXBshZIkpeYckvJqNnhRAgbkjdu3BP6dRoSF+gfMhqZNFcN1N3/QVg2gBe
         HYRy5u72YcR+B6IzuZTZzpRUPqm1sriOgGVvrR6TmiF4QVu71T8QCk48ChM8+MKw8r5w
         j20Gd3en8YfIrJT5BGwj2yBy4wy+b8vgKDmu0xmHGit7t4IWgfy7gHKIKzHLhj0YsJC6
         lPb4xwJmg+vqAc82g6+XFJKo/lqqGixETflUMvwEMqxqLjicUMf/fi8lXmaHLZyci5r8
         Ua1SIq8sFocmAPtCBhBNBfyk3nLDBQXcs60/khDTt+XIB+HBxd+rwCoqXlHX1V4P0v2t
         nzPQ==
X-Gm-Message-State: APjAAAWQ3ehft5+cYdr11+G5aCXNwyHJmuoXB9AsispEtz7FUWHP6vq4
        hNEM2S1lLdlkjbV46hhUifUngKwC2nA=
X-Google-Smtp-Source: APXvYqxk+DJG/ss1hnX5rJ1ggq2B9xRnZK9Mh5Bwa3L8cfr8gTj+2bW+JKB0ebSOUshdoP7oURpSHg==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr17776295wmc.111.1576856536353;
        Fri, 20 Dec 2019 07:42:16 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:15 -0800 (PST)
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
        Brendan Jackman <jackmanb@chromium.org>,
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
Subject: [PATCH bpf-next v1 10/13] bpf: lsm: Handle attachment of the same program
Date:   Fri, 20 Dec 2019 16:42:05 +0100
Message-Id: <20191220154208.15895-11-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Allow userspace to attach a newer version of a program without having
duplicates of the same program.

If BPF_F_ALLOW_OVERRIDE is passed, the attachment logic compares the
name of the new program to the names of existing attached programs. The
names are only compared till a "__" (or '\0', if there is no "__"). If
a successful match is found, the existing program is replaced with the
newer attachment.

./loader Attaches "env_dumper__v1" followed by "env_dumper__v2"
to the bprm_check_security hook..

./loader
./loader

Before:

  cat /sys/kernel/security/bpf/process_execution
  env_dumper__v1
  env_dumper__v2

After:

  cat /sys/kernel/security/bpf/process_execution
  env_dumper__v2

Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/bpf/ops.c | 57 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/security/bpf/ops.c b/security/bpf/ops.c
index e9aae2ce718c..481e6ee75f27 100644
--- a/security/bpf/ops.c
+++ b/security/bpf/ops.c
@@ -64,11 +64,52 @@ static struct bpf_lsm_hook *get_hook_from_fd(int fd)
 	return ERR_PTR(ret);
 }
 
+/*
+ * match_prog_name matches the name of the program till "__"
+ * or the end of the string is encountered. This allows
+ * the matched program to be replaced by a newer version.
+ *
+ * For example:
+ *
+ *	env_dumper__v1 is matched with env_dumper__v2
+ *
+ */
+static bool match_prog_name(const char *a, const char *b)
+{
+	size_t m, n;
+	char *end;
+
+	end = strstr(a, "__");
+	n = end ? end - a : strlen(a);
+
+	end = strstr(b, "__");
+	m = end ? end - b : strlen(b);
+
+	if (m != n)
+		return false;
+
+	return strncmp(a, b, n) == 0;
+}
+
+static struct bpf_prog *find_attached_prog(struct bpf_prog_array *array,
+					   struct bpf_prog *prog)
+{
+	struct bpf_prog_array_item *item = array->items;
+
+	for (; item->prog; item++) {
+		if (match_prog_name(item->prog->aux->name, prog->aux->name))
+			return item->prog;
+	}
+
+	return NULL;
+}
+
 int bpf_lsm_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
 	struct bpf_lsm_hook *h;
+	struct bpf_prog *old_prog = NULL;
 	int ret = 0;
 
 	h = get_hook_from_fd(attr->target_fd);
@@ -78,13 +119,27 @@ int bpf_lsm_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	mutex_lock(&h->mutex);
 	old_array = rcu_dereference_protected(h->progs,
 					      lockdep_is_held(&h->mutex));
+	/*
+	 * Check if a matching program already exists and replace
+	 * the existing program if BPF_F_ALLOW_OVERRIDE is specified in
+	 * the attach flags.
+	 */
+	if (old_array) {
+		old_prog = find_attached_prog(old_array, prog);
+		if (old_prog && !(attr->attach_flags & BPF_F_ALLOW_OVERRIDE)) {
+			ret = -EEXIST;
+			goto unlock;
+		}
+	}
 
-	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
+	ret = bpf_prog_array_copy(old_array, old_prog, prog, &new_array);
 	if (ret < 0)
 		goto unlock;
 
 	rcu_assign_pointer(h->progs, new_array);
 	bpf_prog_array_free(old_array);
+	if (old_prog)
+		bpf_prog_put(old_prog);
 
 unlock:
 	mutex_unlock(&h->mutex);
-- 
2.20.1

