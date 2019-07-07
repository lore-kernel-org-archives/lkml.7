Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5684C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10E120828
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="eOkYYoEn";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="bO66F2uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGGSuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 14:50:08 -0400
Received: from mail186-26.suw21.mandrillapp.com ([198.2.186.26]:38244 "EHLO
        mail186-26.suw21.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfGGSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:50:07 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jul 2019 14:50:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=IEkfr4YRUhLQp/HsBY74d4iNJyE2lakZV4Jo08VmuaA=;
 b=eOkYYoEnGUWqIB0dbm6nCcKDIIjoxM4d+HhRgGETEvjlGfW7UgggueEiV4ZKgBm8ASPzz58BSXeN
   IlmkkOBadR4II4eSBitdArJdpwPS/iD390IQP8SzJQQpZSq5HN0pZhZLS1Ya/MLN88HkPISXXNaV
   qKalsjTLIFxcUuHIVbU=
Received: from pmta02.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail186-26.suw21.mandrillapp.com id h48vdu174bkc for <linux-kernel@vger.kernel.org>; Sun, 7 Jul 2019 18:20:06 +0000 (envelope-from <bounce-md_31050260.5d2237d6.v1-f5fde34343224dcd9d9edba9fbdda79c@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1562523606; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=IEkfr4YRUhLQp/HsBY74d4iNJyE2lakZV4Jo08VmuaA=; 
 b=bO66F2uYOXuv1h/WHJ+zyPIP0BmHtwh52THKQzlyoBeVJYgYEiyH2vKJe1xixzJMj+HUSH
 i1ANXEJCPJgzylWHcGjxBZfFSG+5eR/vzKlLngs/6dGthQ8yIbvjM62NW4MqG15eTGOZSmTY
 fBbQP5AV4cCTWK4SH/rwXwZu/9V9Q=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [Cocci] [PATCH 1/2] coccinelle: api/stream_open: treat all wait_.*() calls as blocking
Received: from [87.98.221.171] by mandrillapp.com id f5fde34343224dcd9d9edba9fbdda79c; Sun, 07 Jul 2019 18:20:06 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     <cocci@systeme.lip6.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Message-Id: <20190707182002.GB25031@deco.navytux.spb.ru>
References: <20190623072838.31234-1-kirr@nexedi.com> <CAK7LNAT2tt+pCX54=L9qN9pzZ+rCOQ5-9p-o1jMLa3GD9jhG8A@mail.gmail.com>
In-Reply-To: <CAK7LNAT2tt+pCX54=L9qN9pzZ+rCOQ5-9p-o1jMLa3GD9jhG8A@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.f5fde34343224dcd9d9edba9fbdda79c
X-Mandrill-User: md_31050260
Date:   Sun, 07 Jul 2019 18:20:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 10:17:18PM +0900, Masahiro Yamada wrote:
> On Sun, Jun 23, 2019 at 4:29 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > Previously steam_open.cocci was treating only wait_event_.* - e.g.
> > wait_event_interruptible - as a blocking operation. However e.g.
> > wait_for_completion_interruptible is also blocking, and so from this
> > point of view it would be more logical to treat all wait_.* as a
> > blocking point.
> >
> > The logic of this change actually came up for real when
> > drivers/pci/switch/switchtec.c changed from using
> > wait_event_interruptible to wait_for_completion_interruptible:
> >
> >         https://lore.kernel.org/linux-pci/20190413170056.GA11293@deco.navytux.spb.ru/
> >         https://lore.kernel.org/linux-pci/20190415145456.GA15280@deco.navytux.spb.ru/
> >         https://lore.kernel.org/linux-pci/20190415154102.GB17661@deco.navytux.spb.ru/
> >
> > For a driver that uses nonseekable_open with read/write having stream
> > semantic and read also calling e.g. wait_for_completion_interruptible,
> > running stream_open.cocci before this patch would produce:
> >
> >         WARNING: <driver>_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.
> >
> > while after this patch it will report:
> >
> >         ERROR: <driver>_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.
> >
> > Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> > ---
> 
> Applied to linux-kbuild. Thanks.

Thanks.


> >  scripts/coccinelle/api/stream_open.cocci | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
> > index 350145da7669..12ce18fa6b74 100644
> > --- a/scripts/coccinelle/api/stream_open.cocci
> > +++ b/scripts/coccinelle/api/stream_open.cocci
> > @@ -35,11 +35,11 @@ type loff_t;
> >  // a function that blocks
> >  @ blocks @
> >  identifier block_f;
> > -identifier wait_event =~ "^wait_event_.*";
> > +identifier wait =~ "^wait_.*";
> >  @@
> >    block_f(...) {
> >      ... when exists
> > -    wait_event(...)
> > +    wait(...)
> >      ... when exists
> >    }
> >
> > @@ -49,12 +49,12 @@ identifier wait_event =~ "^wait_event_.*";
> >  // XXX currently reader_blocks supports only direct and 1-level indirect cases.
> >  @ reader_blocks_direct @
> >  identifier stream_reader.readstream;
> > -identifier wait_event =~ "^wait_event_.*";
> > +identifier wait =~ "^wait_.*";
> >  @@
> >    readstream(...)
> >    {
> >      ... when exists
> > -    wait_event(...)
> > +    wait(...)
> >      ... when exists
> >    }
> >
> > --
> > 2.20.1
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
