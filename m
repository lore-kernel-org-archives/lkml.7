Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED582C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3DF2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hgwNVBPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfHFIal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:30:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/s8wUNloiVZ/r39DkCHiVqmnKOfRol4hev9m4wU/nnw=; b=hgwNVBPR8xl0odZWuchrJVQcX
        3su7RZX0frEguJeRnZ6+3h3hvReZRGEX8N700MrQbaje4yl7A0T40cVnOl7nP5xYmATfSy+tHccMP
        PQIdIJ5WCCTkFOiGak6iDAaFKfqYG6qeDqggPdEnar6XDbJN31SXBieGI5mJT1qJB5BcIiMENIq6E
        MOKBO2UxvOBl8YodIUuxMf/I3ANstalAfJHbXDUUCfC8VAc49vwsQarrFSdOH+SJ8MygukczTc/jN
        Vv2nT3PfK5pkb5OItnNSg1qDrdoEWSW+Q8r6oHU7XbIKJEasF45ShptwDOBIGu79w1t1lViBAlHK6
        lESRTSSdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huura-0004S5-1j; Tue, 06 Aug 2019 08:30:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D150201D5B0F; Tue,  6 Aug 2019 10:30:32 +0200 (CEST)
Date:   Tue, 6 Aug 2019 10:30:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Garnier <thgarnie@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 04/11] x86/entry/64: Adapt assembly for PIE support
Message-ID: <20190806083032.GN2332@hirez.programming.kicks-ass.net>
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-5-thgarnie@chromium.org>
 <20190805172854.GF18785@zn.tnic>
 <CAJcbSZGedSfZZ5rveH2+_3q7pvmMyDGLxmZU41Nno=ZBX8kN=w@mail.gmail.com>
 <20190806050851.GA25897@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806050851.GA25897@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:08:51AM +0200, Borislav Petkov wrote:
> On Mon, Aug 05, 2019 at 10:50:30AM -0700, Thomas Garnier wrote:
> > I saw that %rdx was used for temporary usage and restored before the
> > end so I assumed that it was not an option.
> 
> PUSH_AND_CLEAR_REGS saves all regs earlier so I think you should be
> able to use others. Like SAVE_AND_SWITCH_TO_KERNEL_CR3/RESTORE_CR3, for
> example, uses %r15 and %r14.

AFAICT the CONFIG_DEBUG_ENTRY thing he's changing is before we setup
pt_regs.

Also consider the UNWIND hint that's in there, it states we only have
the IRET frame on stack, not a full regs set.
