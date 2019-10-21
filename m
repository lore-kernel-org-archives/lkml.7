Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C3DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660AF20679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfJUNCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:02:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfJUNCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:02:40 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A05B683F4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:02:35 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id j5so13996859qtn.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MATzqi2DYgY3f2a3E6niPS64+EAt9PrYf2/3XZiaaBU=;
        b=oaE/wM5weGXskH9imoDDayRcUwh3JvBFljoufyO2TYQ33fmm5X3V4bGhaNaLKrfcVD
         GDk6uJh3XlM/fC9S0GY/rxoPYyI2gR7aozDAWYDtYp25v1Ru9lvD6OXK8TUfbaSBsQrR
         hsOxvmj5g7zPfDGWSToA31EFaWrvgYk58Cdm4iTtdDDNCu2RZgqWeWEktu2rhU3xKxh7
         1GZRJ1TJws2LwoLVDrFGQa9IZs3wa29ywaRHd+VgFmM65JX9pGhzGpZb8KRddQGqKfB8
         bSJMojJBka2n2nIj/xnDkC0/sE/C/amtBT+ImKmC4XJlndnyENCmGER1iXuhTE8Ij/SM
         HUbQ==
X-Gm-Message-State: APjAAAWzb24EJAxSmuNVhFYbYU7uL2K5pavRFPxZ7M8QpH3vQ2znVdjY
        CU7pmtRZ5Pn3N4SbGqNtnpO1a3+zMKhXrECccpt8ihmcC+BQ8Rc62eOfZdc0LrcEpjkTfJ1XFfo
        lT5e9EJ+rm4A1VdBYhtv6bE5o4YzB/X3eaO2sjKfS
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22921993qkj.102.1571662954876;
        Mon, 21 Oct 2019 06:02:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhj+jJSrLfQkuYBSA3fMA/d8Rx0RQ7EY47UhYO+DdxvK1frDIPrR+k9EvVDJ33OZEmDSuD4GzUm4UQE4AVqWs=
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22921978qkj.102.1571662954620;
 Mon, 21 Oct 2019 06:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191016144449.24646-1-kherbst@redhat.com> <20191021114017.GY2819@lahna.fi.intel.com>
 <CACO55tt2iGcySugTAb1khEYpiGoq6Os3upG5fGq+0PbE2gyyeQ@mail.gmail.com> <20191021120611.GB2819@lahna.fi.intel.com>
In-Reply-To: <20191021120611.GB2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 15:02:23 +0200
Message-ID: <CACO55tvYEvPHwFLDmLOQ_BCiNw7ZRA7dun9P=KdLb4bvYTtrcg@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 2:06 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Mon, Oct 21, 2019 at 02:00:46PM +0200, Karol Herbst wrote:
> > On Mon, Oct 21, 2019 at 1:40 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > Hi Karol,
> > >
> > > Sorry for commenting late, I just came back from vacation.
> > >
> > > On Wed, Oct 16, 2019 at 04:44:49PM +0200, Karol Herbst wrote:
> > > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > > states.
> > > >
> > > > v2: convert to pci_dev quirk
> > > >     put a proper technical explanation of the issue as a in-code comment
> > > > v3: disable it only for certain combinations of intel and nvidia hardware
> > > >
> > > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linux-pm@vger.kernel.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: nouveau@lists.freedesktop.org
> > > > ---
> > > >  drivers/pci/pci.c    | 11 ++++++++++
> > > >  drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> > >
> > > I may be missing something but why you can't do this in the nouveau
> > > driver itself?
> >
> > What do you mean precisely? Move the quirk into nouveau, but keep the
> > changes to pci core?
>
> No, just block runtime PM from the device in nouveau driver.

but that's not what the patch does. It only skips the PCI PM reg
write, but still let the ACPI method be invoked to put the device into
D3cold
