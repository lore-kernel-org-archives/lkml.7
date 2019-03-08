Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66393C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1A120857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ddj5LQyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfCHSnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:43:32 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37584 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfCHSn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:43:26 -0500
Received: by mail-pf1-f201.google.com with SMTP id m10so23033229pfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bO9Ut6bvYRKsfb9hG438t2Q8GfNMLAbUhphxvMlnr+Y=;
        b=Ddj5LQyjlIjwrHP5ehK+oJ/v9fKavvSearbFSnK49AD0M0Ijda7ZsanGy74D80pufg
         Lgkcv8juSAkThYZJjtNfyaTS7N2zDclYu45eWjgibFFwaNK8ylyh0oB7kmipClxsLsWG
         cxV5JRBPuMfAr5RQ52u+RYzzNTQvS3pNMIth63F6imHd2Ft3RZ8Yp5NVHeLn/kPYvo0M
         fkk9E5iqllL6RJSI9Lsi+bUnPFigtvVlPOKMb7S0PbnrLOFx3egU9xt6UxWQIFUF+QJc
         InrzrowbvnHoW34yZXO0BbCSWS+Yn2NAKH9O/c9a5tz3tcc/HyTAjgeMNowOQwuAJCBJ
         tlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bO9Ut6bvYRKsfb9hG438t2Q8GfNMLAbUhphxvMlnr+Y=;
        b=pIUA+5y0g1yZ6zgt3Ar5qWObM4GLeCDQUmlz8gS9ZIgjQUIDQraxdRuz3NfS/WC/Qe
         C2TSVXwu5rPZawjiobgvbdCMs4/WdodgLfyKxUqydnwfOBkSaH1Uto2QOaeFVO5B/s//
         Bfd143uI8EPlHNHZVnLBp+GGiR824aAvBkoeP0+scQ+frnhw9L2Wq5/WMb2Uoot3My71
         2Ld+KaKqmFYhy0LnDjbjO6Z7ux1z3G2DwlihyWE9tC4SIGnOeCTHSGJ4PnGLgZHaLevU
         vgKvQUEcOil8ImyEp7GGw5E4w5vTmZDuXOK9hF2SQ3gBsCJqk0nCEfaD2NlCgQ0ZW36t
         6Egg==
X-Gm-Message-State: APjAAAWIa8Kl9qCIaNVwuPgTNR5J4205rkdzQNGmn0pzdfedFTHTS9V3
        fx6GhVMt/XjhxY7GzJ9fukTjSiAq9Ys=
X-Google-Smtp-Source: APXvYqw2C6wbweqasiF1cbPEq10gvpXR3nbBbTemia3F7+b5xQQZgTibnmAJlyRQEfHaibrTPeQ7I25CGVU=
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr6269298plo.54.1552070605443;
 Fri, 08 Mar 2019 10:43:25 -0800 (PST)
Date:   Fri,  8 Mar 2019 10:43:06 -0800
In-Reply-To: <20190308184311.144521-1-surenb@google.com>
Message-Id: <20190308184311.144521-3-surenb@google.com>
Mime-Version: 1.0
References: <20190308184311.144521-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v5 2/7] psi: make psi_enable static
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
2.21.0.360.g471c308f928-goog

