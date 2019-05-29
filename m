Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA883C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBDF241F1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aViAEm0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfE2VQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:16:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41848 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559164610; x=1590700610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6/BBRKinUB4rge6hAORapSWWPFH+YEGVDDiNjrTWJA=;
  b=aViAEm0/NOE5aSc/pPcikzMaIPkw66HZoh8XS2YMaXG3B7iFFGFQqi8E
   nShjXTMgNucKbUBuiX3XDBV+Wtiord8txg86Wsax92LjMCVT5DYwoU4wV
   KfpeLIuatx0T3+TaPzbcuTewcH86KShg84Xk66Wter4E0aeP1w8eHXHNQ
   2bzxsNG5QyHcp4KzMCFr6bJXTDGr/a/xXyuOh9f4xzHKXWmDWJ+5BWvm2
   H7nvFTNWhabwAukdWMCMcgMOUDRknulAXKc72OHxgePRkriW7c+TTfdE1
   JtweMznoO42+8B0QRslToAHOY6+rTMJjt8oQN+2D3n4LFRjn9kNghhqu0
   A==;
X-IronPort-AV: E=Sophos;i="5.60,527,1549900800"; 
   d="scan'208";a="110604133"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2019 05:16:50 +0800
IronPort-SDR: t5AQKp2K2oR4CGuuqxiTs4/RSW3qauz23wxW9cj6aGtIGCdcy8id5Hcby/LJTPI5FQx0qz4c0b
 tQwfenFzx9VOcGDt5Mabb47yavzgZkvD8J9MV8XWadoWvOOeZkgdsO6xb2Nq5hE5NQONKVtdca
 FbB/KOQ8DujoilhZDFuS733ETpDmgxSqeieDTIC2COqyMKcS8f2GwY1Mjx4ggokodLadKZpTHo
 oPaAxUSvnTmwS86cXBmBZPz+9f7iQ8Ln/Tazf4THHMreXHXJoCaucF0SPk5ctgIDroyR62W/Se
 wAgjZZrxrbUosXAOw/Ft/ouJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 May 2019 13:52:00 -0700
IronPort-SDR: AtYWETTfUQbYBogdkAYSQ9pD04Qgx/UBv+7e7JgZLMDSy8je1uswZmLuzGHBuBVOlP9GIKuarN
 EVG63Bzc1dznWiALKhS790djk1hjza3hs0FBXbCFeETWKPPZG8+GdQGKOepq3o9LP1t6kOuit3
 vpcn0jy2WV2CpCwHXQMUcLJRzP4PVH6LZMIbT6KA2P8cn34CJjqc68GQbK6hNBdxKF0uHk0uWB
 cnpyuhVgsdf2EaU3Etyc82a0IK/bY9SCTlHQenWjPwXcU+T/zQQcQgSEzw2dKItxYw0Ba+LMHc
 3CY=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 May 2019 14:16:49 -0700
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
        Jeremy Linton <jeremy.linton@arm.com>,
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
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 7/7] MAINTAINERS: Add an entry for generic architecture topology
Date:   Wed, 29 May 2019 14:13:40 -0700
Message-Id: <20190529211340.17087-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529211340.17087-1-atish.patra@wdc.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
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
index 429c6c624861..f0b72ed51e22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6583,6 +6583,13 @@ W:	https://linuxtv.org
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

