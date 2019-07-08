Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E931C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF6520861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+5yRMQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfGHLiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:38:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46728 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbfGHLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:38:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id o19so4799880uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5E4n9npTainsgeWeHKIO7haRg//t83t7wpBcjKc1EI=;
        b=a+5yRMQdCp05W5lQBi+Nsf82gIKYBxx2kTLEWwFGjS6NDssWPIX/iG6X7h7Pie8lqK
         NmeC14C5LYqj+AF4nFJDrgkbdi/C1EXP3W0RkQNxsIqL4yTOE+t+2RbGKhG0S6RHNiK8
         CDayMvFBdNofZvDLVXHCwYX1i75FElfuCS8h0cS1ZP6fhzIrLbyicgRPQXvCcYe0abUP
         KxY6jZoL0QdOezI4/yNbQ4vXWb5m5QMva33Jxi60/T3ElnvdIIrOM/rrDoPDlW3fQ8PI
         UV3NyIdQpi72J16ajxdTxfeoh+Od4P/m24WfrvF1HGx99rPV0EpY6fh6AMWeSJkf15rL
         IuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5E4n9npTainsgeWeHKIO7haRg//t83t7wpBcjKc1EI=;
        b=TTXyNxcBYGzR7yA+kUsvHGU/Pc+j3vrnb/7qIXd6tGyQla7/jRcC0beuzKXMAPxpmB
         9mob8nVKVe9oIhLsdrIe5Hq8tu/voMHb1d4VAFPiN54dmGc4DpVE2mMS7c1J34/mAIuO
         WGoSLKJcfJPATcHIgZCEtpizcndc3O/3Te3vtw0Q2DR8ZPLunejfJ25M0FHsPFyVfbCm
         iPLKdhTbgltZrfZnSiiw+VIOFHMsTbq233elnWuOIvPAxToytEC82yEBo9fUVMfw+rq1
         pGY+78cl5JzjGfB1abw4Q5njxaRI5UdDn6ECP5sk57gsNDCcTHAIYADe0YVgYQ6K07cS
         MokA==
X-Gm-Message-State: APjAAAUXzFRi4ClRca6U9Yb3OxPKvOFhWfma96bhZK+R4rQTSQOIHKsb
        3Xej3hoXwoKQvjhbeStw8y2hbXXzAdTfDdCGLj6ylQ==
X-Google-Smtp-Source: APXvYqyG9rxgsBkPO3Q/qWYU94JZ8SBCOSSIrg6QYN7bP31CsSyQ/lc/BEjb2W/8RV1j0w6RgNy5y8HYv3vu5lOUoP8=
X-Received: by 2002:ab0:20cc:: with SMTP id z12mr9138611ual.32.1562585890288;
 Mon, 08 Jul 2019 04:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190708104355.32569-1-oded.gabbay@gmail.com> <20190708112136.GA13795@kroah.com>
 <CAFCwf11XN_stq3HHVGqD4_LKG8W3uFiYarfbwP50hw58Hi10Sw@mail.gmail.com>
In-Reply-To: <CAFCwf11XN_stq3HHVGqD4_LKG8W3uFiYarfbwP50hw58Hi10Sw@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 8 Jul 2019 14:37:45 +0300
Message-ID: <CAFCwf10Siysrdd61itf0stM_8S8UXmzROtAZmV1eJzfC3p7UXg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use correct variable to show fd open counter
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 2:30 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Mon, Jul 8, 2019 at 2:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 08, 2019 at 01:43:55PM +0300, Oded Gabbay wrote:
> > > The current code checks if the user context pointer is NULL or not to
> > > display the number of open file descriptors of a device. However, that
> > > variable (user_ctx) will eventually go away as the driver will support
> > > multiple processes. Instead, the driver can use the atomic counter of
> > > the open file descriptors which the driver already maintains.
> > >
> > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > ---
> > >  drivers/misc/habanalabs/sysfs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
> > > index 25eb46d29d88..881be19b5fad 100644
> > > --- a/drivers/misc/habanalabs/sysfs.c
> > > +++ b/drivers/misc/habanalabs/sysfs.c
> > > @@ -356,7 +356,7 @@ static ssize_t write_open_cnt_show(struct device *dev,
> > >  {
> > >       struct hl_device *hdev = dev_get_drvdata(dev);
> > >
> > > -     return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
> > > +     return sprintf(buf, "%d\n", atomic_read(&hdev->fd_open_cnt));
> > >  }
> >
> > Odds are, this means nothing, as it doesn't get touched if the file
> > descriptor is duped or sent to another process.
> >
> > Why do you care about the number of open files?  Whenever someone tries
> > to do this type of logic, it is almost always wrong, just let userspace
> > do what it wants to do, and if wants to open something twice, then it
> > gets to keep the pieces when things break.
> >
> > thanks,
> >
> > greg k-h
>
> I care about the number of open file descriptors because I can't let
> multiple processes run simultaneously on my device, as we still don't
> have the code to do proper isolation between the processes, in regard
> of memory accesses on our device memory and by using our DMA engine.
> Basically, it's a security hole. If you want, I can explain more in
> length on this issue.
>
> We have the H/W infrastructure for that, using MMU and multiple
> address space IDs (ASID), but we didn't write the code yet in the
> driver, as that is a BIG feature but it wasn't requested by anyone
> yet.
Let me amend the above statement:
We have the H/W infrastructure for that in GOYA. In GAUDI (I don't
know if you saw the press release), we don't have it, as the use-case
of that asic (training) doesn't require multiple processes support.
Therefore, when I will upstream that ASIC code, I will have to always
prevent multiple processes from opening file descriptors at the same
time, due to the above security concerns.

Oded

>
> So the current solution is to block the ability to open multiple file
> descriptors.
>
> Regarding this specific sysfs property, I don't really care about it.
> I simply saw that it is shown in other drivers and I thought it may be
> nice for a system admin utility to show it.
>
> Thanks,
> Oded
