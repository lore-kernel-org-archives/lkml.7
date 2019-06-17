Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C65C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD9220861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsMQvlLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfFQWL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:11:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46078 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfFQWL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:11:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so4735013plb.12;
        Mon, 17 Jun 2019 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/VaXSLpZ75ORCB1zbl4hdNQEjbM9Qsyda80h69PRSPA=;
        b=HsMQvlLIq0OP3L+FNIJyK0J78hvT1oQovohPXn1CRaD6VJCWPJiDVE7KaumvwPCqPI
         Kejd+2gug/XQ+dNQmZn8ot3iXedEbK/uf+uCWp4vrklRf18r/7wuC36QXr3aC2I+yPSn
         3juO07q/f4tTVJwdeVZeS+cbKvuPVDA2UKZ3y9lNhUdSG9QP7k6tD56pNJfmIEkIqJk2
         sKiiEmKP2oqEo16lJeYQGSdpJTVjAM+5d4O9IfYuxLMdcrGY6tZdFU379hSKXMadpcUH
         BFHBZh5uBpa0YpPUJgjJR7h2ZfTw9qFlGiq/GJX4ri5ptBDGBx/oc8dwS2ohZf26tdUc
         95nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/VaXSLpZ75ORCB1zbl4hdNQEjbM9Qsyda80h69PRSPA=;
        b=rKqaF19YWSXKIarfNptMXy5KG45Xpk+AMi7q4adJ+g7t23xZ9rbKIOAgzsU3zzRQjL
         XiKYxpGy101zW6wPSesKvVi2cNVLcsdfywotBHPUdXUquST5o3A9gluO777vQw4Oluc8
         vSv6/cstxM0dmgA+/amyetNZvoO+3IK87L7tjDwmqJVUuu7PZdiUhjFl5r1rnSVPliOI
         jtkKKc8xa6iuhq48+Tkdjojz3lmDBkPJBNZhHwW0iXzoDaKiRVkmHZ6T+qSsC+iYS93z
         9b6sAezebty/Aa17BoDWnSV/OwyKgf4gL/RRhsj4yACC63Mzwe+7lgA1Q88LNd9nLmaD
         JwDQ==
X-Gm-Message-State: APjAAAXP3XRTxPIIpKcH9Z+65OTRh0W6yiWZGwciYy9estvAwq7quXt3
        a6Bfteyr6NMJpOML36MJwgI=
X-Google-Smtp-Source: APXvYqx55+qVC4ZdfQ7ba9JDRhraTt/q+1YyyqWzNGimZEtBjgZOCXen8WCKjalGTR2c2HmM9y+7AA==
X-Received: by 2002:a17:902:8696:: with SMTP id g22mr84220867plo.249.1560809515479;
        Mon, 17 Jun 2019 15:11:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s129sm12551020pfb.186.2019.06.17.15.11.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:11:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Andrey Ryabinin <ryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>, glider@google.com,
        dvyukov@google.com, corbet@lwn.net, linux@armlinux.org.uk,
        christoffer.dall@arm.com, marc.zyngier@arm.com, arnd@arndb.de,
        nico@fluxnic.net, vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, alexandre.belloni@bootlin.com,
        ard.biesheuvel@linaro.org, daniel.lezcano@linaro.org,
        pombredanne@nexb.com, rob@landley.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        tglx@linutronix.de, thgarnie@google.com, dhowells@redhat.com,
        geert@linux-m68k.org, andre.przywara@arm.com,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        ryabinin.a.a@gmail.com
Subject: [PATCH v6 6/6] ARM: Enable KASan for arm
Date:   Mon, 17 Jun 2019 15:11:34 -0700
Message-Id: <20190617221134.9930-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617221134.9930-1-f.fainelli@gmail.com>
References: <20190617221134.9930-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ryabinin <ryabinin@virtuozzo.com>

This patch enable kernel address sanitizer for ARM.

Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/dev-tools/kasan.rst | 4 ++--
 arch/arm/Kconfig                  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index b72d07d70239..a9cb1feec0c1 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -21,8 +21,8 @@ global variables yet.
 
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
-Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
-architectures, and tag-based KASAN is supported only for arm64.
+Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa and
+s390 architectures, and tag-based KASAN is supported only for arm64.
 
 Usage
 -----
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8869742a85df..5c98431ddaea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -59,6 +59,7 @@ config ARM
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_KASAN if MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
-- 
2.17.1

