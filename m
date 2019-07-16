Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B1C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E0F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbfGPP5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:57:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50666 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:57:36 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnPpc-0002Gs-Vv; Tue, 16 Jul 2019 17:57:33 +0200
Date:   Tue, 16 Jul 2019 17:57:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Neil Horman <nhorman@tuxdriver.com>
cc:     linux-kernel@vger.kernel.org, djuran@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86: Add irq spillover warning
In-Reply-To: <20190716135917.15525-1-nhorman@tuxdriver.com>
Message-ID: <alpine.DEB.2.21.1907161735090.1767@nanos.tec.linutronix.de>
References: <20190716135917.15525-1-nhorman@tuxdriver.com>
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

Neil,

On Tue, 16 Jul 2019, Neil Horman wrote:

> On Intel hardware, cpus are limited in the number of irqs they can
> have affined to them (currently 240), based on section 10.5.2 of:
> https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3a-part-1-manual.pdf

That reference is really not useful to explain the problem and the number
of vectors is neither. Please explain the conceptual issue.
 
> If a cpu has more than this number of interrupts affined to it, they
> will spill over to other cpus, which potentially may be outside of their
> affinity mask.

Spill over?

The kernel decides to pick a vector on a CPU outside of the affinity when
it runs out of vectors on the CPUs in the affinity mask.

Please explain issues technically correct.

> Given that this might cause unexpected behavior on
> performance sensitive systems, warn the user should this condition occur
> so that corrective action can be taken

> @@ -244,6 +244,14 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)

Why on earth warn in the interrupt delivery hotpath? Just because it's the
place which really needs extra instructions and extra cache lines on
performance sensitive systems, right?

The fact that the kernel ran out of vectors for the CPUs in the affinity
mask is already known when the vector is allocated in activate_reserved().

So there is an obvious place to put such a warning and it's certainly not
do_IRQ().

Thanks,

	tglx
