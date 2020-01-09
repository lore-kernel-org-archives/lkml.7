Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB49C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E82A206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578562375;
	bh=9YrX6xPp2e7/KKWxeVFG44sFTaNaqxbhpzi7KEta2Tw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J0Gtn1IvdN/1/T29Cy4mEPjMjGZD6REnTCjQOCVpBeusV8wKvQ20pN2IWv67Gw8Vy
	 u9RfJSPB/uoPWaQfw5bZHdx0qVEslrW/4EU3QXB2Z8Ur+W/mfdfHfNeqVtZEX7jfnT
	 tRKEkELJeTKX93VCi2ZAZXvCEkFu0Noo9sJtDmZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgAIJcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:32:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37523 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgAIJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:32:54 -0500
Received: by mail-oi1-f196.google.com with SMTP id z64so5311381oia.4;
        Thu, 09 Jan 2020 01:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YrX6xPp2e7/KKWxeVFG44sFTaNaqxbhpzi7KEta2Tw=;
        b=if/A+oWjDr+7tTl6hD8hXKk3IcC3Npc2MgPBt+HEVW2CGaALWHDUKoGkFFvD/T9nQp
         mDvbB2kB2N6/GHlPtOOuCpqPskJUzR7THgb3ZR9GwZ8+yTMKWmvhhseQ74+cj58U33LO
         qRnJ2lcTFx6cbte4AEdazLWm50cnQJFffE529eibXVr36KsHQPc8OGQ+3sVhRKh7d2wW
         qZxc569ukqZ5UFHA5em/mSvk/+3z/cD2vJRIe/bYkbmjb8N6v98s/4th5B08DN3Vi+oR
         eHbOQ/dK8TVnVgcv+1RcUqYLIEjXjHf61/EmBPexq24dfEVnPV8EViUq6M64IJoKSbDU
         NoSg==
X-Gm-Message-State: APjAAAXG/kgfO+uS3WljiSOyGfjwc87eRRIw7WNGpuShG8/zbtPkbKHU
        lvrFAZWsbxUfWOn2P7vs1NgOPqdWwDSMXuTXh9FnSA==
X-Google-Smtp-Source: APXvYqxQzRrWQ7PVARLaLZINaBvDHwYstJVKtItaPqE7bHlbZVGrRimgP4uuWuXWd9f80etPtpWo+TxGCkY5BY2rrp0=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr2365881oig.68.1578562373147;
 Thu, 09 Jan 2020 01:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20191213174623.GA20267@dtor-ws> <CGME20191215164117eucas1p159471bd0b90b76b6ff64f26f17a6580e@eucas1p1.samsung.com>
 <2a8a5e6b-9372-978e-03d0-350ab65a2d0a@redhat.com> <f2f41b28-2ca5-7fad-5b19-2ad51c689e5a@samsung.com>
 <87tv55ro9b.fsf@kernel.org>
In-Reply-To: <87tv55ro9b.fsf@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jan 2020 10:32:40 +0100
Message-ID: <CAJZ5v0jb6WNQvx0Kiarwh=9h-inC3VBYzBtBBCJOqVvDHSDUrw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: use proper initializers for property entries
To:     Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 10:07 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>
> > Hi All,
> >
> > On 15.12.2019 17:41, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 13-12-2019 18:46, Dmitry Torokhov wrote:
> >>> We should not be reaching into property entries and initialize them by
> >>> hand, but rather use proper initializer macros. This way we can alter
> >>> internal representation of property entries with no visible changes to
> >>> their users.
> >>>
> >>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>> ---
> >>>
> >>> It would be good if this could go through Rafael's tree as it is needed
> >>> for the rest of my software_node/property_entry rework patch series
> >>> which I would love not to delay till 5.6.
> >>
> >> Patch looks good to me:
> >>
> >> Acked-by: Hans de Goede <hdegoede@redhat.com>
> >
> > This patch is instantly needed as the issue it fixes is again triggered
> > in current (20200107) linux-next by commit e6bff4665c59 "software node:
> > replace is_array with is_inline".
> >
> > Felipe: could You ack it, so it could be merged via Rafael's tree
> > together with related device property changes?
>
> Here you go:
>
> Acked-by: Felipe Balbi <balbi@kernel.org>

Thanks, applied.
