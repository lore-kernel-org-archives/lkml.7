Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75260C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B67206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPz0adFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfCYWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:11:09 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45294 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbfCYWK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:59 -0400
Received: by mail-qt1-f201.google.com with SMTP id 35so11659634qty.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J8bb8AG4h+6OBkHfL5HeKw0AzZuFO45maHYBjqWjP14=;
        b=PPz0adFxRnIhJCiW1dvfFqZx3Mh9sgICPD1y8AZBgFx6LZXJkci0PCoGUL8wjSX9Nf
         h9asMewLvjeCYovlpTTwhQOEiG6aj2hc7hSDk4/IyhhwBSgqpWj3QlDSdNTvpbzB3N7R
         0ZtDDUJvNzb8GbuWfO50FjRp1onycdASeX1OQbR43J99LKeo4zmSIFVAZ5J+S0fB6pXS
         JvAGxNN//FwYcAzUadWvCWpGZqLyZWvKF+qcQhXQNV3TvpGOhhevmSCp9YYif/rOohlQ
         /uxJMY7Na89Y/BRUx+mkD27bASvozs3tqRTBlVkKf8hSPVvLh4RkgJnnqL0VSacDBbvA
         r61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J8bb8AG4h+6OBkHfL5HeKw0AzZuFO45maHYBjqWjP14=;
        b=pQMw6Ayi2gD0rpj2q8vAHErdtgV0SwjmPnDOjQQVH/q6IEA9l8ZWAG0efDkqzeGMBN
         n6hnq1VxbhALDXWyigkNxcA4UCE4J1ODA0D1CoV4P8os6nSSraD/xfyFL9l9vl5IJ3ra
         hMWvfPmHnYV+LX//c1fLYrlY9fyhNNl9bUjp0H65GBO/YUS06yoROaxmEpG88ZiZOs8e
         1+v/e+UwwDaOhjcdyxnGQc2a11w7VEHiauUP34RvtlUYCiYNOwNrFuxZQC014Leml8cs
         I857IXxxQa6EZLmtdC8K+/oW6Rf+ajX9UZmFmMLKXmrg7vATmxKLU/Q2fTEDWV8BFV6l
         j7Bg==
X-Gm-Message-State: APjAAAVf1Jnp1AwG/sVMgZ91bNZjVvKMorsiQ6Ovay6n9kjGOFk+lYCo
        z7KnI9Fm2viVtuJEQQO+VseuOwD3FMqi/Pgo1BKpBw==
X-Google-Smtp-Source: APXvYqwFVFlq0p8BONzLBrYkCyHjaR3SnRyeXjk4F7y76T0DeGn+KK3s010oor2ZvbMe0U/S7B4g3FHOZ4pqAHtO4eEhpg==
X-Received: by 2002:a05:620a:1383:: with SMTP id k3mr13843472qki.346.1553551858792;
 Mon, 25 Mar 2019 15:10:58 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:50 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 23/27] bpf: Restrict kernel image access functions when the
 kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

There are some bpf functions can be used to read kernel memory:
bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
private keys in kernel memory (e.g. the hibernation image signing key) to
be read by an eBPF program and kernel memory to be altered without
restriction.

Completely prohibit the use of BPF when the kernel is locked down.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netdev@vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/bpf/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b155cd17c1bd..2cde39a875aa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2585,6 +2585,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kernel_is_locked_down("BPF"))
+		return -EPERM;
+
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
 		return err;
-- 
2.21.0.392.gf8f6787159e-goog

