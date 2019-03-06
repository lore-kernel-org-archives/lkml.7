Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D88C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF12206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDpvVEqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCGAA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:26 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42575 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfCGAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:22 -0500
Received: by mail-pf1-f201.google.com with SMTP id p9so15436498pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Slizqb5/EuTPaUwcXF3KMpeQ4PrQTQCbKq0uAOfUYTM=;
        b=oDpvVEqXJpIrSthsVtrG1ShhFNsu55AnYk1HsI+XwYF/iW9kwSA2kBAvPZw+7yQjfw
         vzSxG4bd1r2co7712oCcMqt74ttgVvINiMXH2LrnEfxsC4EDf5f61m15hsOZGc8wurdo
         z6ZJHSMjH/LZX7w3vZkraygwiuGz5NTi58N3Acqfjmle8xv12Sll71j3ifjGa63q/qlQ
         gchCUqX0bdhLA2vxyqg9QdSl6LJ/vHnekwBmOl8If6OxlO2ffb/B1kyfZHeRiHVFHwfz
         eRYI39TbxMswh6rAd0+mFAm9dDOPwVdoNwsAl4QTQpyBtiPMO+KPc50P2B8V0cHzf08F
         IMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Slizqb5/EuTPaUwcXF3KMpeQ4PrQTQCbKq0uAOfUYTM=;
        b=mOZ1TFw4aa+/lYaJHxUrK9jmOEdTXxEY5oixHI2+UMstv8iJqkPjPkSELfUdIKFE8r
         DOJNM13APj2nsplMfpvh+RneeJSUdNTDcn/1UfqLb62MXnUygGY0pX+X/d0b6trPOgPo
         ru7GZ4Ne3CGatiTaWbLARdpIWjKImVJJry8t8t44j26RL/hAkIc8LTp/AHwm9zoNZrzN
         LXe4+uYbtjx4orJsR/I1sahUK6YOzQ/5LjrsdFKmgS1Y/geBYRf/z/XygbEbYn9CBb3T
         jJLwBNMofob+7Rm4NBgDWyAI+WIwiTeeN740cZZX5YhNUxWYrCymY1kDRpXdk3YEGH0K
         GEqQ==
X-Gm-Message-State: APjAAAWulwTlc0mFVugu6RILQUXnDDxOETV/iYuubOppuQBz/hYdMU8N
        7t6oxXBw2gqiQHz4pCZYV3ITB2HGW5bp2SapBRA4UA==
X-Google-Smtp-Source: APXvYqzfz1Mm6zPNOwyLTXv7LVSJYhgRqpTmBGV1FsT7o7dpYl1eV0/IRR3lSRHTQ2w2htmMx8UY+sNjaz8NhBbQOd9Png==
X-Received: by 2002:aa7:8215:: with SMTP id k21mr3854968pfi.78.1551916821402;
 Wed, 06 Mar 2019 16:00:21 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:07 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
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
2.21.0.352.gf09ad66450-goog

