Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6DBC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9182086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adtI0jSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfGHLak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:30:40 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40237 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfGHLaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:30:39 -0400
Received: by mail-vk1-f196.google.com with SMTP id s16so2382785vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5pzFQLY6wAoyJcQlkFDkL7kYuo2S97DwVQaLferHSE=;
        b=adtI0jSSRetz0cNJDNRwN3rBX2RHyttxZZI5I9aqf8ysnKkFUV9FnFS27VnYtOfn3k
         5o4kjJ+1I7J7CxPMgViFjIvNnjEIkWU7xA2E97bin/QdmblNigUoUrRme8BaG4m5ZYl3
         Ho71Syo2ZZgqEIOykddM5miHuCI+U0mcIRM0pOauDbdBdKhtxOOzFo+IDcQKS5ChyCwF
         lqyLUI8/4kb5ET4/G0VdZ36KN5HB+0TK1V/bNWkwueoANCSB+/pvjYbPtEpBKJE8paHt
         i8RsNVyHl/fjxqKMiTAzbnPmwTYsyV6UdPcAu3OZxS7m89KY8v9tbCDhTpHueUw4QKBR
         C12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5pzFQLY6wAoyJcQlkFDkL7kYuo2S97DwVQaLferHSE=;
        b=XQWlCcCULLGF9fTxu2f08b8D0QOBZLMX/BXVGNlgPWHM9Me7ZvI8T3lhWjgJiSVTiB
         qiTXNagCN0q+SZS++9XRY6GDsLJOMyXKEzf8WtDys9Q/e2MV7h4ijwGm7MI24QU/eMMF
         lidhj/QCD+IXCj8OetFrE5cGipOZbSnOHXbOQz4qDdApdk8BIiZ+CJcjXHNq8IltCLfD
         JaNOH1lijNQmJPQDqgdGYcONJofCmxiiRXoQylVAMXHUKqKO/NlPeLTo0W+xBGEfGY5x
         Fc8xdOAvwCxm9aCnz19glwzWkqBdptbaNN6V8eNN66KnIrtExXuFGUupVevFL+W9p1z8
         qelA==
X-Gm-Message-State: APjAAAV605hG/ER7nwgD0CbfCo0DqxJMebNXH0Bx3sNRiiQvfk1JwONf
        H5wKjQDE05heN9YEfmm1hOV4SmFU3XmxdpnJlbc=
X-Google-Smtp-Source: APXvYqzZj0O/XoyIApAsOwMBymdNTN9PHBX1xVuSebLD+VpmLa8vLdEL5x+09EymCWCqwKnpWYmt9HaaiwIag95c4s4=
X-Received: by 2002:a1f:ee0a:: with SMTP id m10mr4869923vkh.73.1562585438687;
 Mon, 08 Jul 2019 04:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190708104355.32569-1-oded.gabbay@gmail.com> <20190708112136.GA13795@kroah.com>
In-Reply-To: <20190708112136.GA13795@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 8 Jul 2019 14:30:13 +0300
Message-ID: <CAFCwf11XN_stq3HHVGqD4_LKG8W3uFiYarfbwP50hw58Hi10Sw@mail.gmail.com>
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

On Mon, Jul 8, 2019 at 2:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 08, 2019 at 01:43:55PM +0300, Oded Gabbay wrote:
> > The current code checks if the user context pointer is NULL or not to
> > display the number of open file descriptors of a device. However, that
> > variable (user_ctx) will eventually go away as the driver will support
> > multiple processes. Instead, the driver can use the atomic counter of
> > the open file descriptors which the driver already maintains.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
> > index 25eb46d29d88..881be19b5fad 100644
> > --- a/drivers/misc/habanalabs/sysfs.c
> > +++ b/drivers/misc/habanalabs/sysfs.c
> > @@ -356,7 +356,7 @@ static ssize_t write_open_cnt_show(struct device *dev,
> >  {
> >       struct hl_device *hdev = dev_get_drvdata(dev);
> >
> > -     return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
> > +     return sprintf(buf, "%d\n", atomic_read(&hdev->fd_open_cnt));
> >  }
>
> Odds are, this means nothing, as it doesn't get touched if the file
> descriptor is duped or sent to another process.
>
> Why do you care about the number of open files?  Whenever someone tries
> to do this type of logic, it is almost always wrong, just let userspace
> do what it wants to do, and if wants to open something twice, then it
> gets to keep the pieces when things break.
>
> thanks,
>
> greg k-h

I care about the number of open file descriptors because I can't let
multiple processes run simultaneously on my device, as we still don't
have the code to do proper isolation between the processes, in regard
of memory accesses on our device memory and by using our DMA engine.
Basically, it's a security hole. If you want, I can explain more in
length on this issue.

We have the H/W infrastructure for that, using MMU and multiple
address space IDs (ASID), but we didn't write the code yet in the
driver, as that is a BIG feature but it wasn't requested by anyone
yet.

So the current solution is to block the ability to open multiple file
descriptors.

Regarding this specific sysfs property, I don't really care about it.
I simply saw that it is shown in other drivers and I thought it may be
nice for a system admin utility to show it.

Thanks,
Oded
