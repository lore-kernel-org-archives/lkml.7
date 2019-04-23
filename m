Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B65BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130232183E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PqUPvHzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfDWRjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:39:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52582 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfDWRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2q5bHxyVaSUQ5sH4NkpY5LEKO5vrmJSao/hJT9S7ZPk=; b=PqUPvHzHaTirYCRxEP+XrBzgPZ
        9auAeGoNGTgXWGZx88vZeAN3Jiz/+1hHQvoXSFrdmXqhMMApe9PrCBlXvXOKQkfOSk+jGb8B63rQq
        Vj9mMG10eV3l1yeve4Z0XspSSk/QHzwhbArig58OJ36rzK6FVsuKwTjkV40jsS41Ge6DmJn6GW7fE
        41f8LDaeNFYP9/HOu0nAMKmI5PhQtAf5qGo5/2fPFKDGkrUOLxXLuKM/nIAwoJAtyfURaG1WdnRzm
        /+QYE0P4R4DXwB0zAZRoCCJluLayqJsTt3fUR3TgCl7E2nCCk/jxFSDBTWoCHPxVP8eur5TL2n4MS
        Hdh/vxSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIzNy-0007YS-7H; Tue, 23 Apr 2019 17:39:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF79E29C2574D; Tue, 23 Apr 2019 19:39:12 +0200 (CEST)
Date:   Tue, 23 Apr 2019 19:39:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: mmotm 2019-04-19-14-53 uploaded (objtool)
Message-ID: <20190423173912.GJ12232@hirez.programming.kicks-ass.net>
References: <20190419215358.WMVFXV3bT%akpm@linux-foundation.org>
 <af3819b4-008f-171e-e721-a9a20f85d8d1@infradead.org>
 <20190423082448.GY11158@hirez.programming.kicks-ass.net>
 <D7626BC0-FCE9-4424-A6F5-D4AAB6727ED4@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7626BC0-FCE9-4424-A6F5-D4AAB6727ED4@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:07:01AM -0700, Andy Lutomirski wrote:
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> > index 22ba683afdc2..c82abd6e4ca3 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -427,10 +427,11 @@ do {                                    \
> > ({                                \
> >    __label__ __pu_label;                    \
> >    int __pu_err = -EFAULT;                    \
> > -    __typeof__(*(ptr)) __pu_val;                \
> > -    __pu_val = x;                        \
> > +    __typeof__(*(ptr)) __pu_val = (x);            \
> > +    __typeof__(ptr) __pu_ptr = (ptr);            \
> 
> Hmm.  I wonder if this forces the address calculation to be done
> before STAC, which means that gcc can’t use mov ..., %gs:(fancy
> stuff).  It probably depends on how clever the optimizer is. Have you
> looked at the generated code?

I have not; will do before posting the real patch.

