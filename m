Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E1BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D7A2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHel+7L4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfG3LYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:24:25 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39564 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG3LYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:24:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id u3so43173230vsh.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qy8b6pAXT1g85uDKbfjr6dpN6mEfPaoI9G12nmWUecQ=;
        b=BHel+7L4QsLoebhk7Re1KWwPfxlofOR5sOWeAKaPO+F+6XBPaegT1bMbpOrJ+X/NCt
         boAsGFcqUtP5mxuthp1/ZXtQIobta7ItmM3NhyNXNUsXy5eqlGw3u/oGJT9SwQuIIcMz
         BVc4UKcDTnqdLVWi8S3QrLy8spyZJJpA8nuYcl1Rg5tqAQ2CYFhBrUBPLXAbnrWJ4pa0
         v4e+xZOP2hP1OnP3kjDm6ppgFyneHNfwkeQp4k3Bck+oBDvF00ncxuHq5Mx+KE6xjt8V
         PKKmES6fpPYmLgkyIi3zceJ/TD51D0sbrO18/Omkk/jCfAEp1mG3GKDW0252JqHELS5b
         teyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qy8b6pAXT1g85uDKbfjr6dpN6mEfPaoI9G12nmWUecQ=;
        b=KJT7gmetdkJals81bkmxQGETCgkzC74+EsrH149FoeQ/bHD9eqjE19W0rLwuGq+7mD
         rYctqDEvnpCI8H2SfG+VBtDDpHfgCOsc4Yttw74gZB1GipBpIIDNUFacuTfndOnTcOYd
         wPW4GPzjoYcE+5COHhFd8HlYRJsdheCFIvotFjtJe27vDR2ooTlnyMPxNQV90AbFysBG
         5MNpZxklKkPteauxtt26QNGrHnnktP6MdZHBTVz2PwdSz0BDIkpA31uwyHjP4yKY5S9S
         EnDSzmzyUWaJsDTaXl8yoyc24v+2T5+q4sbCcjG9xY29WTkMYAaHD5Rs3vWWPLf1O6BE
         EOyA==
X-Gm-Message-State: APjAAAWCXqMPZ02Ck/zDE5F/j3VP4cNNZzZdksKXk7I+ZACqrlUL4gCV
        sCta6zAD/22Bj10mXGL7aILgHyiHK1gAi+Wc/5E=
X-Google-Smtp-Source: APXvYqww39n/S9WrQJCAzIN84Mni9AHD1WpQdD9/9K0BU5F0LI8Wzfhs3zZ+99C8KqNvrAOmTsXBIhnVPoiGXLT3q5s=
X-Received: by 2002:a67:dd81:: with SMTP id i1mr51787134vsk.236.1564485864055;
 Tue, 30 Jul 2019 04:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190730094724.18691-1-oded.gabbay@gmail.com> <20190730094724.18691-8-oded.gabbay@gmail.com>
 <20190730104207.GB7325@kroah.com>
In-Reply-To: <20190730104207.GB7325@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 30 Jul 2019 14:23:57 +0300
Message-ID: <CAFCwf11VFEN0o1sAxPjuv3SvoebD_C4QLrsc9Ea8GiVRdztbnA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] habanalabs: create two char devices per ASIC
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 1:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 30, 2019 at 12:47:24PM +0300, Oded Gabbay wrote:
> > This patch changes the driver to create two char devices for each ASIC
> > it discovers. This is done to allow system/monitoring applications to
> > query the device for stats, information, idle state and more, while also
> > allowing the deep-learning application to send work to the ASIC.
> >
> > One char device is the original device, hlX. IOCTL calls through this
> > device file can perform any task on the device (compute, memory, queries).
> > The open function for this device will fail if it was called before but
> > the file-descriptor it created was not completely released yet (the
> > release callback function is not called from the kernel until all
> > instances of that FD are closed). The driver needs to keep this behavior
> > to support backward compatibility with existing userspace, which count
> > that the open will fail if the device is "occupied".
> >
> > The second char device is called "hl_controlDx", where x is the minor
> > number of the original char device + 64 (HL_CONTROL_MINOR). Applications
> > that open this device can only call the INFO IOCTL. There is no limitation
> > on the number of applications opening this device.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
>
> This reminds me of the old tty "control" devices we finally got rid of
> many years ago.  The more things change... :)
>
> Anyway, looks sane to me.  If you are ok with this userspace api, no
> objection from me.
>
> Only one comment below:
>
> > --- a/drivers/misc/habanalabs/habanalabs.h
> > +++ b/drivers/misc/habanalabs/habanalabs.h
> > @@ -51,6 +51,8 @@
> >  /* MMU */
> >  #define MMU_HASH_TABLE_BITS          7 /* 1 << 7 buckets */
> >
> > +#define HL_CONTROL_MINOR             64
>
> Don't try to segment your "dev" and "control" device nodes by minor
> number range, as you will run into problems once you have a system with
> more than 64 of these in the box at once.
>
> Just use the whole range, and do:
>         dev = minor N
>         control = minor N+1
> and so on.  That makes your control device node an "odd" minor and your
> "real" device an "even".
>
> Given that all existing systems should be using devtmpfs, you should not
> have any problem with changing the minor number of them at the next
> reboot, right?
>
> thanks,
>
> greg k-h

I agree, will change that and re-send.
Oded
