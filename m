Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CDBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B84F20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BZH30xY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfCEULg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:11:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfCEULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x9SGw30xc4tViDSHp9clTrj2CNLlRzCFkYvhGOCoSwo=; b=BZH30xY77voSA2DMnNBrdgaO5
        XTV127Nqakg+r5MUxKy28mGRcTPkS6hH4ddVH4AGkb7Vlv/jpeszRAT3GWb5RGAmkI9eVMF3TjPU4
        Fj10igEtO2uVs5vA29iLxZ82mjkRxxFF1QMmc+QBzCH8QMFYy3BQPOYt9KCcaXlMna/jFUotHGEkt
        ra6EGEy6HkH6syktgdxZb7Pt1arCZ/RDwqYQQZUrym0otDd2dosURN2SVK3JXYkfO5ys39YETNlUd
        d3EsovvQurAEeBxZS93jwQE1CkX/BuaE1UHdoeD4JL0tbHvxwhPc1/V1LPT8hinUFFUmJItb4viwn
        67YwES6ng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1GPR-0003CE-Pf; Tue, 05 Mar 2019 20:11:29 +0000
Date:   Tue, 5 Mar 2019 12:11:29 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Louis Taylor <louis@kragniz.eu>,
        Jonathan Corbet <corbet@lwn.net>, pmladek@suse.com,
        geert+renesas@glider.be, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Subject: Re: [PATCH] docs: add extra integer types to printk-formats
Message-ID: <20190305201129.GH13380@bombadil.infradead.org>
References: <20190303123647.22020-1-louis@kragniz.eu>
 <20190303201016.GO9224@smile.fi.intel.com>
 <CAKwvOdm4uCWCtSMVQDVTSKavpT0dCo+ayuwvoXtewmk+ksn5sA@mail.gmail.com>
 <e244390e3d245c94d6d2fb036943e63111ada86d.camel@perches.com>
 <20190305200725.GG13380@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305200725.GG13380@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 12:07:25PM -0800, Matthew Wilcox wrote:
> On Tue, Mar 05, 2019 at 11:59:30AM -0800, Joe Perches wrote:
> > Many of the -Wformat warnings are bogus too.
> > 
> > There's nothing wrong with using %x for a unsigned int
> > of less than long size. (u8/u16)
> 
> I believe you to be incorrect.

No, you're right, I got tangled up in the spec language and stopped
reading too soon.

> 6.5.2.2 Function calls
> 
> 7 If the expression that denotes the called function has a type that does
>   include a prototype, the arguments are implicitly converted, as if by
>   assignment, to the types of the corresponding parameters, taking the
>   type of each parameter to be the unqualified version of its declared
>   type. The ellipsis notation in a function prototype declarator causes
>   argument type conversion to stop after the last declared parameter. The
>   default argument promotions are performed on trailing arguments.

... the default argument promotions performed on the trailing arguments
promote short/char to int.  So you were right.

> I could define a calling convention for my CPU which says to pack u8s
> and u16s as tightly as possible in registers (or on the stack), rather
> than the prevailing calling convention of having each argument take up
> at least one register-sized slot.

... and that is just wrong; it's not allowed.

