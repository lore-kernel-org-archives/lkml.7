Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B260CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C22420679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501883AbfJXMZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:25:58 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:45714 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJXMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:25:57 -0400
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id HQRt210075USYZQ06QRtSn; Thu, 24 Oct 2019 14:25:56 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNcBd-0005rB-2D; Thu, 24 Oct 2019 14:25:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNcBd-00039t-0F; Thu, 24 Oct 2019 14:25:53 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] ARM: Add missing newline terminators to kernel messages
Date:   Thu, 24 Oct 2019 14:25:49 +0200
Message-Id: <20191024122549.12090-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 874f9c7da9a4acbc ("printk: create pr_<level> functions"),
pr_*() calls without a trailing newline characters would be printed with
a newline character appended, both on the console and in the output of
the dmesg command.

After that commit, no new line character is appended, and the output of
the next pr_*() call of the same type may be appended:

    -No ATAGs?
    -hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
    +No ATAGs?hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.

While this commit has been reverted in commit a0cba2179ea4c182 ("Revert
"printk: create pr_<level> functions""), it's still good practice to
terminate kernel messages with newlines.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Dropped changes to code removed in commit 460c82c475f96de6 ("ARM:
    8636/1: Cleanup sanity_check_meminfo"),
  - Included references to 874f9c7da9a4acbc and its reversal in the
    commit description itself,

v2:
  - Rebased.
---
 arch/arm/kernel/atags_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 312cb89ec3648e7a..f7af535f092f038d 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -42,7 +42,7 @@ static int __init init_atags_procfs(void)
 	size_t size;
 
 	if (tag->hdr.tag != ATAG_CORE) {
-		pr_info("No ATAGs?");
+		pr_info("No ATAGs?\n");
 		return -EINVAL;
 	}
 
-- 
2.17.1

