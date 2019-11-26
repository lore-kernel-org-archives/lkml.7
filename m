Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8F52071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MAEPbFL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKZDUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:20:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55206 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfKZDUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574738438; x=1606274438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eDrvdWoX56lIvIiL0slSmxVvIPiwPhCbEp2UPD0kflw=;
  b=MAEPbFL9zU/W4SVk/7C+BMtotGlZJA4h+VVTAc22Pe51NECj7mdwCo2J
   +zXvi+QwvlrsQsHAn7kNrEnuxXk80ird896gDUaY6RyJX9IqvS9fx4kIT
   P9iNnFLp6xcbhHJv08zZNH7LHu0HMK+t1abZLP0e8Q2TWfiNmZyW4vdUH
   81tB3k+rRmlNINwWtqhVnv1KzuitZi1B+aG8rFisaNqrOUTB1dLrk3DgE
   uyYCMVXtrIqPieW1W5e+04Je89jFbXcUFzTMPcXmf899fsUmovTIUCM2X
   TFaG6EDa4wyMYFdHJqrbFGM+dJJkpoKBTSmi3uMzityJJx073nGFnJNoG
   A==;
IronPort-SDR: 2bWRc/45PlZcF9Zrt+pD56DKMYl7Ub8t9p99Ms8YWyuNRrE7y1AByniEbwr4RvwI5Xdwxppv1L
 XOBYx7FaZH8oT68Ib0WsFvAzpRN6Vmno+z8FcD19v+r+zOK6TAhamF4ierTb1qPP1Q+SotI+2v
 VHACcAAPdrZIpmwMGEa7PPNXlH3+3Vs7If0rLSGrH1e3hrufWb9ykVCyZIrL0fPuSTyg3+U/YT
 TLxr/Wvd2n7JEPkkxeDsRAZFWrS2oItvvJZgO+l4H3Ua9izsASHMcjNDXuoJmZZ0o7WF6wkByN
 4GE=
X-IronPort-AV: E=Sophos;i="5.69,244,1571673600"; 
   d="scan'208";a="124761535"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 11:20:38 +0800
IronPort-SDR: now/NGL7huBmQnbG7MW49CeiKa8HL2+E5VkrsIowPQoNG5XocMT2chaEMICkPgDYSLwZMyFM/4
 jqVMFvD9GV01qNJlFv+HqRk7q+XelmJoKE7vGQfiaH2aVw2XTZtXadPG4hSzE89T2P6NlaAqN+
 cPa3O7a7Vi6aHGL0HAYT6hroJEOPlelXTEpLzK7n+VniAlrmuvYUv2pn0YE0N/SoutwyyBI7w9
 h6rtzpAEq4fvZvig13V+XCQ6cQ0y3Ise10rMt54ilSDCHuLmRJ6A5zUXaj+1/ooy5zifZ5CcyO
 YTlcrXWK+ygApuYnkWN9YcMq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 19:15:16 -0800
IronPort-SDR: ksi4hFv4hatdCMU7Za+gnR+Vhiop5cIzfaAdcrQvuWF0SxfjSgcdUvSmVlU+bqykEtNjZ4D7Dw
 rroMOu8Ndu8NqV7JFNZRUluRG5HQj1tWGrEinUZgkHc5+1cO7gUq5CTE6nP4tYVA9AvvomPcPQ
 AMAuP2oE0HKLfYdDGN+3Kqt7YUUC8dn+mcO/FZymCkxLw4BIaJmgrvNKND6ej5SKBco5ksHXLc
 zZuFEn17SIq0WPoYu9g/QCkDUaE6jt+76NzRB0a9oBgmnHcIHdYKHAokdEVjI0y9YyeisXSlta
 G18=
WDCIronportException: Internal
Received: from usa003951.ad.shared (HELO yoda.hgst.com) ([10.86.50.226])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2019 19:20:37 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 0/4] Add support for SBI v0.2 
Date:   Mon, 25 Nov 2019 19:20:29 -0800
Message-Id: <20191126032033.14825-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.23.0
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
implementation between 0.1 and 0.2. It also adds minimal SBI functions
from 0.2 as well to keep the series lean. 

[1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc

The base support for SBI v0.2 is already available in OpenSBI v0.5.
This series needs following additional patches in OpenSBI. 

http://lists.infradead.org/pipermail/opensbi/2019-November/000704.html

Tested on both BBL, OpenSBI with/without the above patch series. 

Changes from v3->v4.
1. Rebased on top of for-next.
2. Fixed issuses with checkpatch --strict.
3. Unfied all IPI/fence related functions.
4. Added Hfence related SBI calls.
5. Moved to function pointer based boot time switch between v01 and v02 calls.
Changes from v2->v3.
1. Moved v0.1 extensions to a new config.
2. Added support for relacement extensions of v0.1 extensions.

Changes from v1->v2
1. Removed the legacy calling convention.
2. Moved all SBI related calls to sbi.c.
3. Moved all SBI related macros to uapi.

Atish Patra (4):
RISC-V: Mark existing SBI as 0.1 SBI.
RISC-V: Add basic support for SBI v0.2
RISC-V: Introduce a new config for SBI v0.1
RISC-V: Implement new SBI v0.2 extensions

arch/riscv/Kconfig           |   6 +
arch/riscv/include/asm/sbi.h | 177 +++++++-----
arch/riscv/kernel/Makefile   |   1 +
arch/riscv/kernel/sbi.c      | 545 ++++++++++++++++++++++++++++++++++-
arch/riscv/kernel/setup.c    |   2 +
5 files changed, 658 insertions(+), 73 deletions(-)

--
2.23.0

