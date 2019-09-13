Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D53C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A420830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568382906;
	bh=BHBg0k71VHbv9SgctzdWgVn1sdAemXeUVtSK9KI7bNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zJ9UBbE9nd9+qWqJods9HqROyuGAN4/D+ScErj3E7rJtZkfSDFqfEuN8LRraVCFeZ
	 6713TUO8CUbxx5bhifMd/cUrjQd+5in9EOmS231HlV28KXGyF6R6Erj+QToP5Pq8D9
	 uTHwOGiAEiu2+iL0eLXWbDe/UdrZ/TnYWJeyNAoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390461AbfIMNzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:55:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbfIMNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bNVVCafqJkMcKoP1y59HFv8nRZ31wfx1kpQ64ijtqic=; b=iK98qwUe7lOp1d7EKY7SRunR0
        JlOgLWm5Fu6g9XFQG1KRkDv+Y0UkI6LgXnV+4TLv+uqQqp6SjUZHhy342WFPU8ErtM2c2hWxh3j2U
        lJkoc/JImKg7rfJvB54cPZVHIS2vg1E8CjdL09vS+vcN/EPqDA6k44scEudr4qd+vzgrMsH6GPHqW
        3+p4AYZdLaRyJ4ygVLqG/8QJ4f7VmWIqojyGf+5liR/oIEh4qx3+FOVFg0iAMnHsPuk7vCxcztdgV
        JbKDP0E9YgdjmUVjZ9hIkTbva1WtTMDiWSiwibb4ud+JDJhkstCYHyPLTWw25+wp37jEmVhG08IJ6
        PAZ5vnqfQ==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8m2I-0003uH-Lp; Fri, 13 Sep 2019 13:54:55 +0000
Date:   Fri, 13 Sep 2019 10:54:46 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Matthew Wilcox <willy6545@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Joe Perches <joe@perches.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
Message-ID: <20190913105446.2b7af558@coco.lan>
In-Reply-To: <CAFhKne8Nbk=OnZO_pqPURneVtxcHqbfkH+xJBrAYfCfsntfQ2g@mail.gmail.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
        <yq1o8zqeqhb.fsf@oracle.com>
        <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
        <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
        <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
        <CAFhKne8Nbk=OnZO_pqPURneVtxcHqbfkH+xJBrAYfCfsntfQ2g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 13 Sep 2019 08:56:30 -0400
Matthew Wilcox <willy6545@gmail.com> escreveu:

> It's easy enough to move the kernel-doc warnings out from under W=1. I only
> out them there to avoid overwhelming us with new warnings. If they're
> mostly fixed now, let's make checking them the default.

Didn't try doing it kernelwide, but for media we do use W=1 by default,
on our CI instance.

There's a few warnings at EDAC, but they all seem easy enough to be
fixed.

So, from my side, I'm all to make W=1 default.

Regards,
Mauro

> 
> On Thu., Sep. 12, 2019, 16:01 Bart Van Assche, <bvanassche@acm.org> wrote:
> 
> > On 9/12/19 8:34 AM, Joe Perches wrote:  
> > > On Thu, 2019-09-12 at 14:31 +0100, Bart Van Assche wrote:  
> > >> On 9/11/19 5:40 PM, Martin K. Petersen wrote:  
> > >>> * The patch must compile without warnings (make C=1  
> > CF="-D__CHECK_ENDIAN__")  
> > >>>   and does not incur any zeroday test robot complaints.  
> > >>
> > >> How about adding W=1 to that make command?  
> > >
> > > That's rather too compiler version dependent and new
> > > warnings frequently get introduced by new compiler versions.  
> >
> > I've never observed this myself. If a new compiler warning is added to
> > gcc and if it produces warnings that are not useful for kernel code
> > usually Linus or someone else is quick to suppress that warning.
> >
> > Another argument in favor of W=1 is that the formatting of kernel-doc
> > headers is checked only if W=1 is passed to make.
> >
> > Bart.
> >
> > _______________________________________________
> > Ksummit-discuss mailing list
> > Ksummit-discuss@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
> >  



Thanks,
Mauro
