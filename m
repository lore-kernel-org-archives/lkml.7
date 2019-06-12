Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D77C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4AF2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oMHCRrVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438228AbfFLLCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:02:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405826AbfFLLCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GyQvzVCRfx2rfSnJth+Ru0ibUKt+HtIeQExiXWplh8A=; b=oMHCRrVClCH7w4MftWKSBm1Xp
        nWqAVapuqvKgC16niIy9kv/HuL8HtzPt8ULFienbDrBOojMdk8+VWGRAeQMavwOqXiA6On+aZFNzm
        4DcZPAG2lD8GVopdAjdkiMMnXj0x5kD7iVJ/iTWV7KYP2H9hHavsXOuuQZ/x9iG+1iJLE2YmZpkc5
        Q+PLGZ4IP82HLaRLeovvSXZrcqSy+grCUuetcHfvnTACjtUyPnQJzlQj22PUUI54QyeIEWnu3SMUU
        usinM2Z9nF8Ve7/PrY8WQef0gC87c/dRpo+5QrHCiYNmC9tanSXE03sBUnoJn/U/oCWcq2TanXTeO
        uxM+AA+XA==;
Received: from 177.41.119.178.dynamic.adsl.gvt.net.br ([177.41.119.178] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb11S-0000xB-Mu; Wed, 12 Jun 2019 11:02:30 +0000
Date:   Wed, 12 Jun 2019 08:02:26 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190612080226.45d2115a@coco.lan>
In-Reply-To: <20190612081929.GA1687@kunai>
References: <20190611102528.44ad5783@canb.auug.org.au>
        <20190612081929.GA1687@kunai>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Jun 2019 10:19:29 +0200
Wolfram Sang <wsa@the-dreams.de> escreveu:

> On Tue, Jun 11, 2019 at 10:25:28AM +1000, Stephen Rothwell wrote:
> > Hi Wolfram,
> > 
> > After merging the i2c tree, today's linux-next build (x86_64 allmodconfig)
> > produced this warning:
> > 
> > drivers/media/dvb-frontends/tua6100.c: In function 'tua6100_set_params':
> > drivers/media/dvb-frontends/tua6100.c:71: warning: "_P" redefined
> >  #define _P 32
> >  
> > In file included from include/acpi/platform/aclinux.h:54,
> >                  from include/acpi/platform/acenv.h:152,
> >                  from include/acpi/acpi.h:22,
> >                  from include/linux/acpi.h:21,
> >                  from include/linux/i2c.h:17,
> >                  from drivers/media/dvb-frontends/tua6100.h:22,
> >                  from drivers/media/dvb-frontends/tua6100.c:24:
> > include/linux/ctype.h:14: note: this is the location of the previous definition
> >  #define _P 0x10 /* punct */
> > 
> > Exposed by commit
> > 
> >   5213d7efc8ec ("i2c: acpi: export i2c_acpi_find_adapter_by_handle")
> > 
> > Since that included <linux/acpi.h> from <linux/i2c.h>
> > 
> > Originally introduced by commit
> > 
> >   00be2e7c6415 ("V4L/DVB (4606): Add driver for TUA6100")
> > 
> > The _P in <linux/ctype.h> has existed since before git.  
> 
> I suggest to fix the driver by adding a TUA6100_ prefix to the defines.
> I can cook up a patch for that.
> 

That entire use of _P, _R and _ri looks weird into my eyes. The code there
do things like:

#define _P 32

...

        if (_P == 64)
                reg1[1] |= 0x40;


It sounds to me that _P and _R are actually some sort of setup
with depends on how the device is wired. 

A quick read on its datasheet at page 19 - downloaded from:

	http://www.datasheetcatalog.com/datasheets_pdf/T/U/A/6/TUA6100.shtml

Shows that:
	P:  divide ratio of the prescaler.
	R:  divide ratio of the R-counter.
	ri: reference frequency input (XTAL osc).

IMO, the right fix would be to change struct tua6100_priv, in order to
add those  parameters, and initialize them with the current values
at tua6100_attach.

That would allow changing those values during device initialization,
in the case we ever need to support a hardware with the same chipset,
with, for example, a different XTAL.

I'll work on a patch to address it.

Thanks,
Mauro
