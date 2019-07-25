Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86FFC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A308A21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbfGYCym convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:54:42 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:38369 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389442AbfGYCym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:54:42 -0400
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jul 2019 22:54:41 EDT
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x6P2hUwb018127
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 11:43:30 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x6P2hUXu005633;
        Thu, 25 Jul 2019 11:43:30 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x6P2gRmC020128;
        Thu, 25 Jul 2019 11:43:30 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2430492; Thu, 25 Jul 2019 11:31:13 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Thu,
 25 Jul 2019 11:31:12 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Subject: [PATCH 0/2] fix kernel panic due to use uninitialized struct pages
Thread-Topic: [PATCH 0/2] fix kernel panic due to use uninitialized struct
 pages
Thread-Index: AQHVQpEGSdyTWH0GVESV/sMpt20Kgg==
Date:   Thu, 25 Jul 2019 02:31:11 +0000
Message-ID: <20190725023100.31141-1-t-fukasawa@vx.jp.nec.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel panic was observed during reading /proc/kpageflags for
first few pfns allocated by pmem namespace:

BUG: unable to handle page fault for address: fffffffffffffffe
[  114.495280] #PF: supervisor read access in kernel mode
[  114.495738] #PF: error_code(0x0000) - not-present page
[  114.496203] PGD 17120e067 P4D 17120e067 PUD 171210067 PMD 0
[  114.496713] Oops: 0000 [#1] SMP PTI
[  114.497037] CPU: 9 PID: 1202 Comm: page-types Not tainted 5.3.0-rc1 #1
[  114.497621] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
[  114.498706] RIP: 0010:stable_page_flags+0x27/0x3f0
[  114.499142] Code: 82 66 90 66 66 66 66 90 48 85 ff 0f 84 d1 03 00 00 41 54 55 48 89 fd 53 48 8b 57 08 48 8b 1f 48 8d 42 ff 83 e2 01 48 0f 44 c7 <48> 8b 00 f6 c4 02 0f 84 57 03 00 00 45 31 e4 48 8b 55 08 48 89 ef
[  114.500788] RSP: 0018:ffffa5e601a0fe60 EFLAGS: 00010202
[  114.501373] RAX: fffffffffffffffe RBX: ffffffffffffffff RCX: 0000000000000000
[  114.502009] RDX: 0000000000000001 RSI: 00007ffca13a7310 RDI: ffffd07489000000
[  114.502637] RBP: ffffd07489000000 R08: 0000000000000001 R09: 0000000000000000
[  114.503270] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000240000
[  114.503896] R13: 0000000000080000 R14: 00007ffca13a7310 R15: ffffa5e601a0ff08
[  114.504530] FS:  00007f0266c7f540(0000) GS:ffff962dbbac0000(0000) knlGS:0000000000000000
[  114.505245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  114.505754] CR2: fffffffffffffffe CR3: 000000023a204000 CR4: 00000000000006e0
[  114.506401] Call Trace:
[  114.506660]  kpageflags_read+0xb1/0x130
[  114.507051]  proc_reg_read+0x39/0x60
[  114.507387]  vfs_read+0x8a/0x140
[  114.507686]  ksys_pread64+0x61/0xa0
[  114.508021]  do_syscall_64+0x5f/0x1a0
[  114.508372]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  114.508844] RIP: 0033:0x7f0266ba426b

Earlier approach to fix this was discussed here:
https://marc.info/?l=linux-mm&m=152964770000672&w=2

This patchset is another approach to fix it and also provide
a fix for potential future bugs discovered in the process.

Toshiki Fukasawa (2):
  /proc/kpageflags: prevent an integer overflow in stable_page_flags()
  /proc/kpageflags: do not use uninitialized struct pages

 fs/proc/page.c           | 40 +++++++++++++++++++++-------------------
 include/linux/memremap.h |  6 ++++++
 kernel/memremap.c        | 20 ++++++++++++++++++++
 3 files changed, 47 insertions(+), 19 deletions(-)

-- 
1.8.3.1

