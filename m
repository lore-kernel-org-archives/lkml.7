Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8489C206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1UEVtxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfCZS30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:26 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50190 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732804AbfCZS2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:44 -0400
Received: by mail-vk1-f201.google.com with SMTP id k78so5823904vkk.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CCajKTRONhdynt5B0tRKLHYn7gScHVmkVEVnwB9DKOM=;
        b=f1UEVtxL0EVlbPLDdmHVG79aucAXc1fBqJUwg7tt7fSA+AaesqY3P1p2ZfzU8cEB3n
         03bsTL9VAsQne/n8Nhvw1sWnpcWum4Nqv3Yd9wb0ciIhqZ81AcSWIwiSc4FpvQcIXzja
         GBTM5kZH/0zi5Ne9dZ+ikq9lnF2Q32FFRZvvpt9YRkY75BhFAUNRNgck5+N1zyk4f1qA
         vMNtUXdf9cac4ri6xntmYw06VGoUUZsq8lxd2e2TecdKei4KeSsc3xhm0MGSU87S8/FC
         RxRKWWq47aOtlEK1k4qA6SDhvIGzXiN34T2kO23uj22gg09sBp27vGRNkphNud+PLe70
         YX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CCajKTRONhdynt5B0tRKLHYn7gScHVmkVEVnwB9DKOM=;
        b=FP/+rvX6Pv1P+gBjYi4dMP0dJpkBz3QxMOzttK+Krk+/ZriewOvhWYrHZbuej6hifS
         Tez18sgMm/gyRx07fQMgIYV0wlfYUtkEfR7JEndJW+INdcQ3XNZAG/xQKY/ObmNRLivY
         LbGBhOjcQFURZaOBg01cT5XJc1ZPGc0/7+qbQda5b6XQro9sLqbDtXGepJ6E3Xj6r/dQ
         m/1uEkNi2+YN3d65N0yUnav0SdB1qsJ7V8oNJlux59jQk2/A5rXNCetUjWBn4aHgTS2b
         4m0EJbGG7uWNKUO1dNbCCsV9fnpAN24N63uIoMZ4U3cDYHI4Y4/yL/Jh+ZYI573ghDEZ
         akfQ==
X-Gm-Message-State: APjAAAXDsdZCFyzcs3BMirRDjOhFRcRYn0BXfYQNqbP4o/3Z0vhJPuaS
        ArFAbvDE+x5l03hs4fIJW1F1dQoVp1ry/Dr5Y75wZw==
X-Google-Smtp-Source: APXvYqz5uwzG+qKt/vXAWjIFjKNq6CxLPDoTjZaK9Y+pyALLrDT+Cci9K4q1KvaMk9n8XrM1s9rc/+mImVPEnueEPe9h4A==
X-Received: by 2002:a67:e405:: with SMTP id d5mr11689528vsf.236.1553624922695;
 Tue, 26 Mar 2019 11:28:42 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:35 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 19/25] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space. This is
a runtime check rather than buildtime in order to allow configurations
where the same kernel may be run in both locked down or permissive modes
depending on local policy.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
---
 arch/x86/mm/testmmiotrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index f6ae6830b341..9e8ad665f354 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -115,6 +115,9 @@ static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
 
+	if (kernel_is_locked_down("MMIO trace testing", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
 		pr_err("DO NOT LOAD THIS MODULE UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!\n");
-- 
2.21.0.392.gf8f6787159e-goog

