Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B09C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0DE2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeBDJvy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDCW1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:27:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50639 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfDCW13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:27:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so614958wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BOtlaSUOh6SUerCJfSPHdxDpudukFzT6tHRpAGQTww=;
        b=NeBDJvy/OKPRGYVBu0dQUieAcspHD1ylMEKo/YziYKBVhgPpe3Fgxttr7z9rqDf/SA
         xqeMvdVf+suYg6XAwf3/m96LGoTqi0rmahJ6rAOymBKD9wd+8DJYuehUyPmy8qkL3BJa
         CbL7ewdIOn3P0f8HOc7kfCjs3uESP4Ke8YJQICooPPYBPqTq5X2gckP5ENGafdTbwjms
         8BC2gC90pN16Mztip7R1G7vCQmuWpG8DLxLqxK0fO8aHMdTXwG96xrd82f++xfXOsGF7
         MY3UkivGHVL30JJPBofPH43M4LGyNNLH/jvk69/xYECh6TJ8Jts1eZfU3+XNN5KIxiJo
         Cyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BOtlaSUOh6SUerCJfSPHdxDpudukFzT6tHRpAGQTww=;
        b=V7l+D1gqZmZd5bSqAK6CHCI37r2VVRvw4bhtDJLwRFjL1yuptNDjIBgLGAiRqCU7TY
         Dzko2yuAmolk+bjj6cvudV10Oi2UZgylkpRTMWfGpEN4t31+vFjyGtvTM1dLOE3iuH/j
         fCDSnB7BQXg49JzMFd5TFZ0qVRGL8r4Fga1I71Oq/V9x1hCqUHAuHZfM2qq7VN9FufBw
         SlmE6V377E5kt40hIVSWcscCBp6ck1XA7oBLlsO70WOY5IoWEtgMmynXD47HRu4WDPQM
         p2VIN60LgoyrC4JnQitgm9YpnCM7TfuQUZHWiRml/XDKqEyyIEKqljnxajxVmpF/BFt0
         wyDQ==
X-Gm-Message-State: APjAAAV2H8s6zYfQK66KiqC46rzWyY2LB6pBpjRHtJM4PV0Qg9ATLX5o
        X1WjNlbp1sFnJhvbiFoDkS8gO6nb2uAv6Dj0F5tl
X-Google-Smtp-Source: APXvYqyud5gU1u28lCZ+hJAVD0GfdoXNYhC2+EANISfGgdPDLjAaXtK7Pw2XzeqLT76P3ilJMfOwDtoO/h9h9uTTcI0=
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr1596406wmc.135.1554330446739;
 Wed, 03 Apr 2019 15:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190325183652.252175-1-helgaas@kernel.org> <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
 <20190401140806.GB4570@kunai> <CAErSpo6MJFJO3s4NZ61CPZngbSaOhG-s5wLJyCQbwvdcnuBP1Q@mail.gmail.com>
 <20190403205724.ozrdjdujvnzzbrpe@ninjato>
In-Reply-To: <20190403205724.ozrdjdujvnzzbrpe@ninjato>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 3 Apr 2019 17:27:14 -0500
Message-ID: <CAErSpo4aRuM3rLFvMiKVwnpDxsfbVc9jR2bWse8tMZ-xWzYp8w@mail.gmail.com>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:57 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Apr 01, 2019 at 02:37:19PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 1, 2019 at 9:08 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > >
> > >
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > >
> > > > > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > > > > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > > > > convert i2c-isch to platform_device") removed the use of
> > > > > acpi_check_region() but not the include.
> > > > >
> > > > > Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> > > > > intended.
> > > > >
> > > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > Added
> > > >
> > > >     Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
> > > >     Reviewed-by: Jean Delvare <jdelvare@suse.de>
> > > >     Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> > > >
> > > > on my local branch.
> > > >
> > > > Jean, would you like me to repost this with the updates?  I assume you
> > > > will merge this (just based on get_maintainer.pl)?
> > >
> > > I will apply it, now that it has Jean's Rev-by. I assume this is
> > > for-next material despite the Fixes tag?
> >
> > Definitely for-next material, not for the current release.  Jean
> > suggested the Fixes tag, I think since it's related to a specific
> > commit and could be backported together with that commit.
> >
> > Should there be a MAINTAINERS update to clarify who applies patches to
> > drivers/i2c/busses/i2c-isch.c?  Right now, get_maintainers.pl doesn't
> > mention you (Wolfram).
> >
> > Patch with tags attached in case it's useful to you (sorry, I'm
> > saddled with gmail right now and can't include it inline).
>
> > From 36fbdab89f5b8aa2d3616bd289e2c695fd3c0f9b Mon Sep 17 00:00:00 2001
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > Date: Tue, 30 Oct 2018 14:12:36 -0500
> > Subject: [PATCH] i2c: isch: Remove unnecessary acpi.h include
> >
> > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > convert i2c-isch to platform_device") removed the use of
> > acpi_check_region() but not the include.
> >
> > Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> > intended.
> >
> > Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Jean Delvare <jdelvare@suse.de>
> > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> Fixed this checkpatch error:
>
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fd46a0064af1 ("i2c: convert i2c-isch to platform_device")'

Thanks, I didn't even know about that requirement for the word
"commit"!  I assume this only applies in the text, not in the "Fixes:"
tag.
