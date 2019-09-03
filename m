Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E84C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99378215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hc0uhxet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfICPHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:07:40 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:36102 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbfICPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:07:39 -0400
Received: by mail-vk1-f201.google.com with SMTP id o75so7918586vke.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e5Xa0/L265hDWGkY0PbNgVQnJTuuZu+3daZLqyOdxeE=;
        b=Hc0uhxetFetgu/poYhUNFgg1T/AwAxEU/l5K1FfOUg+f0UDE9/4KemaScAtIodqCcf
         p+HErAQSwLryXYi6kJhwEDHbcaoIEMJn1t1UXw5opoN+Eo7Q8uX0MgEtrKPvgRCHqr60
         bcyHtxD9NVfAPNsjYgne7wNNEXO3ygL8XmhSxOqgamb2vNSBC/PH9s1qLICgCeuhcUzc
         gor8Bzjd0nOLnqmfz8RlNFqa+Ip17HpWMJ/4Oohd87xpibMA9P2cOON4y/PnV+yD1DEY
         yim6amoWS0+2n19l9MHM7rxxZ1+ZLaK1MEr2KbIKihHzI+SvCc1RGyKDayWQorTmMk8m
         6vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e5Xa0/L265hDWGkY0PbNgVQnJTuuZu+3daZLqyOdxeE=;
        b=lIRhqWXnWvsLIorbgOYWur9IKmjVhdacSj3fPyrRSYNesD++SlWp74j0EZjMlzN5D5
         PL8Qw3Wsjy+JUUvuZ787fyO9ZlkX2JdS+KFnCNSLVnZ7l3IYmE3VHkzhQvwU9xK9CH6n
         PcU1NnMSVrmIN8ZQWyyczyE74UvYPUTrzeHxCUe9oQnoQywaXhhKPFmFTWm7+td0Vwnl
         oTK3dCdhABAS1hLqlR+lm0zfKKSk8GrOacM6NVQoD8e4OjpDDMjgu2QJkz1kWwqibfIE
         r001gCdzdAnZmbTjX926sxdrhXRjuN8AnYmNRTha2yOO+6wZb64nmLIYN6K3CJc8sB2G
         JZ0A==
X-Gm-Message-State: APjAAAWBWPlUQ41USd+Zu94wYuYLEO4Yd7B85V0vf1A3v8efQoZwvAY1
        rGgRkEBkZwXUKj/u971gVBW0UPaj/6aFGxqsc0eHNEbbOV/8JItQoPqIYyV/GfALgzivayOgTP2
        tRwjQVina65CZOVPs+1yU1vW/7xR97en6n0Gzo0MNDiGebadvZAHTidd71l84XfYuydzyiiixCU
        4=
X-Google-Smtp-Source: APXvYqwQdWroZ46qqIvVShU81d8ojjOGsuCIOY/jhv+xD2nymIDWaNxFqSFL2DC3qyyVqkblB8HT7gT1W1ZVnQ==
X-Received: by 2002:a1f:bd94:: with SMTP id n142mr7086317vkf.86.1567523258142;
 Tue, 03 Sep 2019 08:07:38 -0700 (PDT)
Date:   Tue,  3 Sep 2019 16:06:31 +0100
In-Reply-To: <20190903150638.242049-1-maennich@google.com>
Message-Id: <20190903150638.242049-6-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190903150638.242049-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v4 05/12] module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        joel@joelfernandes.org, lucas.de.marchi@gmail.com,
        maco@android.com, sspatil@google.com, will@kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is enabled (default=n), the
requirement for modules to import all namespaces that are used by
the module is relaxed.

Enabling this option effectively allows (invalid) modules to be loaded
while only a warning is emitted.

Disabling this option keeps the enforcement at module loading time and
loading is denied if the module's imports are not satisfactory.

Reviewed-by: Martijn Coenen <maco@android.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 init/Kconfig    | 13 +++++++++++++
 kernel/module.c | 11 +++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..cc28561288a7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2119,6 +2119,19 @@ config MODULE_COMPRESS_XZ
 
 endchoice
 
+config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
+	bool "Allow loading of modules with missing namespace imports"
+	help
+	  Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
+	  a namespace. A module that makes use of a symbol exported with such a
+	  namespace is required to import the namespace via MODULE_IMPORT_NS().
+	  There is no technical reason to enforce correct namespace imports,
+	  but it creates consistency between symbols defining namespaces and
+	  users importing namespaces they make use of. This option relaxes this
+	  requirement and lifts the enforcement when loading a module.
+
+	  If unsure, say N.
+
 config TRIM_UNUSED_KSYMS
 	bool "Trim unused exported kernel symbols"
 	depends on MODULES && !UNUSED_SYMBOLS
diff --git a/kernel/module.c b/kernel/module.c
index 6bb9b938f9c7..f76efcf2043e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1408,9 +1408,16 @@ static int verify_namespace_is_imported(const struct load_info *info,
 			imported_namespace = get_next_modinfo(
 				info, "import_ns", imported_namespace);
 		}
-		pr_err("%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
-		       mod->name, kernel_symbol_name(sym), namespace);
+#ifdef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
+		pr_warn(
+#else
+		pr_err(
+#endif
+			"%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
+			mod->name, kernel_symbol_name(sym), namespace);
+#ifndef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 		return -EINVAL;
+#endif
 	}
 	return 0;
 }
-- 
2.23.0.187.g17f5b7556c-goog

