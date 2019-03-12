Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01E7214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCLIxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:53:07 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52598 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725832AbfCLIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:53:07 -0400
Received: from mr4.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2C8r5YS010637
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:53:05 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2C8r0Sk008711
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:53:05 -0400
Received: by mail-qk1-f197.google.com with SMTP id k21so1559786qkg.19
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=aQSnaQmgA8OKaKcYt9/R0qyi0yOf1jKkt+7rsUlC+Es=;
        b=sthmbdvr61iFjrEcYXR5t0DAP7MM3RO0C9bTxVc2VcXoIknZT3OqtrKN/sV9elAiko
         LGkb1dzx6P9R2eeNpunVmHHAcnttYgO1h9Z+2wmGnAy6B1hJBHBA7ci/VS+LhUeU8Kiq
         9RH/p+ayVBcloySR1WS7sAYWfjwW2z8kZD1kGSirewDLuILeM2tX6QtFy+hdnc5m8cBR
         jFBUUkfKuVgQjykaECWMa5bBrx8AOwH2qRZuTCth9czlmtwM17FG4YKUTbj0X5QeicIy
         3jg1U93V6iqgQyL61WMEitq4n1Z7rRe6I6oTS8W4REnt8wo4ZMdAFslowjdJismRiAnm
         2ObQ==
X-Gm-Message-State: APjAAAWgAQopwDpD8Pioaga7eU2s8G4/5EwwkFODGtHIzSRau7wW4qk1
        T7JEe96w7KPbLL6+aVNZ1jgg6bSpmqDCCsXEEMwaHvp27aR9gpJq42Yq7t3VWqxGUxKyvGay9Q7
        NAErCNiIGsO3Ayzr52iHlEfkQ52wD4B7MinI=
X-Received: by 2002:ac8:7006:: with SMTP id x6mr7381426qtm.4.1552380780549;
        Tue, 12 Mar 2019 01:53:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwpiIIRfNRRR883P9aQfjqz9vt8zMA1GhzF7qOi/lLRvuuzJNfIrcIVfVApudFgS/sTx2+ANQ==
X-Received: by 2002:ac8:7006:: with SMTP id x6mr7381414qtm.4.1552380780314;
        Tue, 12 Mar 2019 01:53:00 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id r68sm4375443qkd.68.2019.03.12.01.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:52:59 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/trace/trace_probe.c - make variable static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 04:52:58 -0400
Message-ID: <2478.1552380778@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains:
  CHECK   kernel/trace/trace_probe.c
kernel/trace/trace_probe.c:16:12: warning: symbol 'reserved_field_names' was not declared. Should it be static?

Yes, it should be static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 89da34b326e3..cfcf77e6fb19 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -13,7 +13,7 @@
 
 #include "trace_probe.h"
 
-const char *reserved_field_names[] = {
+static const char *reserved_field_names[] = {
 	"common_type",
 	"common_flags",
 	"common_preempt_count",

