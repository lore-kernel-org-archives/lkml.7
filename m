Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F384EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C468920874
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0rCIzO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfHMMTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:19:37 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:47613 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfHMMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:19:32 -0400
Received: by mail-yb1-f202.google.com with SMTP id a2so68510324ybb.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5NgEEOsuafidZLfBQW1+8uAN6YPDpjefZYyipohUb1w=;
        b=A0rCIzO1HrKULIk+ltl79te8oL+yJKIRwx4UrVJHdwUX5yyp9GYs4dLvAbOJIpGdfe
         HueqdJXhyRVPVVL2FD7vw9o8IFPjz8RV5MJFgd4D4QgTtlsXaiGnmkj+j5db4+GhrCeH
         mGslTVn5M6Kcv88zBxM1Kts/OutRv5gJuzAhbPJMte99LBE2JnN3XcGXe+j+Odn7ZszO
         MWmVH4oRFy2Iwj9q2XAHxuPIRFJcOw6YPazijDX0o/Xbxdkhjm3BS7GAUFGbobJbhgI5
         uTLHjYkcDb/X4XeFDIsymMzyAmVcjMLbxWMLaOZrRKOBEl3e77UIqo9lAs2K+xAJ4PCq
         UspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5NgEEOsuafidZLfBQW1+8uAN6YPDpjefZYyipohUb1w=;
        b=n87Vy5ofo0J/ixwoTSfNb21p7ZZIgRwc5FTV/o3/QaOrtZr0GcVWshQ62aCL+Z6GdB
         ZStMBpDHDAoQyOWACcok7/aL+T0PduON/VQ9qObc3y4Jc5zevpxMalTHcfTJdStrZYyl
         DEcoHNnf99fX6651wwfgwVsu9lOIEZ+UaReosbVU6Uvp5V8ejahQ1VzQZS8GepbY4RFQ
         88iqqDJYhMTFTVT55Z4Wm6fVeMTeUya+OM2WC8fNGQSnNRqIdQFgm6GtgGMijCZyAwxf
         pc0ogwTD+xEhvjKz04JCfUSWNbyLIZNHuQPrZIBUWEFt82ks6fwVQddw2UM1PlG8Zvjm
         137A==
X-Gm-Message-State: APjAAAXQ9Lt3sNpgQfDpb9F1TZDKYb1Bj6xHHpEE3azhXWUhgfaJQkVp
        DBCg60rwbQB4yjBmDimmGz3+sKuCnEZXE5dHqr987ozkmTIJZNZ2LcaXpYR6CkGEiqdxB6jDN+b
        uA9NQsNjob6OVkbesUG4IhCUbZ6Z0S6OrujpDXbytmYkNAcxWrI3qoYj3RaeYzH2n57tcNoWYB+
        8=
X-Google-Smtp-Source: APXvYqzofTNz2fbZb+Pu/dK4amOg+sOn20B/5a6YQykBvqxFwzTuJhcNhOKlhNTjO07MWW5j+Mv9I/hAS9Au7A==
X-Received: by 2002:a81:1d84:: with SMTP id d126mr25341335ywd.199.1565698770861;
 Tue, 13 Aug 2019 05:19:30 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:17:03 +0100
In-Reply-To: <20190813121733.52480-1-maennich@google.com>
Message-Id: <20190813121733.52480-7-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 06/10] export: allow definition default namespaces in
 Makefiles or sources
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org, maco@android.com
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid excessive usage of EXPORT_SYMBOL_NS(sym, MY_NAMESPACE), where
MY_NAMESPACE will always be the namespace we are exporting to, allow
exporting all definitions of EXPORT_SYMBOL() and friends by defining
DEFAULT_SYMBOL_NAMESPACE.

For example, to export all symbols defined in usb-common into the
namespace USB_COMMON, add a line like this to drivers/usb/common/Makefile:

  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_COMMON

That is equivalent to changing all EXPORT_SYMBOL(sym) definitions to
EXPORT_SYMBOL_NS(sym, USB_COMMON). Subsequently all symbol namespaces
functionality will apply.

Another way of making use of this feature is to define the namespace
within source or header files similar to how TRACE_SYSTEM defines are
used:
  #undef DEFAULT_SYMBOL_NAMESPACE
  #define DEFAULT_SYMBOL_NAMESPACE USB_COMMON

Please note that, as opposed to TRACE_SYSTEM, DEFAULT_SYMBOL_NAMESPACE
has to be defined before including include/linux/export.h.

If DEFAULT_SYMBOL_NAMESPACE is defined, a symbol can still be exported
to another namespace by using EXPORT_SYMBOL_NS() and friends with
explicitly specifying the namespace.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 include/linux/export.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/export.h b/include/linux/export.h
index 8e12e05444d1..1fb243abdbc4 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -166,6 +166,12 @@ struct kernel_symbol {
 #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
 #endif
 
+#ifdef DEFAULT_SYMBOL_NAMESPACE
+#undef __EXPORT_SYMBOL
+#define __EXPORT_SYMBOL(sym, sec)				\
+	__EXPORT_SYMBOL_NS(sym, sec, DEFAULT_SYMBOL_NAMESPACE)
+#endif
+
 #define EXPORT_SYMBOL(sym) __EXPORT_SYMBOL(sym, "")
 #define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_gpl")
 #define EXPORT_SYMBOL_GPL_FUTURE(sym) __EXPORT_SYMBOL(sym, "_gpl_future")
-- 
2.23.0.rc1.153.gdeed80330f-goog

