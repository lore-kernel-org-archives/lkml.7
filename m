Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B830C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D658120830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDJUuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:50:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJUuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:50:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3AKnvSF929555
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 13:49:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3AKnuR0929552;
        Wed, 10 Apr 2019 13:49:56 -0700
Date:   Wed, 10 Apr 2019 13:49:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-24613a04ad1c0588c10f4b5403ca60a73d164051@git.kernel.org>
Cc:     tglx@linutronix.de, jannh@google.com, linux-kernel@vger.kernel.org,
        bp@suse.de, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, bp@suse.de,
          linux-kernel@vger.kernel.org, jannh@google.com,
          tglx@linutronix.de
In-Reply-To: <20190405133010.24249-3-bp@alien8.de>
References: <20190405133010.24249-3-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode: Fix the ancient deprecated
 microcode loading method
Git-Commit-ID: 24613a04ad1c0588c10f4b5403ca60a73d164051
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

Commit-ID:  24613a04ad1c0588c10f4b5403ca60a73d164051
Gitweb:     https://git.kernel.org/tip/24613a04ad1c0588c10f4b5403ca60a73d164051
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 4 Apr 2019 22:14:07 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 22:41:24 +0200

x86/microcode: Fix the ancient deprecated microcode loading method

Commit

  2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")

added the new define UCODE_NEW to denote that an update should happen
only when newer microcode (than installed on the system) has been found.

But it missed adjusting that for the old /dev/cpu/microcode loading
interface. Fix it.

Fixes: 2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Link: https://lkml.kernel.org/r/20190405133010.24249-3-bp@alien8.de
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
