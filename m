Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1102C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C5205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413930;
	bh=1tqwP6ZmT9pyoF5lTfbMdEg+7hy6VWcWe59fJ+ueb2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wO9Bm1zKO+1yb2TOj7P84V5re/rnAi8v/KgXW2Up+vwt0lfgTjE4T5jpEVrC6rr9C
	 Dl0QaOD6BJ+KtU5RKyfqsYumaBbZse+al/xFi4sfrcTmVm9fPbG5LnWIDUhhRuB/Gy
	 CEv4miDJjy2CedoSOkc5RzAEaeQoTsbnZqNSeO3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfCLRMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbfCLRMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:16 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF02206DF;
        Tue, 12 Mar 2019 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410735;
        bh=1tqwP6ZmT9pyoF5lTfbMdEg+7hy6VWcWe59fJ+ueb2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xm1RdGLkSuLY3YL0m/qyHaWETd7yu4YpcK2RiMzSUG3+tjZRAd/MHxazb79z5UVM4
         6iJZr1nOxcK++KXgZmTXwxiTq6sadhMmKC6xnH+Un41Psjfbbuoq/ADC5QKhZsDOVL
         q0UfqHVfDVM385HpE5x5JYZNmH9bnruZdgcSOtCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 056/171] x86/microcode/amd: Dont falsely trick the late loading mechanism
Date:   Tue, 12 Mar 2019 10:07:16 -0700
Message-Id: <20190312170352.966350589@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 912139cfbfa6a2bc1da052314d2c29338dae1f6a ]

The load_microcode_amd() function searches for microcode patches and
attempts to apply a microcode patch if it is of different level than the
currently installed level.

While the processor won't actually load a level that is less than
what is already installed, the logic wrongly returns UCODE_NEW thus
signaling to its caller reload_store() that a late loading should be
attempted.

If the file-system contains an older microcode revision than what is
currently running, such a late microcode reload can result in these
misleading messages:

  x86/CPU: CPU features have changed after loading microcode, but might not take effect.
  x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.

These messages were issued on a system where SME/SEV are not
enabled by the BIOS (MSR C001_0010[23] = 0b) because during boot,
early_detect_mem_encrypt() is called and cleared the SME and SEV
features in this case.

However, after the wrong late load attempt, get_cpu_cap() is called and
reloads the SME and SEV feature bits, resulting in the messages.

Update the microcode level check to not attempt microcode loading if the
current level is greater than(!) and not only equal to the current patch
level.

 [ bp: massage commit message. ]

Fixes: 2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/154894518427.9406.8246222496874202773.stgit@tlendack-t1.amdoffice.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 07b5fc00b188..a4e7e100ed26 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -707,7 +707,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 	if (!p) {
 		return ret;
 	} else {
-		if (boot_cpu_data.microcode == p->patch_id)
+		if (boot_cpu_data.microcode >= p->patch_id)
 			return ret;
 
 		ret = UCODE_NEW;
-- 
2.19.1



