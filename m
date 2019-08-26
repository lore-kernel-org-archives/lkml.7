Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C085CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C5A217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EUv8rLmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfHZXdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:33:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61044 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfHZXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566862409; x=1598398409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c7HyBE9MxmHzkUFyuO44BKPtCDc7GbdgX0jFaQ0/3tk=;
  b=EUv8rLmncqsoi1+eqyTAtspdM8IRD/R7soVkUIL7b56Q+hUHEkW5XFxg
   NTD+ck30XO7Gny8pcDXMYv4HtogFuqGQfP610kLvmGYMTtvXo7VN2Q80v
   zvg7PMULXGSESZGnN30usY/r+S4ZrHYnIYX12giQ+NB9qP6TeTq2adCBt
   V45vT9pL7KGlgl01BKvxJG2YXyeVbo2A7eQkBqM5CAMiB6WVRq5liJhow
   dULmFJA/vr6t+FTwP2Q6sOjC4jZgjbCVC24LdLgYScM61DbWDP6SQ/a+E
   G18mglDo4YznCQq/dolBWjdA1VyeGbqKZuIJM1slpojios3ylQx9LsRtg
   w==;
IronPort-SDR: eiRhv/ImHvqV5eo2bMw7mBwPC9jPPLUNa4cY1zB0/f7bF7p/WihWDl0HxhlX7oViJt4EO2wJ+Z
 Crk3Jd9npfQPDQXvoLFkiLLUp7efWIaPKN5l0/YEdxB0cd7Z4ing5FA1kM/jxI17SAgtJ4mq7l
 H0XPbdADeLLiHRZGSp+4uXlrZbebqDc2e1cL0dOoS7g/qthh8idWHT/LGfsLi+ChAl7xB07nDG
 jGEgETmsSO8B/dBl5HaUgeD03Xiyyvcb1d/PmNBW+1eUNOrFD6qCuMU1V80fH0XpOy1YAiW73F
 MmU=
X-IronPort-AV: E=Sophos;i="5.64,435,1559491200"; 
   d="scan'208";a="116718026"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2019 07:33:27 +0800
IronPort-SDR: voUB7PV34RQJvMk2sTpSSIUufSJRfWTO+KpsR5aYmpp22oky624eppiNhWiOjJ0JpMsY2dnAQe
 Bs67gpV6S42GitHKJxrfjxJ4+GFg6FHi8THesfW2wIRmAYqZTmECiKPgwkpHZkRcQZWvy/44bH
 P+6q4bSpCVScWc0H7oDGJmM8rwRMbOonVB0+7TpEOZQ3OMIO58peYrDj8JTvvYXiR/N50dOtLD
 3ww3QqPCjxgy+mFFTEia60KAPgXwB80tpqspwb1t3FOemN09SqnmkP+AZ58jsZ4bpyj7B+HR88
 nMWiDlimWbs0H+ZTUDsPxQB+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 16:30:39 -0700
IronPort-SDR: 9Zd5jC5jSoaARYwrFGDSti3pbB6lV95YOCcz73lSwbo+WPdag1frpWP9ueLJKzk5qW84IRcSIg
 gqU0EwZtUo6rBWwZY4mBlFoz54S+JaxYhL6sn2qZS6QhKTGClyGt7aD6oIfJBA8957JeJOl1Ie
 V205cfZVDjfU2n4BhwdLOpNTeK44dXkO+whV6x/gR23XDg+ZgaA8Ie1ZPay3IEvj0sW7iiObOf
 g8vgyCN/8zcUz/VVPoP3ubRJPV0bIjatVXe5qrz6qC9NsZANvj2kau9OGfKxN7xQiSH5GRk7Fl
 eRw=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Aug 2019 16:33:27 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 0/2] Add support for SBI version to 0.2 
Date:   Mon, 26 Aug 2019 16:32:54 -0700
Message-Id: <20190826233256.32383-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to add support for SBI specification version
v0.2. It doesn't break compatibility with any v0.1 implementation.
Internally, all the v0.1 calls are just renamed to legacy to be in
sync with specification [1].

The patches for v0.2 support in OpenSBI are available at
http://lists.infradead.org/pipermail/opensbi/2019-August/000422.html

[1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc

Atish Patra (2):
RISC-V: Mark existing SBI as legacy SBI.
RISC-V: Add basic support for SBI v0.2

arch/riscv/include/asm/sbi.h | 109 +++++++++++++++++++++++++----------
arch/riscv/kernel/Makefile   |   1 +
arch/riscv/kernel/sbi.c      |  50 ++++++++++++++++
arch/riscv/kernel/setup.c    |   2 +
4 files changed, 131 insertions(+), 31 deletions(-)
create mode 100644 arch/riscv/kernel/sbi.c

--
2.21.0

