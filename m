Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA58C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB082088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cJvEYsza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfDYQQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:16:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45314 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfDYQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id k92so357691edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GCSKX7upO4gUgT9jk4Ocxz37wBs1AXvqHFgAl4OIuk=;
        b=cJvEYszaGplcwVA5aahxPz4GGTcpMWGKC968tGMzmcc7A0Ms+FCFpqJZkyQ7jHsafP
         pOjFMrefd42+QX/YQw3Ox08ANxB1ITN/SdFQ+Onl3n/wtllW4kMXzpV2t/UB/YAjv7HT
         BHJBflC1UHwuqwJR9wAZ1W/E9mqECAQtXgjzyLwQeOrSifkc5ta7v7tyRy4l5t8RCFvx
         wLuy/Z1erCISaBfgOjm8kII6ukjmcuEExynn0EF8ctW5Qxlx6udO/RUJnRX0EQELqrgU
         zuQfwisQvaYhuWwgtwbKYIrG/nNC6h9Yl+kQZtHTyNjYHvA8y6Xw9CqUygRlOJB9N/xn
         7icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GCSKX7upO4gUgT9jk4Ocxz37wBs1AXvqHFgAl4OIuk=;
        b=gFoNrlCQKJZrW8a63XDxUMQRhBdjhnFZ47PZ+YYmzvioTnjf0EzpEfxTUQl1oE9bdB
         3PYAjT6AvwJHEFi4atAd0HL/NzfVxV1LNCv2hPgLYJlrEvoPMsR62UT4e95e2+E0hj/b
         U7iag6DtJNufH/KBsZDse9pgwDfk3EwAszUZaM88Z4i68c6VTBw0a84LGrDiknNMuLYx
         Cyg8TwMaS3xvkVpKRqdMpoT1e8Gu2BsmrDm8TCQnftXjgt7wkxR13082eNdvco+I4/YU
         AnLZHTWRf+0xlj1aU3Z0del00oEowtNJUGGpVHcd5N6ftEtRJlEZUG4NDfUdkOSlIHa8
         bpsw==
X-Gm-Message-State: APjAAAVipu4c5MQhDAF9yg+A9xz58mp7ol9p2Lh65xtbFhjySytiOGJS
        yT2VfuIL8AccGrrtnkSOkGBmmjZDDpE=
X-Google-Smtp-Source: APXvYqwxkEdXinZTG5bgJ+JaRkll5OK0VSmx+8Dk3imUTlO1TJjYDhn5gWAltymTOjvHCprPimyHIw==
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr20067751eju.119.1556208878132;
        Thu, 25 Apr 2019 09:14:38 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:37 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 12/27] x86/vdso: Restrict splitting VVAR VMA
Date:   Thu, 25 Apr 2019 17:14:01 +0100
Message-Id: <20190425161416.26600-13-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although, time namespace can work with VVAR VMA split, it seems worth
to forbid splitting VVAR resulting in stricter ABI and reducing amount
of corner-cases to consider while working further on VDSO.

I don't think there is any use-case for partial mremap() of vvar,
but if there is any - this patch can be easily reverted.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index babc4e7a519c..ff9875a4d53b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -84,6 +84,18 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	const struct vdso_image *image = current->mm->context.vdso_image;
+
+	if (new_size != -image->sym_vvar_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -136,6 +148,7 @@ static const struct vm_special_mapping vdso_mapping = {
 static const struct vm_special_mapping vvar_mapping = {
 	.name = "[vvar]",
 	.fault = vvar_fault,
+	.mremap = vvar_mremap,
 };
 
 /*
-- 
2.21.0

