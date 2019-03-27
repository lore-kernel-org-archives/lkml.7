Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9258C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AF720651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfC0PIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:08:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfC0PIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:08:46 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9AAS-0005gU-TJ; Wed, 27 Mar 2019 16:08:41 +0100
Date:   Wed, 27 Mar 2019 16:08:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
In-Reply-To: <20190327145918.GU18020@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1903271600050.1789@nanos.tec.linutronix.de>
References: <20190321220009.29334-1-andi@firstfloor.org> <20190321220009.29334-3-andi@firstfloor.org> <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de> <20190326213803.GN18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
 <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org> <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de> <20190327145918.GU18020@tassilo.jf.intel.com>
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

On Wed, 27 Mar 2019, Andi Kleen wrote:
> On Wed, Mar 27, 2019 at 03:20:08PM +0100, Thomas Gleixner wrote:
> >  /* Simple instruction patching code. */
> > -#define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
> > +#define NATIVE_LABEL(a,x,b) "\n" a #x "_" #b ":\n\t"
> >  
> >  #define DEF_NATIVE(ops, name, code)					\
> > -	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
> > -	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
> > +	static const char start_##ops##_##name[], end_##ops##_##name[]; \
> 
> Please don't apply the static/__visible removal hunk, I will just need to
> revert it again for LTO.

Why on earth is this needed for LTO?

From the GCC manual:

 "This attribute, attached to a global variable or function, nullifies the
  effect of the -fw hole-program command-line option, so the object remains
  visible outside the current compilation unit."

Neither the variable nor the data generated are global anymore. This data
is only used inside this compilation unit and I don't see why LTO needs a
reference outside of it. If so, then I really want to understand WHY
exactly.

Thanks,

	tglx
