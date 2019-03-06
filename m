Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75389C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3780520663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joKpMu8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCGAAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:37 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:52316 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfCGAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:34 -0500
Received: by mail-it1-f202.google.com with SMTP id z131so7079833itb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2ZzvoWSyW5HTZoeTqFWgg34ixTiNCj89jLrYIWViRl0=;
        b=joKpMu8ZGY15PM01/2KwGjHB3xEMV66i1KxgvTSL+1mba0Ycnp54vvwcsr5147kbND
         HcmViD1WphwEuzoWcJ4H1/sv96EAylP80mqoUg0iOZfvL+dzMavW3U1OAEyTa1YWH4Vn
         GUJyN4qGi22LgMAOY/b7ZppRgmDrY7lAgA3zJPCf8y1mlCHfBZ/w4PZmdHsrArINQSUO
         +O0CMFhaKttpJXlUG0g8EejPBD3z+u4R/iTnyzrtCwu7XKbYpELQmoWInlNQFRH8S82c
         /lgwwBJE78+C/d91iDKyGYt4HyCEtrQm3ZbbpNfUQ1BisJ/tNxPXHUnrJvVsOZy35ShU
         CwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2ZzvoWSyW5HTZoeTqFWgg34ixTiNCj89jLrYIWViRl0=;
        b=U6rC3dAEd5GqRucS24uwl2iNAYoFhI06hNv7XoDsZMA7KqtH4oO2u1QTGYKAPRH+yq
         zqDdNWKkZpEQpadocXs9q3DGj4OVVyYmmG9uzeJMxgVaLKdHJHKK7s2Q47J4Gy4nNW2S
         Br6z1amGcdm5rRgf5JyDb0KI5dNBdoodLTG/fRrTgcR40OynE1rU/45BARFVPfIImxwj
         GoztdjDskpjJfS1BIUwnRIMCrZUmDJpFl8MEWYQLah/s3iRn4AXfRKDB71RihfwRwQFu
         SBHvnGfF6NviMUJDNYl+kimVF48ieZchxBBEZQfrFCcrpGYR4UcSZiKIOgVQEKRUyQvC
         nEWA==
X-Gm-Message-State: APjAAAWcgFCGLLNasGUlXqbD202+3943i+24fu+FvUZZCusMo5W8JziN
        bDgzE2EcWn7lP2ZlzrfX2PitLuWtH497yX+FuhHeXw==
X-Google-Smtp-Source: APXvYqzNE5CE6nTSGaldcUru/FCAR+lWhmANgOrDY049Tzeob4ckhzRzZiu3wCfqmDEK4LS3gEU6Do3cC6cmiNqK/hjmHQ==
X-Received: by 2002:a24:c1:: with SMTP id 184mr7378710ita.21.1551916833546;
 Wed, 06 Mar 2019 16:00:33 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:11 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 25/27] Lock down perf
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

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>

Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..7748c6f39992 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10461,6 +10461,11 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    kernel_is_locked_down("PERF_SAMPLE_REGS_INTR"))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-- 
2.21.0.352.gf09ad66450-goog

