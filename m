Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D5F20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYZ2dcvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCGAAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:34 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47295 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfCGAAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:32 -0500
Received: by mail-qt1-f201.google.com with SMTP id m34so13503670qtb.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q6GDvRzzqJ3B5qJkvllHotglBKQhGGP0snG7GKJPXnw=;
        b=ZYZ2dcvFODLgDGpfqBJrUFSMC14W0zW/v9LGNR5tj/HLP32OYfhhxK+Qk2jWmzBhHh
         fD0lWZtBnBa8FU0tBiHQdUkFOSuMpN8OnDKhOgnSSwokIumQ5B1rAic14XtmbxwoKcp0
         T/DAeLDBpCvbG392L0WuUZqkzrMF54pbJzA4/5HyQiIKhtn/3CPk0U2n1QTbX7EG99E7
         BHQlX6U3dWAlMz6NWe/h4qEydE2ivUwg/Knf81MCzgaTOpRvylWBO+KNfut/iscvFkh6
         06NUxz9LG8t4XjkO06JTu6xKFZiA0RzmvHpKsWctGwnhpyW7KBo28Jccu01eLCyVQ2kY
         nNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q6GDvRzzqJ3B5qJkvllHotglBKQhGGP0snG7GKJPXnw=;
        b=nRjf011rMkmRRCwuS7GR4sNlVJwPJC9cHXIsMNJ50aC4zJlGsB4Lgl/e5++MCXCBES
         sw5Cv/0UjFC0vD7oXHL4FcZKSNvPmMxqCZX4BEPvF1qmw+QMq6A5oF6XoSLb6JZVSj10
         ThigFkYsWFq8lq/PnTgKApNWB22/PvYgpuIgdVlubgFa4V7RKuyV9z5vazWzQ18RcaSy
         UTJT6ZpqGTwj+nDUh7UCMK22cBn8Fj4U5TisZMp1uNNBoz6xSaqV/vyxSWC6dRwVH86a
         8CCfX+c7YYphqdBGcC9acyOe8xePlFlfNToIPxvsOTAVx0a0z1ekEoZQDrdHB7WEGGwl
         45Gg==
X-Gm-Message-State: APjAAAX/ZukzIW3KZCx6vLTTrjD8dOF/Z/azcA3OewCIqTGc3dFcNozH
        rSFoKhYhyNYzPUkrL9ydR+vWlV3OJQxIjJp4bkE6qA==
X-Google-Smtp-Source: APXvYqxBVZyLnxryEzxwDF1gzsHdvGrc99r5jJU/gjHf4YB4rW2YM9ulw3R1GygBB2M2xIaOh/9oc9tuEPUyt9xGuSAmwQ==
X-Received: by 2002:a0c:d238:: with SMTP id m53mr6292264qvh.30.1551916831188;
 Wed, 06 Mar 2019 16:00:31 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:10 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 24/27] bpf: Restrict kernel image access functions when the
 kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
2.21.0.352.gf09ad66450-goog

