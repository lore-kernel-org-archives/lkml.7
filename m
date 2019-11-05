Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD486C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ABA20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbfKERNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:13:45 -0500
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:59897 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730959AbfKERNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:13:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E6B174DA7;
        Tue,  5 Nov 2019 17:13:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mist27_345d099eb123
X-Filterd-Recvd-Size: 2930
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Nov 2019 17:13:42 +0000 (UTC)
Message-ID: <3a6d170b616eb52735dc6dbf985377b1c836b9e6.camel@perches.com>
Subject: Re: [PATCH v2] hp100: remove set but not used variable val
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Chen Wandun <chenwandun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        perex@perex.cz, kstewart@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de
Date:   Tue, 05 Nov 2019 09:13:31 -0800
In-Reply-To: <20191105155024.GA2677365@kroah.com>
References: <20191105133554.6C01F9A06CB85816F399@huawei.com>
         <1572964619-76671-1-git-send-email-chenwandun@huawei.com>
         <20191105155024.GA2677365@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 16:50 +0100, Greg KH wrote:
> On Tue, Nov 05, 2019 at 10:36:59PM +0800, Chen Wandun wrote:
> > From: Chenwandun <chenwandun@huawei.com>
> > 
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > drivers/staging/hp/hp100.c: In function hp100_start_xmit:
> > drivers/staging/hp/hp100.c:1629:10: warning: variable val set but not used [-Wunused-but-set-variable]
> > 
> > Signed-off-by: Chenwandun <chenwandun@huawei.com>
> 
> I need a "full" name here, like the one on your email "From:" line.

You also need the submitter to run checkpatch on the patch
and not just the file.

WARNING: drivers/staging/hp/hp100.c is marked as 'obsolete' in the MAINTAINERS hierarchy.  No unnecessary modifications please.

WARNING: drivers/staging/hp/hp100.c is marked as 'obsolete' in the MAINTAINERS hierarchy.  No unnecessary modifications please.
total: 0 errors, 2 warnings, 0 checks, 18 lines checked

> > diff --git a/drivers/staging/hp/hp100.c b/drivers/staging/hp/hp100.c
[]
> > @@ -1626,7 +1626,9 @@ static netdev_tx_t hp100_start_xmit(struct sk_buff *skb,
> >  	unsigned long flags;
> >  	int i, ok_flag;
> >  	int ioaddr = dev->base_addr;
> > +#ifdef HP100_DEBUG_TX
> >  	u_short val;
> > +#endif
> 
> #ifdefs are not ok in .c code, sorry.
> 
> >  	struct hp100_private *lp = netdev_priv(dev);
> >  
> >  #ifdef HP100_DEBUG_B
> > @@ -1695,7 +1697,9 @@ static netdev_tx_t hp100_start_xmit(struct sk_buff *skb,
> >  
> >  	spin_lock_irqsave(&lp->lock, flags);
> >  	hp100_ints_off();
> > +#ifdef HP100_DEBUG_TX
> >  	val = hp100_inw(IRQ_STATUS);
> 
> Are you sure that this doesn't actually change the hardware in some way?

If anyone still _has_ the hardware, please let me know.

I have the only VG test equipment I know of in a box
somewhere in my basement and it's yours for the asking
and the postage.

It hasn't been powered on in 25 years, no guarantees...


