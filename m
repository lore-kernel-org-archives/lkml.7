Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F08DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5472A2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PB1TrApq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKZTF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:05:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:62441 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574795129; x=1606331129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2tYGSMNcs0UW5Lvpl6YDf0Tvze90VFHUzSCbHuotN/Y=;
  b=PB1TrApqXL5cuyt9fDw8haeQVSPFwU+HhI+p5JarF2526gLUoJfE/OAR
   c01bPPQ2jWZ6tfMQ+fneaYCZZRpMRy/gx6bfzNw/HjYEufH0KFH2o9mpQ
   bjyCKEbZooxxgXN1sd5dJwqsdoURvagGtETkFb6eI7b3OE53pxTiWrykZ
   RTxXlKUDOuk7RWx84ZEA+XccXLEzeYaEMqHWTCAng4nNKnbRidNAZfVnI
   huLdMwsTgMEcG3gXDWj0iE76Sg5k66AAfTLebJSI2Rri58BEW40VXlka8
   cIVu47WKhe/zY4CNf+4deXXH3xemTMp2afLl9wa/pnwrKB7i+tVA/5fEF
   Q==;
IronPort-SDR: RSHekiM2ktTP1Fy2hRLyJS7EDFBn69Ti6V1vT00Li8I7tnDJKX7qfp+XUFINtuEmjAeeCUjmDJ
 jinr8DTwJFuXdG8pCNr9ROcNYulvFJcaAycHsMr1wu5MO9PJu7W6aiIMv4wRqSQ7GTBo31M/ex
 Z2aCmAueJfqQAYEsoDS1w0PMVmJeUAN3DMybvHXeKlApBY94MOTH5XxfS3GvhoUbEP8lyiBnMu
 eZfuSmK70JHdp+J6lRaacB8RrfxdZg1BTsPkGGhzTnTedUb/TXBRotqIBLGtRnE2ki4mqP/IJr
 qT8=
X-IronPort-AV: E=Sophos;i="5.69,246,1571673600"; 
   d="scan'208";a="128481924"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 03:05:29 +0800
IronPort-SDR: NxX2HEtXc3w80hllkIiLNPL070rWoCcG2mzbi4235JPMIqghBmncA9794qRg8szFUnWEFb6yKV
 KKYWo9oevq1GuHyVINFkZUtavVsxWLCj2zJPFVVw43sbpyv46pShPwqoL1OcCS0VyNiogmmi1k
 S8gtYqPlWpf0a2TQ6eM31RqvvK6ZZM/i/7lic4wOece6xfT+wZV58BSmtr3gToa96Eea0fwY6/
 Npa4+VGKny69jwACx1EToLM9WJRRF2cMQLg13RepVLh97pXcetjVLbstKODllZil7Z3m2F28S3
 dGDp5AXMMAZ1vIgUk6kefNfm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 11:00:06 -0800
IronPort-SDR: nxYeJpflgf54V2H2m4tS5AoYPhejdMtOxwXGMEpLk0poTU5aapkCjQSswOYP3wGvbOLWQ0nyl5
 aJT1M7YX96RukqYxDqEvdZBsDgOneOpmX73Sg2wfzaZeZp2lWUDWiSDnZe1tOfrC73dmdkdMId
 3FJWqp+VkDFmthixKtXkAVdh+m2Rr+LnSxtc2Eciu/pVUaDXI4voO4M2ZTvr118Dq3qcFMMmNA
 6QYOx/VcZNJM4e6ZZzyGnQ5ph4Qb5dF53L8Wd4IhJ/8U7MTxHcRkUrG248nourw/3wnmgxK3Xe
 4N4=
WDCIronportException: Internal
Received: from usa003951.ad.shared (HELO yoda.hgst.com) ([10.86.50.226])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Nov 2019 11:05:28 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 0/4] Add support for SBI v0.2 
Date:   Tue, 26 Nov 2019 11:04:59 -0800
Message-Id: <20191126190503.19303-1-atish.patra@wdc.com>
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
implementation between 0.1 and 0.2. It also add other SBI v0.2
functionality defined in [2]. The base support for SBI v0.2 is already
available in OpenSBI v0.5. This series needs additional patches[3] in
OpenSBI. 

Tested on both BBL, OpenSBI with/without the above patch series. 

[1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://github.com/riscv/riscv-sbi-doc/pull/27
[3] http://lists.infradead.org/pipermail/opensbi/2019-November/000738.html

Changes from v4->v5
1. Fixed few minor comments related to static & inline.
2. Make sure that every patch is boot tested individually.

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
arch/riscv/kernel/sbi.c      | 547 ++++++++++++++++++++++++++++++++++-
arch/riscv/kernel/setup.c    |   2 +
5 files changed, 660 insertions(+), 73 deletions(-)

--
2.23.0

