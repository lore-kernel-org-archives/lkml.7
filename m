Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710FFC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDE02184D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkRScrd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCSX4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:56:37 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54367 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfCSX4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:56:33 -0400
Received: by mail-qt1-f201.google.com with SMTP id b3so589024qtr.21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hcsw4jWN1hMUQas5fk8qH4/pHraV7uLJWBMnp4emY1w=;
        b=kkRScrd31+enlreI5z0oUEdvclr3JCffoxWlBxgdfvsiHG+l1qdm7rpPzTM74AffEB
         LfPQCYRFRkk5MVQ3Sswlo00GL73nAMZLv5CUblp9iwglJ0iHORdkEQbjcmg+RAyhtDSK
         O9SwD0WRSCDe+dqmFFjegvme5136ckLAkDUHKL6mVSMZP0sNbLYuvx8Ezdf706E/KfDY
         9fBeMjXuR3YFS9h86rSzKNERDrjqmseba0FXjHr885Gzr4DFfIZy5quXrHuTBM0lthvA
         9RXHgsNWSfaXr1nwN76MY2akaLAzeMLaPr9LrKq+sgEJNGwUCyr6TQwEqhNFsTdPpUau
         OdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hcsw4jWN1hMUQas5fk8qH4/pHraV7uLJWBMnp4emY1w=;
        b=k9pOBDOHGI2ysdtWx2sPGLGdyFNXJ+GbwDbmq/qjPM4/gimI7280itkPBCNrDyfWzc
         aeyE41qj6oV57YwUt+gC/6p38IWJsrxU2kR32rGNkzPIrYqcqke1DO/sW+juIkAmvHXe
         PTJ/QIf0lynvrr5eYvAQlpg2CoiNMdpSx2hI6NlcvP2IRDgTxWmDb+uLAeNcKQIvf909
         h3ngYhgSqpBoNvVbqZRTPX0A+q2EMD/RepxY99YQen0o1D89NMjjQEkSmtPMRipj/kzK
         YYj+JterK0wmMcL4sJ0c7gb0+lB4POamfhuQuYQsjVCamwPxvbtjYcT5ijvMtXphgTcV
         AVyA==
X-Gm-Message-State: APjAAAXbZEaNN8eDCUkz7ZBUxwQPIxxBLyzZ46Nr0zpOOL09YfGeF+JQ
        5RC+lxxvOUuN22KAVih9wVl3UGhqOaY=
X-Google-Smtp-Source: APXvYqwR1TAk3oGEqI2JtJ8ECEcet2nolarI6UbO1myJOnWcfePT76GDZJa39xicW9tBqtTiou2qy4qktOo=
X-Received: by 2002:ac8:2e7a:: with SMTP id s55mr13937762qta.34.1553039792366;
 Tue, 19 Mar 2019 16:56:32 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:56:14 -0700
In-Reply-To: <20190319235619.260832-1-surenb@google.com>
Message-Id: <20190319235619.260832-3-surenb@google.com>
Mime-Version: 1.0
References: <20190319235619.260832-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v6 2/7] psi: make psi_enable static
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

psi_enable is not used outside of psi.c, make it static.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/sched/psi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 22c1505ad290..281702de9772 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -140,9 +140,9 @@ static int psi_bug __read_mostly;
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
 
 #ifdef CONFIG_PSI_DEFAULT_DISABLED
-bool psi_enable;
+static bool psi_enable;
 #else
-bool psi_enable = true;
+static bool psi_enable = true;
 #endif
 static int __init setup_psi(char *str)
 {
-- 
2.21.0.225.g810b269d1ac-goog

