Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EB82173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3VCDyNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfGXSpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:45:25 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52066 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfGXSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:45:22 -0400
Received: by mail-vs1-f74.google.com with SMTP id b7so12715547vsr.18
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=BjWNWCDen5V1rKWn+IHS9XDd/FHSwkWnF0k7e0VBT3Y=;
        b=L3VCDyNh6Wyj2VLaIJBKXSI/rngNMWnuv4xkxRlSK+6K/OhCbI+VGsbNycNwB7Pls7
         QviD0x5CvHDVD1T1CONj4E9EbqBKjI6/lTBptdTGhLsqTKxJW8gWc8iLKCrFALVqsHiI
         LA3OEt21TnGOyewXtTeZDtbXEktYsO5aak6sErMlARNCczzH3QElLWKjhdCE/ChmmnIf
         lmCkY8JElyCdBel9Tutcc4uQy7gOo1tBbQ7PutM7OFxJ+K8//2OXRUYW1Xx1zEwb4/7H
         zCwzZsS5NySC46A4j+t1SdzltawktcT0bQFjLKZor5U1+YOPA5CUr+desdcvL81GEn91
         MrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=BjWNWCDen5V1rKWn+IHS9XDd/FHSwkWnF0k7e0VBT3Y=;
        b=adv3K7lWXS+4TPDtggCiKMFDTQr47Gbmhc1F0iacdj0AJBEUSEAgrxYaqOYSQhug7n
         CAwFGvY6iHVyRxNUEoR7TPsPm3sZk0R8UlA30ibo5jAwGRvsEBSIeloZyBkiTS06eyvk
         liNPas+182zABzLxwXe25pFSdxLe10lRmNuO53zuaoVpgq7R/QBkORKQNcC/DeVT9Ush
         GCQxbu2F8h/rsMby4ZKUBvPBCUt6UBn8kn3cK0VmvnGKDWvTw1H2wAXJdIjjrTPe+jH3
         SI+1TkBn44th843m71PqgkHK4l+ImI8mXD8JbF4QSfVz/NxRN3LlcKj6Kyq/8bXJQXNc
         C6Eg==
X-Gm-Message-State: APjAAAWJ1SoWSY5tLwa70JGunMSUVdhl/7OS6fiwJQQriWLIZST3tJ0b
        BngSpPImXqk8xmaQnl+RUVmpJxQb
X-Google-Smtp-Source: APXvYqwMeSWHYpwf4jtheM7WrYWVnwJGl3IyxA2eT7GgXjUcjxoG+6PP9OPz5+/8Ua0m+keyX0Zg1Vv9
X-Received: by 2002:a67:6bc1:: with SMTP id g184mr3704438vsc.70.1563993921248;
 Wed, 24 Jul 2019 11:45:21 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:45:11 -0700
In-Reply-To: <20190724184512.162887-1-nums@google.com>
Message-Id: <20190724184512.162887-3-nums@google.com>
Mime-Version: 1.0
References: <20190724184512.162887-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 2/3] Fix ordered-events.c array-bounds error
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf does not build with the ubsan (undefined behavior sanitizer)
and there is an error that says:

tools/perf/util/debug.h:38:2:
 error: array subscript is above array bounds [-Werror=3Darray-bounds]
  eprintf_time(n, var, t, fmt, ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/perf/util/debug.h:40:34:
 note: in expansion of macro =E2=80=98pr_time_N=E2=80=99
 #define pr_oe_time(t, fmt, ...)  pr_time_N(1, debug_ordered_events,
 t, pr_fmt(fmt), ##__VA_ARGS__)

util/ordered-events.c:329:2: note: in expansion of macro =E2=80=98pr_oe_tim=
e=E2=80=99
  pr_oe_time(oe->next_flush, "next_flush - ordered_events__flush
  POST %s, nr_events %u\n",

This can be reproduced by running (from the tip directory):
make -C tools/perf USE_CLANG=3D1 EXTRA_CFLAGS=3D"-fsanitize=3Dundefined"

The error stems from the 'str' array in the __ordered_events__flush
function in tools/perf/util/ordered-events.c. On line 319 of this
file, they use values of the variable 'how' (which has the type enum
oeflush - defined in ordered-events.h) as indices for the 'str' array.
Since 'how' has 5 values and the 'str' array only has 3, when the 4th
and 5th values of 'how' (OE_FLUSH__TOP and OE_FLUSH__TIME) are used as
indices, this will go out of the bounds of the 'str' array.
Adding the matching strings from the enum values into the 'str' array
fixes this.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/util/ordered-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-eve=
nts.c
index 897589507d97..c092b0c39d2b 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -270,6 +270,8 @@ static int __ordered_events__flush(struct ordered_event=
s *oe, enum oe_flush how,
 		"FINAL",
 		"ROUND",
 		"HALF ",
+		"TOP",
+		"TIME",
 	};
 	int err;
 	bool show_progress =3D false;
--=20
2.22.0.657.g960e92d24f-goog

