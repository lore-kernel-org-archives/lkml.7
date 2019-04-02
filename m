Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FDB206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfDBPz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:55:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37454 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDBPz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:55:56 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBLlR-0003d8-Te; Tue, 02 Apr 2019 17:55:54 +0200
Date:   Tue, 2 Apr 2019 17:55:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     573149609 <zhanggenex@qq.com>
cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: KASAN: stack-out-of-bounds in unwind_next_frame()
In-Reply-To: <tencent_E6DB50597F35B3DFDBE589FA2AE0033F020A@qq.com>
Message-ID: <alpine.DEB.2.21.1904021753070.1676@nanos.tec.linutronix.de>
References: <tencent_E6DB50597F35B3DFDBE589FA2AE0033F020A@qq.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

On Mon, 1 Apr 2019, 573149609 wrote:

> In 5.1-rc2:
> [   66.801925] BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x177b/0x19e0
> [   66.801925] Read of size 8 at addr ffff88806d007c50 by task syz-executor374/5016
> [   66.801925] CPU: 0 PID: 5016 Comm: syz-executor374 Not tainted 5.1.0-rc2 #1
> [   66.801925]  dump_stack+0xca/0x13e
> [   66.801925]  ? unwind_next_frame+0x177b/0x19e0
> [   66.801925]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   66.801925]  ? perf_prepare_sample+0x83a/0x15a0
> [   66.801925]  ? deref_stack_reg+0xe0/0xe0
> [   66.801925]  ? lock_downgrade+0x620/0x620
> [   66.801925]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   66.801925]  perf_callchain_kernel+0x400/0x5b0
> .......
> [   66.801925] Memory state around the buggy address:
> [   66.801925]  ffff88806d007b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   66.801925]  ffff88806d007b80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
> [   66.801925] >ffff88806d007c00: 04 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00
> [   66.801925]                                                  ^
> [   66.801925]  ffff88806d007c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   66.801925]  ffff88806d007d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> And I also tested this problem on 5.1-rc3:

> [65.871020]BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x177b/0x19e0
> [65.871020]Read of size 8 at addr ffff888067657988 by task syz-executor798/206

....

Unfortunately this does not reproduce. Please provide your kernel config.

Thanks,

	tglx
