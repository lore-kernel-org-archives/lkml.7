Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B12C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F1420661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfCHTDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:03:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfCHTDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:03:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A36DDC057F40;
        Fri,  8 Mar 2019 19:03:40 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B338C600C8;
        Fri,  8 Mar 2019 19:03:36 +0000 (UTC)
Date:   Fri, 8 Mar 2019 13:03:34 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org, andrew.cooper3@citrix.com
Subject: Re: [PATCH 05/20] x86/uaccess/xen: Suppress SMAP warnings
Message-ID: <20190308190333.dba7s7dg2aj2mpr4@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.530608243@infradead.org>
 <20190308190038.ehrczmqnoulfkuoe@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308190038.ehrczmqnoulfkuoe@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 08 Mar 2019 19:03:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 01:00:38PM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 12:45:16PM +0100, Peter Zijlstra wrote:
> > drivers/xen/privcmd.o: warning: objtool: privcmd_ioctl()+0x1414: call to hypercall_page() with UACCESS enabled
> > 
> > Xen needs to do HV calls with AC=1 for hysterical raisins. Make the
> > warning go away.
> > 
> > XXX: arguably we should rename ANNOTATE_NOSPEC_ALTERNATIVE to
> >      ANNOTATE_IGNORE_ALTERNATIVE.
> > 
> > Cc: andrew.cooper3@citrix.com
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/xen/hypercall.h |   26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > --- a/arch/x86/include/asm/xen/hypercall.h
> > +++ b/arch/x86/include/asm/xen/hypercall.h
> > @@ -214,6 +214,24 @@ xen_single_call(unsigned int call,
> >  	return (long)__res;
> >  }
> >  
> > +static __always_inline void __xen_stac(void)
> > +{
> > +	/*
> > +	 * This is just about as horrible as this interface; we abuse the
> > +	 * nospec alternative annotation to supress objtool seeing the
> > +	 * STAC/CLAC and getting confused about it calling random code with
> > +	 * AC=1.
> > +	 */
> > +	asm volatile(ANNOTATE_NOSPEC_ALTERNATIVE
> > +		     ASM_STAC ::: "memory", "flags");
> > +}
> > +
> > +static __always_inline void __xen_clac(void)
> > +{
> > +	asm volatile(ANNOTATE_NOSPEC_ALTERNATIVE
> > +		     ASM_CLAC ::: "memory", "flags");
> > +}
> > +
> 
> Shouldn't these be using SMAP-based alternatives like stac()/clac() do?

Also this you could get rid of the comment if there were an
ANNOTATE_AC_SAFE macro which does a similar thing.

-- 
Josh
