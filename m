Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9FE214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfCLIGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:06:46 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35070 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726714AbfCLIGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:06:45 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2C86i5t001677
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:06:44 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2C86dhu017840
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:06:44 -0400
Received: by mail-qk1-f197.google.com with SMTP id d8so1477310qkk.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=TBeWJfRUXHjes74nAuPOGyMjyvbI1CBDmId9R58Fmwk=;
        b=j+pgVlWxDdQeu0yExEUIgDrr/jPeywOneu8dUVw91mSmI78LMGkTeg4AoxIDAz6FPX
         MdK1g8t8HWOFOfBiRwL03MQPgAkZdqoC7Bo8dQ3e9KXRK40kdf76QzkCcTMxrnQpL6b3
         bkESnFTeUdldYxnTBgi3AybTz3MVU81+9EDN/gMlW1QQDVSdw/APghl7ZUDeY+rIFxpH
         ZhTvoCh3qfuIRdbuCVAHreSLIzSVuIQItXkoYyvp53H6FFDXPrtG3+GFe9nc5G9zKADE
         0YnQtc1GiceGN85WImeASKDXNFWnaiPxpikl7NnFuzuskdU9lH7YdM58hl0IfMYcu9yW
         AGag==
X-Gm-Message-State: APjAAAVKGOBgQgdWAToP1Yvj7Rl5XaWnWG2wi8zdoqhiE3asuaEbfiz4
        0GI/siXc/UV/WAHmM6hahSkZZpKqGiztbfOKf/W7JUrha5mKZ7bWN8hb6XtPq23gcdnYgDHPi7w
        77Z1mKOsbqXbAPXmw4pCS30Mbp6RGzlKV1tQ=
X-Received: by 2002:ac8:2ed4:: with SMTP id i20mr690240qta.52.1552377999574;
        Tue, 12 Mar 2019 01:06:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwDuJyEL6q5UcFt0PCt61Gtrv63vf/25vh8g/1gYvlXAvQIgJkvVpeJpMXSDNFeQriGb5+Zjw==
X-Received: by 2002:ac8:2ed4:: with SMTP id i20mr690231qta.52.1552377999429;
        Tue, 12 Mar 2019 01:06:39 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id i4sm1992966qtq.58.2019.03.12.01.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:06:38 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/events/core.c - make perf_swevent_init_cpu static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 04:06:37 -0400
Message-ID: <28974.1552377997@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make W=1' causes a gcc complaint:

  CC      kernel/events/core.o
kernel/events/core.c:11877:6: warning: no previous prototype for 'perf_swevent_init_cpu' [-Wmissing-prototypes]
11877 | void perf_swevent_init_cpu(unsigned int cpu)
      |      ^~~~~~~~~~~~~~~~~~~~~

It's not referenced anyplace else, make it static.

(Other unrelated warnings elided for clarity)

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f7086c388781..77eaa65363d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11874,7 +11874,7 @@ static void __init perf_event_init_all_cpus(void)
 	}
 }
 
-void perf_swevent_init_cpu(unsigned int cpu)
+static void perf_swevent_init_cpu(unsigned int cpu)
 {
 	struct swevent_htable *swhash = &per_cpu(swevent_htable, cpu);
 


