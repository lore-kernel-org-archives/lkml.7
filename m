Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFBCC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460C6206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEDOfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:35:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34370 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEDOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:35:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id j6so10055125qtq.1;
        Sat, 04 May 2019 07:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQgaLnyd1PzWRuAcPpOm2m6B4C3dJFTkE6v5h3uPP4o=;
        b=OjqydM2tYABlKRPwaDWqg1dM1O9OpwEEffgOkhAUV1/6BQeoWWmfHAQR3T/WH5gCs5
         40kbSctPEwPq2sn3g3TV4i1tKBxEbBtNZxPWKYUT2HpUY58Mnn6VbIqbjn/DLUqQL3wH
         f0Mk4KzQdxSZ+MBF1Yi+fKfYOBSgGsLa1nqJSZU56RtJNA9aucFHK5I/LDfS0/aWssQ9
         BTAYUOe5iVMHIUstiDge+FboiadC8gMae4FABaBL+yuYKY8qf7c4NZXYK2kwrGlWN9a5
         yOUfVADov/HCArKbMknjIp96e0SSPtrhccBjBlXRShYdVU1zvpj1s/H1STkjQFwhxpTb
         P3cQ==
X-Gm-Message-State: APjAAAWt3kmG+7cZNoxxr2bb+1VS2liIE/mE+ESevVRaykTA51F2A3u3
        d6xCzpvkDD3RhVI5axMU92kzXjjmtmTeBnkmUKg=
X-Google-Smtp-Source: APXvYqxvPIZmsXc7/1Lsx8u1uNwbWRJxYtcxgpxdevIAEaVf/6zZoMUz0DyMRRuNK8rGfyNiuEKbyfamxoIOG5ECJA4=
X-Received: by 2002:ac8:29cf:: with SMTP id 15mr13552977qtt.319.1556980520015;
 Sat, 04 May 2019 07:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com> <20190502172345.GC1874@kroah.com>
In-Reply-To: <20190502172345.GC1874@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 4 May 2019 10:35:02 -0400
Message-ID: <CAK8P3a2EKXrg4amHDi5zVvOQ8AM+u6EAhBc=T8Hk_tU20xSV4w@mail.gmail.com>
Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 1:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Apr 27, 2019 at 11:04:58PM +0100, Dragan Cvetic wrote:
> > Add char device interface per DT node present and support
> > file operations:
> > - open(),
> > - close(),
> > - unlocked_ioctl(),
> > - compat_ioctl().
>
> Why do you need compat_ioctl() at all?  Any "new" driver should never
> need it.  Just create your structures properly.

The function he added was the version that is needed when the structures
are compatible. I submitted a series to add a generic 'compat_ptr_ioctl'
implementation that would save a few lines here doing the same thing,
but it's not merged yet.

Generally speaking, every driver that has a .ioctl() function should also
have a .compat_ioctl(), and ideally it should be exactly this trivial
version.

        Arnd
