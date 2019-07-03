Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734DC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B137D21993
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qbaLWSdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfGCAaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:30:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44679 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfGCAa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562113829; x=1593649829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TMJsHq9zABqqQ3LglKzp9QSrjZnTx0R4BAlOB34vBkE=;
  b=qbaLWSdzSoWQnpjSdvyiow0GvNZW+csP1PEyH7wFfcvy9kAgLQIGPC7t
   OtOERKT+5oRz5YMQjjg6a9I39qQxdJnJeMbihQqTpP4tk6xisKOQsj9fr
   9z9qbUmju22k+dhQNmcpQGJHZw/VtDLO2eHMUclxhQNgvS1LyoG7o+/lf
   RYWUAGpTHOjgUF+qXQYnpdUOOUbtXyy29RNjbkWaG/lP1z/sxKN9ZLb8n
   pub17rIBro2lu7ZKL+Ctf0kMGWG87Jpzp8SldFecEtsHQ79N6JKQiRLFi
   I3NWSapZqTCzVO3l8qKzvAZgd95x7liOJCZX+KL1aidWXB+fGb+18Jozj
   Q==;
IronPort-SDR: sHuzIviK+rqOr3zkt+yyrX62rRI0jtge+iJnIfU+Clus+YqtGHm4LGZXlIJAXRxr0Y8xizVtDa
 lW8m9MgwvKUJyzEOWjO+VQwbq12utj8RCmKL4kDG6bkcm3nIEOv+N/q6uL4YhpgvPBtsCbUDjc
 cCitwg1ssr++el1XW1sNKDY9wxM5mD5jucNc9pi2Gbbq6Muwur2qWwhNER5EUXrkio4dpSoeLu
 4ZHWkB0/AdxdQcruyIz0MUq4/MSLxFs8pf1HZSZW7p5aoDnEEvLR9VQjRwKqu3vz/6aDWd6DVb
 0DQ=
X-IronPort-AV: E=Sophos;i="5.63,444,1557158400"; 
   d="scan'208";a="112096599"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2019 08:21:25 +0800
IronPort-SDR: k1nZz9KcjzgOF5L0VqvUuyU3GpENOHupdjsAd2K7HOXLKwz9433aBju8eoWZaTuDxDe5xh3wIT
 SxzU7IGuR3J+3/EgswCDH5S4cwPB1qB0kJZMUqd6LelkGfkUqpuetNQepzL7TmvggSytnVR211
 4R3l5d53tIl+CsLsVgCBuKLjQQErpqBnwQsIdz9yBkI5YZduKYe8/GIG/IXgHFsNNMIfREOW0S
 gwhGjhNEgxkpWLpeuDGLVaeuwXhrQSASehh3RmluP1VITohltlcI6B5fkFCsKKG0+ejmByHYlW
 vQAHj8LFYcRgcNV1RT+d+Wil
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Jul 2019 17:20:25 -0700
IronPort-SDR: GPO25u+udSBPahbfy+LtrdJF8rWSyoRkc3XxlFv4pm3hyXenQn0hdzbsFHK2AvCJ9uDi/HKxDs
 rECGrfHTBptEsQ1oz219xFHu1ZO7WDlCc8vsT64rheUNk8Xn77uPUS9uw7hVMOO13ekYHhi/DQ
 P/w99yrlU4MEQga/Zh81U39mh6mYScAczMwZfYpZ27ZnUAM2runiKt6pIYrwCgLH3Car19xDsq
 li4fxN1Za0Pn6E8Q4OSLA0TuQdC58+HcvXq/DPoqnnTOUxQDKVz/M3dfN/LpAE2tRlz6lM3j9f
 NDI=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.140])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2019 17:21:24 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-riscv-bounces@lists.infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/2] RISC-V: Handle the siginfo_t offset problem
Date:   Tue,  2 Jul 2019 17:18:40 -0700
Message-Id: <20190703001842.12238-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

