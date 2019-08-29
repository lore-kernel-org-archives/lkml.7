Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EBFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD6F20828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tOnffQYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfH2K7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:59:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2K7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x0XZgx3t1UzfCJFBHVabtWw2MvCtyqf//s0QXH54R5M=; b=tOnffQYNciYRiqyeAqE5jtn7c
        uAlj5rotHDwY8R7Mb4Z5UbWvoPZOlCTYdIwV04ObchSlBVue1FWGtnjtbQQgdyBP9pTlS2mtuTnVD
        T92n6hh8q9gQpLV5J6VOcsmC+C6qTB4ws1wJMCSdmEovc2PVjg6HamYApJBpByUXd8PxlVCHaaKlP
        xMVrHxpYYjl5alLD4cT4tz98Y1PEQ+3T8oti1KvBYNJ1NzgRLXAP2CT7Tznt9bn1i4DuYG/XUu4IN
        qOdE3GtKdzv9tUDjY4yf9XvLQO5ibDYhhg8V4D7jZDthxoDsGQSLKVU+fnTpUj5UX8B91DpqbLi2L
        nqeo/dYVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3I99-0002ot-RM; Thu, 29 Aug 2019 10:59:19 +0000
Date:   Thu, 29 Aug 2019 03:59:19 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/2] Add support for SBI version to 0.2
Message-ID: <20190829105919.GB8968@infradead.org>
References: <20190826233256.32383-1-atish.patra@wdc.com>
 <20190827144624.GA18535@infradead.org>
 <a31c39e8653bd04efe0051a5fd6f0238d33a80e7.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31c39e8653bd04efe0051a5fd6f0238d33a80e7.camel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:19:42PM +0000, Atish Patra wrote:
> I did not understand this part. All the legacy SBI calls are defined as
> a separate extension ID not single extension. How did it break the
> backward compatibility ?

Yes, sorry I mistead this.  The way is is defined is rather
non-intuitive, but actually backwards compatible.

> I think the confusion is because of legacy renaming. They are not
> single legacy extension. They are all separate extensions. The spec
> just called all those extensions as collectively as legacy. So I just
> tried to make the patch sync with the spec.
> 
> If that's the source of confusion, I can rename it to sbi_0.1_x in
> stead of legacy.

I think we actually need to fix the spec instead, even if it just the
naming and not the mechanism.

> >  (1) actually board specific and have not place in a cpu abstraction
> >      layer: getchar/putchar, these should just never be advertised in
> > a
> >       non-legacy setup, and the drivers using them should not probe
> >       on a sbi 0.2+ system
> 
> In that case, we have to update the drivers(earlycon-riscv-sbi &
> hvc_riscv_sbi) in kernel as well. Once these patches are merged, nobody
> will be able to use earlycon=sbi feature in mainline kernel.
> 
> Personally, I am fine with it. But there were some interest during
> RISC-V workshop in keeping these for now for easy debugging and early
> bringup.

The getchar/putchar calls unfortunately are fundamentally flawed, as
they mean the sbi can still access the console after the host has taken
it over using its own drivers.  Which will lead to bugs sooner or later.

And if you can bring up a console driver in opensbi it should be just
as trivial to bring up the kernel version.
