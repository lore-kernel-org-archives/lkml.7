Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14EC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BD6216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J8JDgFWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfHVAqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:46:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34532 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfHVAqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566434911; x=1597970911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fkNZnhPM7WfLkPzEFjEzhMya8eMeeNJ+IP3XtPFJp3Q=;
  b=J8JDgFWxyZOTT7jzkPBkqGjdHKVF4SU9H1dHBrgi79lNtzpUqiCFv0YM
   vPRAlptgC5eEGf552tb7ZrTvqG8g2lW7CrVlnUpl0aX0dKijaH4y7Y12i
   6tO5olY06FqqnO9zKIJJGJpxQIa4su/XYsftHXJXo5Qx+sf++9Mwv1vUA
   MX8KnnMT3h7XX209n4xi8oGlHsj+H+FHBU553AhKLbziL6CwaB4QgBJrb
   8YB36vSZZG2966vQ/r8pTLTqT9PcxpfuMPVVRXoobgV+QrUnj8NUS9NDx
   +XZMo9UyzayyTmwH28hPtuh9AfXJuRBTrd9FsEQoJHORmRNC81dbXmCHJ
   Q==;
IronPort-SDR: Em7cRNC0MJy6nZN4bamznU4UsIi8AeG85jIgJYKMbkw4/kfsuldSHleZrV3iQO7erQxfmH5gZ6
 UPuYvJ8yO2ZyhCJsArplQ3KKTrHGGGECvgOddpnV6UR09rHPLy2KpuXrbyrZAEBKloKDVG+zG/
 5JwoejWr1PzC+WjGWePbWAjQisEAZmmDSZqI4bLhamvPZK2gJSSvIBUWVYDywcWXHLQ6SgIH9E
 QRV2eY++VQNtZINxAhXamt/q3FyqASxq8F2hXW/O2hNt2AMoRg5PSP33ePwWz9BI5C8f5dmyM3
 SzQ=
X-IronPort-AV: E=Sophos;i="5.64,414,1559491200"; 
   d="scan'208";a="216804434"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 08:48:31 +0800
IronPort-SDR: sdXsG/CmnKiBycK7B/lSmWF+ERjlycbUcExbzc9n+7plk6dCJJfpoLxtH+gGmkAy0P/hvqrFoy
 4V0+V7coD3uV1RhDMm7Lw0hYmP/WbFsOzadyMmeCatCMllj90NdgZyvBCS3JxB2zhw0YToL5Ep
 iGH+LmS53uAPTqyVDgMRxTTexKkSBvp7RwbqqSyTqMsKFL8qbBKCn66txEUE8Wn89eUUr5ivZf
 umHPw08z8uBEME2T0O4yzmOzr5hebTNxwIfAMDDVbFerIk/nGaT5fnevbjlqqBCt7vhCBvCC/2
 a10qxCHkO4j1QnWSgyIxfHjP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 17:44:05 -0700
IronPort-SDR: JNPiJpHMaiTIFAY7i+CnRyW5tg8oDoexB2wvQ4LX60OFhmEwmMkNgti6rFJ246w4vvkAQeCowv
 2HNlHJde7i1diC60YFtMugD/dcSGES1pdi9Yr2jpZaMHcpZhZ7f+02lFTYhmkUAaSxQrNAebDF
 DC/2GdabYRzTJcAyBqFqtlICj0plAUWyVOoj++FcaN1lCEzvVlENnHyxwIyE3C3ZOatn22XNzq
 GLPmUup3LDOqPkysfev1S+dmtrg4RWzXC4Po6SXngDie4bXQu94HdoaQ9qr0v3NMRpF1Q85DPy
 UPA=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2019 17:46:45 -0700
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
Subject: [PATCH v3 0/3] Optimize tlbflush path
Date:   Wed, 21 Aug 2019 17:46:41 -0700
Message-Id: <20190822004644.25829-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds few optimizations to reduce the trap cost in the tlb
flush path. We should only make SBI calls to remote tlb flush only if
absolutely required. 

This series is based on Christoph's series:

http://lists.infradead.org/pipermail/linux-riscv/2019-August/006148.html

Changes from v2->v3:
1. Split the patches into smaller one per optimization.

Atish Patra (3):
RISC-V: Issue a local tlbflush if possible.
RISC-V: Issue a tlb page flush if possible
RISC-V: Do not invoke SBI call if cpumask is empty

arch/riscv/mm/tlbflush.c | 21 +++++++++++++++++++++
1 file changed, 21 insertions(+)

--
2.21.0

