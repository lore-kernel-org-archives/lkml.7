Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C17C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A752133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpVUN+Ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbfB1XNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:13:51 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48089 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388051AbfB1XM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:59 -0500
Received: by mail-pf1-f201.google.com with SMTP id e4so17306390pfh.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pGMKAmmDh5CXWuiQ7W09QK/FwS2bHkIIbTbOhTQuPUY=;
        b=IpVUN+LnDhNCnYgH87Yti/gH8YcHfd3eB0nigEUV7nIBR7yUCtn8GYobBEJYY1+3Jx
         D9t+k05834I29T2Sf2A6lVcrFiWh46QBO1J+cKI7uCvU+ydhut+eHS5Cb1YsqAWa9PWQ
         NYkfFRn5xgKOIfEsrVIeLj0A42O3PtwH/A5BZlTGMBfZD6jfRKafOCLNwSTK7nLrDQ3u
         JhnooqXvCTwySTQBTHWZv0usxXx7UZeGT+4fKRkEUMQT8hZwSiW5HzoqQLFGdytfBpFV
         S1y8NrZqwCjD1xrR+mT1C5LbDhSJL0i5O7UDf0QHQylgwFBKVxjlHqQCV13OPaCKcShT
         lzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pGMKAmmDh5CXWuiQ7W09QK/FwS2bHkIIbTbOhTQuPUY=;
        b=kg/hGQMfH8+4T8Wg0KzyYVnklWCIru3Y6JhTX9z2CaOTqn49Wu4OC2brWfn3WcmqAr
         5rR4+qD8s/TzTKCgh53C36ZYGMwAqXLI9v7dVqeqJwOGUswENfnej6PO5Z4aFjkH5O7O
         PtlfVEwcHG428SCS7tg8ZFRbddPt84VxD9H2yWnhdOTRNxHx4opXblJnytuX9G+0v5YC
         SO+v3FQnuP2uqlllpOlnPMeGg9RlZHugSBuwMKBvq9g3mv1KuId9fHyITtv/7n/WXBTJ
         EAvD2KQfE5hHeC/xFWnHWQgu5EaBmZ65kQwkv5FLtHkAgfUiLLjxaG9aiZARyiNynTQr
         CRDQ==
X-Gm-Message-State: APjAAAWGFMQE6ir0h5pfK7TuvTDkI33ajW7vhzqjBz/U+Kf+WXNonWvd
        zgV1EBFrTssGHCEddGV5WKnGjLofjoxnHtSq5S4+lA==
X-Google-Smtp-Source: AHgI3IbdRsmVD4cLGmyor1MNc5tkjRGqx/qg/fddoUfCqLYQ0pZsImsOab5wV8/apSee3hsgNQESH3ULN0YMTwdETvbmSA==
X-Received: by 2002:a62:2e05:: with SMTP id u5mr960236pfu.137.1551395578986;
 Thu, 28 Feb 2019 15:12:58 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:57 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 21/27] x86/mmiotrace: Lock down the testmmiotrace module
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

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
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
2.21.0.352.gf09ad66450-goog

