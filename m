Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4D4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CA92176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sp8JNkZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLRVjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:39:37 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31480 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfLRVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576705177; x=1608241177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v8HddCjwnP5FyVMQJWro7VQJAFHYljHP5zq5vtrPivM=;
  b=Sp8JNkZ/xrW7enio0QzZeMK7DS2PCJf3TfNU/gP4EhEerPFRkN1KJQsA
   TdZPnZc169lh8LVkSZ+5RE984k6AWAsZPXs6/CLbZFlp0lzRrCyzbe6Ms
   wP+eU4qfc4lGCfoE8qYNvIBoTvfuRg0amNOMXfPuDGFNck+skOderb28S
   lZ8cqaIS8vM3zXAo0hBXIK3RropYTUpi3FxXNI5V0mrQLNmIPV8oW1+1m
   dNRe4TTWc7dZ7C56f1RqzaC6YXnO0EHvGo7h/puLvlMgg91pev7OQ7AuA
   JrkuRt72JijImgCtIpRbNUTC//dTCKu4WxXtYbcGSBL9jSZ4Fx1IzpLpb
   g==;
IronPort-SDR: 9Ko5r1tykZb5FjOXG/Pbg66YvdaS1NIz+wM9yKH0k18q0j+bUK+vE97UqA83qoVUXIA+fDCa1Y
 KeLON331YVrDUXrv7JfoKyAZTNyCsSq4BUVnW0oxSdBoSmUL9MK7ScvqWWTT6ZLWoUrkmM/bnP
 KmXW0CU8l+Y59Tidll+Z5ihLcr8eomYQs8GgQDuh4pY/yeCwpSb0jCWm5r8daGv7E93K001Ugy
 2KhabSoM4ugFY0ysqBckH9XBvlMllY1qN9v5rNz2whKQlVOU9vyu88Ipx1JBR5JH3g+clHQBZS
 cIc=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; 
   d="scan'208";a="127281457"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 05:39:36 +0800
IronPort-SDR: 3tUIxcdGlPo6rW9f/ZbC+0s8R6WFSwdExDV1cluiQYn5looYzTWsrVn72IwFzSYsRUzqGNzCPv
 VJmN2HhamBSN+Zk+4J//rA76IgTDuVBHA+gxyeO3DbF9h6yav0Zy0E6gbyceqDdQk7zoGKrbLM
 xP9klHlM+TfDfhUfTYmtnDTaXYyDtQ06wTdm/Q+nsBSPda+ANKxjUC9LaJ+p9c2SIJE1iPBBF+
 877MKGECg8UHKM7CenXBe9OAemlhm4CsFnrd3Vh/Z7GDWcO32YrjGOjISMZAsu8qOawRKBh3zv
 z6Fje0JSFJiSYGfQmbXmP40i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 13:33:38 -0800
IronPort-SDR: i0GqJ4pvI0E4KdQ8DBhp9xHtwyGFGQIfO6P/FJjeFmfzdP4+6zCQRFX5AYhGSTLZSkfT0sy0Bh
 6Ouq1QqLqLUU0dEfGIlUFDGqsSt4QbKvxO4JyFujBxvAximyunKqIkXP0oAvRoppb2nOHVwXLl
 jzksbZwneDPELVbeOaKVlGmHycKvZoReXgz0YS7A0zc9XjPNaxdh/d8RUr9gsia9W3FHnyqZ5X
 lPljjLCnEuEog2k/j2o2tTWFqaHaPiBhOh0npZIdliOrX4ZcexdwgqDl3AhHMM+pJ1fn3aZ63l
 ego=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Dec 2019 13:39:37 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v6 0/5] Add support for SBI v0.2 
Date:   Wed, 18 Dec 2019 13:39:13 -0800
Message-Id: <20191218213918.16676-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Supervisor Binary Interface(SBI) specification[1] now defines a
base extension that provides extendability to add future extensions
while maintaining backward compatibility with previous versions.
The new version is defined as 0.2 and older version is marked as 0.1.


This series adds support v0.2 and a unified calling convention
implementation between 0.1 and 0.2. It also add other SBI v0.2
functionality defined in [2]. The base support for SBI v0.2 is already
available in OpenSBI v0.5. This series needs additional patches[3] in
OpenSBI. 

Tested on both BBL, OpenSBI with/without the above patch series. 

[1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://github.com/riscv/riscv-sbi-doc/pull/27
[3] http://lists.infradead.org/pipermail/opensbi/2019-November/000738.html

Changes from v5->v6
1. Fixed few compilation issues around config.
2. Fixed hart mask generation issues for RFENCE & IPI extensions.

Changes from v4->v5
1. Fixed few minor comments related to static & inline.
2. Make sure that every patch is boot tested individually.

Changes from v3->v4.
1. Rebased on for-next.
2. Fixed issuses with checkpatch --strict.
3. Unfied all IPI/fence related functions.
4. Added Hfence related SBI calls.

Changes from v2->v3.
1. Moved v0.1 extensions to a new config.
2. Added support for relacement extensions of v0.1 extensions.

Changes from v1->v2
1. Removed the legacy calling convention.
2. Moved all SBI related calls to sbi.c.
3. Moved all SBI related macros to uapi.

Atish Patra (5):
RISC-V: Mark existing SBI as 0.1 SBI.
RISC-V: Add basic support for SBI v0.2
RISC-V: Add SBI v0.2 extension definitions
RISC-V: Introduce a new config for SBI v0.1
RISC-V: Implement new SBI v0.2 extensions

arch/riscv/Kconfig           |   6 +
arch/riscv/include/asm/sbi.h | 178 +++++++-----
arch/riscv/kernel/sbi.c      | 522 ++++++++++++++++++++++++++++++++++-
arch/riscv/kernel/setup.c    |   2 +
4 files changed, 635 insertions(+), 73 deletions(-)

--
2.24.0

