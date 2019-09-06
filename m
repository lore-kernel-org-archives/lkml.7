Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA147C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD93120854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6GJr2Au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391041AbfIFJPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:15:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52034 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfIFJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A7pQ/2obJSu6glFAN/iZb0WmVvetjWy1D+ZDyW159q0=; b=p6GJr2Au6TrWlxxqLStxIRds3
        7iFWkUB02Kd6586GkS4LwCk+4pdf5Jt/2Gj/B3rmkyeRULXcns1HeHJlDlGqlDZzXpBPNh1brGotx
        7PsSj7im9GKrqgL45P5+Ha5uS1MVfyXlLTI6+uV7Mqb1F5+p58D/OlqSyzA8ZDJtApIs2nhF8vIDw
        qx488sDprcKbJPSiCOum3mRkXLGiCE7aABCz1ljlJq7WoXky41y1BHMskIzL3tkj0hC0gqbhq4Kaa
        DQ5anAnYz8PPvARMepjD/L8d/dNOmHjpKJY1exF82Q/Am4cxqinCxD5WcntHqcyG9E1vTB9kJOVIX
        Ww+lODi/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6AKm-0004yn-IX; Fri, 06 Sep 2019 09:15:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BC19301A5D;
        Fri,  6 Sep 2019 11:14:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2DA429E2C316; Fri,  6 Sep 2019 11:15:10 +0200 (CEST)
Date:   Fri, 6 Sep 2019 11:15:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v3 1/2] x86: xen: insn: Decode Xen and KVM
 emulate-prefix signature
Message-ID: <20190906091510.GV2349@hirez.programming.kicks-ass.net>
References: <156773433821.31441.2905951246664148487.stgit@devnote2>
 <156773434815.31441.12739136439382289412.stgit@devnote2>
 <20190906073436.GS2349@hirez.programming.kicks-ass.net>
 <20190906174519.699b83f08d81b55203212fa1@kernel.org>
 <20190906175143.469287501610cbca73f0abbb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906175143.469287501610cbca73f0abbb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 05:51:43PM +0900, Masami Hiramatsu wrote:
> On Fri, 6 Sep 2019 17:45:19 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > 
> > > How about we make this asm/virt_prefix.h or something and include:
> > > 
> > > /*
> > >  * Virt escape sequences to trigger instruction emulation;
> > >  * ideally these would decode to 'whole' instruction and not destroy
> > >  * the instruction stream; sadly this is not true for the 'kvm' one :/
> > >  */
> > > 
> > > #define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e  /* ud2 ; .ascii "xen" */
> > > #define __KVM_EMULATE_PREFIX  0x0f,0x0b,0x6b,0x76,0x6d	/* ud2 ; .ascii "kvm" */
> 
> BTW, what should we call it, "emulate prefix" or "virt prefix"?
> "virt prefix" sounds too generic to me. So I rather like emulate_prefix.h.

Works for me; and yeah, just see what is best for the other things. I
only started down that road because the Xen and KVM 'prefixes' were
initialized so inconsistently.
