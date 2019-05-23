Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6D0C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E6220879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEeOX5Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfEWGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:50:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36210 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWGuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:50:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so4508873wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 23:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HmFIp9t60XLoWbjpmc3RIKG7TQwMK3zhK3suz8duCcY=;
        b=QEeOX5Zpege49oGEBr/MZw4gdpiibcLBcjULl5TUds3gk8zAdN8f1nfT1u+ph3fgaU
         /3l68la0eQiaGbHrv6tfi2qhOpJu//Dn5OToqvU2T/urx8hetpHMpLCC9TOMa2v+EuE2
         IkazlMnmKpYUetYUAYrn29xY3+m6WpLyo4vqtiV8rSDCeyCzk5MeM+lRRx5s3WY1/ity
         /uvsMq2tNu1qLCNNdgMX6Y9qpvzsDGL5TGYc8lDaVmE8ME8BjlbyS6E0vqN3ftwHzuvi
         ggFlgT9GEepD47JvSKsanvVRtIditNdwnIzS1RaaOnTomsrmj3dPVklO6NnxdviUPg2/
         ecZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HmFIp9t60XLoWbjpmc3RIKG7TQwMK3zhK3suz8duCcY=;
        b=J5iA2OawLjXutiYDCgNjrwzdKEEbAemfEXAjzD1UY5ZGx/466CRTTE7q0uB6GQodLj
         65KOLu3xgjTQSlVZZjWjyvlVWvl0lwKjU4/sOEnrhYVJ01zWTw30VMy5dY9THJqBVGlr
         OsCzpzTt+lCQFXgCS9WUowuz4H2JLPxOrg1pERSmWD5OK1qsiY8afBQ0XietSAqRufUJ
         bn2hD/MqyqHOLDcMMwo1oVB9Hxzchclu7oHzDo34Yil4R7wFbKoCoDhRc3NjMFt/3xQ0
         Kh7N0oh54WybwZBfUFM48ocwCZxrylv1S1561qKRsBGiSYP5luT3El+ic1wHv953M5Hg
         biVw==
X-Gm-Message-State: APjAAAVSQCmU/dPPmxrFrZRgdQ/oPotvTXX4j33+/pa5M85EIBpyIXiF
        eC2y7j7uhvhVHqc+qCghVz8=
X-Google-Smtp-Source: APXvYqzRjJAfgOF0LfSB//bPT2XjMKpaZ04zbTcRKVPJSru3IHBGx1d8nHeZGLgkGQJbXV3P77YNBQ==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr10884971wmj.87.1558594199985;
        Wed, 22 May 2019 23:49:59 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id g6sm36004224wro.29.2019.05.22.23.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 23:49:59 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9137C1146D73; Thu, 23 May 2019 08:49:57 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/32s: Include <linux/moduleloader.h> header file to fix a warning
Date:   Thu, 23 May 2019 08:49:56 +0200
Message-Id: <20190523064956.29008-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 2edb16efc899 ("powerpc/32: Add KASAN support") support for
KASAN has been added. However building it as module leads to (warning
treated as error with W=1):

  arch/powerpc/mm/kasan/kasan_init_32.c:135:7: error: no previous prototype for 'module_alloc' [-Werror=missing-prototypes]

Make sure to include <linux/moduleloader.h> to provide the following
prototype: module_alloc.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 0d62be3cba47..0c31e440d094 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -7,6 +7,7 @@
 #include <linux/memblock.h>
 #include <linux/sched/task.h>
 #include <linux/vmalloc.h>
+#include <linux/moduleloader.h>
 #include <asm/pgalloc.h>
 #include <asm/code-patching.h>
 #include <mm/mmu_decl.h>
-- 
2.20.1

