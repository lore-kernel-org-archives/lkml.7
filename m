Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C325C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4680520830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f/43EHVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDJWpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:45:12 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49965 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJWpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554936311; x=1586472311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a3VvaOh2cf1QC+g5MffvF8to+gMoca9eohO0HIC8O3Q=;
  b=f/43EHVQg6FNa0WyUw2hGtrxQ1QGYJU6aLsnEpXeWkoxpfHNlr5S1oHQ
   Qdhmrd2l7yjoUH3uxYLCtFbbdVyFDutZs8t0f1nBCToSVl5YCuXSA66SS
   usQnwMsecIJw9VWtxP4kwdNYebnH+IZ1TE0TRod1MkaI697q6Jqs3cqmh
   6+9mmgHqprZHNZiREMAG7Hcj5xJKU50MoOnEoLWccKjNUW2C7ZIaEkonR
   L5LFwJ+X0r2x4MYAKoSXDmFxEBhBTJ4lg1bsUiTdtZCCJ6mvM61YKL0Sb
   NewTARIfKNag9pgULpxLp6u4mtRE8uNzECY7Y8jR0KGWqsKgqdbeI/Rvf
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="105470406"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 06:45:11 +0800
IronPort-SDR: V4u7oo/db40Dtl6p+3mc20DNtOs9nOl5X88PNc7u1c5lHAmSa7iVriy0dSLK7l0Am2CJMxXHgI
 f+s6gTOX/NhzK84ZU11r4UtONAP8OW7uW5GKSLoVd5/SBQjwPQ5I7QqAa8eaJN5EfMH3h87m6h
 laRn1MIGYdKMinUU4rJoxfDeCcqfTD6uIKC6IobXkyTfDF4kYMhf60LQ4wYFd2vp0NUEpXUl3g
 iNQr/QLnhYdkRKKBT4P0+4wjB7RXYkl1TMKFlmMgRYWp9DusbNfD2pGBsAqQPCchsWrjycM7Sp
 jqc+IYGZDpBAtvomMiQVfvyr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:22:05 -0700
IronPort-SDR: QlOKyi6VU6nK9T6rpHWVoYgt23bZNACPlGHgqvZhpoX/gyPVFdKc50HhypFMdxTAjDyQfHRryu
 6PWonAigBO3stB2INKY2ZKSqX6Imvy9+ghIv+m5qGEQUPmCPa3fA3NyoJVzTZbmwh5wIWQ+vVX
 FnrnnatYkvFWgISr6UksoLUIcqH1owqc3a4f40/WXNDCFTYwfFkFPhA+5fNP++Qg31NUDPZtJU
 tyfNwUHwcBxYQmuY8y2bvMUDcwDWORzXw+Y1nZPcNolUfbQ1QPBYhFPB7wUXovph73WtY0W+E7
 xyA=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Apr 2019 15:45:10 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [0/3] TLB flush counters
Date:   Wed, 10 Apr 2019 15:44:46 -0700
Message-Id: <20190410224449.10877-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V patch (2/3) is based on Gary's TLB flush patch series

https://patchwork.kernel.org/project/linux-riscv/list/?series=97315

The x86 kconfig fix patch(1/3) can be applied separately.

Atish Patra (3):
x86: Update DEBUG_TLBFLUSH options description.
RISC-V: Update tlb flush counters
RISC-V: Add DEBUG_TLBFLUSH option.

arch/riscv/Kconfig.debug          | 12 ++++++++++++
arch/riscv/include/asm/tlbflush.h |  5 +++++
arch/riscv/mm/tlbflush.c          | 12 ++++++++++++
arch/x86/Kconfig.debug            | 15 +++------------
4 files changed, 32 insertions(+), 12 deletions(-)

--
2.21.0

