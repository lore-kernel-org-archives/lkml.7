Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AFFC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0030320723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="FUWeFJQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKPLlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:41:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51894 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:41:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id q70so12224960wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 03:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qrbBm1fL62NwECBN+3glE+N1as0J/NyBOFPV+RHSPg=;
        b=FUWeFJQPe7xIzamd5joY0TZn2ICzDMAdR0UP0/kbwZecxanpjgHKCIH2HiHcTW3IrD
         HHMsF0uOQlBekIwAo2lKkzSBGRs9meIn2OcL1EagZ4kF+ogadMnEVSnv/UMtpZKs4z58
         06mxx/5O0wGASoSt+sxQhEfx5lGOTuHh+2/cMOsvwIRV4hw89sADsQZAWtuIPMPURJ0j
         ErQ6DcMtJTDWnJf4cQy8qBA8ktgbmnmvoqur3vl5XWBN35DDnNtVcH3IF7iAlWkP/I6p
         YcQTfD2GPho+PkD/38XEIbT5oQHET5Om0OqgsaWJEyAlBCUeE8zOvCUTpC4juDBHFJoZ
         TjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qrbBm1fL62NwECBN+3glE+N1as0J/NyBOFPV+RHSPg=;
        b=TXKOEhPXynxcjI3n05i/uy71hKqM/qhHRBP3XVWqzCx98cLGnnD7yuvEOcBY6mJ6Rp
         22Nj89kHUtegNup8UYRiVtBpDmRN0ZsRCkIsUcnB2Sqd3BeveOJnTfDMbycAKJp6e6LX
         SVOhl+0g1EzbkCXbf9DvxiKcN5YZhNpexTHKgQC+V9BQW52mA2WI3RMhFVaDp5mTQ7OD
         b0Os+lpa+3Hcfn5OXVEE0BBdZ7Cy0Efvqb/2z7fqsJTfCO2I6rn4nft/I6M2LTx5Zkw4
         Z8YRvb/sDWRq+P3UHzQMhFIttNcONFWVngl8ZM/odLPPhnx+SQ4l11xdLTBWe5R63JyP
         QbmQ==
X-Gm-Message-State: APjAAAXDahw7yKhoGM02fDHDRwtaBkTrXU4e+sCddijmSZO1hNIwvQkk
        bNDn1pO4S0rSglpFUJFv/Y6mDA==
X-Google-Smtp-Source: APXvYqxd3+/pvXHp+aXQvAUHFjmjZyEe3Wr02QAA/72ZOBUitdXD7hE7GEdnDudUfo1+6/HqB0HC5A==
X-Received: by 2002:a1c:9917:: with SMTP id b23mr19488879wme.42.1573904483443;
        Sat, 16 Nov 2019 03:41:23 -0800 (PST)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id x5sm12539189wmj.7.2019.11.16.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 03:41:22 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     mtk.manpages@gmail.com
Cc:     adrian@lisas.de, akpm@linux-foundation.org, arnd@arndb.de,
        avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: [PATCH 1/3] clone.2: Fix typos
Date:   Sat, 16 Nov 2019 12:41:12 +0100
Message-Id: <20191116114114.7066-1-christian@brauner.io>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Fix two spelling mistakes in manpage describing the clone{2,3}()
syscalls/syscall wrappers.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 man2/clone.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/clone.2 b/man2/clone.2
index f67a60067..57a9eaba7 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -70,12 +70,12 @@ create a new ("child") process, in a manner similar to
 .PP
 By contrast with
 .BR fork (2),
-these system cals provide more precise control over what pieces of execution
+these system calls provide more precise control over what pieces of execution
 context are shared between the calling process and the child process.
 For example, using these system calls, the caller can control whether
 or not the two processes share the virtual address space,
 the table of file descriptors, and the table of signal handlers.
-These system calls also allow the new child process to placed
+These system calls also allow the new child process to be placed
 in separate
 .BR namespaces (7).
 .PP

base-commit: 91243dad42a7a62df73e3b1dfbb810adc1b8b654
-- 
2.24.0

