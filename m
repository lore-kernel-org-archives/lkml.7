Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8596AC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A32217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nFKO+usO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfDXACY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:02:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53963 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDXACX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556064143; x=1587600143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XiNEr+PSJjtuVX087I0r7I3Y9FgKCYJ6yrGmyRyacdU=;
  b=nFKO+usOTNZsv6wHpU7O5XjMotnakHs4sRSWgr5/0euW+Ryrm7Z/AAvi
   tsppNyu6dQvAYsDa3VZbT7H51YP9I3gm3WkQcyojR/13YAVfbkHLQI4r0
   ePneHxPItHxn3C3zPoY3+ghaimY9IdxZmxNbnXMHrRSxcnmnDUib0JS5i
   pBfJNFMS38cdLOcMI/edQ8AjX/7ZGoeQXCHMwhwiFz1GXwvufOOsFRtKM
   TsRc7DhgBAA8U6c091x1TNixEh4+ULqdvRy7VZe2AbkMu6Wz5BPwBFWn9
   hK8Cm9wqyETQVDK5AN55lidIue3Rtl9Lgd6tu7oT4Iaf6ftbLXC6au3xr
   g==;
X-IronPort-AV: E=Sophos;i="5.60,387,1549900800"; 
   d="scan'208";a="106649527"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2019 08:02:23 +0800
IronPort-SDR: ePQifEgAGB6/nTd4aRhZTOdmuGkgZxO3KExscOpkbLhYxG3zmCHKUTvh2kwdJDKEEyr6We4PBU
 VcCVVer06E/iG7V155gtl9IJWbkpkVl55vgud9nl9YRtBs6RD+LIeNWak6agd2RN1Nnu8kqTXX
 M/BFKZ0aD8cyjO6R16VVKxPPwOLyLaiDgYKBZl5L5hqQakFmxNy6BIzxLxs4IwyChDWyDNpiSx
 co7EKTVnMHfI77cTE9WoFKcS8dR2QhHPiuqWuuFhnPadZu4ckYPKbV6nefeEkZi6PYrQgNITHt
 hNy6lQd4TSwDer+fkEf8ZxGq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 Apr 2019 16:41:03 -0700
IronPort-SDR: cA8mCqTqPppT2Ml7LpCNlgN8VnVzAcqm2YLkAzH55HD0iy1M1KnZmrrmrLvas12gEN/6GRPZ7I
 UPvQPemxtXPqi4Ww+y2kTFbOMTTqaLMrYj9sC1n05Nhg2gBeZCicxelYl58ZCG7R/0o34fwHAb
 5f7Mm0dLGcA7xG+MhDWitbFLEu1oalTouSttCiWzr6YZVbS+YC8/n8imcTtBRMQF/vFLlfQlKK
 f9JhjBEEO/3pYkp+GaD+dmSEMx9SxbfgscZ940tZo50UTh7b9bGU0jd37OWHHoxWRbr63mAj2s
 puU=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Apr 2019 17:02:22 -0700
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 0/3] Miscellaneous kernel command line fixes
Date:   Tue, 23 Apr 2019 17:02:24 -0700
Message-Id: <20190424000227.3085-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assorted command line option fixes for RISC-V.

Changes from v2->v3.
1. Merged patch 1 & 2 into one patch.

Changes from v1->v2.
1. Update pr_err string in patch (4/4) as per review.

Atish Patra (3):
RISC-V: Add RISC-V specific arch_match_cpu_phys_id
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

