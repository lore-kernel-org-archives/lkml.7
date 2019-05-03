Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26628C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A432081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AqEzJvbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfECFZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:25:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35146 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECFZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:25:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so5156762wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fiP1dSzJDSxcySo13/x6XymhVx+VfpZdcVooeC5gJFk=;
        b=AqEzJvbCcfFDntnYU56JtRgeHQPMo0DRo1hQXaws3BJPWPvHxNhO8a2xRjRGbI8P0i
         v4umZt28CK37wTrPQa76i7I4LArx4l90zW0ZIF8ZstoAYirVGXeXmOrFAQPN+nStz0oX
         LkpA/JwpT2+81wqkz/gqGKw6oHFqgRgNEI+zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiP1dSzJDSxcySo13/x6XymhVx+VfpZdcVooeC5gJFk=;
        b=aBLiskYij82dj1+NHGLUyIjpYjn8lmYmMnr8HOZny5Btj8s7V6k7oUXvZFU6k04OT2
         TcocCT2L1KV5VEruYo/1lSxJMk27wFLFLA7KV29kluuevd13ZKXxQrnoUbDE6NyubVkB
         9/PIDJQVJyyrkgdzttV1uamPffHqqwkjmZN3/qNlfKogw/gj+pH0uPaTP2QLfnOIYjTb
         AQFko1Z4A72KIVw+qVLDqojLnW34mdjzA047NEcocNIkEaMYnnpRMq26m7EOOeAxQJKz
         pd3oio9Ue6bqLxybimJXJl658AyjZY7NJTAZC8url0/i58HjGh6/9MkQgyUCKv6/pMhL
         q4xg==
X-Gm-Message-State: APjAAAXg99+VBzCu2JgT5zJZ6E/LuBqtm9j5K2c9w+oK+n3Fgd3pqJeI
        IH4kPmqtro6o4pvwHtQ/vzxbwWSg0tuYFBOGnDegcA==
X-Google-Smtp-Source: APXvYqyISYH7nKcdjdVCeeugv6IoT9S8/ObRtKGQv/5SEzsVgM1UETN2cuGzb4GZ/x3EBExgqyhrzlVjaHU1k+1xLF4=
X-Received: by 2002:a1c:a843:: with SMTP id r64mr4976939wme.45.1556861135435;
 Thu, 02 May 2019 22:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190501113038.GA7961@e121166-lin.cambridge.arm.com> <20190501125530.GA15590@google.com>
 <CABe79T5w4hb572KHUhyrwAN7+Xxnz2jF9OGLpfTmAdHuLuO2Fw@mail.gmail.com> <7c44526aebb6403890bab8e252c16375@AcuMS.aculab.com>
In-Reply-To: <7c44526aebb6403890bab8e252c16375@AcuMS.aculab.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 3 May 2019 10:55:24 +0530
Message-ID: <CABe79T5h3N3VZd12a51gGzOpw3-vrvNcQxS88q8xMi8=HWr6Tw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To:     David Laight <David.Laight@aculab.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for review, I will fix in next version of this patch set.

Regards,
Srinath.

On Thu, May 2, 2019 at 3:24 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Srinath Mannam
> > Sent: 01 May 2019 16:23
> ...
> > > > On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > > > > Few SOCs have limitation that their PCIe host can't allow few inbound
> > > > > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > > > > DT property and this address ranges are required to do IOVA mapping.
> > > > > Remaining address ranges have to be reserved in IOVA mapping.
>
> You probably want to fix the english in the first sentence.
> The sense is reversed.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
