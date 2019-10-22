Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F82CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC4B2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1DWMhTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfJVJ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:26:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40120 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:26:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so10274887pfb.7;
        Tue, 22 Oct 2019 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DdMpMJAPnmBmCGb18HjxGQhrUj1kKI9wqWAZL3wLOWs=;
        b=S1DWMhTY89ozmFHQkzFl5Q28aag2OyFasv0X7bDFv76h0glgW/z2aSTZTECEzNHTcv
         jko++DVwnjYdd+qOqawZrmm8AZt8Sp3b222Tw6dJM1wUwaykte2a//RI8aaRTLLjABqU
         uxY1LM14teSkX9WooV1VxG0h5gpCrUCUHGufzQ/Rq/oQdxRfE7h0/0pWkib4iOm3ErVE
         Z9PhPgW855RJD0RRSvJ+ogN73MUuXZslBBgdQFqs8O801UQpYHUrvAxreGxHFueODljA
         6XO979ZFcWNrOA7oRvHXkru2vCmpExuUQhOwZpXPl3RIPcYWK+QqkT/LaUEu5wXjdKuf
         +SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DdMpMJAPnmBmCGb18HjxGQhrUj1kKI9wqWAZL3wLOWs=;
        b=edYBAKzg4/Fat7IOI5xf5mh5s/3bO873H53efF5wV2cHAEwkd/jab3zQu4lk44kdPh
         11fTZuU2JTYrfExnWQFfniwoKWyZM3aOSwkxwPRX1b+81/rsp9HjkMdZ0QY3sn4BrV2m
         nJrZSxfNEKRTY5+rMlceTXM86xD4bN5Sk1CsrsJMmXVc9R3PnobQEbzbTaM+EB2a7R5l
         vSPc5Ll/U6YdiyX2WNkQY7Mf4Nlh0WWNe50OF6KAAPZB/PGnM/93FEM0Z1U7IB+Zgsj+
         NTqdZu/EKJRsKuwdTmmoPlM4KvonVAA5v4JIkPgjEBnX8YgQY3/jAnHWHPofPDcPRX1H
         vrpg==
X-Gm-Message-State: APjAAAUtWrNDG+5GjvK5sAq9bae1JLk+qPS7ed4336xjNDPxWbhP4+pF
        VHMoqfDUomytvc+q5gvB3KI=
X-Google-Smtp-Source: APXvYqwgWG9OpQkEB7Kl+tkbEIQ+XaDY3+W/SRAzsOjNPH5E+4ZQBagRjyMUhp7M4Mw7SPKih9L6Rw==
X-Received: by 2002:a63:7344:: with SMTP id d4mr2776662pgn.416.1571736376600;
        Tue, 22 Oct 2019 02:26:16 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.gmail.com with ESMTPSA id j17sm17423770pfr.70.2019.10.22.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:26:15 -0700 (PDT)
Date:   Tue, 22 Oct 2019 18:26:11 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        valentina.manea.m@gmail.com, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] =?iso-8859-1?B?dXNiaXA6oEZp?= =?iso-8859-1?Q?x?= free of
 unallocated memory in vhci tx
Message-ID: <20191022092611.GA3941@localhost.localdomain>
References: <20191021142414.27164-1-suwan.kim027@gmail.com>
 <alpine.DEB.2.21.1910211706240.2877@hadrien>
 <936d4cf8-cd5a-a297-8298-e9bc5d3c193d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <936d4cf8-cd5a-a297-8298-e9bc5d3c193d@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 01:28:54PM -0600, shuah wrote:
> On 10/21/19 9:08 AM, Julia Lawall wrote:
> > 
> > 
> > On Mon, 21 Oct 2019, Suwan Kim wrote:
> > 
> > > iso_buffer should be set to NULL after use and free in the while loop.
> > > In the case of isochronous URB in the while loop, iso_buffer is
> > > allocated and after sending it to server, buffer is deallocated. And
> > > then, if the next URB in the while loop is not a isochronous pipe,
> > > iso_buffer still holds the previously deallocated buffer address and
> > > kfree tries to free wrong buffer address.
> > > 
> > > Fixes: ea44d190764b (“usbip: Implement SG support to vhci-hcd and stub driver”)
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > ---
> > >   drivers/usb/usbip/vhci_tx.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
> > > index c3803785f6ef..b290e810d11b 100644
> > > --- a/drivers/usb/usbip/vhci_tx.c
> > > +++ b/drivers/usb/usbip/vhci_tx.c
> > > @@ -73,6 +73,7 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
> > >   		memset(&pdu_header, 0, sizeof(pdu_header));
> > >   		memset(&msg, 0, sizeof(msg));
> > >   		memset(&iov, 0, sizeof(iov));
> > > +		iso_buffer = NULL;
> > 
> > Somehow I would have put it after the kfree, since the kfree makes the
> > value invalid.  iso_buffer is already initialized to NULL for the first
> > iteration.  If you want to put the setting to NULL at the top of the loop,
> > maybe the = NULL in the first line should be removed.
> > 
> 
> It makes sense to clear it after kfree() on line 150.
> 
> This kfree() and clearing iso_buffer are necessary only for
> PIPE_ISOCHRONOUS case.
> 
> Please add a comment above that this is for isoc case.

Ok. I will send v2.

Regards
Suwan Kim
