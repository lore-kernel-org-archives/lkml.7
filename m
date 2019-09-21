Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE467C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 13:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D7C208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 13:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CJjuHNf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437932AbfIUNFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 09:05:30 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:51948 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405958AbfIUNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 09:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=w0t/w
        YDFIo3k1zk7BQGWh+CvPwbHogEVFBzHqTKZ5w0=; b=CJjuHNf0ggvPC7hWoYCCK
        VZMFFp7n8GrCeR+XFutCXHDMxS0LSp1z465CtQF5k/IE99lJXQur2+u3mNcFZ6s4
        +1SDpMXabasf+0oHrYaQnTTTrNoxF5wLwrw+Wk2r5B5chbOWxQOYf3XaoftfYJVN
        0BXGFWlM6LRPA7lTtTWNJk=
Received: from localhost.localdomain (unknown [101.206.228.127])
        by smtp3 (Coremail) with SMTP id G9xpCgD3ps_3H4Zd6P8gAw--.89S2;
        Sat, 21 Sep 2019 21:04:57 +0800 (CST)
From:   Yu Chen <33988979@163.com>
To:     rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yu.chen3@zte.com.cn
Subject: [PATCH] arm: export memblock_reserve()d regions via /proc/iomem
Date:   Sat, 21 Sep 2019 21:02:49 +0800
Message-Id: <1569070969-5168-1-git-send-email-33988979@163.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgD3ps_3H4Zd6P8gAw--.89S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4rAr1UKFW7AFW7Kry3Jwb_yoW8tw1kpw
        47Zw1Ygr48Gr1xXa93Ar1UuFs5Z3WIvrW3WrW3trWfZa1Dtr17Jr10qryj9Fyav3yxKr1a
        vr1vyFWI93yUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-4SrUUUUU=
X-Originating-IP: [101.206.228.127]
X-CM-SenderInfo: attzmmqzxzqiywtou0bp/1tbiKxk3slQHRUSb3AAAsi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <yu.chen3@zte.com.cn>

memblock reserved regions are not reported via /proc/iomem on ARM, kexec's
user-space doesn't know about memblock_reserve()d regions and thus
possible for kexec to overwrite with the new kernel or initrd.

[    0.000000] Booting Linux on physical CPU 0xf00
[    0.000000] Linux version 4.9.115-rt93-dirty (yuchen@localhost.localdomain) (gcc version 6.2.0 (ZTE Embsys-TSP V3.07.2
0) ) #62 SMP PREEMPT Fri Sep 20 10:39:29 CST 2019
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=30c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: LS1021A TWR Board
[    0.000000] INITRD: 0x80f7f000+0x03695e40 overlaps in-use memory region - disabling initrd

Signed-off-by: Yu Chen <yu.chen3@zte.com.cn>
Reviewed-by: Junhua Huang <huang.junhua@zte.com.cn>
---
 arch/arm/kernel/setup.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d0a464e..606d1ac 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -911,6 +911,34 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 		request_resource(&ioport_resource, &lp2);
 }
 
+static int __init reserve_memblock_reserved_regions(void)
+{
+	u64 i, j;
+
+	for (i = 0; i < num_standard_resources; ++i) {
+		struct resource *mem = &standard_resources[i];
+		phys_addr_t r_start, r_end, mem_size = resource_size(mem);
+
+		if (!memblock_is_region_reserved(mem->start, mem_size))
+			continue;
+
+		for_each_reserved_mem_region(j, &r_start, &r_end) {
+			resource_size_t start, end;
+
+			start = max(PFN_PHYS(PFN_DOWN(r_start)), mem->start);
+			end = min(PFN_PHYS(PFN_UP(r_end)) - 1, mem->end);
+
+			if (start > mem->end || end < mem->start)
+				continue;
+
+			reserve_region_with_split(mem, start, end, "reserved");
+		}
+	}
+
+	return 0;
+}
+arch_initcall(reserve_memblock_reserved_regions);
+
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE) || \
     defined(CONFIG_EFI)
 struct screen_info screen_info = {
-- 
2.7.4

