Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345DC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2C82087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564816561;
	bh=gv4lNW9JyzRG9OD26MUsEo1NrPFsRqynRTd4wNfQqtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QcbHbZL/5Mid44FHtjXZdSs3ktp81KlHnuL+DEah5s27otRozX02dB+1zHb3O7Qu7
	 lMxPZg1qMgbvbQMDeLLD8QbIU4WyW09uxm4KsxK5RjCjR2n80A1xSTeeQICoUj4B1n
	 3P4NNduBZ9WLBIyvssHCJ24VFI6YM6+cdPLIrQCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfHCHQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 03:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfHCHP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:15:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEB220665;
        Sat,  3 Aug 2019 07:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564816558;
        bh=gv4lNW9JyzRG9OD26MUsEo1NrPFsRqynRTd4wNfQqtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJGYmLcedXICtCvvzzvRSwMVYetMZEA2wmDcMl/KlJdsMrv/jNARt4VI1d17sBdrb
         yIoNEXapfwLvAXQdKKQQhim7hPhWWPM3Op8phH1uCT4xA/dWK3xIdpfYkwvEm5ByaN
         93wOoii7ttRl0XC/A9tHhly9i6z3nzySzZCZHnis=
Date:   Sat, 3 Aug 2019 09:15:55 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "boqun.feng" <boqun.feng@gmail.com>,
        kimbrownkd <kimbrownkd@gmail.com>
Subject: Re: [PATCH 1/1] genirq: Properly pair kobject_del with kobject_add
Message-ID: <20190803071555.GB24757@kroah.com>
References: <1564703564-4116-1-git-send-email-mikelley@microsoft.com>
 <20190802063423.GA12360@kroah.com>
 <MWHPR21MB078463AB854A336842118405D7D90@MWHPR21MB0784.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB078463AB854A336842118405D7D90@MWHPR21MB0784.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:19:37PM +0000, Michael Kelley wrote:
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> Sent: Thursday, August 1, 2019 11:34 PM
> > On Thu, Aug 01, 2019 at 11:53:53PM +0000, Michael Kelley wrote:
> > > If alloc_descs fails before irq_sysfs_init has run, free_desc in the
> > > cleanup path will call kobject_del even though the kobject has not
> > > been added with kobject_add. Fix this by making the call to
> > > kobject_del conditional on whether irq_sysfs_init has run.
> > >
> > > This problem surfaced because commit aa30f47cf666
> > > ("kobject: Add support for default attribute groups to kobj_type")
> > > makes kobject_del stricter about pairing with kobject_add. If the
> > > pairing is incorrrect, a WARNING and backtrace occur in
> > > sysfs_remove_group because there is no parent.
> > >
> > > Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > ---
> > >  kernel/irq/irqdesc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> > > index 9484e88..5447760 100644
> > > --- a/kernel/irq/irqdesc.c
> > > +++ b/kernel/irq/irqdesc.c
> > > @@ -438,7 +438,8 @@ static void free_desc(unsigned int irq)
> > >  	 * The sysfs entry must be serialized against a concurrent
> > >  	 * irq_sysfs_init() as well.
> > >  	 */
> > > -	kobject_del(&desc->kobj);
> > > +	if (irq_kobj_base)
> > > +		kobject_del(&desc->kobj);
> > 
> > But now you leak the memory of desc as there is no chance it could be
> > freed, because the kobject release function is never called :(
> 
> In the alloc_descs error path, when irq_kobj_base is still NULL, the
> kobject code sequence is:
> 	kobject_init()   [as called by alloc_desc]
> 	kobject_put()   [as called by delayed_free_desc]
> 
> So I don't think anything leaks.
> 
> If irq_kobj_base is not NULL, the kobject code sequence is:
> 	kobject_init()   [as called by alloc_desc]
> 	kobject_add()  [as called by irq_sysfs_add]
> 	kobject_del()   [as called by free_desc]
> 	kobject_put()   [as called by delayed_free_desc]
> 
> Again, everything is paired up properly.
> 
> > 
> > Relying on irq_kobj_base to be present or not seems like an odd test
> > here.
> > 
> 
> It's the same test that is used in irq_sysfs_add to decide whether to
> call kobject_add.  So it makes everything paired up and symmetrical.

Ugh, that's a tangled mess and totally not obvious at all.  I'm sure
there's a good reason for all of that, and I really don't want to know
:)

Anyway, yes, you are right, the patch is fine, sorry for the noise.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

greg k-h
