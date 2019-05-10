Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFDC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF242173B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ks6g1IZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfEJMZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:25:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42238 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfEJMZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:25:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so2766387pln.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnVIZDxnd0kEyrDCPIaIICh1v6B5djz4lFgkebP+I0U=;
        b=ks6g1IZri8AzzL2Z/Sekh46nlKvX0lPLCP6q1vHc3VawPqG2JBFcUNQIbMhWVfRNck
         /g60XtjGD56oSr91jQlB/0vZcCLyCOeVcfFoIUIz0XuvSwpi2xuwCS0/EM/hMBtB2d50
         /6Rwih2UKTjYyXtBSFY8Rt7/dqy4eXiizaAGoT6YBAZAUCDM7NDW0x8U+ovpb7ZSRd9p
         3S9MVF9KPIN6zroUuD8lNa5PFbG49LBYSDupu1rXiQ5aiuOHOg18M2z0bNkO4i/cgODP
         vOKBFAHp6OXxrQA4Zdh9TxdBWU7TmEeVLK6yiv5ssaXttd8Dz9wHGvzwohyk131sj1vU
         wE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnVIZDxnd0kEyrDCPIaIICh1v6B5djz4lFgkebP+I0U=;
        b=G/kgcnWPe5/uQYJGLae/CJInIzRHGv2nswopLRfBlHG3vO7Nbe3BvFGVP1c/YhDVUB
         Lra3ZUVI1s4VWn3WScYQfRMCys0fWtqLJVDJohO6Kw2a+Oeq5ZWDVumG/nvKwHk22I9p
         ORSqg40FdAKOaVAY9LGQXZK3xOPBT/ntdd1AQ++wWjPpEDXQE845xvk7fPze7NlJXBgI
         hoNH3nWSefGcvX2mT+Ym7RCFlWBIGG8XcQTd2pc4lTfO+sfbdTFdKr5I8+cVqVtjktqk
         du99c5+I6hc0NcZYnRFbxg7Bqj1aFQoaasEF7+kF2xRCXAC5JpGW8yDPMCDYxuTkH2aB
         WaMw==
X-Gm-Message-State: APjAAAXdCLN0qZ1L0PvTD49fC6hp+fknqbbdg8KwrAjN2cgGQSQG/Xed
        fF2mvjg+OlE1jj1lzxSQVPSsEbkR6z4lbhsxhVJlMA==
X-Google-Smtp-Source: APXvYqymw800JfAsq/fca67/PjD5ZO/DNdkah38J2POt71VwpmYcmFgZY9hcOodBnt4cn72VZwx8gC/PQBgnGj1upRY=
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr12658630pln.10.1557491128296;
 Fri, 10 May 2019 05:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <75ce3040b4086ffa2d2e088ad7f24f5e4a87be56.1523552145.git.andreyknvl@google.com>
 <20180604042900.GB31498@zurbaran.ger.intel.com> <CAAeHK+yvf-LqrfdQ18FMzaCNqdNHqAjgrDMrwUReZq8ei=hTYQ@mail.gmail.com>
In-Reply-To: <CAAeHK+yvf-LqrfdQ18FMzaCNqdNHqAjgrDMrwUReZq8ei=hTYQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 10 May 2019 14:25:17 +0200
Message-ID: <CAAeHK+wDMGOWYAegV20A5VpkwtT3_jFXSraT3LeueASzb8gEUw@mail.gmail.com>
Subject: Re: [PATCH] NFC: fix attrs checks in netlink interface
To:     Samuel Ortiz <sameo@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, Jan 2, 2019 at 4:30 PM
To: Samuel Ortiz
Cc: David S . Miller, <linux-wireless@vger.kernel.org>, netdev, LKML,
Dmitry Vyukov, Kostya Serebryany

> On Mon, Jun 4, 2018 at 6:29 AM Samuel Ortiz <sameo@linux.intel.com> wrote:
> >
> > Hi Andrey,
> >
> > On Thu, Apr 12, 2018 at 06:56:56PM +0200, Andrey Konovalov wrote:
> > > nfc_genl_deactivate_target() relies on the NFC_ATTR_TARGET_INDEX
> > > attribute being present, but doesn't check whether it is actually
> > > provided by the user. Same goes for nfc_genl_fw_download() and
> > > NFC_ATTR_FIRMWARE_NAME.
> > >
> > > This patch adds appropriate checks.
> > >
> > > Found with syzkaller.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  net/nfc/netlink.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > Thanks, applied to nfc-next.
>
> Hi Samuel,
>
> It's been 6 months and this fix is still not in mainline. Did it get lost?

More than a year passed since I've sent this patch, it's still sitting
in the nfc-next tree which hasn't been updated since June last year.
Did NFC stopped being maintained?

>
> Thanks!
>
> >
> > Cheers,
> > Samuel.
