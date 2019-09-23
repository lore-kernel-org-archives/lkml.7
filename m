Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108ADC432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E2221D6C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="acu4taYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407738AbfIWW7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:59:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40678 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbfIWW7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:59:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so10131249pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y3z1k4gVNAaPIrfZzgoCW8IDcBYw5cfRh8zYf6ua3ow=;
        b=acu4taYfUhopSZ/FZ0DfFK9vw+1y6QouHY91xUqg+5XYUZBzHEmMK7/agA8QWKZ38K
         gSOe2DGR6TC//GWU0Qkss5sMiFYQjLUMpXL6ObW+ioTVnvccSaWQZG/DwXn6sUHQWUwo
         +TR1dW1VihKSd7pGvXWmkh6d7GG7Cwf0lpc0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y3z1k4gVNAaPIrfZzgoCW8IDcBYw5cfRh8zYf6ua3ow=;
        b=TheCQSOncI3Bt3Zh8p6u0ioVUghJHhVdL26dvx8tcsZP/6QF6JL/MAYZuhD2awZ+Ps
         ioJ+iCaw9RWvcYnjaS4fEJPUYgwhdByQ7EiB9ziEEqEtyM+jAgoRBaffcotGC+htbQQW
         Z6GY3wveis6v7RKSZBxNkBWn/RmZhzx9+jSPQAZRB/QKA3eF4WTk2N5U8HIONKMx2maX
         uVQDnfoKoCpWUtjOtlZxlnPaJrZzzhKha3yX1o13oKY6GTii5GBHkMPP5ESbhIrKGIm/
         npQJbsQe7swIVqC25IOuYIyTmAc3xCjPP7WbyWU6z9nKX8U4pDC7prfR+pFUmrI22o42
         cBxA==
X-Gm-Message-State: APjAAAV4EebvQx1gywy7CSGVZYJpV2NfzRQTngAE7SRB+R51XOX4lyM/
        dPN6VdW/RrW3OVpgxam7nXoAsA==
X-Google-Smtp-Source: APXvYqzC0oJkIVQqCSyw7IVni9HHJq0DhtsYJeDEiYatLGTyGs22f0t7scv9POwDos4m/Y7CrMr5Yw==
X-Received: by 2002:a63:df10:: with SMTP id u16mr1671596pgg.373.1569279550656;
        Mon, 23 Sep 2019 15:59:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14sm6227427pjt.8.2019.09.23.15.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 15:59:09 -0700 (PDT)
Date:   Mon, 23 Sep 2019 15:59:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Dingwall <james@dingwall.me.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Juergen Gross <jgross@suse.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: pstore does not work under xen
Message-ID: <201909231556.7FF7A11@keescook>
References: <20190919102643.GA9400@dingwall.me.uk>
 <3908561D78D1C84285E8C5FCA982C28F7F472015@ORSMSX115.amr.corp.intel.com>
 <20190919161430.GA28042@dingwall.me.uk>
 <ae56e2c0-b2d3-835d-04cb-e4404d979859@oracle.com>
 <20190923154227.GA11201@dingwall.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923154227.GA11201@dingwall.me.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 03:42:27PM +0000, James Dingwall wrote:
> On Thu, Sep 19, 2019 at 12:37:40PM -0400, Boris Ostrovsky wrote:
> > On 9/19/19 12:14 PM, James Dingwall wrote:
> > > On Thu, Sep 19, 2019 at 03:51:33PM +0000, Luck, Tony wrote:
> > >>> I have been investigating a regression in our environment where pstore 
> > >>> (efi-pstore specifically but I suspect this would affect all 
> > >>> implementations) no longer works after upgrading from a 4.4 to 5.0 
> > >>> kernel when running under xen.  (This is an Ubuntu kernel but I don't 
> > >>> think there are patches which affect this area.)
> > >> I don't have any answer for this ... but want to throw out the idea that
> > >> VMM systems could provide some hypercalls to guests to save/return
> > >> some blob of memory (perhaps the "save" triggers automagically if the
> > >> guest crashes?).
> > >>
> > >> That would provide a much better pstore back end than relying on emulation
> > >> of EFI persistent variables (which have severe contraints on size, and don't
> > >> support some pstore modes because you can't dynamically update EFI variables
> > >> hundreds of times per second).
> > >>
> > > For clarification this is a dom0 crash rather than an HVM guest with EFI.  I
> > > should probably have also mentioned the xen verion has changed from 4.8.4 to
> > > 4.11.2 in case its behaviour on detection of crashed domain has changed.
> > >
> > > (For capturing guest crashes we have enabled xenconsole logging so the
> > > hvc0 log is available in dom0.)
> > 
> > 
> > Do you only see this difference between 4.4 and 5.0 when you crash via
> > sysrq?
> > 
> > Because that's where things changed. On 4.4 we seem to be forcing an
> > oops, which eventually calls kmsg_dump() and then panic. On 5.0 we call
> > panic() directly from sysrq handler. And because Xen's panic notifier
> > doesn't return we never get a chance to call kmsg_dump().
> > 
> 
> Ok, I see that change in 8341f2f222d729688014ce8306727fdb9798d37e.  I 
> hadn't tested it any other way before.  Using the null pointer 
> de-reference module code at [1] a pstore record is generated as expected 
> when the module is loaded (panic_on_oops=1).

This change looks correct -- it just gets us directly to the panic()
state instead of exercising the various exception handlers.

> I have also tested swapping the kmsg_dump() / 
> atomic_notifier_call_chain() around in panic.c and this also results in 
> a pstore record being created with sysrq-c.  I don't know if that would 
> be an acceptable solution though since it may break behaviour that other 
> things depend on.

I don't think reordering these is a good idea: as the comments say,
there might be work done in the notifier chain that kmsg_dump() will
want to capture (e.g. the KASLR base offset).

The situation seems to be that notifier callbacks must return -- I think
Xen needs fixing here.

-- 
Kees Cook
