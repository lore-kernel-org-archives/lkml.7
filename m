Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86160C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5784821773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk6PIHAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfEWQUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:20:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38735 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbfEWQUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:20:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so10049368edl.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H30dHdsxBPBoa8JLcL+g+keeJW2Oufbx6fLEMF7l9Mc=;
        b=Uk6PIHAfcIBagXE3yQ+ZMAoIf7u/SwCgbE03WL5jxy3da5wnXxgvWADrv+ExRoIbyX
         JLGuGoKMS5x6s3a3LwWnEHneHUNXEmD1I9eeC5IILLqSHIPdH03C73xYSgf9H++xe5tQ
         C9OjbIHFtFzfFeICwpTjwpwbnaeq3q0S2nC+fxOpJNVHnHbnpyRE+eLzLRBmOl/7Ckq/
         8O4+hIDG5rYXHDB8DDfFrbiy5dlLSjXxwAMy4UnrVn8H8NymOzEZstkD5Mtl9qVzDEh4
         ad30NWk40ncirgQKXsU/aBUczKEvVFM25KizoTbi/OlZcXqFkP1On4FnCetY9Et+q1E7
         eANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H30dHdsxBPBoa8JLcL+g+keeJW2Oufbx6fLEMF7l9Mc=;
        b=O8ciGxNdGy2auYsuIhU3vLsNWzsxcloedpOg0GW5EJG6hxNsz/WueHOwTaApbGWZN4
         SI+6xQ1CFAu1Fi4QcaDGpYrHLX89Q8Lsg7UY6hbrLFpCVZOFMYn9yIvrHuACNtgFTQQu
         rdol6D8gZrkJZ7AzI1ej4fkOjt8Wnhei8dCL5J9aGPlMVmlaZXxp0JN3ApBJAS3zpy/+
         jWbLL/1LYRu7KZaQ1w64r6r0CiQegmdR5z/fR4uB7wPOZpNIwksh4iHiZ2KyruXzNFfb
         ibVJaL5tiRwmCr0ebZZUxZduqyUrHi9RX8+zJThaGGFxQhaQeExZS7A4c4ouXwZGFxu2
         xkNQ==
X-Gm-Message-State: APjAAAU0kS8155ma2LruVY54psYNZDhMtFwfazp+xIkVnmlh93rBcnYE
        MXIwIcw8VGmjtlN5047XFww=
X-Google-Smtp-Source: APXvYqy0Zfb98N8uGjBV+UaBsA5VMLP/7LBWT1yjLQ/+5QFV4N7YycSNd+gvpMDSsKnj2WBzOlUJnA==
X-Received: by 2002:a50:94ed:: with SMTP id t42mr99222736eda.288.1558628420022;
        Thu, 23 May 2019 09:20:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id x40sm8018971edx.52.2019.05.23.09.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 09:20:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Hines <srhines@google.com>
Subject: [PATCH] misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa
Date:   Thu, 23 May 2019 09:15:33 -0700
Message-Id: <20190523161532.122421-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
In-Reply-To: <CAAzmS69VFrTPzZ8DY_NPPTZYtBssocRnQOFAyo3VbSTO4CesbA@mail.gmail.com>
References: <CAAzmS69VFrTPzZ8DY_NPPTZYtBssocRnQOFAyo3VbSTO4CesbA@mail.gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is
uninitialized when used within its own initialization [-Wuninitialized]
        void *buf = buf;
              ~~~   ^~~
1 warning generated.

Initialize it to NULL, which is more deterministic.

Fixes: 279290294662 ("[IA64-SGI] cleanup the way XPC locates the reserved page")
Link: https://github.com/ClangBuiltLinux/linux/issues/466
Suggested-by: Stephen Hines <srhines@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Thanks Steve for the suggestion, don't know why that never crossed my
mind...

I tried to follow buf all the way down in get_partition_rsvd_page to see
if there would be any dereferences and I didn't see any but I could
have easily missed something.

 drivers/misc/sgi-xp/xpc_partition.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index 3eba1c420cc0..782ce95d3f17 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -70,7 +70,7 @@ xpc_get_rsvd_page_pa(int nasid)
 	unsigned long rp_pa = nasid;	/* seed with nasid */
 	size_t len = 0;
 	size_t buf_len = 0;
-	void *buf = buf;
+	void *buf = NULL;
 	void *buf_base = NULL;
 	enum xp_retval (*get_partition_rsvd_page_pa)
 		(void *, u64 *, unsigned long *, size_t *) =
-- 
2.22.0.rc1

