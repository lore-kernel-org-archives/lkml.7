Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB90C73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFD021537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DAePqwMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfGIMqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:46:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36091 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIMqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:46:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69CkDjL1917659
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 05:46:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69CkDjL1917659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562676373;
        bh=U/vVBHXOEkI3YW6CYUzVqwbbM4lrp80ZngJftIrF8aM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DAePqwMINK0JUQJEyeww02fCph2N/S/lwrdSrWJhAuZta8A+bGlstpRj0c8YzssVl
         EEhY6G1yKG0WuL8cmAJYWBwCpiP3nck4A5SWbPkLh/0bXekR4Q6FWtoJNCUZmHN/m5
         tBwxgHZyLJdZBhfAmm0ISgQ+W9wmU5hmaRhKftq3OjmOU821vEmx84S6vkuxBn8UGu
         nfTBQmMIiEMOE0UUkh9SmbzkzMdImKfUS1LBlVztEKQz16XuakYSfhiXT5B8ev0reQ
         Hkd/SF6jlGpMIwXmvf8yJF7XzZX8SFcRGz2vnVTunjmFwNrxCeKbBB1FhJpk+xzRvv
         FkhRW8aV6P87w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69CkClK1917656;
        Tue, 9 Jul 2019 05:46:12 -0700
Date:   Tue, 9 Jul 2019 05:46:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Slaby <tipbot@zytor.com>
Message-ID: <tip-1cbec37b3f9cff074a67bef4fc34b30a09958a0a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, jslaby@suse.cz
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jslaby@suse.cz,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190709063402.19847-1-jslaby@suse.cz>
References: <20190709063402.19847-1-jslaby@suse.cz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/32: Fix ENDPROC of common_spurious
Git-Commit-ID: 1cbec37b3f9cff074a67bef4fc34b30a09958a0a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1cbec37b3f9cff074a67bef4fc34b30a09958a0a
Gitweb:     https://git.kernel.org/tip/1cbec37b3f9cff074a67bef4fc34b30a09958a0a
Author:     Jiri Slaby <jslaby@suse.cz>
AuthorDate: Tue, 9 Jul 2019 08:34:02 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 9 Jul 2019 14:41:03 +0200

x86/entry/32: Fix ENDPROC of common_spurious

common_spurious is currently ENDed erroneously. common_interrupt is used
in its ENDPROC. So fix this mistake.

Found by my asm macros rewrite patchset.

Fixes: f8a8fe61fec8 ("x86/irq: Seperate unused system vectors from spurious entry again")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190709063402.19847-1-jslaby@suse.cz

---
 arch/x86/entry/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 1285e5abf669..90b473297299 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1189,7 +1189,7 @@ common_spurious:
 	movl	%esp, %eax
 	call	smp_spurious_interrupt
 	jmp	ret_from_intr
-ENDPROC(common_interrupt)
+ENDPROC(common_spurious)
 #endif
 
 /*
