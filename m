Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19853C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74DE20865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SyOYhhaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfJDBUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33208 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfJDBUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570152002; x=1601688002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NzwMkZfhyj9zYXOCuOOZ0vuE69ztDUVtvki7aeyLmd0=;
  b=SyOYhhaK8aZDIXRucb3/YVGgBZ770QYHr/q9NY+gwD7Amxc55JDGWIqC
   M+cRtRN4Hd5nUHWC8F+pyTbf/nfbjagMLTU1027nKeDD/okjFQrHPA6JC
   Jpc55qnB3dUT9WUn3PHRatBLOjgrwy+RWnX5QW1HimVwLWn6c4IBoJNjn
   HEeGT+vZet8CRLwuJ5nbuEX9cWATtJ/a2KoxJUvjMhW6RijJbsisrGmQq
   4pqtSJ8FsQpraBlNpDs9WAZ338yGNgjIxqAE92vkJarVAFh+TZ0NDEs1s
   YIYbzssapugJxa5gMXI2iDn3gideloLASOHG3drb79WEvRf8rPDsYsD1d
   g==;
IronPort-SDR: iFZpQDYyVjMJKrO0yxFbbrjDt/sl/JYcOJYcSMs1ReWhQMNXljxyCc26qBIqWWG5ITQ5lw5oMT
 Lk5MciJv7paiNNDL3fAXO0EY/PHcN2rKAXx7jEUoIAgGeqyXT9Uzpr8gY2vXezj3HBq3e/9RfC
 veKZgChec+l85sF/wyihww7EhssfY1eTnmIpoyJd3ETWflapX3Fagtp69f2XesDr3wNzJbZmCe
 cLI0yHMdwHw7nro3OH9OGvZF7od5d5NipcUNb29F/LT727APROvX+0c0mCBkbDu34SnyFZ2+Dt
 XUo=
X-IronPort-AV: E=Sophos;i="5.67,254,1566835200"; 
   d="scan'208";a="119765636"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2019 09:20:01 +0800
IronPort-SDR: 6vSk2ULkGyku89yDd8uvkHJsnn8psoh3O09WvNkDc1pj8fJ26rC1yNhP/dYopSfaa1B885kBOT
 JWfWb3lJo0zh2SZSwaaFVhxTaVA5LBDg/fiYHX2R7W6P4b+L6KKjvETCAnDck9/Et5vk3AiB/+
 6qomKvEino5YVdglGPzIjZ5dB1R2t672gkXsq23roZXJwzHMauCzyTNjmdPr+UdBNu1/yoPnAI
 CGOcGfxjAeCdpoI0qojt7s4MF9g+Up1ltCaLEAE63kOWQRGejHwali3AnlG0a5nLaietVYzBkS
 dnyx6rxKMnTTK4hvjbPdNJNB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 18:16:10 -0700
IronPort-SDR: KuxEV1SGWdJOztyc5eYy40O3JRvzi+JQ3c0RSx2GcM44hBQu7yP4fnOywYeiIwcgxIVqS1vCJS
 +iR4eFhykfeU2PnByGRiFkYUZGRS2QYw/0smedlSiogmAkcTaSZueo5U54zt7EoKEye6YkGM9f
 n6MF/SjkErw8g1HlVdKrj2fqPi7KhCKVxc0Lv+mx6IG8hEV8FelqiWnipB+Z/hnDWdE+NISKS6
 yPCcRadrRt0YFCp/tbLoudLXfIFGMOSSD1oKd23cNaus/cn6GCt3ZDlDb0ifyEl6YxsOmGPVtx
 sdM=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Oct 2019 18:20:02 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <aghiti@upmem.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v1 PATCH  0/2] Cleanup isa string access and print 
Date:   Thu,  3 Oct 2019 18:19:58 -0700
Message-Id: <20191004012000.2661-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup series addressing issues around isa string accesses
and prints. Patch 1 is actually a revised patch as a result of discussion
in the following thread.

http://lists.infradead.org/pipermail/linux-riscv/2019-September/006702.html

Patch 2 is an additional cleanup that tries to consolidate all isa
string related checks.

Atish Patra (2):
RISC-V: Remove unsupported isa string info print
RISC-V: Consolidate isa correctness check

arch/riscv/include/asm/processor.h |  1 +
arch/riscv/kernel/cpu.c            | 85 ++++++++++++------------------
arch/riscv/kernel/cpufeature.c     |  4 +-
arch/riscv/kernel/smpboot.c        |  4 ++
4 files changed, 39 insertions(+), 55 deletions(-)

--
2.21.0

