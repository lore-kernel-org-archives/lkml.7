Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4B8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BB121773
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554029661;
	bh=4HM+x0ouR3FkGp8ze/XbaNHI9VClw8K5B1zNh85MZ8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZkgA8LimMM206CMSE4Zk0JHUCALlz60VfBn4vgcxGI+a8p7ZgTrqpE79XejrxIbrD
	 3prREpIhjWKXmn+UALx24PfPni8/O7+FcmoauGRU/BhFKYQ5E/FgsiF4O3gG8tAMmp
	 y15iGKoRrKulegos+xjHPBhpigNw+j2HSB4RyOLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfCaKyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfCaKyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:54:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F63206B7;
        Sun, 31 Mar 2019 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554029658;
        bh=4HM+x0ouR3FkGp8ze/XbaNHI9VClw8K5B1zNh85MZ8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZTPcr1au0PQAV1iPq5yG9K0vmonsAAk8j06Dx+ybAYuFjOqmsYWTOlFNLw8Im8ca
         NGWRG0NbvV1c34A7WB7ljoE2G0NhYmkyjKMxF2aqBn7haNpk2BZCbh7s1cLR+WbIay
         Qxev5e2mp2W6sqAFNmYJminoTP+1sDBtw1l3zgE4=
Date:   Sun, 31 Mar 2019 12:54:12 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andrey Abramov <st5pub@yandex.ru>
Cc:     George Spelvin <lkml@sdf.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "richard@nod.at" <richard@nod.at>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vgupta@synopsys.com" <vgupta@synopsys.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Message-ID: <20190331105412.GA9393@kroah.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
 <20190330183826.GB21828@kroah.com>
 <201903302015.x2UKFnSL003850@sdf.org>
 <20434561554015618@myt1-cd60b8ae9bb9.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20434561554015618@myt1-cd60b8ae9bb9.qloud-c.yandex.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 10:00:18AM +0300, Andrey Abramov wrote:
> 30.03.2019, 23:17, "George Spelvin" <lkml@sdf.org>:
> > On Sat, 30 Mar 2019 at 19:38:26 +0100 greh k-h wrote;
> >>  On Sat, Mar 30, 2019 at 07:43:53PM +0300, Andrey Abramov wrote:
> >>>  Replace int type with size_t type of the size argument
> >>>  in the swap function, also affect all its dependencies.
> >>
> >>  This says _what_ the patch does, but it gives no clue as to _why_ you
> >>  are doing this. Neither did your 0/5 patch :(
> >>
> >>  Why make this change? Nothing afterward depends on it from what I can
> >>  tell, so why is it needed?
> >
> > It's just a minor cleanup, making things less surprising for future
> > programmers. As I wrote in a comment in my patches, using a signed type
> > for an object size is definitely a wart; ever since C89 it's expected
> > you'd use size_t for the purpose.
> >
> > The connection is that it's a natural consequence of doing a pass over
> > every call site.
> >
> > You're right it could be dropped from the series harmlessly, but it
> > comes from the same work. But it's all of *three* call sites in the kernel
> > which are affected. Surely that's not an unreasonable amount of churn
> > to clean up a wart?
> 
> George Spelvin is absolutely right: "It's just a minor cleanup, making
> things less surprising for future programmers."

Then document it.

> 31.03.2019, 00:51, "George Spelvin" <lkml@sdf.org>:
> > It was so obvious to me that I didn't question it, but you have a
> > good point and I'm sure Andrey can clarify. Thanks for the attention!
> 
> I thought that it is obvious enough (argument called "size" should be
> of type size_t in the 90% of cases).  Should I resend this patch with
> better explanation "why"?

Yes, "int" is a very nice variable for "size", you need to explain why
it is better to use size_t here please.

thanks,

greg k-h
