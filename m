Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E65C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFF32133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbWK4YE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbfB1XNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:13:37 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:55466 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388152AbfB1XNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:13:07 -0500
Received: by mail-oi1-f201.google.com with SMTP id i67so7287178oia.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=587I7do7VgxQ57ltQWC5RYKCBbhcordnhHm7PVPlrfA=;
        b=sbWK4YE0HC80ETP/khZWToJ0cY/+JZs2pKZzeqO1jHXpQLJR84Q1N85z026hYQyuB3
         LeV0T57ywlzszxahT2vl/qZUIVwhBikEiOeJ0MbD+DOwdCmXusrvPnZMVNg6l1tievGR
         f8FKwhIb0yArv5Q4zkGy69wseUmP6EnDPUmydSvSYXVyM8Bs5Db1sLbsk66kaL63Nr7U
         4GZ4DhjEzgipUCGH8blHScAGTgIWf+FjggAhdKmeUbv42UA1ivgbihlAxXVyeRj75ZSu
         b+bLBp03z512RhDnhKfLybHJrLmLP+GTVdf3MJquifWC4bLlksxJ84N5WGRpdTmRqUGQ
         J1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=587I7do7VgxQ57ltQWC5RYKCBbhcordnhHm7PVPlrfA=;
        b=X5vvzYvX1/WUAqIYS1TH1MmT86fUoIgQKkoCZhD7hRNtrcRQfKvcWSkIYw9KHvtPnd
         pp0drLAG6AWw9j6KK1pcUnIfVs4/6UDW8K2EzClq0NXlmpu0Z8JVOpvpX1+KxG7SeP0a
         UPwMmi4SWz59ZfPYq46ZtNU5DyTVUbG3W04wb5qqKJqOfkmNYAKwqhgSFaj/PjSIRzhy
         Ia1qwFJ4Qy9e1pF6NkxElnbzJ5ct6bNp12oGpIs0hlpyN20BGL+jSNX1RfJYqJ/ND7/b
         DIILlmnaJpkjwxQ/FD1KQK35IQuvFZB0IitoYdJVdoUbT4cFXLE4aMxXPSCyluLRKCyQ
         w5BA==
X-Gm-Message-State: APjAAAXuQ9SJBEuhWdqOX2xe3aeDvpAj0Cj4hM2nme+sI4ojL4ORrMyR
        eifPiMWy0WSNF2eKPRZfY3Q02SRC9CwHZYJx79h4iQ==
X-Google-Smtp-Source: APXvYqzOiv/mL97RdQqgTV+SouP3a/ir0Fmjes/HKCMDAbGlipGiqFHPSNi7JMtsJsXvmAuEhbuhiYDZK3zdSUUKm7AtYA==
X-Received: by 2002:a9d:6c58:: with SMTP id g24mr1304166otq.10.1551395586760;
 Thu, 28 Feb 2019 15:13:06 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:12:00 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
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
---
 kernel/bpf/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8577bb7f8be6..e78dbe5473c9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2593,6 +2593,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
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

