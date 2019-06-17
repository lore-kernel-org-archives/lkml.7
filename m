Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9361FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6942D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EKmfXpL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfFQTBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:01:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59831 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560798061; x=1592334061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=41zR8QjGMqwDXm/EOxIo4VhtiejJSwkpc8NiWlOpJ0o=;
  b=EKmfXpL7QA9KpvaBunhOEYkMXhcuYgxnYw/5yMyJNmZ89KmCKpiLqffl
   i46ULg94aQNPjhbOM2gi4sIpnQEMxAFgG8FVKFmCTDbd2bqh05REjCPgx
   q89rdZ+Op4B8TfLdouE5ScXeSPbnvyDrt64h3wm4DAYuB5JZ+2m7RbYdk
   4R23N3jy+IsPOocHkO0D5skPAqnQNU+rCGo3jdPtzCo27fY/Nlzbb2RNX
   QkzxnswsW3augTTHvPC43/cnR2mRi5acYEuET5uRXT30ZnSxypn6rM4N6
   QOb0gSNYtGFFwdr91XZA6Ci50rIcF/1Eh/l3STg14pY0iRU9RPQKXRLS+
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; 
   d="scan'208";a="115695482"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 03:01:01 +0800
IronPort-SDR: spOuXSxRrjdAUR5Mf+tol6cicoxFy6dFp37yEtiIA1Nch8T1ddPewPRTfcSswfnmbGLgpN/qx+
 IQ6FwWZovP0BY5luNPn8kEm15kpGFQxoIA/wZwLsRvZ9cTNPgLuLtZeSFbE7PyyDowR0owe1r5
 qpi0XDaV42LK0wN7tg6bbFK/DmCDh37TX6erD7819+m0gidSeCLrFHZQH/hE4o+7tD1DrPqYtH
 skEMgKm2cdvCAhERy2SRCVxnOGnQaObZeH35sqCG6EaOSe7wDrdDU9kODS1H63VH3h87g0bP0A
 rmIoNafpStXSRnP5ksLBDWRD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 17 Jun 2019 12:00:34 -0700
IronPort-SDR: 5sUm89DLg86LTT++XMnEPR2jSdCE5MaQwfzr9HlRyf5iwKcy5zp28LRQQmd7TMxYAuZ1fNw30B
 459ZfbJFgwAVTKPs9nKxf1E4+lNKOaJVP0Fbr1Yl8K53d+JwBG5UWpUhzutPjcVT00hrkMYbdG
 Cae24DcFXM/uWBZR+PMIxGlEABrADVP8zbX2hGZgBNTHWXNel5CKyP9nufYJTM0aVyKGU9YlGZ
 CB93X6sU8FPK1IiwanicqFZIv/1vK9c/aeMY4WWXxRmO5T/cxXgiCdE69aDS0+1RIJBuY8Qv9J
 vsM=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2019 12:00:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v7 7/7] MAINTAINERS: Add an entry for generic architecture topology
Date:   Mon, 17 Jun 2019 11:59:20 -0700
Message-Id: <20190617185920.29581-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617185920.29581-1-atish.patra@wdc.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

arm and arm64 shared lot of CPU topology related code. This was
consolidated under driver/base/arch_topology.c by Juri. Now RISC-V
is also started sharing the same code pulling more code from arm64
into arch_topology.c

Since I was involved in the review from the beginning, I would like
to assume maintenance for the same.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..c6f7d7152f01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6595,6 +6595,13 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-gemtek*
 
+GENERIC ARCHITECTURE TOPOLOGY
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/base/arch_topology.c
+F:	include/linux/arch_topology.h
+
 GENERIC GPIO I2C DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 S:	Supported
-- 
2.21.0

