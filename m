Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF1C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FFC208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qtSyw2tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfGLNJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:09:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGLNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RoZ9NwrBVujcpsAvtIUW8qVulCLJLVw22pbbzzk1gqI=; b=qtSyw2tgioP0MTUAKB5BWB0bt
        HZPhunYUqGQQ9wiLBRzPovUQQ/niRKOLhDBBcSKReSIE1w6VCx6OqDxBE/z3UMiHoNt2aLsb9L2aS
        jmgQPE/TMEvmYmPDTzWQP/1osZ/srt9yeZ3y9OOsC0iKx9YW5nY3wXiI6UR7+2Nkld74EwAHFhYMn
        EYftcLFpid0YlUG7gwKti7QE6USxah1Qe6GlepNAVH7oNGskDH3o12IEaXVgYAn8Sji8M4DTCCLD1
        LIuCdR8VbRYlDDmBoQSVWD0MTVtWQ6f3HXB1TY/8tIoRcxsLohVivLT+DX6GeG/Y3zef1X/jefIBT
        WVeTxAYLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlvIc-00078I-FO; Fri, 12 Jul 2019 13:09:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBACE2097730C; Fri, 12 Jul 2019 15:09:16 +0200 (CEST)
Date:   Fri, 12 Jul 2019 15:09:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, srinivas.eeda@oracle.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] xen/pv: Fix a boot up hang revealed by int3 self test
Message-ID: <20190712130916.GR3419@hirez.programming.kicks-ass.net>
References: <1562832921-20831-1-git-send-email-zhenzhong.duan@oracle.com>
 <20190712120626.GW3402@hirez.programming.kicks-ass.net>
 <a5f5ea4c-f30d-122e-0161-be7b1cb4877c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f5ea4c-f30d-122e-0161-be7b1cb4877c@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 09:04:22PM +0800, Zhenzhong Duan wrote:
> 
> On 2019/7/12 20:06, Peter Zijlstra wrote:
> > On Thu, Jul 11, 2019 at 04:15:21PM +0800, Zhenzhong Duan wrote:
> > > diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> > > index 4722ba2..2138d69 100644
> > > --- a/arch/x86/xen/enlighten_pv.c
> > > +++ b/arch/x86/xen/enlighten_pv.c
> > > @@ -596,7 +596,7 @@ struct trap_array_entry {
> > >   static struct trap_array_entry trap_array[] = {
> > >   	{ debug,                       xen_xendebug,                    true },
> > > -	{ int3,                        xen_xenint3,                     true },
> > > +	{ int3,                        xen_int3,                        true },
> > >   	{ double_fault,                xen_double_fault,                true },
> > >   #ifdef CONFIG_X86_MCE
> > >   	{ machine_check,               xen_machine_check,               true },
> > I'm confused on the purpose of trap_array[], could you elucidate me?
> 
> Used to replace trap handler addresses by Xen specific ones and sanity check
> 
> if there's an unexpected IST-using fault handler.

git grep xen_int3, failed me. Where does that symbol come from?

> > The sole user seems to be get_trap_addr() and that talks about ISTs, but
> > #BP isn't an IST anymore, so why does it have ist_okay=true?
> 
> Oh, yes, I missed that boolean, thanks. I'll try ist_okey=false for int3 and
> test it tomorrow.

Thanks!
