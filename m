Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0C7C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7747D217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557436350;
	bh=yjSJ5+Ioa9r+AGOxhWCEdbWXRoBVtO7ci0q8/R0m/2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r1yjN98Z9ggJgMm28X78IhBVP4ky/nDj6qnll69sLBtxETMebf6yQrOw0IZ4uVlsh
	 aTIENDedYx95dqRxBZz1HBIZulvQdT8zRDgZpkJsC+Lwn5jb8ffFaCcsEnW5s8NcqZ
	 W2b/FS5fE/LR3m8Ve4xJfXPinkqIsQaspQJYxftc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfEIVM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfEIVM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:12:29 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB97217D7;
        Thu,  9 May 2019 21:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436348;
        bh=yjSJ5+Ioa9r+AGOxhWCEdbWXRoBVtO7ci0q8/R0m/2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVKWjoFzoI283O7REsm3MYyiuLd91yFoVnEZqWp8/+BsaCjSbJ6Zdvxq1oXe073Xh
         XIkgjPQS0R2/MYz3D3WBSxDB7qARP3dsoNfqt2zUWU8DUsMECDS7dl1Db99BV/BgnF
         FTenRAp+AqMKqDGc9cg0tU/LGJKbRa+rzazhW2Sc=
Date:   Thu, 9 May 2019 16:12:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] PCI/PME: Replace dev_printk(KERN_DEBUG) with
 dev_info()
Message-ID: <20190509211226.GC235064@google.com>
References: <20190509141456.223614-1-helgaas@kernel.org>
 <20190509141456.223614-3-helgaas@kernel.org>
 <CAHp75Ve9-659N5N=f7pPb-9amvbGbi+zWxL9p-BnYocvXJPwZg@mail.gmail.com>
 <69ff0a66d8c68f9e1adc8308847541e9566fe23e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ff0a66d8c68f9e1adc8308847541e9566fe23e.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 11:31:04AM -0700, Joe Perches wrote:
> On Thu, 2019-05-09 at 20:35 +0300, Andy Shevchenko wrote:
> > On Thu, May 9, 2019 at 5:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > Replace dev_printk(KERN_DEBUG) with dev_info() or dev_err() to be more
> > > consistent with other logging.
> > > 
> > > These could be converted to dev_dbg(), but that depends on
> > > CONFIG_DYNAMIC_DEBUG and DEBUG, and we want most of these messages to
> > > *always* be in the dmesg log.
> > > 
> > > Also, use dev_fmt() to add the service name.  Example output change:
> > > 
> > >   - pcieport 0000:80:10.0: Signaling PME with IRQ ...
> > >   + pcieport 0000:80:10.0: PME: Signaling with IRQ ...
> > > +               pci_info(port, "interrupt generated for non-existent device %02x:%02x.%d\n",
> > > +                        busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
> > > +               pci_info(port, "Spurious native interrupt!\n");
> > > +       pci_info(port, "Signaling with IRQ %d\n", srv->irq);
> 
> Why change the logging level?
> Why not use #define DEBUG and use pci_dbg ?

What would the benefit of using DEBUG be?  I don't want these
particular messages to be conditional.

For messages that *should* be conditional, there's a later patch in
the series to use pci_dbg() and convert them to dyndbg so we have a
single mechanism for turning them off/on.

Bjorn
