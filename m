Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7E12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVqaNZmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfB1XMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:21 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:34441 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733124AbfB1XMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:17 -0500
Received: by mail-it1-f201.google.com with SMTP id x87so4988374ita.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=omvW46xVRIJwG7a8uUzxR/RTr/Sb5wtOc00auoVaOTc=;
        b=CVqaNZmT/Vxo3WpAM7ktoGnUP7Q/3Hx0MG5cQwh9S0SE/J5yZCEog/cy4qgT/Top4V
         JXL0JlsqLvMEz/iuxg9miOURifPBUNIQQdqd9DTk3jboMiFD9Gpm/Ty0DATFBMCHLzRo
         sEhvOu0cPA+j4usH1UVgAzYuFmmZL06a4OtYjRRkz7aP02dz/gjQeceXfVe2rNvRvCbl
         8vikkPt5QQ30X9wvHV4nVfVjc2wo8Dqodx/3jyVJJg43fapTWHgQN66blfpaeOlUDjhm
         jdXuEbPrRkArOWpORujX/IXd7Lzboi/jDh2JE9Lsmv68uH0PM8X910TxaHaE8OOepXOq
         K9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=omvW46xVRIJwG7a8uUzxR/RTr/Sb5wtOc00auoVaOTc=;
        b=r5mqUnuJRr9YT8JV478YUi6kfXAPi+sMUILAJ+Erz+60jPyshDfL3KZGsjdxJt9Suo
         cN5scy/i9/Raat4dwxj8CfDyV1cuIjZrnPDDLRhAw0SPKn36LDVIDd/LntRAVDYmRdYT
         TdXy0Cr2imBiEXgoqpCSWFCsYc7P7urgHJGF7bN1Su63kbAPmMRs3t54LRwuZ0wQkA5z
         KjB0GegYdNVdzLaxT1ugwlYJlG5c39CuxCvpmZOhZodmR9Xa+qufANsgH2jxN/1T9VwZ
         7A7WNdtl7Tf7CZwXJq4yMXuJtRACg/eCedq3jAqKKVXt6N7P60CwwN7vPX1QdsQ8/2Sg
         NMqw==
X-Gm-Message-State: AHQUAuZm32GbOkfVpQkD6M6bzXp4OZwTY13g/R4ZfYLYJlpUHddVAIkk
        gPElaQFhs1/2SWY6kKG4gmBKTINQ/zJWaZPPY0RFKg==
X-Google-Smtp-Source: APXvYqxN++346xVExb88s90l6mAGuPKjGUD+3tiMTwdRvtYnnzM8Y5Op2dnO142zdc5PVmmMAcM77+lQIwSp+hj5CTq8/Q==
X-Received: by 2002:a24:16cf:: with SMTP id a198mr1544187ita.0.1551395536713;
 Thu, 28 Feb 2019 15:12:16 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:41 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 05/27] kexec_load: Disable at runtime if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: kexec@lists.infradead.org
---
 kernel/kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..8ea0ce31271f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,13 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (kernel_is_locked_down("kexec of unsigned images"))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
-- 
2.21.0.352.gf09ad66450-goog

