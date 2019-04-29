Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E016C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8D1216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q5Q7snqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfD2V15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:27:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37432 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfD2V14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556573276; x=1588109276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4UgYDqaqXewXdZpSjZRGrTp4ntBC/cMWJSLoGwmniTQ=;
  b=Q5Q7snqKEbaeJw89dT4sxNt2mTiWTVM/sEiVVSUS/MewWKkdREICJwMZ
   jaAWzH6kx51sUwQb4XA8Oapd2ULABrDiRRJ1McaP8kDM8KiFJ9SvkqEra
   EZnEkbq0veFFsqKyZwrr7t/ADeRO6r6u9Q+F1bgG+/28PMaBzKANepcmH
   6XIFMd6IX3kULrYw57ghuA2lST4q0RHHkUSJOgNzNK8V6UYM00ZfUfOJE
   Oy8MjMp4bP74B9PuGPF0QWcqIMvhziB2pX6dgpsHitpeiWkAiRG89dLv8
   39yF07q5/a8xAlmuQpGqLKKOuHUFHjj3UHHVCNrhwMa5Ift2xaGFDQfMd
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,411,1549900800"; 
   d="scan'208";a="108317111"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 05:27:56 +0800
IronPort-SDR: +Yvl2PzcEeWHBOSp36FFByi3Nr9UgWi1NEe+QKFq53TiflylLbdeONTHKsGcISB8BnnerfM3y4
 2KFoLW0bi2v2uh7m/F6ntH8FeE2pnPvKbJsuv8If2ftljNrORCbStsS9IDrUYeN/9GjYyaJR+Q
 4M2iRlmzvELhYzhqWQC4Axv4iERjzPVrWVYN3hEy906aJSFqGREpcMS09KteK9NBeUdlWgoe5V
 +KrwAY/MqmIzUffH9UKO0cNMj+Qoi26tKoHnAf63xpmI2kVKYsIe3wkk2N7dnXHMjtgyt190+i
 8Tqg4rFOdX95c5mikhAhUW/I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Apr 2019 14:06:26 -0700
IronPort-SDR: L5YyWUfO1v3iSC0YLTmHGxOo0u8t1/ovWfGcPfXKWdd9zxyno6Wrw7LIYVTLxdypRM/NEMoO0n
 8flKqWEx5OXEU9UPpxTCSIOJ03DdKzYi6Csd/polE4HvD78O/iXdro9jhukq4E8cJwuOvkbUZr
 fWcXQT/T5B+EOBGIfPXu+DydO38MQaREAnKH5WurpdXSeZOxvBpzzV9Ux2B7n/Jge+vygrGCSO
 rT1kBqVqV7h7/H5TcI59TFOh6Wue39RytkiOck9YEBu+zF9WfhwZR1YdgLE5Xuby32fChh+60G
 374=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Apr 2019 14:27:56 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>,
        Changbin Du <changbin.du@intel.com>,
        Gary Guo <gary@garyguo.net>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 0/3] TLB flush counters
Date:   Mon, 29 Apr 2019 14:27:47 -0700
Message-Id: <20190429212750.26165-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V patch (2/3) is based on Gary's TLB flush patch series

https://patchwork.kernel.org/project/linux-riscv/list/?series=97315

The x86 kconfig fix patch(1/3) can be applied separately.

Chnages from v2->v3:
1. Fixed typos and commit text formatting.

Changes from v1->v2:
1. Move the arch specific config option to a common one as it touches
   generic code.
2. Introduced another config that architectures can select to enable
   tlbflush option.

Atish Patra (3):
x86: Move DEBUG_TLBFLUSH option.
RISC-V: Enable TLBFLUSH counters for debug kernel.
RISC-V: Update tlb flush counters

arch/riscv/Kconfig                |  1 +
arch/riscv/include/asm/tlbflush.h |  5 +++++
arch/riscv/mm/tlbflush.c          | 12 ++++++++++++
arch/x86/Kconfig                  |  1 +
arch/x86/Kconfig.debug            | 19 -------------------
mm/Kconfig.debug                  | 13 +++++++++++++
6 files changed, 32 insertions(+), 19 deletions(-)

--
2.21.0

