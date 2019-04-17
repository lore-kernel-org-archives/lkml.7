Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881DBC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0FF20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ctGvaGUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbfDQMiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:38:20 -0400
Received: from m15-112.126.com ([220.181.15.112]:49437 "EHLO m15-112.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfDQMiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gmCJs
        j1+c7WIUQvfshADQT5R+2RGaGeIXR2yM3rWD2s=; b=ctGvaGUHtOuRjDiC0/wAZ
        LOI/zkkOlwk73u9xOS14JvVq1g1kX4NYhAkCEG9R7OfbbV5+nf+qKVaA3U7jx6bg
        i+ZNgOSNSJ2u9ghQlodT6XxAfiEPoCpaRH8alimusyFEmpMEBWGCiC9nBaLWAInQ
        Yry+mgSHUGl6Jh7UBiZUVA=
Received: from zby-ThinkPad-E480.192.168.117 (unknown [218.17.115.198])
        by smtp2 (Coremail) with SMTP id DMmowAA3FnvVHbdcTmFUAQ--.50586S3;
        Wed, 17 Apr 2019 20:36:40 +0800 (CST)
From:   Boyang Zhou <zhouby_cn@126.com>
To:     catalin.marinas@arm.com
Cc:     will.deacon@arm.com, haozhu@nudt.edu.cn, mark.rutland@arm.com,
        linux@dominikbrodowski.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Boyang Zhou <zhouby_cn@126.com>
Subject: [PATCH] =?UTF-8?q?The=20patch=20solves=20the=20type=20error=20=20?= =?UTF-8?q?of=20the=20parameter=20=E2=80=9Coff=E2=80=9D=20in=20syscall=20m?= =?UTF-8?q?map=20on=20the=20ARM64=20platform.?=
Date:   Wed, 17 Apr 2019 20:35:25 +0800
Message-Id: <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAA3FnvVHbdcTmFUAQ--.50586S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUGw18uF4ftrWrurWDXFb_yoW8Gw1fpa
        10gw1kKrs7Wa40ka47Cw1rW3yUCas0va1jgFsrtryYk34YqF98XF9xX3s8GrWxAry8ZayY
        v34Y9r15KFs8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDyCJUUUUU=
X-Originating-IP: [218.17.115.198]
X-CM-SenderInfo: p2kr3uh1bf0qqrswhudrp/1tbiZh+ZO1pD6JkvywAAsX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error information is that “offset value too large for defined data type”.
Reason:
On the X86 platform, the data type of “off" is unsigned long; but on the ARM64 platform, the data type is defined as off_t, and off_t is by type long instead of unsigned long.
When the off right shifts in the function “sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT)"on ARM64, high address of off is filled with sign bit 1instead of 0.
In our case, we mmap GPU doorbell on both platform. On the x86 platform, the value of off is f009c00000000000, after shift the value becomes f009c00000000; while on the ARM64, the value of off changes from ed35c00000000000 to fffed35c00000000. This value is treated as unsigned long in later functions. So it is too big for off and the error happened.
We have tested the patchs in Huawei ARM64 server with a couples of AMD GPUs.

Signed-off-by: Boyang Zhou <zhouby_cn@126.com>
---
 arch/arm64/kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index b44065f..6f91e81 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -31,7 +31,7 @@
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
-		unsigned long, fd, off_t, off)
+		unsigned long, fd, unsigned long, off)
 {
 	if (offset_in_page(off) != 0)
 		return -EINVAL;
-- 
2.7.4

