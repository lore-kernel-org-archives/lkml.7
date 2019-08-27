Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF22EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6342173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566900492;
	bh=SFb86+qjaKI9Qky0RQ1rmDRIa1oUN0wb9kAG5FfufGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TxoG02heGhCNjMtYe962ATMsuMICd65z3WKQ+EEhmpj85rsBb7mwcbkdORYdbAgPV
	 vqRSZXZ3g8VlEDwUAcIYX7E9xBNyrkde9SzSxQ9t3DLizCyoQ7unjrs1mapOG07JqQ
	 vPOFA7pp2SgHCTWdNo3I+hujW/9P+DFaOdzeP3oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfH0KIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfH0KIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:08:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0897320656;
        Tue, 27 Aug 2019 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566900490;
        bh=SFb86+qjaKI9Qky0RQ1rmDRIa1oUN0wb9kAG5FfufGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHS1dBUREG89+8lkRgXYXyJTEn/sVVXLcv0VK30wcUemMw9R5/dHvi8NalVVPlUxc
         jK/aCddafeQ7nWrIhDGTow0NDsb2dxSGzuNnzTyB4FWEkulMKBMYTWzJHqW1ii1MeZ
         VPwq0t88YMnxOcaSUdK09Fjg73RUVi7n4tvICkkI=
Date:   Tue, 27 Aug 2019 11:08:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kallsyms: Don't let kallsyms_lookup_size_offset() fail
 on retrieving the first symbol
Message-ID: <20190827100800.nncxkjsxl3exxyd5@willie-the-truck>
References: <20190824131231.26399-1-maz@kernel.org>
 <20190826104638.9098e6fe940ffe19d24959a2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826104638.9098e6fe940ffe19d24959a2@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 10:46:38AM +0900, Masami Hiramatsu wrote:
> On Sat, 24 Aug 2019 14:12:31 +0100
> Marc Zyngier <maz@kernel.org> wrote:
> 
> > An arm64 kernel configured with
> > 
> >   CONFIG_KPROBES=y
> >   CONFIG_KALLSYMS=y
> >   # CONFIG_KALLSYMS_ALL is not set
> >   CONFIG_KALLSYMS_BASE_RELATIVE=y
> > 
> > reports the following kprobe failure:
> > 
> >   [    0.032677] kprobes: failed to populate blacklist: -22
> >   [    0.033376] Please take care of using kprobes.
> > 
> > It appears that kprobe fails to retrieve the symbol at address
> > 0xffff000010081000, despite this symbol being in System.map:
> > 
> >   ffff000010081000 T __exception_text_start
> > 
> > This symbol is part of the first group of aliases in the
> > kallsyms_offsets array (symbol names generated using ugly hacks in
> > scripts/kallsyms.c):
> > 
> >   kallsyms_offsets:
> >           .long   0x1000 // do_undefinstr
> >           .long   0x1000 // efi_header_end
> >           .long   0x1000 // _stext
> >           .long   0x1000 // __exception_text_start
> >           .long   0x12b0 // do_cp15instr
> > 
> > Looking at the implementation of get_symbol_pos(), it returns the
> > lowest index for aliasing symbols. In this case, it return 0.
> > 
> > But kallsyms_lookup_size_offset() considers 0 as a failure, which
> > is obviously wrong (there is definitely a valid symbol living there).
> > In turn, the kprobe blacklisting stops abruptly, hence the original
> > error.
> > 
> > A CONFIG_KALLSYMS_ALL kernel wouldn't fail as there is always
> > some random symbols at the beginning of this array, which are never
> > looked up via kallsyms_lookup_size_offset.
> > 
> > Fix it by considering that get_symbol_pos() is always successful
> > (which is consistent with the other uses of this function).
> 
> Thank you for fixing this issue!
> This looks good to me :)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

There doesn't appear to be an official tree for this file so, unless anybody
objects, I'll pick this up via arm64 as it's looking like there are some
other fixes on the horizon too.

Will
