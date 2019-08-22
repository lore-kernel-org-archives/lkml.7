Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3806DC41514
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E537216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ALzRCfqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfHVAqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:46:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34532 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfHVAqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566434912; x=1597970912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YlJDmiJLhozVCCONzet/NwZI4xFiot+23HMp3bKyELg=;
  b=ALzRCfqUydbTGqZba0vgbcwKLQO+ep48AHRHtypTRRK17NNTo93/nFDw
   AWaaZeq71khbXkKBtSjKZTFhCMPWFy0xX0LBCSSOmm/Rm/HFdnnbLqG6X
   cna7qJYP0XWzqdtX2nDknVITNsrS2E8cU5MjE0ko0DX0uvLxcRcvlFMwI
   kbI3l8ORiuOFc2HUqaFL1KwMgsw5iozTUutstikD3/NrF3NL2FmT4JVew
   szpb10YHS4+VEsYsLafjoe1B0+N7eCH9YMh5jKalSxmYAq+1Q8ru7VwjI
   jYWYZtXIDKx+uwEqWkIPCfCB5+5Rw9C1skQVW6yi0duHylas2j4Vw17Cy
   Q==;
IronPort-SDR: 3Iky/8oI7rQRWQoVE1nGNiS2tJn4QXVY1MBGuBnM97TsdIsWXYcnTqlBkNb7mlhGh/lupbQ0SB
 iLjxJqQKWhByOmg00SnAEoe6/9EWV0+cpLIjPGgPIru3vXCziG9EbZARiHskRECvxOcbAK/KTk
 pzxthshCGpoCO5MsG6DiTT/Nx1CB3Ez9KcKpQ5n1Cm8nzwxxCa78JG6pdI/U70SgZuysd59dRA
 uH9zyG4FDjru/2+ZdJkV/AuHelHRROwjKlo+L77jBFd1x/ZY+Lurh6Ghmc2uPk2zYgWTuOUlyV
 S20=
X-IronPort-AV: E=Sophos;i="5.64,414,1559491200"; 
   d="scan'208";a="216804440"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 08:48:32 +0800
IronPort-SDR: 9KIiuNliAWSdin1ubjIA5jfsyIofJU7x/lu3VLgVUqVXblFTH9ncVYSfojIP4rFmgx/AHoOcCZ
 mvZPJjmciqbSXM4AAaGa1vbzxWgcQpZQig9r/JgZRb/GUgywbmpognzuV8Mwz7nFV3fA9Ob6sc
 oK4289QA4lZwGZqUE4PsG8+no1gkC30RgzhJgnpEDvzpd4jUpHzGgZlUCoPxhgXmvQNIMFMY9j
 0VjD3a+1OFIlOvFZrFForqTjjb578x3ijQB/IM3qQbPR4gg21xcj1Pgv9fbKHrsZiZhU8zuN76
 abTTRMQI5fqupD9Rs6polN9t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 17:44:06 -0700
IronPort-SDR: HYUsOW/XJrLNmL4Jvw+YV1eMd4r1pZej015AjlwdtGCcqCmLZcEFcuvZUczk1QqfpfRU2gI+iK
 zBQZc+Cxyr0xD6KjQUy6cPLxyIstg8xkVVxEFGmEYlJT3IRbUA29M581QIhg8AKzDyp4e0yEoK
 Gy2oKkYOOjBDnaTgGmeh4Ju4IJS3uoBufXp8nYXCWFed0ZclGgwdgHwo+T+oI4Vvo57VwtLrKO
 o+MHJKaXQEPguVb5HoGum31fc4ETUQuuyn0+7D9QCzk4Uj6zCrSOj2b6bzrir3OuMC7SivUc2f
 Mvo=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2019 17:46:46 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v3 3/3] RISC-V: Do not invoke SBI call if cpumask is empty
Date:   Wed, 21 Aug 2019 17:46:44 -0700
Message-Id: <20190822004644.25829-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822004644.25829-1-atish.patra@wdc.com>
References: <20190822004644.25829-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI calls are expensive. If cpumask is empty, there is no need to
trap via SBI as no remote tlb flushing is required.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/tlbflush.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9f58b3790baa..2bd3c418d769 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -21,6 +21,9 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 		goto issue_sfence;
 	}
 
+	if (cpumask_empty(cmask))
+		goto done;
+
 	if (cpumask_test_cpu(cpuid, cmask) && cpumask_weight(cmask) == 1) {
 		if (size <= PAGE_SIZE && size != -1)
 			local_flush_tlb_page(start);
-- 
2.21.0

