Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F55DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7F521721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cP3ve+V2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfFLT05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:26:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38107 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfFLT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so18129835wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nDl/CUmCqqh37N3cXS8r+aNsaHvCoXX3q5gpIkIcXw=;
        b=cP3ve+V2cqLDHqdmmZWEIRkLThECV8dV9CpQoJNIPFK0OOyl/ECobu8g3pVyvDlF/5
         N75tP0MJFDZSkg+g0Shq9KGffobsEPGgPJk11TBMBvqgLSYNqFDaW4asBO2bzEQqYn4Q
         aboNx7HWRw1FAXssQZ2KToQglqdWfu/Zy6LJqzbTQVUn5GBTfKW5q4ZoOo+KfSj2fgDm
         FehmyhHpObVdhb7DKtYfbdJ8BtyNp9ccDg6GkgIbxSd7su5z0qXpRHf/rTftjbH+mNaO
         XLQ+vggFv8tm6QMbsuOqCXaCX85efXP2r8VMLnArHWepTMd7UJhqN4A+oNNaGUMSQgQr
         4tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nDl/CUmCqqh37N3cXS8r+aNsaHvCoXX3q5gpIkIcXw=;
        b=YrGGw/UEN5s4b0d4IOqb8YMbQrRekD8kt1rIq4EC3Dnzx54kvOd+xzKcdWLUFDHOH/
         EpQNaVP8loQOQaG95R6cmiABbdI9ttCmqfWttxBxovraI0RRNCf4zSTdvXvc4NKVHB+j
         pmbqIJlAL1dkL7MjN0AWSXiVrAFvm1loOOQ2wR4ZHAvmzj97ez2a/+wS2es7v7X6xAko
         vxPVR4j4wbwkVnCSijo9BzV6/Y1ljrnvcah/gFjyojg2lApKSUcmAT+uFH0mEjeJZCqg
         4skuG2s1QtvYf8RhStYhWC3jzgw5dMgix/GEaLH1DhjgiXvtuyn4o+tUjO8XX0bqnTSw
         WIBQ==
X-Gm-Message-State: APjAAAVEvenmLvioyTMgSmLkgaERrkloOJBGxnGdP+j1gpyqQR52fOY3
        6445ymX79HwTNsaKWckHQvNgbEp5kXQ=
X-Google-Smtp-Source: APXvYqzvFvZKw4czh3fj4IC0HCIsTNt0UN8B6+q4hgTO1PoZvnQtXhK6OsfwFtRQLTAdWfRhowlMWg==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr19501473wru.264.1560367608606;
        Wed, 12 Jun 2019 12:26:48 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:48 -0700 (PDT)
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
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 13/28] x86/vdso: Restrict splitting VVAR VMA
Date:   Wed, 12 Jun 2019 20:26:12 +0100
Message-Id: <20190612192628.23797-14-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
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

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 8db1f594e8b1..d2b421233ba5 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -84,6 +84,18 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	const struct vdso_image *image = new_vma->vm_mm->context.vdso_image;
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
2.22.0

