Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FC420663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ja0HNHll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCGAAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:31 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51835 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfCGAA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:29 -0500
Received: by mail-pf1-f201.google.com with SMTP id 23so15436383pfj.18
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1/Q9WI1yRVatQ/yQs+U4SWm6wGnrwBw/w693pRoFvME=;
        b=Ja0HNHllquwFqNG1YcYRVsIuOz1GquTrJ6u28a+VNVnXPhxF0/mfK/FHq09suoplle
         7JqwJEgcdxpohcoOyj26m2vvd2O3DWaqqVJfBENoEsmPBIwdu9vxrBtRnHwgBn5u4uMz
         CGvyoeNzOQApATOK1KARCskkWxz6Zkg83BIqJ8sf7ZnfQ+y6DbqwKfs1rA5Lsw1IO0Yn
         86ZEJt3E1SPzRbvLNtuYph5p1H02Q+kVt115/5FBrrpN9ok4axreUzF+V4aHGUXoKvcY
         PoXpEbSBn/qn3twrhP+7BhbzPl6dPIAt0jvQxIn5hP4UbXMvUAaKhgGorMQDWn7McRPd
         22TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1/Q9WI1yRVatQ/yQs+U4SWm6wGnrwBw/w693pRoFvME=;
        b=TJJjCFhVVH81TG4lRvI5CpVKHakhNOMcK3dG7QirJ585tNVAgi7FsU17hrrZTHfqIA
         XV5OmhW1hfmmlxHARlR6CFc5SOoxBZ2yzQNwqk/G8MV1C/TykzfhJklTel79ExFy4K1I
         2X0Ebutl66jJMX2mBH9QS4WhD8LHDLTxiDG9DCb00dt4k5ERiuJIq8clxUcNf2rNcQcw
         iokFXlM6hMKfCpRE7P0gWrY5Fx/ohY7eUWiFnehJLRLpTkI4CwJbyDO9/X9isxoxI09H
         GVja0/qYylShM/V/zpWEnU85cEbl7t4hLWNWPjDqjofZbMTXv4CDdNlZnC0FDhbVu5Ry
         HiXQ==
X-Gm-Message-State: APjAAAUy3jTV0A8W1Q6BjB8pKgoiTljsvvSPd9JytFzrmTMGHMO+KrhS
        Pu5Gy6HGKIkITkAiaQ6ouqh6y4bUIWNHJOaUsP33AA==
X-Google-Smtp-Source: APXvYqzJGpcTZFiJ60Kt07J6NBi126oe9ezITe7lm1I1QgqAXsalOHpVGI9OZnjH4Zin/mrlx94uy1Z6ewP1nF8X/XrI7w==
X-Received: by 2002:a63:a506:: with SMTP id n6mr37123pgf.98.1551916826638;
 Wed, 06 Mar 2019 16:00:26 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:09 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 23/27] Lock down kprobes
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

Disallow the creation of kprobes when the kernel is locked down by
preventing their registration.  This prevents kprobes from being used to
access kernel memory, either to make modifications or to steal crypto data.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4ddfdd2d07e..6f66cca8e2c6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1552,6 +1552,9 @@ int register_kprobe(struct kprobe *p)
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
 
+	if (kernel_is_locked_down("Use of kprobes"))
+		return -EPERM;
+
 	/* Adjust probe address from symbol */
 	addr = kprobe_addr(p);
 	if (IS_ERR(addr))
-- 
2.21.0.352.gf09ad66450-goog

