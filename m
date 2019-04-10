Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA08C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F01220850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DCRd82DW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDJXFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:05:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61696 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554937500; x=1586473500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GLs0GoxRzUrfv22VND2PfnCLlwY3Um+V6ZRAqFdvJic=;
  b=DCRd82DWgoKQnvCMICabtb9sEHM1psLYYg0jDWGFy4SBbV4xP60kwNXJ
   aCRLn/AHKkN/ILmrLhDbDd170exmcZ4tQyj8yGwiEmOGad0VB5xL3THf8
   F96RHRx2bRIh5WoYiTre97X2y6WvdGwJ087vPJSFblYiaGqU1wU1WbwpU
   apGyVk1qmSKdsyd+KRznecrZ1YHGRudxCXdb2OMkbSDdFvE4c/h5K6OQI
   7Y+m89IrsT5SREoMuMNFK2h94g//l/sya0SARVN0rtLuUr4VeEr2uC+si
   c/WoM6iK8qxZUNyRt0MVaJ2+KnLEadOeWBZ7XJIFlX6QrKuYUv3wFDHd9
   A==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="110531204"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:05:00 +0800
IronPort-SDR: V6KWr+K8V/3eBXMl+srttJt5bpySJWq87WqBg4+EcYfcixL33Z2Ee0ZWDUD2yZDvYHX5WM8VU6
 OEgUYqz0rBRpIfVB8NQBfdroGduz7r80j6ulHJLaJc0iE12HiCRax6Su/NQ9JNWehTYxHvqzto
 Ukqm6yxDvCYDisAoGRZ3i7JsYN5BAi2QKyGjN4uov4crRNwaP40QmIfVzxSbLjQ/Mn2kjnXbIM
 NkMX1049l8vQKL68Z+vrNrAtHPHmTCESatdLDoRL0qh8pwoWgj+VZRqrxGOep7ztHyFcKCw/C9
 kQ6nokfG4jeBSItmuP34YV3P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:41:52 -0700
IronPort-SDR: zAezptHMBcF3SaRvVTnC+jsYaiyx1J5/a/GTFW1QBEGumpEwYjawwuSewMtYYPIASdxheJ1JJf
 +PGD2epfHl4RBRz2Ce/FOjT9g7mikC+PnrdwVn944btrwc7I9ktZF6/AlqBsEEHe72gHEkjPcN
 yBStiVZ55Nw/ZSCyqhGhX29gzf0cw9AliY9s5emYMGVjtpHvujPHcY4nCmJHA4Pby1ZcVOfvxD
 WGWJA0XCgYz+a2MGaQGehUZrDKnOpNFR1aPiMT9EuuLrvG7uVowP4Si9MA+9ZFCGo0+hpslTWZ
 DWk=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Apr 2019 16:04:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 0/4] Miscellaneous kernel command line fixes
Date:   Wed, 10 Apr 2019 16:04:39 -0700
Message-Id: <20190410230443.15729-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assorted command line option fixes for RISC-V.

Changes from v1->v2.
1. Update pr_err string in patch (4/4) as per review.

Atish Patra (4):
RISC-V: Add RISC-V specific arch_match_cpu_phys_id
RISC-V: Fix of_get_cpu_node usage
RISC-V: Implement nosmp commandline option.
RISC-V: Support nr_cpus command line option.

arch/riscv/kernel/cpu.c     |  3 +--
arch/riscv/kernel/smp.c     |  5 +++++
arch/riscv/kernel/smpboot.  |  0
arch/riscv/kernel/smpboot.c | 22 ++++++++++++++++++++--
4 files changed, 26 insertions(+), 4 deletions(-)
create mode 100644 arch/riscv/kernel/smpboot.

--
2.21.0

