Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F852075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfDPECm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:02:42 -0400
Received: from www.osadl.org ([62.245.132.105]:49136 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfDPECm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:02:42 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3G427M9032015;
        Tue, 16 Apr 2019 06:02:07 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] ARM: mvebu: at least report the kzalloc failure
Date:   Tue, 16 Apr 2019 05:56:31 +0200
Message-Id: <1555386991-8855-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although it is very unlikely that the allocation during init would
fail any such failure should point to the original cause to allow
easier understanding of the ensuing null-pointer dereference splat.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with experimental coccinelle script

V2: Russell King <linux@armlinux.org.uk> pointed out that the use of
    WARN_ON() would result in a stack trace followed by the oops due
    to dereferencing of the NULL pointer and so make it even less
    likely that users would uncover the actual cause - so drop the
    WARN_ON() and use a short pr_err() message that points to the
    oops cause directly.

Note that this will trigger a checkpatch WARNING
"WARNING: Possible unnecessary 'out of memory' message"
but comparing the oops with an without the one-line pr_err I would
argue that it makes sense to include it:
<snip>
[ 8061.514840] shared page allocation failure in hello_init()
[ 8113.563239] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[ 8113.563250] #PF error: [WRITE]
[ 8113.563255] PGD 8000000129993067 P4D 8000000129993067 PUD 129992067 PMD 0
[ 8113.563267] Oops: 0002 [#1] SMP PTI
[ 8113.563276] CPU: 2 PID: 2656 Comm: bash Tainted: G        W  O      5.0.0-rc3livepatchtest-next-20190123+ #4
[ 8113.563280] Hardware name: Quanta TWH/TWH, BIOS QU221 10/14/2011
[ 8113.563292] RIP: 0010:foo_store+0x3a/0x90 [hello_chardev]
...
<snip>

Patch was compile-tested: mvebu_v7_defconfig (implies MACH_MVEBU_ANY=y)
(with some unrelated sparse warnings about missing syscalls)

Patch is against 5.1-rc4 (localversion-next is 20190415)

 arch/arm/mach-mvebu/board-v7.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 0b10acd..df84cb6 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -128,6 +128,9 @@ static void __init i2c_quirk(void)
 		struct property *new_compat;
 
 		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+		if (!new_compat)
+			pr_err("new_compat allocation failure in %s()\n",
+				__func__);
 
 		new_compat->name = kstrdup("compatible", GFP_KERNEL);
 		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
-- 
2.1.4

