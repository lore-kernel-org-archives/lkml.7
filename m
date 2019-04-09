Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E0EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FADD20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="G82ZdSPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfDIV0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41293 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfDIVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:25:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id u2so118320eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KN4q20HRUQBAdf+paD/ffQpCN5tvmQdqpoiavL9WR4=;
        b=G82ZdSPq0Rot6o3lKKasjZMa+n0D3x81mT0LEpd08rBCmJP5aCIS+t6gyjf4dd3qt9
         B61dGodhXZoGr+r58ljQgYP4AINfcPMu5yZRE93NnYY9SHMFwxRWQShueEqf/morqNKF
         5S1vcS5JaYoNIPAUPVS3E6sQ/HVhFWvXjXIhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KN4q20HRUQBAdf+paD/ffQpCN5tvmQdqpoiavL9WR4=;
        b=swSBL1Eo8nYhDIGDAk3qqAHvh7WKGT/fv/wlHp1be+YIBXR94IR3sgWQzkjW6IL/Uw
         HWZ0IeXt7W6WvQp35Hyp2Aqi3JYahl4VpeXO2LPwQS8HU4XtP+A/VToHkkgdmhk4Yk7k
         qljF7hvKNQRqUyq91s+W0d9JboHHQh3iLyWDEiXRAOpQFuDjyY9D2nUqfDC3Xgmt017y
         OJFuuiAa8UVBtOF/4YuKfBrk9Z0xrln+686w4m/gTkWH2HOhWududCP7xld/YGsQ7Csx
         E0aXkVIXhEXq5KQXr7ZUPyMAxUGPmlOdS9kL4vz6Zc+a1HISI1SUqEk1KZ/70fOWtBj+
         hDGA==
X-Gm-Message-State: APjAAAW47Zsjqv682eRzbpVE/Jqqn6v2h095Jqs7zNKhooZKActSAm/u
        OvuGBv5onRiGZikEeUA+03BvHA==
X-Google-Smtp-Source: APXvYqzyJejyNdbpvNpdxhygYigUxm7wvBSO92k5fpaDlrWSpS9pBpnqu+zwmpfKptcJDbe7RdfqIw==
X-Received: by 2002:a50:a4db:: with SMTP id x27mr24655365edb.120.1554845153314;
        Tue, 09 Apr 2019 14:25:53 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:52 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH 02/10] linux/net.h: use unique identifier for each struct _ddebug
Date:   Tue,  9 Apr 2019 23:25:09 +0200
Message-Id: <20190409212517.7321-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for net_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Cc: netdev@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index c606c72311d0..828e0db1e63a 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -266,7 +266,7 @@ do {								\
 #define net_info_ratelimited(fmt, ...)				\
 	net_ratelimited_function(pr_info, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
-#define net_dbg_ratelimited(fmt, ...)					\
+#define _net_dbg_ratelimited(descriptor, fmt, ...)			\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
 	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
@@ -274,6 +274,8 @@ do {									\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
 		                   ##__VA_ARGS__);			\
 } while (0)
+#define net_dbg_ratelimited(fmt, ...)					\
+	_net_dbg_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define net_dbg_ratelimited(fmt, ...)				\
 	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)
-- 
2.20.1

