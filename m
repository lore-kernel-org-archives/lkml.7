Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C14CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58A1215E5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/o1SxMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfLCOO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:14:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbfLCOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575382465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YGNeo9sIm5raPrVI5CnFHmE5Tuq8fy9YiFNIx3zIos=;
        b=f/o1SxMawCu9EBCtusUqkDy2u1YOQ8H9kvresv0DRGjhTGuxRlS/ORtWPFs6vDcToFThaW
        XK8Esd+Ntj8ZrVQCttWtOf1LvaBsdU3aKMIOFctetX/toHrmUTYouC5H7ZOq/Z/2OrpNsJ
        FU3/YP9jsZUCAG7OLgWSKBC9nZXIAFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-QrnM8yCQN8OpepUaOcfvPg-1; Tue, 03 Dec 2019 09:14:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F93102CB8F;
        Tue,  3 Dec 2019 14:14:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8528D610E0;
        Tue,  3 Dec 2019 14:14:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Dec 2019 15:14:17 +0100 (CET)
Date:   Tue, 3 Dec 2019 15:14:12 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 4/4] x86: introduce restart_block->arch_data to kill
 TS_COMPAT_RESTART
Message-ID: <20191203141412.GE30688@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191203141239.GA30688@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203141239.GA30688@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QrnM8yCQN8OpepUaOcfvPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch x86 just saves current_thread_info()->status in the
new restart_block->arch_data field, TS_COMPAT_RESTART can be removed.

Rather than saving "status" we could shift the code from
get_nr_restart_syscall() to arch_set_restart_data() and save the syscall
number in ->arch_data.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/thread_info.h | 12 ++----------
 arch/x86/kernel/signal.c           |  2 +-
 include/linux/restart_block.h      |  1 +
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thre=
ad_info.h
index a4de7aa..75c4a0a 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -233,18 +233,10 @@ static inline int arch_within_stack_frames(const void=
 * const stack,
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED=090x0004=09/* regs poked by 32-bit ptracer */
-#define TS_COMPAT_RESTART=090x0008
=20
-#define arch_set_restart_data=09arch_set_restart_data
+#define arch_set_restart_data(restart)=09\
+=09do { restart->arch_data =3D current_thread_info()->status; } while (0)
=20
-static inline void arch_set_restart_data(struct restart_block *restart)
-{
-=09struct thread_info *ti =3D current_thread_info();
-=09if (ti->status & TS_COMPAT)
-=09=09ti->status |=3D TS_COMPAT_RESTART;
-=09else
-=09=09ti->status &=3D ~TS_COMPAT_RESTART;
-}
 #endif
=20
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2fdbf5e..2e52767 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -771,7 +771,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *reg=
s)
 static inline unsigned long get_nr_restart_syscall(const struct pt_regs *r=
egs)
 {
 #ifdef CONFIG_IA32_EMULATION
-=09if (current_thread_info()->status & TS_COMPAT_RESTART)
+=09if (current->restart_block.arch_data & TS_COMPAT)
 =09=09return __NR_ia32_restart_syscall;
 #endif
 #ifdef CONFIG_X86_X32_ABI
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bba2920..980a655 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -23,6 +23,7 @@ enum timespec_type {
  * System call restart block.
  */
 struct restart_block {
+=09unsigned long arch_data;
 =09long (*fn)(struct restart_block *);
 =09union {
 =09=09/* For futex_wait and futex_wait_requeue_pi */
--=20
2.5.0


