Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1846CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E549521852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AqlCOzRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfGXSpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:45:21 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53279 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfGXSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:45:19 -0400
Received: by mail-pf1-f202.google.com with SMTP id 191so29106514pfy.20
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=bK/jHJchVPHPYOwMi778tukKzlyA3mqpp5GJOr1wzvk=;
        b=AqlCOzRejDvJtBa3V73BDsWfcruVREk/7GiGhGV4KN1M+qUiNd8ClgtjTQz30/eXsH
         L5xOXl/XawTO4pj0s1v3wWbGxSd3WahyFeb1GxaPL0frjHZdz+ZCIy6r5wHOY4GHdoPP
         /+nJtfQq/kmODVc/hf10FJ4fp3W3VO/1R50GQrLKUF7MhA2Enk9w/AaQR8EJlOSG/RB3
         Yq9sFSMfw0LPEKDl/8icpqjXtdH0BGiK+mwCCTNVuVQkFd/Gs4EWK3HWmQdW+pjUU3u5
         zWTJVdSgY0ZedM/V3Yv7ThAC9eWTPaLcLoy9CWa9dNKx0kGvXh8ADypTotBxiBLky1qh
         sKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bK/jHJchVPHPYOwMi778tukKzlyA3mqpp5GJOr1wzvk=;
        b=qbIN+sj74nuQggcHGEw6RNBe9N5sSPTi9IfMgp/skZviX7jgZ0wBwTg4xFWAcZYgWz
         PhD7imjw0RqtpDplfXgjnjW4Rlol6mr2hSv4TMeRfGae/T+c0SMapLVBVwtqdHoVZZ6w
         9DMeLqHST6vxtKg8XwPBwBw+2ZzEDguitWIzBr+sYfhCphPV334XwaKlKEEPhkIdro9Q
         0vIZkr8ofF6anXsOz41QmrgTKLAM3aljdvd7gC+ANzVlTVO4oPAPreO6t7jY9zRD01z2
         7pWYniJc5PRGSgzO27NTMXoUaQr8PUYm7T6OckTsuhD8HUL2OGf6FEN83YBDvLhMJ3Su
         lt/A==
X-Gm-Message-State: APjAAAVwAf/0u8qEQFg9jPrWEoBlx2FzxbiD3lBj/C2dmFUxmr9xz4lO
        vu3JhJ17ePU2LuhM5srMTL3awfnj
X-Google-Smtp-Source: APXvYqwLixNdPPOEKOE7Ny1b3TRD41W9VF9rnvw6wOesxd06xbtV/R5kw47F2uWNrJYRDKTCX0cFDISs
X-Received: by 2002:a63:1749:: with SMTP id 9mr30154039pgx.0.1563993918702;
 Wed, 24 Jul 2019 11:45:18 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:45:10 -0700
In-Reply-To: <20190724184512.162887-1-nums@google.com>
Message-Id: <20190724184512.162887-2-nums@google.com>
Mime-Version: 1.0
References: <20190724184512.162887-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 1/3] Fix backward-ring-buffer.c format-truncation error
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

tests/backward-ring-buffer.c:23:45: error: =E2=80=98%d=E2=80=99 directive o=
utput
may be truncated writing between 1 and 10 bytes into a region of
size 8 [-Werror=3Dformat-truncation=3D]
   snprintf(proc_name, sizeof(proc_name), "p:%d\n", i);

This can be reproduced by running (from the tip directory):
make -C tools/perf USE_CLANG=3D1 EXTRA_CFLAGS=3D"-fsanitize=3Dundefined"

Th error occurs because they are writing to the 10 byte buffer - the
index 'i' of the for loop and the 2 byte hardcoded string. If somehow 'i'
was greater than 8 bytes (10 - 2), then the snprintf function would
truncate the string. Increasing the size of the buffer fixes the error.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/tests/backward-ring-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/bac=
kward-ring-buffer.c
index 6d598cc071ae..1a9c3becf5ff 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -18,7 +18,7 @@ static void testcase(void)
 	int i;
=20
 	for (i =3D 0; i < NR_ITERS; i++) {
-		char proc_name[10];
+		char proc_name[15];
=20
 		snprintf(proc_name, sizeof(proc_name), "p:%d\n", i);
 		prctl(PR_SET_NAME, proc_name);
--=20
2.22.0.657.g960e92d24f-goog

