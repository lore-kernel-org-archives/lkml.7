Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C036C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D871320835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbfDXSTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:19:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55146 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfDXSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:19:54 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJMUT-0003TF-8Q; Wed, 24 Apr 2019 20:19:29 +0200
Date:   Wed, 24 Apr 2019 20:19:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Will Deacon <will.deacon@arm.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Price <steven.price@arm.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 5/5] arm64/speculation: Support 'mitigations=' cmdline
 option
In-Reply-To: <20190424141631.GH14829@fuggles.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.1904242019001.1762@nanos.tec.linutronix.de>
References: <cover.1555085500.git.jpoimboe@redhat.com> <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com> <alpine.DEB.2.21.1904162124020.1780@nanos.tec.linutronix.de> <20190424141631.GH14829@fuggles.cambridge.arm.com>
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

On Wed, 24 Apr 2019, Will Deacon wrote:

> Hi Thomas,
> 
> On Tue, Apr 16, 2019 at 09:26:13PM +0200, Thomas Gleixner wrote:
> > On Fri, 12 Apr 2019, Josh Poimboeuf wrote:
> > 
> > > Configure arm64 runtime CPU speculation bug mitigations in accordance
> > > with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
> > > v2, and Speculative Store Bypass.
> > > 
> > > The default behavior is unchanged.
> > > 
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > ---
> > > NOTE: This is based on top of Jeremy Linton's patches:
> > >       https://lkml.kernel.org/r/20190410231237.52506-1-jeremy.linton@arm.com
> > 
> > So I keep that out and we have to revisit that once the ARM64 stuff hits a
> > tree, right? I can have a branch with just the 4 first patches applied
> > which ARM64 folks can pull in when they apply Jeremy's patches before te
> > merge window.
> 
> I'm assuming that this refers to the core/speculation branch in tip:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=core/speculation
> 
> but please can you confirm that I'm good to pull that into arm64?

Yes. It's all yours :)

Thanks,

	tglx
