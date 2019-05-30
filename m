Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6C6C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2624C66
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187854;
	bh=DjLObwZZ+RDNqaf2WeRU/ZKKUnJDXzMdktihC5/aKoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oTwh8CKz0BdRSV7rG7iHH9402AVUMQp8SVStYcUIdIdXwdsrKo5C9maV2MMYMVS0o
	 3l76bJT+T50SyUw9/sKX85xc+kNGjl+HX8l9Q5iT+2reZRp2zJ262EdJE6XOz4MlAE
	 zRdIhB/yOz8oXtYA+z+o2TJUAiJRO4pPKr/olUo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfE3DoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732403AbfE3DVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:00 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0321A249A6;
        Thu, 30 May 2019 03:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186460;
        bh=DjLObwZZ+RDNqaf2WeRU/ZKKUnJDXzMdktihC5/aKoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eqt77iyIb0Z458qo1BHDxxRfJsjqDlNW4+IDt/1jZeEAvouM/z9HL0HVt/cSkvC4B
         UjZ7qf2WmHBHjHiG5G8hwvl6tYkPKJuIUg0MfUf7TaUvMQxBksYLkHHE3ft/luM8+W
         fYan79ZJ/Pal55D5ZHTGevkVPGlv1VNsK01vd9Bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 076/128] hwmon: (f71805f) Use request_muxed_region for Super-IO accesses
Date:   Wed, 29 May 2019 20:06:48 -0700
Message-Id: <20190530030448.301170316@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 73e6ff71a7ea924fb7121d576a2d41e3be3fc6b5 ]

Super-IO accesses may fail on a system with no or unmapped LPC bus.

Unable to handle kernel paging request at virtual address ffffffbffee0002e
pgd = ffffffc1d68d4000
[ffffffbffee0002e] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 94000046 [#1] PREEMPT SMP
Modules linked in: f71805f(+) hwmon
CPU: 3 PID: 1659 Comm: insmod Not tainted 4.5.0+ #88
Hardware name: linux,dummy-virt (DT)
task: ffffffc1f6665400 ti: ffffffc1d6418000 task.ti: ffffffc1d6418000
PC is at f71805f_find+0x6c/0x358 [f71805f]

Also, other drivers may attempt to access the LPC bus at the same time,
resulting in undefined behavior.

Use request_muxed_region() to ensure that IO access on the requested
address space is supported, and to ensure that access by multiple
drivers is synchronized.

Fixes: e53004e20a58e ("hwmon: New f71805f driver")
Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reported-by: John Garry <john.garry@huawei.com>
Cc: John Garry <john.garry@huawei.com>
Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/f71805f.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index facd05cda26da..e8c0898864277 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -96,17 +96,23 @@ superio_select(int base, int ld)
 	outb(ld, base + 1);
 }
 
-static inline void
+static inline int
 superio_enter(int base)
 {
+	if (!request_muxed_region(base, 2, DRVNAME))
+		return -EBUSY;
+
 	outb(0x87, base);
 	outb(0x87, base);
+
+	return 0;
 }
 
 static inline void
 superio_exit(int base)
 {
 	outb(0xaa, base);
+	release_region(base, 2);
 }
 
 /*
@@ -1561,7 +1567,7 @@ static int __init f71805f_device_add(unsigned short address,
 static int __init f71805f_find(int sioaddr, unsigned short *address,
 			       struct f71805f_sio_data *sio_data)
 {
-	int err = -ENODEV;
+	int err;
 	u16 devid;
 
 	static const char * const names[] = {
@@ -1569,8 +1575,11 @@ static int __init f71805f_find(int sioaddr, unsigned short *address,
 		"F71872F/FG or F71806F/FG",
 	};
 
-	superio_enter(sioaddr);
+	err = superio_enter(sioaddr);
+	if (err)
+		return err;
 
+	err = -ENODEV;
 	devid = superio_inw(sioaddr, SIO_REG_MANID);
 	if (devid != SIO_FINTEK_ID)
 		goto exit;
-- 
2.20.1



