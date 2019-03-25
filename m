Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF63A20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfCYNFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:05:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfCYNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:05:54 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8PIK-0004fJ-Sv; Mon, 25 Mar 2019 14:05:41 +0100
Date:   Mon, 25 Mar 2019 14:05:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org
Subject: Re: [RESEND PATCH v6 04/12] x86/fsgsbase/64: Enable FSGSBASE
 instructions in the helper functions
In-Reply-To: <alpine.DEB.2.21.1903251345180.1656@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1903251401580.1656@nanos.tec.linutronix.de>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com> <1552680405-5265-5-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1903251107300.1798@nanos.tec.linutronix.de> <alpine.DEB.2.21.1903251345180.1656@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Thomas Gleixner wrote:

> On Mon, 25 Mar 2019, Thomas Gleixner wrote:
> > The whole point of FSGSBASE support is performance, right?
> > 
> > So can please someone explain why having the following in the context
> > switch path when it can be completely avoided is enhancing performance:
> > 
> >   - 4 x SWAPGS
> >   - 1 x RDMSR
> >   - 1 x WRMSR
> 
> Corrrecting myself. That should be:
> 
>      RDGSBASE
>      WRGSBASE
> 
> obviously. Still the point remains.
> 
> >   - 2 x local_irq_save()
> >   - 2 x local_irq_restore()
> > 
> > Of course the local_irq_save/restore() pairs are utterly pointless because
> > switch_to() runs with interrupts disabled already.
> > 
> > SWAPGS instead needs:
> > 
> >   1 x WRMSR
> > 
> > and nothing else.
> > 
> > So trading the single WRMSR against the above in the context switch path is
> > gaining performance, right?

And even IF the sequences are faster than the single WRMSR, this does not
justify the mixed bag of SWAPGS/FSGSBASE usage at all.

Thanks,

	tglx
