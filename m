Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE17C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC64026D5E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EAUDatB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfEaRs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:48:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaRs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ox5SYttOkOuRXfS7cs3JsHQ+R0GLTw4N6BHjQRoaW9E=; b=EAUDatB5hW46G9M1Ux5rKjKdO
        2gatVjjYZRPlz/Y8yieBJl+NTOqpgatgBKBU0KD4TsTPRHuOAOdASb97lecou22eiM2OapeLCzPgp
        B0i0qPk66SspAy6OJFa1NIO4ol3ItewiiFaxYuuw7LLCg6ihQcITsomL18HAh28KsH655hSpvEaXK
        xELWZ9GoG8dKe0FlwT+BYKfNw7vVZDolyKXu+JXuRall/zajJ1hcm3jvaxeoZ0nnxHMg7OjxSwtOg
        5Emd9DEvLQB4DtO5nEcmw84mXxgWLl2OJrNXW+ggkep9wq+uTLg1JfxZNt1MTnoW7sdnu4+jS5Uxt
        sHxXOWYlg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWleA-0002Ni-V0; Fri, 31 May 2019 17:48:54 +0000
Date:   Fri, 31 May 2019 10:48:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] mm: Generalize notify_page_fault()
Message-ID: <20190531174854.GA31852@bombadil.infradead.org>
References: <1559195713-6956-1-git-send-email-anshuman.khandual@arm.com>
 <20190530110639.GC23461@bombadil.infradead.org>
 <4f9a610d-e856-60f6-4467-09e9c3836771@arm.com>
 <20190530133954.GA2024@bombadil.infradead.org>
 <f1995445-d5ab-f292-d26c-809581002184@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1995445-d5ab-f292-d26c-809581002184@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:17:43PM +0530, Anshuman Khandual wrote:
> On 05/30/2019 07:09 PM, Matthew Wilcox wrote:
> > On Thu, May 30, 2019 at 05:31:15PM +0530, Anshuman Khandual wrote:
> >> On 05/30/2019 04:36 PM, Matthew Wilcox wrote:
> >>> The two handle preemption differently.  Why is x86 wrong and this one
> >>> correct?
> >>
> >> Here it expects context to be already non-preemptible where as the proposed
> >> generic function makes it non-preemptible with a preempt_[disable|enable]()
> >> pair for the required code section, irrespective of it's present state. Is
> >> not this better ?
> > 
> > git log -p arch/x86/mm/fault.c
> > 
> > search for 'kprobes'.
> > 
> > tell me what you think.
> 
> Are you referring to these following commits
> 
> a980c0ef9f6d ("x86/kprobes: Refactor kprobes_fault() like kprobe_exceptions_notify()")
> b506a9d08bae ("x86: code clarification patch to Kprobes arch code")
> 
> In particular the later one (b506a9d08bae). It explains how the invoking context
> in itself should be non-preemptible for the kprobes processing context irrespective
> of whether kprobe_running() or perhaps smp_processor_id() is safe or not. Hence it
> does not make much sense to continue when original invoking context is preemptible.
> Instead just bail out earlier. This seems to be making more sense than preempt
> disable-enable pair. If there are no concerns about this change from other platforms,
> I will change the preemption behavior in proposed generic function next time around.

Exactly.

So, any of the arch maintainers know of a reason they behave differently
from x86 in this regard?  Or can Anshuman use the x86 implementation
for all the architectures supporting kprobes?
