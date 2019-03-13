Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AEDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0310F206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+FoqXqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfCMUYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:24:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33440 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfCMUYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:24:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so3468864wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTScBOdTsxFi9IV1z8i5dHwn22wCLDi4xhj5TO6bFt4=;
        b=L+FoqXqjuMTIGtPakrePMuOlMatJZZr5kD0fGrUSUBF0IxSNmO70uAEWf7l/hmT/iR
         XreW4scMoUu/vBm00sQ4jNhTvIfMtVSTFMjMkr/ABikExHqS/tY/PjWAndx25E9ej0Ck
         AfyQsP52Bz4yVg5W9heU1oaAH3CpxOUXBSIGHYQGpgYR0xVFmPcKN8q7uDvvBrObQhp+
         vJDt0E+V8+gvOZKTkjNU+vpQIZ8Fgv+8sZZpnUJaNoCpO1I3WwXoCs70FucVaqwllqy7
         j4aaqWgAcdtRif9S28k1fXy8vZk6p0bFDZME6wBZcKHIromUAgW7QbFa58T+TEp5k/pJ
         IAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jTScBOdTsxFi9IV1z8i5dHwn22wCLDi4xhj5TO6bFt4=;
        b=silbBDA2qmKOW/0wmjjwTWYiLaqUTjgfV6oAevigqBcKoN8bKcKNZdoE+ZZi9xWcxe
         4y1n2Y5zt6IBFOgWrw8z44u8BEa/Mq7M6tnnqpRWvF5MuagNBU2nHQ59sWNYVFmyun+l
         6THgj/qyBJxJEU4cuvtn6Dwtc3Zoek/6bISUzAszLN3qxaPICAi3kzntw8J5fslc8W4C
         cjXpzLFWeYyo71Ggs0/KDOxCzkMBRUihFkGnQ9ph4iwSdkoDsNIwba7Qv/SV7CIajogQ
         hxMc9d9O6tLPbZfgQZmxtHwbWwhSLcPf3z+ruCC10d1/dHYxIoVPfvn5u8e8HrCUXfar
         vvnw==
X-Gm-Message-State: APjAAAUJwQ2Q805wpy16FRyyaj6AqXrH3CAa9w92Fu787XDzT+bNfPs/
        gyhtdVKPaJQdqqQvjV6Wj7o=
X-Google-Smtp-Source: APXvYqxZpl3GX0IYjhBsHwLKZQorMbDKiBlyYBFz/fnc+LSJugIiU+neOVcwVnE+F8+1WkVXQ/Z/pg==
X-Received: by 2002:a5d:500e:: with SMTP id e14mr27993658wrt.219.1552508683877;
        Wed, 13 Mar 2019 13:24:43 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id y140sm32787wmd.18.2019.03.13.13.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 13:24:43 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 7072E1140A07; Wed, 13 Mar 2019 21:24:41 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] lib/siphash.c: annotate implicit fall throughs
Date:   Wed, 13 Mar 2019 21:24:29 +0100
Message-Id: <20190313202429.20797-1-malat@debian.org>
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

Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: some cases were missed in v1, update missing ones

 lib/siphash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/siphash.c b/lib/siphash.c
index 3ae58b4edad6..f4f778d28660 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -69,10 +69,14 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
 #else
 	switch (left) {
 	case 7: b |= ((u64)end[6]) << 48;
+		/* fall through */
 	case 6: b |= ((u64)end[5]) << 40;
+		/* fall through */
 	case 5: b |= ((u64)end[4]) << 32;
+		/* fall through */
 	case 4: b |= le32_to_cpup(data); break;
 	case 3: b |= ((u64)end[2]) << 16;
+		/* fall through */
 	case 2: b |= le16_to_cpup(data); break;
 	case 1: b |= end[0];
 	}
@@ -102,10 +106,14 @@ u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
 #else
 	switch (left) {
 	case 7: b |= ((u64)end[6]) << 48;
+		/* fall through */
 	case 6: b |= ((u64)end[5]) << 40;
+		/* fall through */
 	case 5: b |= ((u64)end[4]) << 32;
+		/* fall through */
 	case 4: b |= get_unaligned_le32(end); break;
 	case 3: b |= ((u64)end[2]) << 16;
+		/* fall through */
 	case 2: b |= get_unaligned_le16(end); break;
 	case 1: b |= end[0];
 	}
@@ -432,6 +440,7 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 	}
 	switch (left) {
 	case 3: b |= ((u32)end[2]) << 16;
+		/* fall through */
 	case 2: b |= le16_to_cpup(data); break;
 	case 1: b |= end[0];
 	}
@@ -455,6 +464,7 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
 	}
 	switch (left) {
 	case 3: b |= ((u32)end[2]) << 16;
+		/* fall through */
 	case 2: b |= get_unaligned_le16(end); break;
 	case 1: b |= end[0];
 	}
-- 
2.20.1

