Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294DCC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC72E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpB5lrCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbfCYWKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:54 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:38956 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbfCYWKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:51 -0400
Received: by mail-yw1-f73.google.com with SMTP id p1so16055322ywm.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WIYErqKuw8M4x3DY6l/FyYzixwb10M5/VPpKJUswY2U=;
        b=hpB5lrCxLRgzsbFkoUuenQDO6lEUzGh6NLvKA42UxU+AGaIXIjJE+xcRp+e/ZOInqG
         x7oBxQiIyt0Jr51SRzdjcAfkWutI6bY1d+giGLhZZMY6zF7D3Dq3jK4cHupG4miI9Ozt
         Dq7meYBrTo9DDUqob4RK3zVwZflAN5Cfi8BrCfLVpZMqpuTXP0q49E9QxEAQllrodIqn
         G6Qar+TYGLbgnUi+tum0fy/urAULLofT7wZ/OnBAyMMjOOLn/P2Ur5Kp6fw+NeMAVuUm
         sxvbYg2Op3Rj9WUwJJ590ShWho7Yn3yc6YZFn0EPTL7xnlnGsim/gEJbpwsFab/V+mUa
         EDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WIYErqKuw8M4x3DY6l/FyYzixwb10M5/VPpKJUswY2U=;
        b=cpPPAJ0GkRjTnnWOMEg3L1bw6sT951Y6hvxbe3OUjxAFjmYDZiWK6C1f9KAHUhvBco
         SABdTuzy5sIIel871MqKLBDmDVrLmzPifuc8k7JBUZObEbwcqBDGNHfmk7w4kq+C9jvn
         rpaVnfiy3Vvx9wTfio4r82r3EA2HHx0bkDpI+P1mg5P/JwSzKRAK8+ZCsBERwjG1W9zh
         k/IdCWwRTg/5fVJEFYsBV8vGPJRKOiNdFRAydhU3xf545dZzDYvAjwNABsGP+tV9+qsh
         9OhE4OpMQAajNPsIZRITk6cxa6+9jw06Tg+yzyWE6Ilg8VETpaLpEZIXFAM1AVCog/Dr
         gZXw==
X-Gm-Message-State: APjAAAWycxMpM6LKg8QkNj27ujKbtIpB7sbKyBx/ojNXUW8S2gcr3P8A
        gskGGVCSxLJ7Mz4+o8N3u+gJOcaAAv6sqeTFFOt2vQ==
X-Google-Smtp-Source: APXvYqwVJ4zN7NiVgCoA+y896Titofd2gogrsZmPVHIfd0661OOJsMLiZ6FrWOjowM6gu0u12nVkbgN4S7Q0G/WH0XsLRQ==
X-Received: by 2002:a5b:8cc:: with SMTP id w12mr4545500ybq.113.1553551850650;
 Mon, 25 Mar 2019 15:10:50 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:47 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 20/27] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 arch/x86/mm/testmmiotrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index f6ae6830b341..bbaad357f5d7 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -115,6 +115,9 @@ static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
 
+	if (kernel_is_locked_down("MMIO trace testing"))
+		return -EPERM;
+
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
 		pr_err("DO NOT LOAD THIS MODULE UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!\n");
-- 
2.21.0.392.gf8f6787159e-goog

