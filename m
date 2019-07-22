Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC223C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93D5219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfGVQ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:57:28 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:36182 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfGVQ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:57:27 -0400
X-Greylist: delayed 1166 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 12:57:27 EDT
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1hpbK3-0000th-Ut; Mon, 22 Jul 2019 12:38:00 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 9239D5601D8; Mon, 22 Jul 2019 12:37:59 -0400 (EDT)
Date:   Mon, 22 Jul 2019 12:37:59 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
Subject: 5.3-rc1 panic in dma_direct_max_mapping_size
Message-ID: <20190722163759.GA28686@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

only got a partial panic, but when I threw 5.3-rc1 on a linode vm,
it hit this:

 bus_add_driver+0x1a9/0x1c0
 ? scsi_init_sysctl+0x22/0x22
 driver_register+0x6b/0xa6
 ? scsi_init_sysctl+0x22/0x22
 init+0x86/0xcc
 do_one_initcall+0x69/0x334
 kernel_init_freeable+0x367/0x3ff
 ? rest_init+0x247/0x247
 kernel_init+0xa/0xf9
 ret_from_fork+0x3a/0x50
CR2: 0000000000000000
---[ end trace 2967cd16f7b1a303 ]---
RIP: 0010:dma_direct_max_mapping_size+0x21/0x71
Code: 0f b6 c0 c3 0f 1f 44 00 00 0f 1f 44 00 00 55 53 48 89 fb e8 21 0e 00 00 84 c0 74 2c 48 8b 83 20 03 00 00 48 8b ab
30 03 00 00 <48> 8b 00 48 85 c0 75 20 48 89 df e8 ff f3 ff ff 48 39 e8 77 2c 83
RSP: 0018:ffffb58f00013ae8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffffa35ff8914ac8 RCX: ffffb58f00013a1c
RDX: ffffa35ff81d4658 RSI: 000000000000007e RDI: ffffa35ff8914ac8
RBP: 0000000000000000 R08: ffffa35ff81d4cc0 R09: ffffa35ff82e3bc8
R10: 0000000000000000 R11: 0000000000000000 R12: ffffa35ff8914ac8
R13: 000000000000ffff R14: ffffa35ff826c160 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffa35ffba00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012d220001 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
Kernel Offset: 0x1b000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Will try and get some more debug info this evening if it isn't obvious
from the above.

	Dave
