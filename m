Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FCBC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29672133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjXCs01N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbfJDJ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:57:56 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:57234 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbfJDJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:57:55 -0400
Received: by mail-qt1-f202.google.com with SMTP id m6so5866609qtk.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1/VpF4gesFXU4507UWxnVqQ50T2yMtX0vj1yZbNb6oQ=;
        b=EjXCs01Nw9e85QbwhhT2J7CTEZu2WaD0wE4BqfUUDVzVWVU028VQ8BTERUBxKdYCud
         MA243tqwxNN5ZMv+MijBP/HwGQn1TDDQR82nDKo0OxslMQ/vn9mde3VL2uRXgW2Qdo8D
         vzdH7lDcznW/2FXUsmgMYlytbjNXeOSZrb6jAO6euFMwnM73Bwgq+upRy3G0qgF8yZCO
         B+VHFwgykCM4yR1WymcI/HBJtLVJDtakY1wEi4K34lpkRnT1jgogUopWcBZitko8fIij
         QuREfON3rxVDSqjhMQhBc8d/7Qdy4qH9pntPhSx2KfLkBbaJkODzpTLMq2iBs9NWO3qu
         NHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1/VpF4gesFXU4507UWxnVqQ50T2yMtX0vj1yZbNb6oQ=;
        b=oIT0rnGMv3Wb0k0OpoJRzG7xcEOEg9UdiyxWTBzE2cNYKq/jrZtTGZMY4FcFhIxtx9
         HcgbGutUBTpsOcWysLUXv0rxkRsQwoIawrSrEbdrKfs3EYcMqjMI8fHe2C95apc5Sv5B
         XuAW3D4hetxlpcwS8uL/zT1BKV33PZm4JZpY5kCN8h1KWf4Bd26WH+6kwU+iqP6JqWvw
         g5U4mtxOV9J9+nQhk4i7t36xT8oo5jjyGQpbpS2URbbUyMpnStAmiEeXoWTxB4pQE2H9
         v4Z8r6k3j7N4JlbpIoP16OsqlC5FvQMuwxx/tJ10EUY4YUY9+MwEeOoe87TB4EYgYOoL
         ByDw==
X-Gm-Message-State: APjAAAVO9laQOMXZgZjDFUBV3tH20kIcAsmgLm1L/zZG8CpjebCfk+cP
        0678AViagFyGJgCtq1DM3MHCo35/9U/YDRkpkbUBBDalHv3Z00aA1UHrv3SMTKQCSrPbXShJ9es
        FMHbe3s4UV2IskkKelEH949m+abiHziVMtGLdkOzdqJwXzL6AmM8acVpgBs1TusJK7snIBO4dQT
        o=
X-Google-Smtp-Source: APXvYqw/XciF/wt63YDVoL1Jtf61U+HYneFII6RukZGjq5FfUKVrdl8BiBFZBR4/xCnzvjveFzbrGC0YSkJ34g==
X-Received: by 2002:a37:8f02:: with SMTP id r2mr9282685qkd.197.1570183073090;
 Fri, 04 Oct 2019 02:57:53 -0700 (PDT)
Date:   Fri,  4 Oct 2019 10:57:48 +0100
In-Reply-To: <20190917231031.81341-1-maennich@google.com>
Message-Id: <20191004095748.223119-1-maennich@google.com>
Mime-Version: 1.0
References: <20190917231031.81341-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] depmod: create and use System.map.no_namespaces
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

depmod in its current version is not aware of symbol namespace in
ksymtab entries introduced with 8651ec01daed ("module: add support for
symbol namespaces."). They have the form

  __ksymtab_NAMESPACE.symbol_name

A fix for kmod's depmod has been proposed [1]. In order to support older
versions of depmod as well, create a System.map.no_namespaces during
scripts/depmod.sh that has the pre-namespaces format. That way users do
not immediately upgrade the userspace tool.

[1] https://lore.kernel.org/linux-modules/20191004094136.166621-1-maennich@google.com/

Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Martijn Coenen <maco@android.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org
Signed-off-by: Matthias Maennich <maennich@google.com>
---

Please note this depends on the new ksymtab entry format proposed in
https://lore.kernel.org/lkml/20191003075826.7478-2-yamada.masahiro@socionext.com/

That is likely to be merged soon as well as it fixes problems in 5.4-rc*, hence
this patch depends on it.

Cheers,
Matthias

 .gitignore        | 1 +
 scripts/depmod.sh | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 70580bdd352c..5ed58a7cb433 100644
--- a/.gitignore
+++ b/.gitignore
@@ -59,6 +59,7 @@ modules.order
 /vmlinux-gdb.py
 /vmlinuz
 /System.map
+/System.map.no_namespaces
 /Module.markers
 /modules.builtin.modinfo
 
diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index e083bcae343f..602e1af072c7 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -39,7 +39,13 @@ if $depmod_hack_needed; then
 	KERNELRELEASE=99.98.$KERNELRELEASE
 fi
 
-set -- -ae -F System.map
+# Older versions of depmod do not support symbol namespaces in ksymtab entries,
+# hence create an alternative System.map with namespace patched out to use for
+# depmod. I.e. transform entries as follows:
+#    __ksymtab_NAMESPACE.symbol_name -> __ksymtab_symbol_name
+sed 's/__ksymtab_.*\./__ksymtab_/' System.map > System.map.no_namespaces
+
+set -- -ae -F System.map.no_namespaces
 if test -n "$INSTALL_MOD_PATH"; then
 	set -- "$@" -b "$INSTALL_MOD_PATH"
 fi
-- 
2.23.0.581.g78d2f28ef7-goog

