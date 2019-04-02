Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA2FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6720857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfDBIys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:54:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34121 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbfDBIys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:54:48 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBFBp-00006F-AE; Tue, 02 Apr 2019 10:54:41 +0200
Date:   Tue, 2 Apr 2019 10:54:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
In-Reply-To: <alpine.DEB.2.21.1903272337250.1789@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904021053160.1676@nanos.tec.linutronix.de>
References: <20190326213803.GN18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de> <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org> <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de> <20190327145918.GU18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903271600050.1789@nanos.tec.linutronix.de> <20190327154522.GV18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903271958320.1789@nanos.tec.linutronix.de> <20190327204049.GW18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903272217240.1789@nanos.tec.linutronix.de>
 <20190327222914.GX18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903272337250.1789@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019, Thomas Gleixner wrote:
> On Wed, 27 Mar 2019, Andi Kleen wrote:
> 
> > > > I checked the code general and with the .globl in NATIVE_LABEL the
> > > 
> > > With or without? I removed that as well.
> > 
> > With.
> > 
> > LTO would still need the .globls because the variable and the asm
> > statement can end up in different assembler files, and resolution
> > would rely on the linker.
> 
> This really sucks. As this is a constant source of trouble, we might better
> bite the bullet and get rid of this fancy macro completely. It's not that
> we add these patch patterns every other day.
> 
> So a good old:
> 
> /* xor %eax %ex */
> static const unsigend char patch_qspinlock[] = { 0x31, 0xc0 };
> 
> and then in the patch code:
> 
> 	return paravirt_patch_insns(ibuf, len, patch_qspinlock,
>     	   			    patch_qspinlock + ARRAY_SIZE(patch_qspinlock));
> 
> might be less trouble than dealing with that clever inline assembly
> forever.

Just for the record. GCC people have confirmed that all the constructs suck
in one way or the other and are just working by chance. So the above is the
sanest solution.

Thanks,

	tglx


