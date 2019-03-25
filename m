Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781D7206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWvLXqUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfCYWLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:11:05 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:49209 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbfCYWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:11:02 -0400
Received: by mail-ot1-f74.google.com with SMTP id s22so2754508otk.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3+VKqpN9HOYaIvT2+O3RmkFaED64oX5fAU7Jkszi2gg=;
        b=mWvLXqUtDJA6ZLQ4rljXx/YaZEYZSY7mEfqNWbs0oXQfF43ZORE6QxhourW5k0jnJR
         EOW/YzXY2k9Y/KSzznidAk77H9YCAgP6qmLaA8i7271DXENkkL83AXVxTKa/Meu4Q2co
         m8fTI12PGZS3e44w3/pqpyVKbejs8l+8KA8+tKOSmF5W1GlmrnasS7nHxNENL0GL5XQ+
         br75aVOU3PTCH7P9nYFy3uguV+OntpJ2wGZepe2FUIbVWrydycpb+54B1Hdm4WN8q64S
         zz2puwjsK3PPtJ47euvqUEzpvVrFHK8DvYd+YxQNYnD46/jx2VVSSWYUg1drwzVpSubk
         Cf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3+VKqpN9HOYaIvT2+O3RmkFaED64oX5fAU7Jkszi2gg=;
        b=ScJQl/WBs0ChBHjz86ztzYfOn1oh1CFQ+V/4a6pyglED6Iqwfkdc8uinnckDS8zqHb
         /qZXfu5LX+HHdg7mlLHOKBTEO1D/chI0/nweTGCC7/RKa6Xlp8yYQ/bTdPITmVvWTFJO
         rtHnRDucTuXmOZRpuvydL/GuMXMF7DqaXenVaJMMp2CnKF9gjMpFpptAr0fhTJMvOQWE
         ptOonbJkOjVvZn57UiLYGsQEcdtMw61Dg2bzq2vM0/bof4+1hxHh/+evdxViWdt+NAta
         oeQMu5Q9P3e4BvHQz9DcEXvHbifROWGwv6A/giWmdh6u30F6B2OsW7RA6fDTb6gtm9mK
         13Ew==
X-Gm-Message-State: APjAAAWiz/YVAxs3BDKTPua7ZM4xSglrXgDw9byfbnTPOWSxY1riTOQ9
        ZgdvUs1iHLoDWE3h434Rj8PIX0/FmgiPWhjgsgGG4w==
X-Google-Smtp-Source: APXvYqwWnnRUoY5R/OT5gcEm/ggiwDceTHXuykWXRhTc4QGkHiNci4Egd2xX6G579iCHrIPXxi6s8Cbr11+1Z/L75xFCVQ==
X-Received: by 2002:aca:aa91:: with SMTP id t139mr13629092oie.174.1553551861302;
 Mon, 25 Mar 2019 15:11:01 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:51 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 24/27] Lock down perf
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
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
2.21.0.392.gf8f6787159e-goog

