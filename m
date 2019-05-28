Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0723BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05952166E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5odcy97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE1Qdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:33:35 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:32971 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfE1Qdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:33:35 -0400
Received: by mail-qk1-f202.google.com with SMTP id t196so7928255qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ekpV16BsEuFUmwpAG23aREMsNr/hn6GV4TCSg0P4aJ0=;
        b=U5odcy97XOoX4/hsqlmVKYuwP4/Dzi2ZmyDZP3yoJZB5LDIwVkMgKbI8ma6mqcul7P
         S7sCOi8GdwJXwsybjd88DJ5N1iuOo4iL7LqMF+ZDDxjkiDXLD5cjzCiUiSc3CPBDC69g
         frw6B8ukJA3Rcr9xLlLqsttQzlwul75Ba2rfCB5z8D9DFTQA3Dr+oouto0vigcT4CulR
         wkWx2/Mc9AmOq9w8fdmBR17dncN4Rahlu6uWnN4rh90BYJGsA1ZF1koQUUsuZAq8LO9E
         o6KQc4A1evKB5IcZK+DnSGrbbfk8+fmiNMjt4HIlMyGfJVEy8IFHPE0Ex/Ho92Nz7/8b
         /0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ekpV16BsEuFUmwpAG23aREMsNr/hn6GV4TCSg0P4aJ0=;
        b=PlSVLOBkR3PC3o8N0krWXiyze0yFcoauyC9YfQvOpKZ+o2p5LiL7xpInHqz6z/1tAq
         dX11dz9m7m0N9LhKTjJdobodCQupPjEepIj8tUKqYAEliQOHa28ZuO7GZ1Nl7E3HU01E
         EVgjuYU2lM+ace1ClPPuCum4iu5QlXxcdqY6pgeYI7teSKrB/B1woLmIem7dUtdwwZgG
         Lvwr3Nhp5czZaxMW6T5PGVbPKK9ty2L21xxbxR7k9r1dnCpHTvUpoAVzKAWFf256PqkP
         VMtFqiLmgHjBHszWsx1rVTFteQvzMicVc5xxBNM+YIw8YANJ9JYEIJ+MIVWm+e0uKIxr
         mQjQ==
X-Gm-Message-State: APjAAAVLbp81kCWjCe+2ct6k+TqcywC9j546jwwV/MGkNb4wVsN/d3pe
        ANL8i8/5xPpbl/+KRidN9t9JA9vCew==
X-Google-Smtp-Source: APXvYqz2pdkms74LUkgOHBXXnCSTIO447N3UMEsALJsohwzxqupbdIBQTZSArOjvC/iRjbLMRMYd1FeaAQ==
X-Received: by 2002:a37:ad12:: with SMTP id f18mr5399903qkm.3.1559061214532;
 Tue, 28 May 2019 09:33:34 -0700 (PDT)
Date:   Tue, 28 May 2019 18:32:57 +0200
In-Reply-To: <20190528163258.260144-1-elver@google.com>
Message-Id: <20190528163258.260144-2-elver@google.com>
Mime-Version: 1.0
References: <20190528163258.260144-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH 2/3] tools/objtool: add kasan_check_* to uaccess whitelist
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a pre-requisite for enabling bitops instrumentation. Some bitops
may safely be used with instrumentation in uaccess regions.

For example, on x86, `test_bit` is used to test a CPU-feature in a
uaccess region:   arch/x86/ia32/ia32_signal.c:361

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..eff0e5209402 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -443,6 +443,8 @@ static void add_ignores(struct objtool_file *file)
 static const char *uaccess_safe_builtin[] = {
 	/* KASAN */
 	"kasan_report",
+	"kasan_check_read",
+	"kasan_check_write",
 	"check_memory_region",
 	/* KASAN out-of-line */
 	"__asan_loadN_noabort",
-- 
2.22.0.rc1.257.g3120a18244-goog

