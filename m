Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522D0C46477
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2243420665
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jas+EXkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfFLLsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:48:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfFLLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N36G2g57Ph5uthflFMPZ6+P+b7ByUozCwCs1YB+Sqpk=; b=jas+EXkG6E230EvfsPKthqm51
        XM2eWfuLmox2Fxh4sqPljdTZYkicu3GTqMofjpZIAdffOApbbBlLivJzIVuiufD+s8O51wVLoeHrE
        nmg7+L86pKdq3W+U3l2/uq41hGO0qTmEvwxFAVMJHh3NVmItNr03HUq7yzCfm+5UquNYLZsqcXvyZ
        W00U07o9+qOClYHKQHWKbvVqP4Ccfns9yXl2W6rW1DkLwSuOCI1huPCGVEfMg6Ai1IWdxS+QctC1r
        mDlupCXKhzywCvZz/McwbowxRzceFUxjUzNR2J3wOKBux6Kn3PVjyErevST6S9RG0H8H/LLbiWmPK
        CQykCKw9g==;
Received: from 177.41.119.178.dynamic.adsl.gvt.net.br ([177.41.119.178] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb1jw-0004Xw-Ke; Wed, 12 Jun 2019 11:48:29 +0000
Date:   Wed, 12 Jun 2019 08:48:24 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190612084824.16671efa@coco.lan>
In-Reply-To: <20190612110904.qhuoxyljgoo76yjj@ninjato>
References: <20190611102528.44ad5783@canb.auug.org.au>
        <20190612081929.GA1687@kunai>
        <20190612080226.45d2115a@coco.lan>
        <20190612110904.qhuoxyljgoo76yjj@ninjato>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Jun 2019 13:09:04 +0200
Wolfram Sang <wsa@the-dreams.de> escreveu:

> Hi Mauro,
> 
> > That entire use of _P, _R and _ri looks weird into my eyes. The code there  
> 
> Yes.
> 
> > do things like:
> > 
> > #define _P 32
> > 
> > ...
> > 
> >         if (_P == 64)
> >                 reg1[1] |= 0x40;  
> 
> Yup, I saw this, too, but didn't feel like refactoring the driver.
> Thanks for stepping up!
> 
> > I'll work on a patch to address it.  
> 
> OK, so that means I should send my pull request after yours in the next
> merge window? To avoid the build breakage?

Either that or you can apply my patch on your tree before the
patch that caused the breakage. 

Just let me know what works best for you.

> 
> Kind regards,
> 
>    Wolfram
> 



Thanks,
Mauro
