Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0033C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C60E2147C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dJkH3pTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfDIV0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34009 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDIV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:26:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so151665eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJAxNVsdZpvgQ0lycDmUvZ/w5aUsw9h9L87n2JSUnEY=;
        b=dJkH3pTk5Euyl6AnuMTJVWpsHfbXhza0vHCBLB/kgIB/5IVjmFm+TZMTTZfA8ZCPIu
         yQiCbVbv4J51PAnNP5TOkxdC2ztuNqrvxYRVB3esWN7AnwbF6R+aA869+HMRaGeMp2ih
         7g60BKCA5L44+IsOaByY2KVh0D8iMGvH9Yhro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJAxNVsdZpvgQ0lycDmUvZ/w5aUsw9h9L87n2JSUnEY=;
        b=hSNuzC28KpnWNv/LnIlqbOsUJIK8+h364RTV2FS+u4ZoznkN+gN8OIS/sVr4lyiY6L
         MNcS3rLneBOLBCtNHz93kjISlODqioskaIMvc6bxaF12GB0o+JBoZ949DSLSG8sGF9Ec
         mC5zaCtSvda8qcCBahTiJDhLXtG0vEqOMZkTxNQElk/6RvVbEI484RziQrxJjTVOnI64
         NVZ0rjbh+jglgDK85LaMInVji7kCmc+3dzxUys0iEHAs6+XVJe/Gyqt+VPMq5/MPYIED
         UmUI3LatpdYwDckaSu7sWM3cfiMJYCzGihK1sRC/leK9EC/PHtRCMIzb/6u3Pn8O0muM
         xmOQ==
X-Gm-Message-State: APjAAAVLI6u2byk4d/zh7bMcDX/nBeUHGuNTCa0t/TYQYePGSa23t1kl
        aoMtHfEUy0+nakvtE7ZBpyPbcg==
X-Google-Smtp-Source: APXvYqx92lGbh5GjPk75seT6pvqLK58Ld7lPc1nByda+1LtFL6qiVgkxzGCRs7R0ZEXtFBJ7TZrwUA==
X-Received: by 2002:a50:9438:: with SMTP id p53mr24334679eda.92.1554845160122;
        Tue, 09 Apr 2019 14:26:00 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:59 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 10/10] powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for PPC64
Date:   Tue,  9 Apr 2019 23:25:17 +0200
Message-Id: <20190409212517.7321-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to GENERIC_BUG_RELATIVE_POINTERS, one can now relativize the
four const char* members of struct _ddebug, thus saving 16 bytes per
instance (one for each pr_debug(), dev_debug() etc. in a
CONFIG_DYNAMIC_DEBUG kernel). The asm-generic implementation seems to
work out-of-the-box, though this is only compile-tested.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/Kconfig            | 1 +
 arch/powerpc/include/asm/Kbuild | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82c3061..6821c8ae1d62 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -155,6 +155,7 @@ config PPC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64
 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index a0c132bedfae..f332e202192a 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -3,6 +3,7 @@ generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
 generated-y += syscall_table_spu.h
 generic-y += div64.h
+generic-y += dynamic_debug.h
 generic-y += export.h
 generic-y += irq_regs.h
 generic-y += local64.h
-- 
2.20.1

