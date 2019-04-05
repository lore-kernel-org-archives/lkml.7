Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB64C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB34218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jzOKIbb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfDENaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:30:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfDENaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:30:23 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 251601EC0B4B;
        Fri,  5 Apr 2019 15:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554471022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVCYPMUF/s+LCEf1aaC9/FI55Ra37pX7sIXRW94DiLU=;
        b=jzOKIbb/6FyyBDEzmYAoljfGor9eTYKGuLxurYiItd8MiXbI5oa0IZdkH7y4ZGOCs84eGw
        cTE/26Vm2eoyy9NzB5jR6NC4NDA/7jLDleKNFS3WiYRKp4vuCdahlfJyUyY1Tpf/hVRzkQ
        /9S/Ir9w2/EgAM7q2xdlosa+4i/vi/M=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>
Subject: [PATCH 2/3] x86/microcode: Fix the ancient deprecated microcode loading method
Date:   Fri,  5 Apr 2019 15:30:09 +0200
Message-Id: <20190405133010.24249-3-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405133010.24249-1-bp@alien8.de>
References: <20190405133010.24249-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The commit in Fixes: added the new define UCODE_NEW to denote that an
update should happen only when newer microcode (than installed on the
system) has been found.

But it missed adjusting that for the old /dev/cpu/microcode loading
interface. Fix it.

Fixes: 2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 5260185cbf7b..8a4a7823451a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -418,8 +418,9 @@ static int do_microcode_update(const void __user *buf, size_t size)
 		if (ustate == UCODE_ERROR) {
 			error = -1;
 			break;
-		} else if (ustate == UCODE_OK)
+		} else if (ustate == UCODE_NEW) {
 			apply_microcode_on_target(cpu);
+		}
 	}
 
 	return error;
-- 
2.21.0

