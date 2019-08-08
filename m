Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E86C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91F421743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404319AbfHHR2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:28:54 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41538 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732444AbfHHR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:28:54 -0400
Received: from mr2.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78HSrGY021721
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 13:28:53 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78HSm1R019449
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 13:28:53 -0400
Received: by mail-qk1-f198.google.com with SMTP id x17so83215294qkf.14
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=ckuO7AH+Z8D+AGjx8XWAjP+p9H9PqjZuvFzkT06lDlY=;
        b=IX+sRdoz2qfGLx6mQGQLXfmMDsRaalKNqpBGZneBWNf0y+tpUBvQ6FE2vzVUS+Z/Y1
         M/e2Vx793G3axiOJfkJUFfslU2fHaNSh4/dnWmtSrq4ESXgjq3qaLRdFgVHgf28cR4Fk
         MxseoizG8VGjJHNEk2MPCpTUF3V3SVO+msCz9hEz6i4HYSukOP55WgGqIYQ5RNOo1c23
         P+TZPQpRW7mSKG3mFr4nq5o2aPY6wIrI22fC0/gKUj85LLQbZXms4R1BCtDWgXRE66Y/
         viuoVpUBwePaOa5TUYnqBCrBuT85sFpHA1Hije6pyai2kGzUymCzmPcq+t3ligfK6VQC
         IQgA==
X-Gm-Message-State: APjAAAWlMWV1xUnQ78LQvkZTXx3RS0c+DHlQRhqAoDAEyix+g0IF+BwR
        zvJvLuWJ22dvuJo0pWzyT3tKb6CZ5RXaX+xNF8d6Knm8homkC6YQsvjvxQuhXw7qy4eVveLcFHn
        MYaoxRS5Dplp7FI3+dXqd9oZLbffgzE2iBi4=
X-Received: by 2002:a37:490c:: with SMTP id w12mr14737121qka.327.1565285327487;
        Thu, 08 Aug 2019 10:28:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSGLmycWjv1kGN+Rwz5CRen998Ej9GiuSbCrNKuEG1856eNJLN27TdoaPqNJWY8W6+8iAe7g==
X-Received: by 2002:a37:490c:: with SMTP id w12mr14737094qka.327.1565285327141;
        Thu, 08 Aug 2019 10:28:47 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id j19sm37123521qtq.94.2019.08.08.10.28.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:28:46 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86/events/intel/lbr.c - make variable static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 08 Aug 2019 13:28:45 -0400
Message-ID: <122387.1565285325@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with C=2, sparse warns:

  CHECK   arch/x86/events/intel/lbr.c
arch/x86/events/intel/lbr.c:276:1: warning: symbol 'lbr_from_quirk_key' was not declared. Should it be static?

And yes, it can be static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 6f814a27416b..ea54634eabf3 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -273,7 +273,7 @@ static inline bool lbr_from_signext_quirk_needed(void)
 	return !tsx_support && (lbr_desc[lbr_format] & LBR_TSX);
 }
 
-DEFINE_STATIC_KEY_FALSE(lbr_from_quirk_key);
+static DEFINE_STATIC_KEY_FALSE(lbr_from_quirk_key);
 
 /* If quirk is enabled, ensure sign extension is 63 bits: */
 inline u64 lbr_from_signext_quirk_wr(u64 val)

