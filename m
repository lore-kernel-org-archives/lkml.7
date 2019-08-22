Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFFEC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A4921726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mWty84D2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfHVH7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:59:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20011 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbfHVH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566460740; x=1597996740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QcWeubIkfrNRIenwwrXmwbneuUHMuNrk72My33ahgcU=;
  b=mWty84D22xigddfD4YOkzf07KzjfgQd080z2lnO8mTAc1vgPqnUoJqNJ
   6/8H0Qf6rjOi3W7ld/WII/VbgYw5avFUKfEjCXByuDBSZrAMUbyLcff14
   lVkfxC5bFsS12hh3Kutytydf8vPjwOID5PqOWybRxISHwRvRiLHLxINfj
   gLUbg5JJe0643CnPqDhNQwyDASUtq5ebNgl+W/9m6/5zKu1+FpSs2dgp9
   1nEg56RuNjwv/k8aqEBnyBxf8BurPZR+Lg30qQrQ0P3eaP55idekG41Yg
   FKvBxyXkAq7nLUPrm+0PdFE+HlFht7CktCX0yA1izCbiVv0TVrSH2l+t/
   g==;
IronPort-SDR: mr5rwO6M/mOdw1hl+KMbGoU/ieoDdtwPsIZSMBuK6itrVDCq1OhtaQ/I0UTBaER5oPtoGevo0f
 QmmYfYtmv+TIl23fLmEpH2rApEZA9hZFW8SNczHeG37jb8QSkV4b5PbDs8fOFZkQ0i9UfbFyBT
 cJwbpvsSAZmD6bNoGWK5BmPc7LOeYYnmRFavISbcjiPwQ9TPB7bQOyfC4tFQHc/2bNEugBhje6
 ow2DzERAXPn4XgnPLHGGHBuSx5sGuuatLW1tSiVYCH5RpALX/NFMKezJfZN4UrY6vldShPu+87
 5Co=
X-IronPort-AV: E=Sophos;i="5.64,415,1559491200"; 
   d="scan'208";a="116397475"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 15:58:58 +0800
IronPort-SDR: cqdGkb3OVlDdgYwOikNlR7j9HGSLeH9D1J9OUo6Pu2Jud1lV0e55b4mUDULOV1EYhJBPWnEI4n
 zYrWMkTojG+pvbXn/Nz8R4HYBMl0U0CCT8zBnEVcfN9Ty5orROvxb5L01omqNYqoGPE7FaEYaW
 hIuyUg0k2ROmpWNnIzTPH3+ATuOYLx/o3E37vOq17O/ABeDN43bCecJ5TDywMWHdz18CtlrTLD
 DLsd4BK+Yu8nBfks0nYxeJf6hw34ELDOZ5mjuwUu2jtOkx6VwM0fc6aTFBO/HB4JpyXGH/dht2
 JrwRfN4OgwNe7gheHK5ovNNi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 00:56:19 -0700
IronPort-SDR: 5+z4id9bKYI3iBBh15JNRJHsyhAB1X1xxEPv8cc5V+2UHHTZm/FVENkLtf82Mh1hLQ9rozGuwf
 WuPlKEfi6xXbIvx8HuHh+8w8Oni43TrwC0fq8SfhxiP4rI/L9aWHGGvB1DBfRtoSx17Lro8crf
 8JaxCm7xlHsAShBFeWwVaiU3/ZxS4HtvbfmdGc8ZcOHlJQ7sC16TwVIZvnzZKLNkiRPe6MI5Kc
 kr+2z7C5MzuFZi3hq/vpFNQPkCjJzeznFqPF5xI9fi2CVjjqMkNkFIAh/P2f5dX4LqVSfKvgRd
 FKY=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 00:58:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 0/3] Optimize tlbflush path
Date:   Thu, 22 Aug 2019 00:51:48 -0700
Message-Id: <20190822075151.24838-1-atish.patra@wdc.com>
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

Changes from v3->v4
1. Simplify the local vs remote usecase.
2. Reorder the patches in the series.

Changes from v2->v3:
1. Split the patches into smaller one per optimization.

Atish Patra (3):
RISC-V: Do not invoke SBI call if cpumask is empty
RISC-V: Issue a local tlbflush if possible.
RISC-V: Issue a tlb page flush if possible

arch/riscv/mm/tlbflush.c | 25 +++++++++++++++++++++++--
1 file changed, 23 insertions(+), 2 deletions(-)

--
2.21.0

