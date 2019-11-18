Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E09C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690F02230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n5JckDIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKRW5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:57:06 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53672 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfKRW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574117825; x=1605653825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZSd0SXCN7idLHbRMIPaxb2QJs2P5ieiyu0O1EqyLi4M=;
  b=n5JckDIEW5BQIUXF/dFjM1OzVxrEi7LmQQU4S5b+WvksrQV6D8I07gHL
   76uLNgaaBwv7mROSdGMgbFL0Q0pmvEsgPea35t5d/+Zzf/PTsrK9nCfg3
   60i9McSUPh/uYDIeAvVmUCiQARK8it23x+EgQ0cWZ+389wr2UjU6M6VD6
   bIGmjyCnhkMgIXel1lEkq4/Ye7pt6Jc9ucheU2e/MlsxS9rAQ+Xeh30M8
   OZASXipn/i4k2Gu2P/eHnYW7jgDx+Myn4kmG1mbes5BAaihpfM8INXTqH
   vzX4V1E1Jk+1o1Anx56iV/AcwAsl40p00JdX/botTJHxYqFZ2z9HhVZko
   A==;
IronPort-SDR: j2AdENMsmlG21keFJ1edme+nPRhq0P4nsgxxBUVV6jRYZ1sS7RLGvP42haCghNnMJBWhKUUtRu
 xlj4W0MqYYoLwgpAUUna4cJhELxp9D2qSVgQa66S0YrNJEBJhpVsH8IfK/BJ5Rt1drKNXnP1eU
 sn3U0iXE/VZ3mj+KYwcx9c8cC7nYrA9+69bMMSxTgrI0uxpaEp5Z/Gt7NXDJ5+0H/LN04pgy7h
 4tgvL0sg3LYYcE+ORvpTou+7BWrDeXjqT54+RpdY8mNnRfmGoJHiKKxyOUCySJv8NiHOzOTVxe
 Pb0=
X-IronPort-AV: E=Sophos;i="5.68,321,1569254400"; 
   d="scan'208";a="230735379"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2019 06:57:05 +0800
IronPort-SDR: GUkNJV7xWgVpdC1d0zUthPyf/eVjN8uzMzOYSu3Ou36xbHf8UJ8sabKBfipGQrq819QUxY1E0m
 wNZeK2/+XBH2H9/0YcotSyfVMcK1mtJzwG7U+g5rRfn+CRbqR9xA6Z8vjE+BE2Q6cu0VDxtaS5
 2+bnhSNZia3daYGW2FadHz9HlQWkEdW65EIvI5jQF1UD2CVdDU9gqwZsx8g8+vjHpsEcymhuWP
 GzwvfguURLDe3WU403P/ZqnYKxLAWk4PDqIBDlo3k9XFDU4cQUE/4SVGxI6D/XRgMb2sIYdUDl
 QU14ak6pppN56eUaOOiEVjuL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 14:52:18 -0800
IronPort-SDR: qEANtRlkmrDMPzgx7tEIrskIgOOSkeJZpMLrMl0c5nehwBZrpa50yA007yiWapUAVHLs2Yp65d
 a9Zuds8hI0DHa79xVLqdxwMSzJT7f5m9KtXg/n1kSicrea2VRrzApEO2krMpmzpjZCIs4mkyFT
 Awi+GcDMxOffBQQ8NjaMU7DYmgwKedqCUdbGXOfk0TZ0qn4FsjT4eOvg2DqJ1Wwwzifo2WhBMv
 tL7JPo6OLxnI+9wsUWhgTq0znQDA6Io9Hx93YGB2/62aAvIzPJK0U7eaoPR71+c+iiovChc+cl
 9qY=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.237])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2019 14:57:06 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Behrens <behrensj@mit.edu>
Subject: [PATCH v3 0/4] Add support for SBI v0.2 
Date:   Mon, 18 Nov 2019 14:45:35 -0800
Message-Id: <20191118224539.2171-1-atish.patra@wdc.com>
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
RISC-V: Implement SBI v0.2 replacement extensions

arch/riscv/Kconfig           |   6 +
arch/riscv/include/asm/sbi.h | 163 +++++++++--------
arch/riscv/kernel/Makefile   |   1 +
arch/riscv/kernel/sbi.c      | 330 +++++++++++++++++++++++++++++++++++
arch/riscv/kernel/setup.c    |   2 +
5 files changed, 431 insertions(+), 71 deletions(-)
create mode 100644 arch/riscv/kernel/sbi.c

--
2.23.0

