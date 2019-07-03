Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74E3C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC09521852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hEdLVLX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfGCAyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:54:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53186 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCAyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562115281; x=1593651281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fVT1Neu72Cl7Ti24Xfa8jpNhBvPMuWv91mK1LHqkCSA=;
  b=hEdLVLX97kyJRiEd+bxnw2YMyBr1Cnmouuwv4r1VmEA3MIxoGcEPD7yz
   LManCbYvIhcvy7/pmH6ZNGI+JDAfy2NvFP10Y4joBe8c5kSw7H8w+5sp+
   i9fm6nwwrfaxz6BBocw/0pBGKksVLmSbtermfwaKRe/FKZCncljPv/lG9
   yEb7LGSqqrv4/HAN3Qz2li094hKtvIfTv0b7ZCA/1nRNQ728+xnsv7I7N
   qFY3L1WY/Cl14xA9pfLe2/i7j2YVxy37nU0zziu2AihKnWQswDRQFY5If
   wLxj8hlAd4d9WyEQxEDlO3Vuep/zMOSZGj1XY/UJnIBZAeMAEdsIlWS9D
   g==;
IronPort-SDR: sl0pWYsrzo1WizLcFQJCThEl3psYdQ5qorW4DLQAOpQyWenFwIWU83U6DbJm0HeWzMy7GYV4SN
 KQxFlhLHfB1qVrZDRUxMCqZbI9Mze58YSbkuj8IVCRMSkoYC/1C00Y44wkE0DecfdvH96vS5RR
 LsbGHDwMl1nT3KLISr92GHGBGJutJWCrLkcJtj3k2Fn/BKmowWRUs8X01iwYiLwW97daOJ38gd
 il9StJWX5IZbmszeCqheihOeRz51Yxe2ZbJGJDTRFMLvk/qud4H0cSLihbQvBnre2WOAeDNtjN
 Hbw=
X-IronPort-AV: E=Sophos;i="5.63,445,1557158400"; 
   d="scan'208";a="113716743"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2019 08:54:41 +0800
IronPort-SDR: Cv0UqDRPdqm7tL2awNL5BBMz4ALeO/qghQctSObPmRAsyxKJVO8QKz3aA8W+xo3o/vWMT62emF
 bM8ofbCrY1HjilujaKmvpBnwkmIR6+MSE4/c+hZ42TWZ9OhGHYBKCJwa7MpmPjqrkyGmxtNfIC
 N33UIPRKqtKn9BQNWz5nSiFc/RkWmB7ZdxMjVwwq9H4snENgVNz9O8Ql5trNREuO2+lnlVcjQ6
 bGwBISNPnyefffkhXh/Bdt5Lw8cK0iZ9bxgC4RwOhT9pfzNhdEaMcfb7CyEPYZjK6uax4BcmCK
 7ziMww4848sHmLeJZCagan9/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Jul 2019 17:53:41 -0700
IronPort-SDR: 3uwdGreIxlVjC6rLHAVUNPxCvYFm12JW++t5byZuYThYEKpHQy1rvPmQ3xRuq3bHiMuNnv4Hq7
 63wzCLqFIFApUyBBAcjPM74IesbGPjKYsPFPpuufziviVGB/UkXWgcGM2tZsqTjMkIhvf4D+UQ
 QojHazb4wUUMSjboC3ARtuE89wBtlKhK6Jx8R0Q4qcn4UNQJe3cHoKaHzdb/G2Cyi68fnwbElo
 tp+WtZHcEEzeowOCXxYJUduMa2yzOo5GB0CBsspNsy7AprVueWfrW2IeIt7UG4W4ouF7OhCsgw
 AVk=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.140])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2019 17:54:41 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-riscv@lists.infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH RESEND 0/2] RISC-V: Handle the siginfo_t offset problem
Date:   Tue,  2 Jul 2019 17:52:00 -0700
Message-Id: <20190703005202.7578-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the the correct linux-riscv address.

In the RISC-V 32-bit glibc port [1] the siginfo_t struct in the kernel
doesn't line up with the struct in glibc. In glibc world the _sifields
union is 8 byte alligned (although I can't figure out why) while in the
kernel wordl the _sifields union is 4 bytes alligned. This results in
information being lost in the waitid syscall.

This doesn't seem to be a great fix, but it is somewhat similar to what
x32 does (which has 64-bit time_t like RV32) and I can't figure out why
the two allignments are different.

1: https://github.com/alistair23/glibc/commits/alistair/rv32.next

Alistair Francis (2):
  uapi/asm-generic: Allow defining a custom __SIGINFO struct
  riscv/include/uapi: Define a custom __SIGINFO struct for RV32

 arch/riscv/include/uapi/asm/siginfo.h | 32 +++++++++++++++++++++++++++
 include/uapi/asm-generic/siginfo.h    | 32 ++++++++++++++-------------
 2 files changed, 49 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/siginfo.h

-- 
2.22.0

