Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D253C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88E32146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpMpMIkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfDKQsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:48:47 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38255 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKQse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:48:34 -0400
Received: by mail-wm1-f42.google.com with SMTP id w15so7528356wmc.3;
        Thu, 11 Apr 2019 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MupClbbPCAMqvvPxT4Mofjt3KZ1UBW04TL/nvAxW0bU=;
        b=fpMpMIkfHtGDzIe0/lue3RnyAW25xIAjn2xr4Gz17E1dQ3eHgrHOzkF6Ha+/4DM1rM
         4DFLN+n2vNCZFzBERk028iR3TOleZbKwsq1ZQCfYy1YxGyVAOPw8OiVlNkpBh6Q5Zx80
         /6AYDAD/6/sb/etGg6Ym+X31rjGsX1RfTDto5jUOqT4SQLCV/G3uoKwrNiGKdHoqCfYF
         IVry6GLGUXJ903h1KEIL0CLTSbMBOW/m9hLQooiC6X99LKnDh+uaw/z6EZHgtxmFkSiN
         eFKU/RVlaJwV9pYhicGRESQPG2yHoyy7S0GzNzdygmE+CiOcpk5CEsXj4Jw8pkaqVxG6
         CxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=MupClbbPCAMqvvPxT4Mofjt3KZ1UBW04TL/nvAxW0bU=;
        b=AB41yoKQLYVnXn7BTzOBphR9LhhZKOdjvKQVCasAX3OVP3Vuh/nGDyfv7MZKYEf761
         dBv5uxboW4Enu8MX5dDFC061zKfFNzme4f1iprr764lLDVftyYdKQk9KvrCvH7LnDR8H
         W7d7N878h3r+kc+N6QVBB1ubBX9jLivxOKip4zDfNFRuwFTcn+KpUG0FLZD5e7GwcE+b
         y7DO7k3IS0M8VkS5OI2KfZPRxo2o7BAZFknsxeG6JIEyd63dIWC6CkfN9VoDXW75/WgU
         ASdZ3Aa8lXBzBskJnowTWLsle91us5P8XapaEtzH9CsjZBgAK1gcnymvWEWtGGYP3wuY
         G4fA==
X-Gm-Message-State: APjAAAXIDoIgMp0Ipv2lis7hV7pL1ujInpAQn/TkKhJZfogvbO7eofou
        stP/uuWEkAc/3i1bmlm+/siUUZ3u
X-Google-Smtp-Source: APXvYqy1qAEo/YMSn/RQU+1QHzHg/u/UcU1AOWqdl5jVFncKlUEGqZ0/GVzuVvSI1UbUeJih/AISmQ==
X-Received: by 2002:a05:600c:28b:: with SMTP id 11mr7340295wmk.129.1555001312057;
        Thu, 11 Apr 2019 09:48:32 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f10sm46386134wrs.17.2019.04.11.09.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:48:31 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 2/3] selftests: kvm: fix for compilers that do not support -no-pie
Date:   Thu, 11 Apr 2019 18:48:27 +0200
Message-Id: <1555001308-36016-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555001308-36016-1-git-send-email-pbonzini@redhat.com>
References: <1555001308-36016-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-no-pie was added to GCC at the same time as their configuration option
--enable-default-pie.  Compilers that were built before do not have
-no-pie, but they also do not need it.  Detect the option at build
time.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 7514fcea91a7..2d2e10b219d5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -1,3 +1,5 @@
+include ../../../../scripts/Kbuild.include
+
 all:
 
 top_srcdir = ../../../..
@@ -30,7 +32,11 @@ INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 CFLAGS += -O2 -g -std=gnu99 -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
-LDFLAGS += -pthread -no-pie
+
+no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
+        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
+
+LDFLAGS += -pthread $(no-pie-option)
 
 # After inclusion, $(OUTPUT) is defined and
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
-- 
1.8.3.1


