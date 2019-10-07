Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C5C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F6E2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tn3/sLQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfJGGsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:48:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfJGGsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VC1GuNkX+uZS9eXnX2PP8oaN3tjy1U0kpr1+rnVuXGQ=; b=tn3/sLQbW2uwgU3t4QIAYel7o
        X6X2P9v3Xe0vjRPmh6lKpF94odAngKMnqVmZ0QVte1VDMMqjnuQDnSO335qKiyn/rcxwPim0i8vr1
        xbLihyeoOMlgIEmdIPy6lcXmh3lgkSNTy23Z4MQ/AYNjtzG49/5SnWHb7YwtIOnrOSLip+8OndOmP
        BrJxYkgvSkOeucZuLB+TvVEeSQgIWhSvTfsq+egiScL+W02KbnX4dIMU4VbUimU99u1yqNUiCuOWo
        T1eyL3+op7UOTLjEtY9KNPhxVqb5ibpnEIlT5rWm7Zr4U3A2WoFo/lnHpFy0DPPr2os/6MZvzKObj
        pDpOLBJeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHMoh-0002fG-I5; Mon, 07 Oct 2019 06:48:23 +0000
Date:   Sun, 6 Oct 2019 23:48:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about using #ifdef CONFIG_PPC64 in driver code
Message-ID: <20191007064823.GB25561@infradead.org>
References: <CAFCwf11-MzroWUmj4qOgwLTibqsdOmPP9cHJjXZmS0Pgr3bEOQ@mail.gmail.com>
 <CAFCwf13AtwkWQ4Gnxi6pfKbcdEK95+X__7cFboN1FdHd1aKNQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13AtwkWQ4Gnxi6pfKbcdEK95+X__7cFboN1FdHd1aKNQw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 12:33:31PM +0300, Oded Gabbay wrote:
> Hi Greg,
> a while ago we had an argument about identifying in my driver's code
> whether I'm running on x86 or powerpc. I tried to do something
> dynamically (based on parent pci bridge ID), and you and other people
> objected to it.
> 
> I see in other drivers (more then a few) that they are using #ifdef
> CONFIG_PPC64 in some places for similar things (e.g. to run code that
> is only needed in case of powerpc).

> e.g. from ocxl driver in misc:
> 
> #ifdef CONFIG_PPC64
> static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
> ...
> #endif
> and also:
> 
> #ifdef CONFIG_PPC64
> if (cpu_has_feature(CPU_FTR_P9_TIDR))
> arg.flags[0] |= OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT;
> #endif
> 
> Is this approach acceptable on you ?

This is a pretty horrible example and needs to be fixed up.

> Can I do something similar in my driver:
> 
> #ifdef CONFIG_PPC64
>       foo (64)
> #else
>       foo (48)
> #endif

No, you can't.
