Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA41B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUzJQhsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCMVMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:12:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42943 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:12:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id o9so3555529wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3yDHN758qs9niJt5sETfy4WdqiHkxw2spT/deZ7Yxs8=;
        b=RUzJQhsyGtzldGyQX5GF4WO3g3Jrx/WLKpLjI6U4NoUbmrp02tiuPMTSXbiC2zr4km
         EOuGLNORWRVhU4aJ8XNounjkkdXXLasE+Tvr9+tr3M2brmGCeOue9E2ZWjLnwuh2DFc/
         v+OwsWkUg2pbsnsrcIYDCvVhRoczmeX/WmzYc09d5gzBlWh6JSoZsROLC3PooB448wYT
         cd8g+wup5wygTvrqTHDl4iAYdF65R1jGZmmtEiGhfp0zn/HEPuPC5SxGxm7GS/6gXol8
         DBoe4lopyC7Ae25MWOTvp8zt5GXBLBwPixsF4ptjv88hhWm2VoBwGWyVsgwJ9oOXiL2/
         uv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3yDHN758qs9niJt5sETfy4WdqiHkxw2spT/deZ7Yxs8=;
        b=FKokb5kE/uEUeXMa35Osgf0516uFuS0MgcFY8n5iDnyC4FPbQLsKFR1S5pRNV4fAt/
         3Mci9zg5nqR9tFgTbBY3iJBt1FuY2I1YqzO7ONy1TnYJkvfdEf6/l+YPTDrGheq+U88L
         p7CCLMsHL8WiQbs4CSdH+754UzYASY4wUOcX39RBgscDWuVSj7ZkHCqYG0hxVA+MhaCh
         uCVe0ABX21f2ICiS6T1JqG8EsYHfzBIEkW2HzAo525HUuUSOa1UcQrRemsQuEMYuV1no
         piKkrsU/3J4LPppBM2PqXsyuHUXMibsCoZx244CXV4QZ6D4232lP4/rUcwTXIXJnYXau
         Wzmg==
X-Gm-Message-State: APjAAAWWvkKLx5PjMR+4/X+QI5Vm4GUKV4UOV+Ot1213iRGWq3TeUIrz
        R/tvZGOgyvSBsZqSLB+Pcyg=
X-Google-Smtp-Source: APXvYqxFrOHLfy0UQEMOi80Lqwu3jNEaEgNkw9M/fgnXZgaUkpj2/D5zrR3FYzu7CNTSTQp6gn27uQ==
X-Received: by 2002:a5d:6a0c:: with SMTP id m12mr10652660wru.57.1552511572357;
        Wed, 13 Mar 2019 14:12:52 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id f68sm217960wmg.5.2019.03.13.14.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 14:12:51 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 041631140A07; Wed, 13 Mar 2019 22:12:49 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] lib/siphash.c: annotate implicit fall throughs
Date:   Wed, 13 Mar 2019 22:12:30 +0100
Message-Id: <20190313211230.17527-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114201911.13725-1-malat@debian.org>
References: <20190114201911.13725-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  lib/siphash.c:71:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:72:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:73:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:75:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:108:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:109:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:110:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:112:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:434:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:462:12: warning: this statement may fall through [-Wimplicit-fallthrough=]

Move the break statement onto the next line to match the fall-through
comment pattern. Also move the trailing statement onto the next line to
pass checkpatch verification.

Acked-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: move break statements onto next line and please checkpatch
v2: some cases were missed in v1, update missing ones

 lib/siphash.c | 76 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/lib/siphash.c b/lib/siphash.c
index 3ae58b4edad6..f459e0f4a14e 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -68,13 +68,26 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |= ((u64)end[6]) << 48;
-	case 6: b |= ((u64)end[5]) << 40;
-	case 5: b |= ((u64)end[4]) << 32;
-	case 4: b |= le32_to_cpup(data); break;
-	case 3: b |= ((u64)end[2]) << 16;
-	case 2: b |= le16_to_cpup(data); break;
-	case 1: b |= end[0];
+	case 7:
+		b |= ((u64)end[6]) << 48;
+		/* fall through */
+	case 6:
+		b |= ((u64)end[5]) << 40;
+		/* fall through */
+	case 5:
+		b |= ((u64)end[4]) << 32;
+		/* fall through */
+	case 4:
+		b |= le32_to_cpup(data);
+		break;
+	case 3:
+		b |= ((u64)end[2]) << 16;
+		/* fall through */
+	case 2:
+		b |= le16_to_cpup(data);
+		break;
+	case 1:
+		b |= end[0];
 	}
 #endif
 	POSTAMBLE
@@ -101,13 +114,26 @@ u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |= ((u64)end[6]) << 48;
-	case 6: b |= ((u64)end[5]) << 40;
-	case 5: b |= ((u64)end[4]) << 32;
-	case 4: b |= get_unaligned_le32(end); break;
-	case 3: b |= ((u64)end[2]) << 16;
-	case 2: b |= get_unaligned_le16(end); break;
-	case 1: b |= end[0];
+	case 7:
+		b |= ((u64)end[6]) << 48;
+		/* fall through */
+	case 6:
+		b |= ((u64)end[5]) << 40;
+		/* fall through */
+	case 5:
+		b |= ((u64)end[4]) << 32;
+		/* fall through */
+	case 4:
+		b |= get_unaligned_le32(end);
+		break;
+	case 3:
+		b |= ((u64)end[2]) << 16;
+		/* fall through */
+	case 2:
+		b |= get_unaligned_le16(end);
+		break;
+	case 1:
+		b |= end[0];
 	}
 #endif
 	POSTAMBLE
@@ -431,9 +457,14 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 		v0 ^= m;
 	}
 	switch (left) {
-	case 3: b |= ((u32)end[2]) << 16;
-	case 2: b |= le16_to_cpup(data); break;
-	case 1: b |= end[0];
+	case 3:
+		b |= ((u32)end[2]) << 16;
+		/* fall through */
+	case 2:
+		b |= le16_to_cpup(data);
+		break;
+	case 1:
+		b |= end[0];
 	}
 	HPOSTAMBLE
 }
@@ -454,9 +485,14 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
 		v0 ^= m;
 	}
 	switch (left) {
-	case 3: b |= ((u32)end[2]) << 16;
-	case 2: b |= get_unaligned_le16(end); break;
-	case 1: b |= end[0];
+	case 3:
+		b |= ((u32)end[2]) << 16;
+		/* fall through */
+	case 2:
+		b |= get_unaligned_le16(end);
+		break;
+	case 1:
+		b |= end[0];
 	}
 	HPOSTAMBLE
 }
-- 
2.20.1

