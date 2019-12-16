Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EABC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0D124673
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGU/TMzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfLPWG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:06:59 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:37019 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfLPWGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:06:55 -0500
Received: by mail-pj1-f74.google.com with SMTP id a31so5279493pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YrbllExGb6NsWygYEF2barQHzhEld5JNWw7UJUUR3A8=;
        b=bGU/TMzHT8t1jHkPRMHorm6ZH+kS5NyIJFKxyLm+Jkb2Pge5M7rd+zZgm2+XK7IggH
         58+fAHsLstoRBKR4oSp0awoxKcmZn/vdwak7Ok6hW/9zQp6qjTGTCjvSYQM4QWyPYFXU
         bZLt/DOJBPHWPkNBHlfbB17DP8F1Yi138OSSXfwuqRMnlbFDqGiKO4aiFX16zURzXZjm
         y2QdB3uD5FFiZra6BzFKDqLLdSu7s0YZlLGs48ZPu1EBHyVhiWQlbtBIWUT5ZpBNetkL
         8p0derp2Urlgej5DMKZQwSV7gXlDYUJvoMtyGKZo7sLadNMXYzCVWfNvyQ+QRF6yoA+P
         MtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YrbllExGb6NsWygYEF2barQHzhEld5JNWw7UJUUR3A8=;
        b=TfMld/wPCjL2dKbwdEVweFYEnzct1PmEk2Kdop7Jqi+1h/Fozc+s1cYKs4md5ZX9SP
         Klo8rxuiQ0fojMxbDFxPb/9Wy3ATapuy+j1osYBhng3T55YYvA8r7TYkXNDushSb+mQI
         /FacbEVvorE7IE51ZJ3JT2sr57FBP5m6YyrfpMun6GH8A5L4Ft8K7Lz5xUmX5MZooWp9
         Gx/RUGQesATen0z/IaOlGDxCUOBZ7u7MFW/CLLfb6fJGRjZOcDJ6xY39hk5Cc3x9Cirl
         1SP9/G5oDSdFlpfJpw3WLbKODG7ZxSMbkz7V8lxruOGx3BNw5JUrW8eJz2eFdPhAtnVI
         kXIQ==
X-Gm-Message-State: APjAAAWVam5ysvOZw6y+JEgPTQPO9/XoqsODG/U8dRKVd0WH1W8q6d9H
        o4t7gMpNMlPXLloC3Xo0WwwLpPkJQDYicn4Fe2+rtw==
X-Google-Smtp-Source: APXvYqxrelSmb8kJZfwAxsqH/X93e7hDs660BOk608W2qWxwl/pKbx/L56EOVl3cXeaGEHwoy1HG/gK9hYm+dvGXKNnr0A==
X-Received: by 2002:a63:d249:: with SMTP id t9mr21497292pgi.263.1576534014906;
 Mon, 16 Dec 2019 14:06:54 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:51 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 2/6] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 7145ce6999822..eab9ceb450efd 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.24.1.735.g03f4e72817-goog

