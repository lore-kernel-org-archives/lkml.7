Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60367C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C9A2070A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJFNkTYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfLCONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:13:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36247 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726474AbfLCONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575382416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAhp0ornz2YHEQIA4nh6ljvKEWN9EysjuU/tygcjX7Y=;
        b=TJFNkTYqlGz1C9UVta9Ioda0phyYHqoebZRbSt682I4TlJewtP0fVf04/ztij4zBt0zpbW
        rB7AYLDz3BMs0hLsbYqIFMlwT3sqI6ZxasrRGbx3SWRVsaDBdREynQXt30KliUG+rv6HB0
        ZO/kdf0vVGO5cAaGERsTRed5haNPwMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-cvAZVQ41NbKEAcv81iMabA-1; Tue, 03 Dec 2019 09:13:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B4E8108AF65;
        Tue,  3 Dec 2019 14:13:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id AEEE7600C8;
        Tue,  3 Dec 2019 14:13:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Dec 2019 15:13:30 +0100 (CET)
Date:   Tue, 3 Dec 2019 15:13:25 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 2/4] x86: mv TS_COMPAT from asm/processor.h to
 asm/thread_info.h
Message-ID: <20191203141325.GC30688@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191203141239.GA30688@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203141239.GA30688@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: cvAZVQ41NbKEAcv81iMabA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move TS_COMPAT back to asm/thread_info.h, close to TS_I386_REGS_POKED.

It was moved to asm/processor.h by b9d989c7218a ("x86/asm: Move the
thread_info::status field to thread_struct"), then later 37a8f7c38339
("x86/asm: Move 'status' from thread_struct to thread_info") moved the
'status' field back but TS_COMPAT was forgotten.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/processor.h   | 9 ---------
 arch/x86/include/asm/thread_info.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proces=
sor.h
index 54f5d54..d247a24 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -507,15 +507,6 @@ static inline void arch_thread_struct_whitelist(unsign=
ed long *offset,
 }
=20
 /*
- * Thread-synchronous status.
- *
- * This is different from the flags in that nobody else
- * ever touches our thread-synchronous status, so we don't
- * have to worry about atomic accesses.
- */
-#define TS_COMPAT=09=090x0002=09/* 32bit syscall active (64BIT)*/
-
-/*
  * Set IOPL bits in EFLAGS from given mask
  */
 static inline void native_set_iopl_mask(unsigned mask)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thre=
ad_info.h
index f945353..b2125c4 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -221,6 +221,15 @@ static inline int arch_within_stack_frames(const void =
* const stack,
=20
 #endif
=20
+/*
+ * Thread-synchronous status.
+ *
+ * This is different from the flags in that nobody else
+ * ever touches our thread-synchronous status, so we don't
+ * have to worry about atomic accesses.
+ */
+#define TS_COMPAT=09=090x0002=09/* 32bit syscall active (64BIT)*/
+
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED=090x0004=09/* regs poked by 32-bit ptracer */
 #endif
--=20
2.5.0


