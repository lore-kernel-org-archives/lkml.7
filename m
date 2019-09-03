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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B29C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAD12339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PB5Ah+kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfICPHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:07:44 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:48780 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbfICPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:07:42 -0400
Received: by mail-yw1-f74.google.com with SMTP id l16so10006249ywb.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QzLwUka7MndmPbLBfBjtnVUWcO8y+yUapUjSVd2AkdE=;
        b=PB5Ah+kYC1m4B/Vqzh02d5Dma2M2yVL7Bdqf/cgU5C5/QHZXWWxWusz5yxJTxv/UaW
         cPQ+if9lMxNZfGZL8S6lAAv/KZXOdRW/TgOTyyk2SxYWVb84rGwfPhHTdzrwyml3fyYR
         zMB9ShCEW07O4VXQZsewgm0bwovFzEdsUHPpP51HT13xk3Eva1qhEajcX6jZ8XP0Sq9l
         WK3aEEJXUIn/x+ktaxUYG8u++q7nTs10fbIeFJFJgHQ61R003giZa7EC3s1heJ+v3BkU
         DhFAq5i9QktVcROUV7GZTvihIhoDpLPBW6QkwLuwo8b24v/88OsKzS4oZLrp9/OjXMdl
         ZYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QzLwUka7MndmPbLBfBjtnVUWcO8y+yUapUjSVd2AkdE=;
        b=fsNK9iqnXdcZTlL/+DzVZaI6GtKaP8hytMeFinW+VitTg4iRKS+4ER7Zsc/ldd6B+7
         Rsl7tRYhELvgjh7KYe35+TKn3e7z1B/cTLF/JGZhJPXWgIb4go5oksEUGCMVvz8xo9Oy
         cpzOC83ZnglGSnZI3rVflvJBO1m+pHMaZnxw9z/I3oB4LkitIvNx9DO8KHBPZI2alhQI
         jz0z/8/Fh6GMmON9smAz+PVvH2ttVzQo7QY0FlWtGH1IcSMb9JOrZRzIo3whGVvjscxE
         i130ll412lqd9qdjpT9KTqvBOQPPKycWydfMULbY9XjfHmyA3mYbs8xZ3FAwtJM5FvM+
         SXgw==
X-Gm-Message-State: APjAAAVxcWgkNb7UkrokhqlSy5piCygD6Rh4X8FTcHE8H1MafPalHexi
        RPq6EnQZQsCGCrTMqPm9yX2avFj1zaT2Oiy33uNPfcIcJHncGgxrM6Ve+9OW08TYSKXwi0Ox3H7
        fBWMTYwhAcGcSKo6+WHlN/ZMX2VTD4OdRqLmxmt4q1W5UwGLrXPSjI8ofhFuVf97FtqVeDzg5jV
        I=
X-Google-Smtp-Source: APXvYqwwwghshBlXbu3SzPrPSRDK2LVE5Xdl4WcySrrwEMVrzGCbbqWqp4Yfsy68npcFDyQxAHFyHkK5McSccQ==
X-Received: by 2002:a81:9ac2:: with SMTP id r185mr25908588ywg.210.1567523261200;
 Tue, 03 Sep 2019 08:07:41 -0700 (PDT)
Date:   Tue,  3 Sep 2019 16:06:32 +0100
In-Reply-To: <20190903150638.242049-1-maennich@google.com>
Message-Id: <20190903150638.242049-7-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190903150638.242049-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v4 06/12] export: allow definition default namespaces in
 Makefiles or sources
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 include/linux/export.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/export.h b/include/linux/export.h
index d59461e71478..2c5468d8ea9a 100644
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
2.23.0.187.g17f5b7556c-goog

