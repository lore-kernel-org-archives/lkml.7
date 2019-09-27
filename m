Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B66C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAAD207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ej7e0p2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfI0AJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 20:09:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38047 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfI0AJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 20:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569542987; x=1601078987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s8wencevRmeMDEGXC4oPCf69aZsPiCihnU+edmEPkWw=;
  b=Ej7e0p2aEbWVXAsiilTlTU+D0X/cIIOIIjZbJO9DaDH4BrDlwCKrcInw
   r+giZM579t717orVxTyTbQzsq4V/9+tx3CQqEDGVBOXCnX0/B+ZFBdo9p
   Wy0wcnlGwXa5zStQ6qxyOT98NBmEp4mxzqHPilLIcvEzJeFFRFqn9G0mo
   1rlJ2o6Z7y65gvjbSolCPG1wTbEh/K7UYQXkUjEtpoMwYJ/pb4PZCdqsq
   Z1I2uy4gSNpHMt3s9yUlsgJUKuozMoJfqF5iBxJ6dLIX+VBtjvQAmbNXw
   1810aLRghtfYObQYaEShpcWH8qZJVd0kVYh2RJsoMC8uJP+SjjmlTnZ5z
   A==;
IronPort-SDR: hiueuz5vIpbAgMw++JQJQGVPQB+OGa7P2eMSBl1mqi0YPS7k4mCe+ZVfO2AxeZV4DdtDWGuBFv
 Uv+D7t873M0aVxV8whPGui/vInVPdSzZTvZlqIffBVstjUheTLTVnTVPRAjNVe0LSKFxstfIRW
 7qIIBpsoFctIXGk4VwYWpAvA5ZPph03RTHu71GPEVkdypV/GU3yu3GKbSxRQmolJiBmPtGIT9o
 Mpo/4VoTYG6nOPn/EUZbih7uj3l02KE6+bY1SaT5hY8kjr8gBBPvH4KQeumZPr3MimDf8B3E7e
 dO4=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; 
   d="scan'208";a="220096732"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:09:45 +0800
IronPort-SDR: 8Yj5RDTQbH6D1JaWmeOYjj2sU1NhrtzL74OSNqBXhIJ++CufH4ZSdKVje7LPt9fQKci4N2k4N0
 JF1LKnUXExZHSeJAWtzLlR5nP1ZtnhZvd+/ZgJGR0uuH8Vk4tGNkYsr4LAe7klyTV671Mi0bb7
 sb+yTfgpZzlj3o0rUG9g8YvQNBdnzdMCjt4iS8saHVltLmeo6+HwCrWfdRDnrATwp3KvSSBrXJ
 Do+n56/tS5R+I9XXu4mRb3y1EP0jYb9Mj6tcJ+WxFFLRnGVVAkYSQRfnPZoAFUfRYUpL8z753K
 uJdYJ2rq2Ff7KLEfR9ncCpD7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 17:05:45 -0700
IronPort-SDR: T01SUBszgnCFFTpYhAutlE/F0IhOeeTfpSKFyhZjg4LICu9Mvq8KbW/RSMGwTOz4weUwIa+U+2
 43KU9rdSbkurKSoj5OJZKqdeCoSNyVuew2CNR10B2W6uLePqS1TAOgAJpV+5/qU3VvsiwY3zm4
 BVB677+W3j0uE0iCNAZUiOKM///VB5QXiEwBT/MI3DhWhTOkjVpelMQbxgZgXvr60ToiHjuOUg
 WooKN/v+KeFPwlWv6CWkN4Btgt53KdeLVhRyk2wlt6UTdyehcKt8tpslx0z+oV5EN7JR+edF/f
 WzA=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Sep 2019 17:09:24 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/3] Add support for SBI v0.2 
Date:   Thu, 26 Sep 2019 17:09:12 -0700
Message-Id: <20190927000915.31781-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
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

The SBI v0.2 support for OpenSBI is already available at

https://github.com/atishp04/opensbi/tree/sbi_v0.2_2
and in the OpenSBI mailing list.

Tested on both BBL, OpenSBI with/without the above patch series. 

Changes from v1->v2
1. Removed the legacy calling convention.
2. Moved all SBI related calls to sbi.c.
3. Moved all SBI related macros to uapi.

Atish Patra (3):
RISC-V: Mark existing SBI as 0.1 SBI.
RISC-V: Add basic support for SBI v0.2
RISC-V: Move SBI related macros under uapi.

arch/riscv/include/asm/sbi.h      | 109 +++++---------
arch/riscv/include/uapi/asm/sbi.h |  48 ++++++
arch/riscv/kernel/Makefile        |   1 +
arch/riscv/kernel/sbi.c           | 241 ++++++++++++++++++++++++++++++
arch/riscv/kernel/setup.c         |   2 +
5 files changed, 328 insertions(+), 73 deletions(-)
create mode 100644 arch/riscv/include/uapi/asm/sbi.h
create mode 100644 arch/riscv/kernel/sbi.c

--
2.21.0

