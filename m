Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4395C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914772077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN+9VmVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfG1QI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 12:08:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35748 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1QI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 12:08:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id u124so39224947vsu.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oat0jFEJlEvABOmAlFb7bwdbZdjVZNd8ImPgoSC+TRM=;
        b=jN+9VmVct/UPgvulFXi4i/F6HFSp1sDYuYZs+ZwL8YTXaXGXyTofN8JbcEjekuOFvC
         am0Cz+rDGhtq4TNq+7kM9crqxONRE7k046dvTvqqe+zHACB1BEQ5GhN0OwY67iaf+P+2
         V64MgJv26CajBeL/wxfN4FD2HQ99AYEI4Buz23BbQ8J1l82NbTB1wIV6I8zcc3P2Ni6e
         ZfezmpAYUjnTnjaKDo6E1GiXO206lS11HQ5e0oIvaWo4IoNidhz7sp1p3xrj4nnUdkH5
         EkLqFQWjOHDh9QiUZDI4XGAnBoUpsfOX1z8yaIXPDWWSEn96jBOmX6ghjjwgkxgM91WX
         onSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oat0jFEJlEvABOmAlFb7bwdbZdjVZNd8ImPgoSC+TRM=;
        b=GTyIq8yEwDbXtu0IhbnEMHW3Z5jznVCzDoOaChVtBQ5cpGGTMmixjFm7+Q5UiDXlSi
         78km9h1qn7UxfouAnAMS6Ut+gTJZCHtaXcWcUio2rMVsMVUqQBxQYxLgxUqAtSOuFhJw
         fcUxtmFYwJ+ZLRdbG7I047NwnzDkElYU6mZiX8Jke/uiQGU9nVgGP2K24yzZM68RHVe1
         iKyACG6sdFsZyE6+47JuE3b43yHIU2rIVe5RRolVHWeeA6hc5oVYtROdkHupfNo7bbDf
         9gYTE37uEd1c0Lf4tY/4MSUjS1nt1kWubW5b0VSczhg9OWJZAx3NlW2Q3ahQa0NPsny2
         +ZrA==
X-Gm-Message-State: APjAAAXtosaZXn5Ey03AxZ2HwV3YllUd2tZZ15v0f8a87bGNsWoYgW8Q
        qQwzYGCHWlAgezEDAxPqpSjSn26ck7CoOASC2dM=
X-Google-Smtp-Source: APXvYqxMOElHr9cY76yjhTYcwZ00L3fQ+IG37kSHPVmmFzVu+jb85bhJCsmJxqClKzwEHt9r/FW+OqpOc7wFtOKzATk=
X-Received: by 2002:a67:e3d5:: with SMTP id k21mr6130217vsm.172.1564330104933;
 Sun, 28 Jul 2019 09:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190728124812.3952-1-oded.gabbay@gmail.com> <20190728131424.GB5007@kroah.com>
In-Reply-To: <20190728131424.GB5007@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 28 Jul 2019 19:07:58 +0300
Message-ID: <CAFCwf12WrwTBOJ-kLbACMN-d5rznuMBaEC2kYYJz38DwadwHug@mail.gmail.com>
Subject: Re: [PATCH 9/9 v2] habanalabs: allow multiple processes to open FD
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 4:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 28, 2019 at 03:48:12PM +0300, Oded Gabbay wrote:
> > This patch removes the limitation of a single process that can open the
> > device.
> >
> > Now, there is no limitation on the number of processes that can open the
> > device and have a valid FD.
> >
> > However, only a single process can perform compute operations. This is
> > enforced by allowing only a single process to have a compute context.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> > Changes in v2:
> > - Replace WARN with dev_crit
>
> Looks good, thanks.  The other patches in the series looked fine at
> first glance as well
>
> greg k-h

Hi Greg,

Actually after sending this to you, I think I have a problem with this
whole solution of allowing multiple processes to open my device.
I would like to consult with you about this. I have an idea how to
solve this problem but I want to hear what you think and perhaps you
have a better idea.

Basically, I have a multiple-readers, single-writer situation.
I want to allow unlimited number of processes to perform one of the
IOCTLs I have, the INFO IOCTL, which only retrieves certain
information from my device/driver. Those are the readers.
At the same time, I want to allow a single writer to perform ALL the
IOCTLs I have. i.e. submit work to the device, map memory, etc. This
is the writer.

The way I solved it above is not good. By doing "lazy creation" of the
context in the IOCTL call, I created an awkward situation where a
process that opens the device must call an IOCTL to execute something
in order for the compute context to be created.

Now, assume we have a box with 8 devices. The user doesn't care which
device it gets. So he opens the first device and that works for him.
Now another user comes and also wants a device. He opens the first
device and that also works for him. However, when they will try to
execute something on the device, only one of them will succeed and the
other one will fail. But the fail happens in the data path! not in the
open stage. This seems to me like a very bad design and in addition,
this also breaks existing userspace.

I thought of doing something similar to what the drm sub-system is
doing and that is to create an additional device file per device,
which will be called something like "hl-ctrlX" (in addition to hlX).
In hlX I will create the compute context in the open device. That
means the first user that opens the device has full access to it (the
writer). The next opens will fail (because a compute context already
exists). Applications (system management) that want to perform just
the INFO IOCTL call can do it through the hl-ctrlX device. I say it is
similar to drm because drm creates 3 device files per GPU.

What do you think ? Will you accept something like this ? Am I
breaking any rule with this suggestion ? Do you have another Idea ?

btw, I also thought maybe to use the read/write flags of the open
syscall to distinguish between reader and writer. What do you think
about that ?

Any help/advice/flame is appreciated.

Thanks,
Oded
