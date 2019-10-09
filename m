Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B9ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77E420B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M+WVhJXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfJIWBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:01:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58909 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfJIWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570658490; x=1602194490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Q4GE5gdbitQv1cQSotQR8lsgi17rKp/inu/3Yi4EBk=;
  b=M+WVhJXQ4R5I9Igb3YWhqcviUFCHsdpF8NRqDJYijsM1Pwm9eDERC8Dn
   wn+xLSdXf3iU14KoK/nQB/LUffvxuT20mFPlUclWGlskA+KTCMOIvDCCf
   eugjbqypb36UlY93dc63mcHTUwIJps0ONgSJW6a9hUYLmWSTiuc6FuS0I
   VctxnEpKB5hqvaQymJMc1fGUwen3vgKsQcteij+1H8Orhkj7aS5MahWuE
   VPnfcXt1a9WW7+sAlfCq/hBLMyv9kt5GNBMwVf9LdYx+AzEPKOXKTNs4G
   e2qL7v/HWdkQ+2AbBZOXhgCNk5W1zWFRCwBgKd/+SjU02KYiTyMAeUiOs
   Q==;
IronPort-SDR: dP5NnaypNocZKDTNy86ibQFzs7n9YarhY0+ZnWrgXFDBpVoHIhQPGXIY/ANdpiAJ4kZgP7DK6p
 Bz0kI3ARlRLB8gZPjNfSnA/IQqnyxh58TrSjUqCrGCIgO7LPTnVSAa/VhbKX1mjZeSX5rpn/g1
 YRtlKE421d7xzOpVF5FVIOr6G5O8hJAIecTGe62FkuB1BdkC7eezhJ4ibKSzzWDKZ+yl/m40zv
 aI+S2PZzQzqx2EQjKT6lgU8k1hMukzs3Ewxv0j8jtNypnsi9HQsvmN6gE5t/3Z7h9fNun9wYyH
 Y3U=
X-IronPort-AV: E=Sophos;i="5.67,277,1566835200"; 
   d="scan'208";a="121776282"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2019 06:01:29 +0800
IronPort-SDR: DB2AdpsHRiMM6f8t6VeUY+1lQNxFPY9Tt2DI5TZWkOkNDaHtVNWZC+QoCN0L8uxKWPh6Q8UH6f
 Iknn4qslJ4q2ev7NC+nHDVg3UeIxq3U/RMtsaJvupt7OFQsCPVJIKWiVngRzuzhAQVWkgMox2U
 ygNp/Jc0M29qSqJDLEhEj5Mb3+A0jIR6GYMlrD3Sa2JXV/z12gg9K0CMhwASZ6R44vaHD1/DzE
 Paa67liGMKdcetTq5JSNpEbLjMg5r9VXbm8Nw7pKxkMLp5NzBv54DN41YKseRn+yFqvoPn1s9x
 vjVmWTQ4A6KN3/uK0jRimCsd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 14:57:27 -0700
IronPort-SDR: U0ejGo6VniJ5zhqevlDDzVhwPOQOhhjCa+WXrdc2T7aDNINglgGRDlroCFlTlv7RCW3A2zHgsv
 Eux2EkcMeLIj+8rx6Y5QEr6lTMhhp/365SoySWibBacGoChDa1K/3ekmmn0PuiLh5shqpIkdnn
 ZBwaR8JE8+9sLufWKX4Op2dHYl/7JZON6Z6UhObVnf3JR16yq/XYhWFvmeKWKoH7TJbYbAZmwo
 a1c7RyhpTOPENdH2C3VumKL0YNN4P5WACFBl2J8znLrIYtt3eMtWNbr+WDlvCDk60Pw6FkLRWc
 F3c=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Oct 2019 15:01:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2  0/2] Cleanup isa string access and print 
Date:   Wed,  9 Oct 2019 15:00:56 -0700
Message-Id: <20191009220058.24964-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup series addressing issues around isa string accesses
and prints. Patch 1 is actually a revised patch as a result of discussion
in the following thread.

http://lists.infradead.org/pipermail/linux-riscv/2019-September/006702.html

Patch 2 is an additional cleanup that tries to consolidate all isa
string related checks.

Changes from v1->v2
1. Used IS_ENABLED instead of #if defined
2. Adding additional warning statement incase of invalid isa string

Atish Patra (2):
RISC-V: Remove unsupported isa string info print
RISC-V: Consolidate isa correctness check

arch/riscv/include/asm/processor.h |  1 +
arch/riscv/kernel/cpu.c            | 86 ++++++++++++------------------
arch/riscv/kernel/cpufeature.c     |  4 +-
arch/riscv/kernel/smpboot.c        |  4 ++
4 files changed, 40 insertions(+), 55 deletions(-)

--
2.21.0

