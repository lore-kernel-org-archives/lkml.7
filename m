Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A62C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56562176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TokXY0h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfLPWGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:06:55 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:57118 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfLPWGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:06:53 -0500
Received: by mail-pj1-f74.google.com with SMTP id y7so357831pjl.23
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5GF2pWf6msGQN8etrt2iWOqdBHUuLXbl9k/FxNh5v+M=;
        b=TokXY0h0FaJqcvxseVpsJGN6ZtDjjoNbdzkLrp/FhUz5OP6IXO8ZCrIXDI+PY0fTd1
         oZhnN2G3IY35fYa0Vd6aKWkkKfpE0XctXn1bZnDNJ3CzEvoBqo+SatsbITCDLDy8ykR6
         fxtkiFTfU3rvec9vRRvpWD2YlOMxO6UMc5CK40/eVLYp3ezoi3Fvp6jASFpqrssHDfhQ
         JoNpxsQO2k472r0XC/Os5dmDPkCAIztjTmIo7eM+W0jioX/6cYwGsOxuL6giyAoe9ug1
         ox0hj9kulfl2piPDZK2eDsvD1R89K1OSaRpkkhQR4te1nq2plCbTPDiiJniBhzGPKAph
         Q0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5GF2pWf6msGQN8etrt2iWOqdBHUuLXbl9k/FxNh5v+M=;
        b=hpXjMyxCnzRv0doBY6n6pSnsFLP9iNqD0Cpn0q4qD7Hf5CknwqqJrjjL3AS4A0UDcy
         +GbXX7njXtLItYvJ6np1wsGCWumni5XZdjQz+NywvZIkT2v1izlM21ciMUXo13SpoRPe
         kB42tPUiY1bMUl8hPQ5xYv/0t/oxbn0uNWh6D9EhtEjr7vI1hR4GkQcmm16j/LPqsPvs
         q52POo1wYFQKqrrMj9oli8AhVyuD0Ai6mZtwTYk9UNv6qi2yqmu+UidD3LU0GNDdR/WN
         D3sEalsg/MAPvAP7weouLSLd3RvlyBFeC1288hzYcUYf7ERs400B0qx7V5hMtO92rRPk
         b7Wg==
X-Gm-Message-State: APjAAAU8Es3uIWnY0KBcotPXV7YlnmvKTU7wogGQtmpewXkCZnZjU9l9
        7FYxQ6ku8RXJlcMqP9ASAQPWKge0D5/Y2xgLdvpHRg==
X-Google-Smtp-Source: APXvYqz7Zh96kKZmFQEhLR+5+8b03CjI/b3463pKKBrTBSZrKUfy+3thDSrMp+0LJ99EepEYrJc7YHRMsYbtyIxAiEtJhA==
X-Received: by 2002:a63:a350:: with SMTP id v16mr20232559pgn.87.1576534012471;
 Mon, 16 Dec 2019 14:06:52 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:50 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 1/6] vmlinux.lds.h: add linker section for KUnit test suites
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

Add a linker section where KUnit can put references to its test suites.
This patch is the first step in transitioning to dispatching all KUnit
tests from a centralized executor rather than having each as its own
separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 include/asm-generic/vmlinux.lds.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4f..99a866f49cb3d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -856,6 +856,13 @@
 		KEEP(*(.con_initcall.init))				\
 		__con_initcall_end = .;
 
+/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
+#define KUNIT_TEST_SUITES						\
+		. = ALIGN(8);						\
+		__kunit_suites_start = .;				\
+		KEEP(*(.kunit_test_suites))				\
+		__kunit_suites_end = .;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
@@ -1024,6 +1031,7 @@
 		INIT_CALLS						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
+		KUNIT_TEST_SUITES					\
 	}
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
-- 
2.24.1.735.g03f4e72817-goog

