Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA2C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B8821479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="f3sofSU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403804AbfGHQcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:32:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54387 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389421AbfGHQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:31:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so145994wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2q/9DY/eMlLakYA2goJPIRtdbZUH+0KxlPnLmYNTOY=;
        b=f3sofSU/bXru9qax++aOgBk+uAlSYw6diTvQz4Zb6xU+ePOE1k+PF6XybmrF8zA8Lm
         cxUhOmVfIKOmnI0trsImIeXpuUUW+sKjTOhPWo3MCCGcHCf+iQIseb8AfeR7KKbyPnKH
         4z9UWgWFHpp2PrqssJUgvo0yyedi5hHUcIboQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2q/9DY/eMlLakYA2goJPIRtdbZUH+0KxlPnLmYNTOY=;
        b=KWA1ayTb905HzzxTGrfJo4hohC//uMc5uVvCOxzfHLNZ4o4zP1YqKAtwGCAXxJT1PQ
         KEkkXo5vc+VEa+BL7oaMvbI/RVdmbIDyNLiGnKKxTd2rOQ4qoc6pUsQhHqYkIPqwlJ4E
         vxAbAXAh7d6MjyV4f4aAFA/+YoqbPNVIYGNzaYZfXd2ssfb092h+Ikr1UJpMyCNYcC6r
         GwBYbX4yopuYyh/mC1ib+6sKqXmwFQP2BLJV83ilhzcGUeA7upOJ2MP/iMH021kdbl+1
         KeFSZPWYNRgOqEDUP4AryS+H+q4ACallxwq9Uc9Od5V2nFEQN5LZG5uNarxB6l6V7WoJ
         sX4A==
X-Gm-Message-State: APjAAAWePJOmEMOa16JR83EBvoK98+qfH2xyvYNwZWbVwGmykgiup7n9
        boorWymwrQQhlmDo8z1xgfwYYYVykd146g==
X-Google-Smtp-Source: APXvYqwgF4eK6PEywYbJMZghzfU39cx60C67Re6v5ey3Aa4/20vDkjnYdTfyPjo4Ljm9od9zONwd/g==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr17401953wmj.152.1562603514984;
        Mon, 08 Jul 2019 09:31:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedbe.dynamic.kabel-deutschland.de. [95.90.237.190])
        by smtp.gmail.com with ESMTPSA id e6sm18255086wrw.23.2019.07.08.09.31.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:31:54 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v3 07/12] tools headers: Adopt compiletime_assert from kernel sources
Date:   Mon,  8 Jul 2019 18:31:16 +0200
Message-Id: <20190708163121.18477-8-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708163121.18477-1-krzesimir@kinvolk.io>
References: <20190708163121.18477-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will come in handy to verify that the hardcoded size of the
context data in bpf_test struct is high enough to hold some struct.

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/include/linux/compiler.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 1827c2f973f9..b4e97751000a 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -172,4 +172,32 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 # define __fallthrough
 #endif
 
+
+#ifdef __OPTIMIZE__
+# define __compiletime_assert(condition, msg, prefix, suffix)		\
+	do {								\
+		extern void prefix ## suffix(void) __compiletime_error(msg); \
+		if (!(condition))					\
+			prefix ## suffix();				\
+	} while (0)
+#else
+# define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
+#endif
+
+#define _compiletime_assert(condition, msg, prefix, suffix) \
+	__compiletime_assert(condition, msg, prefix, suffix)
+
+/**
+ * compiletime_assert - break build and emit msg if condition is false
+ * @condition: a compile-time constant condition to check
+ * @msg:       a message to emit if condition is false
+ *
+ * In tradition of POSIX assert, this macro will break the build if the
+ * supplied condition is *false*, emitting the supplied error message if the
+ * compiler has support to do so.
+ */
+#define compiletime_assert(condition, msg) \
+	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
+
+
 #endif /* _TOOLS_LINUX_COMPILER_H */
-- 
2.20.1

