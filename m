Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CE3C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A4C2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dtA/F1XN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfJGIFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:05:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGIFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gdg9elnsf3wozWn5hBtwj3GibPZ8yx8aDTfxb6usBZI=; b=dtA/F1XNxf9MA7A/kG5mlnzgM
        XTY/1k01FeH6bJDlfLrZqow/j86gQPmofg4jHWULInz/SoyzoODA6VHVq2s3StZn1uNmnoiB+pcXK
        lOcBbibB1Hxxz9urelAc8Si8K3YlQRklTmTieTVntKuflDfNNR5GtzZTJG1VkDMdATNcjfYK139Q5
        T9HoA6aMxwBYQaRCSabFznlwyZ+RUTGKptoOUolp+Jrs61xsiIzCfeoL3YGfb/siI13Lu5evtbySP
        aU33ZghazM9F/0hEAiJMfC1smS8DUHojWDiCG0ehJOOH431d4pOhmsNtmHMXCc3SnEDSPg637rn6H
        7cj+PwBIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHO1K-0007Sl-UU; Mon, 07 Oct 2019 08:05:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 536F4305803;
        Mon,  7 Oct 2019 10:04:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05E9C20245BB0; Mon,  7 Oct 2019 10:05:28 +0200 (CEST)
Date:   Mon, 7 Oct 2019 10:05:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/3] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191007080527.GA2311@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.053490768@infradead.org>
 <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
 <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
 <20191003110106.GI4581@hirez.programming.kicks-ass.net>
 <20191004224540.766dc0fd824bcd5b8baa2f4c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004224540.766dc0fd824bcd5b8baa2f4c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:45:40PM +0900, Masami Hiramatsu wrote:
> Hi Peter,
> 
> On Thu, 3 Oct 2019 13:01:06 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > > I'm halfway through a patch introducing:
> > > 
> > >   union text_poke_insn {
> > > 	u8 code[POKE_MAX_OPCODE_SUZE];
> > > 	struct {
> > > 		u8 opcode;
> > > 		s32 disp;
> > > 	} __attribute__((packed));
> > >   };
> > > 
> > > to text-patching.h to unify all such custom unions we have all over the
> > > place. I'll mob up the above in that.
> 
> I think it is good to unify such unions, but I meant above was, it was
> also important to unify the opcode macro. Since poke_int3_handler()
> clasifies the opcode by your *_INSN_OPCODE macro, it is natual to use
> those opcode for text_poke_bp() interface.

Right, but I think we should do that as another patch, there's a lot of
instances in that file and just changing one or two over is 'weird'.

I can put it on the todo to fix that all up.
