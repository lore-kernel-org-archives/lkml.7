Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1272920811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfCZQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:16:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48730 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCZQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:16:25 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8okN-00011w-CZ; Tue, 26 Mar 2019 17:16:19 +0100
Date:   Tue, 26 Mar 2019 17:16:18 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     573149609 <zhanggenex@qq.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        jpoimboe <jpoimboe@redhat.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: BUG: KASAN: stack-out-of-bounds in unwind_next_frame
 (*Reproducible*)
In-Reply-To: <tencent_8AB8ECDA7628A2210A7AC0B2C0BF54125F08@qq.com>
Message-ID: <alpine.DEB.2.21.1903261714320.1789@nanos.tec.linutronix.de>
References: <tencent_8AB8ECDA7628A2210A7AC0B2C0BF54125F08@qq.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

On Mon, 25 Mar 2019, 573149609 wrote:

Thanks for the report.

> I think I found a reproducible kernel bug in version 5.0.4.
> Source file: arch/x86/kernel/unwind_orc.c:505
> The KASAN output is as following:
> [   26.095365] BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x1403/0x19e0
> [   26.095365] Read of size 8 at addr ffff88805cc67d18 by task syz-executor.0/2296
...

Can you please verify whether this problem persist in 5.1-rc2? If not, then
we missed a fix to backport. If yes, then we rather fix it there.

Thanks,

	tglx
