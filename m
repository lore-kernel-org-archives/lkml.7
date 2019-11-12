Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2EEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F27A21D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bxKujLwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfKLB2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:28:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45136 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfKLB17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id z10so11374960wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPSw/UOdt7xB1QuYCMoUI4pcnZZHq7LOyRGakzDPhvI=;
        b=bxKujLwpSvnSBfvq+9GxFXZBk0fosEFIQu9lr4CCpHjCV/1cevth4hWeSvwGu3jXUg
         iMTnekQcGqyu8pgBV8mUR5Aoc7otsDk6EAlPtSc3HK7VqBocmppGL3L5GjAaFdpCOaT5
         YmqAw/nwAkf0ITdD9Wrzy5yom9JD730T7okBxndsP3B1o2IxyS4ZZlTz32imsooh0TwN
         yzuq33yvbBT5hRRykeOZmVsdUMp08FvumwBSyoxL0PXiHm4U4m7uf9wF4TB4hdl0e/4z
         CZgt4KoRn7GTL1AZo2W/8wiRiZRurgZP1uJFhOqvE2V8CZEPNBXpk5sZhMGjrsX98Fkt
         NUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPSw/UOdt7xB1QuYCMoUI4pcnZZHq7LOyRGakzDPhvI=;
        b=PN/lTXPIKQyGD6UzArHS0n2JVzHbQBn2u+KwP/5ipHY0YxfeFX7NmMbhWN8TY4q9Sd
         J7Kz4wVUiWcb0/qnOAZt4MAJ1lTxPuZ/E8Rfs3ZMVvwDQIoKOnODYCGSjE5MIKFb1BWI
         r47OQ+TotYeBLsd3tjCeeb/8abVOtD84OorN2GB0hcItUA4L0OKqmvNeHI2pvXnLhtfC
         Uyw7vZ7/HkSMfYdD7PCo+bEHUohCOyd3seKQQIAABhkTUbjveDmVhLNC+SUp0Yg9Wi+u
         8dcJ+OjdJNyTQ+K9fC517YDnNbLDGrjhEYowL8IlmDjwdypVd0vPfWbU+gLm4oNJ4MJz
         DEmA==
X-Gm-Message-State: APjAAAXhBa9iS9GUF7GY2/rsRraOhz9FYTLSNbBZ9nmztq6NtW1dS6Mh
        prjqotg1lvum7jDSrI59kWDQVsy2zgI=
X-Google-Smtp-Source: APXvYqxJ52RCdRtZXBGKvF7hBbK4CsqzC6J5l2nywtYZwC4mbKUuLfByBGGlt3KvYWcvwHacM8yMHQ==
X-Received: by 2002:a5d:5687:: with SMTP id f7mr2689884wrv.384.1573522077199;
        Mon, 11 Nov 2019 17:27:57 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:56 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
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
Subject: [PATCHv8 19/34] x86/vdso: Restrict splitting VVAR VMA
Date:   Tue, 12 Nov 2019 01:27:08 +0000
Message-Id: <20191112012724.250792-20-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forbid splitting VVAR resulting in stricter ABI and reducing amount
of corner-cases to consider while working further on VDSO.

As offset from timens to VVAR page is computed compile-time,
the pages in VVAR should stay together and not being partically
mremap()'ed.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f5937742b290..000db8282cc8 100644
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
2.24.0

