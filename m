Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A153DC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DEC2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207628;
	bh=QHYJhSEipdE/rN48jgEvQ9kYkDbe97frh8T5Aa0FxHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bJWga8lNZH76YsZm/wI5Z+RJ880N/8wTARQt73PjRrW7D/gYLeaTW1D5HycGeDRfU
	 wbX7jA4QHZ+WPGKG5zpQ59EQGNFsO8J55suuprIDv9qNgBecJEUTUzqnUrisiq4uT8
	 hBt/9c2V6jqU0gI87hvErBVhjNkpL0/Y8OXH6Iec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfEGFk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfEGFkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C97C20675;
        Tue,  7 May 2019 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207618;
        bh=QHYJhSEipdE/rN48jgEvQ9kYkDbe97frh8T5Aa0FxHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dl9KccCazJdMyVfJPS3NONLamcTMuA5CXlx8tDg2708Q5PLO334nQmxoZBoUEeeFx
         fHdTZRa8sqQ7pQh4w1UqMq/ZL0TJX7tIdIAQuka/iO7RufjvV+OqzMxmPQZw1PIRg6
         QVNtRQTQq0hLa6mX+kpIzSmG4Xr8ukbMB8M6hiU4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alistair Strachan <astrachan@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Borislav Petkov <bp@suse.de>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, Thomas Gleixner <tglx@linutronix.de>,
        X86 ML <x86@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 60/95] x86/vdso: Pass --eh-frame-hdr to the linker
Date:   Tue,  7 May 2019 01:37:49 -0400
Message-Id: <20190507053826.31622-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Strachan <astrachan@google.com>

[ Upstream commit cd01544a268ad8ee5b1dfe42c4393f1095f86879 ]

Commit

  379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")

accidentally broke unwinding from userspace, because ld would strip the
.eh_frame sections when linking.

Originally, the compiler would implicitly add --eh-frame-hdr when
invoking the linker, but when this Makefile was converted from invoking
ld via the compiler, to invoking it directly (like vmlinux does),
the flag was missed. (The EH_FRAME section is important for the VDSO
shared libraries, but not for vmlinux.)

Fix the problem by explicitly specifying --eh-frame-hdr, which restores
parity with the old method.

See relevant bug reports for additional info:

  https://bugzilla.kernel.org/show_bug.cgi?id=201741
  https://bugzilla.redhat.com/show_bug.cgi?id=1659295

Fixes: 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
Reported-by: Florian Weimer <fweimer@redhat.com>
Reported-by: Carlos O'Donell <carlos@redhat.com>
Reported-by: "H. J. Lu" <hjl.tools@gmail.com>
Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: kernel-team@android.com
Cc: Laura Abbott <labbott@redhat.com>
Cc: stable <stable@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: X86 ML <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181214223637.35954-1-astrachan@google.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 839015f1b0de..ab7f730cf7f2 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -182,7 +182,8 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
-	$(call ld-option, --build-id) -Bsymbolic
+	$(call ld-option, --build-id) $(call ld-option, --eh-frame-hdr) \
+	-Bsymbolic
 GCOV_PROFILE := n
 
 #
-- 
2.20.1

