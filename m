Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF0BC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E1B216F4
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFgHgE5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHKHkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 03:40:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35036 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfHKHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:40:48 -0400
Received: by mail-vs1-f68.google.com with SMTP id q16so2346933vsm.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOd915wRGmaFHmvSsqMLaIMuU9MZwgBIy0+B1JtnVN8=;
        b=FFgHgE5/l2OnB2DQEQFAVQq+wm13sBZ2hN4bqbyskwilGjMRw8ygGcbdQbPdKA7Z6N
         S7i+VAbnmWUNtvPjaTETWeTwvvzZ1qZS0Muec/gnvZGyjNgv0xiMXfy8cXarNL3zM2vt
         T7n67Dwn7fb/lFIC8cYSP+2UCYKOj6plJHZRKFV+PKZCBbjvvZn2VpA+QQizaUNz2NYT
         yavACqH8pzxLkJmDPjZn4qTINJeTAKzjeedy9RGyVIO4pC6wJ3WmnR5Ju7BlJwemPnGf
         l+LZ6l4fWeA4zHb9tar3gFuQ7d64WLYT/7Iqkqx83NzCD6spWrKYAXQOiQhy7Y6dKOHT
         EtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOd915wRGmaFHmvSsqMLaIMuU9MZwgBIy0+B1JtnVN8=;
        b=nXzc903pW8CkHP4iZAyvwhFdWVcyTI5jE8YodfEHdd9bfdE3M5FEsRN2v3WkzywCmg
         s5yYZiEiJHM8N1fQzb1NLgPb4y+Jf52WKX3RS7oOt46R3dunOlPmofBYP3PehrstXqa1
         OAXH/xTYIb2Sz9ceZ2OC+u1pELG9+Ys25lRFnX7aOs/hWDE6c2JvHP8zhpmGfQmQfRNZ
         CVZbvqAvfLCEPC6yMLxLclFqmZbpBWcOw1ODdPjWq4zkb963GX4M6tRLJfwex8C/j0+m
         74cvSSZatHSr/LnABNo74ZyycHNZ3xc9AKeQ8xxBRZQADk7RKbY/7ru0JZMQKABVcyf9
         C4zg==
X-Gm-Message-State: APjAAAVVOu8aecovC4ZrGVzwQ9jjUl4qYrM2HRnnwFLc4fw4zZbVcvzy
        4snobwSo1byCT3vdJ/Jw/GfGdiT/IScY2xSRmGsuC4cd
X-Google-Smtp-Source: APXvYqy1VFm1njiMe8uo43oTbhKqL8jfcGnbAMHsqnnZGt8z+TD5UWHOE9PfXxjEkUhiMQyqt5gUU+uOPetrxKVrN0E=
X-Received: by 2002:a67:d410:: with SMTP id c16mr19361782vsj.61.1565509247573;
 Sun, 11 Aug 2019 00:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190810123808.13845-1-oded.gabbay@gmail.com> <20190810125344.GE15251@kroah.com>
 <CAFCwf10SV0w-HQHuONSmdcDYFjmCJN3PLzc89MQMO4j37Qum=w@mail.gmail.com>
 <20190810172317.GA4482@kroah.com> <CAFCwf12E7CQFG1=etvYogp7rvg8+R=hYR0OBD3j1Zqba1u5Hug@mail.gmail.com>
 <20190811073856.GC3034@kroah.com>
In-Reply-To: <20190811073856.GC3034@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 11 Aug 2019 10:40:21 +0300
Message-ID: <CAFCwf10FHK-qWbXcMF0mTCD+xTJkXaTzOjsZwpBwQNuc6T_QXA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: print to kernel log when reset is finished
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 10:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Aug 10, 2019 at 08:45:54PM +0300, Oded Gabbay wrote:
> > On Sat, Aug 10, 2019 at 8:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Aug 10, 2019 at 06:29:16PM +0300, Oded Gabbay wrote:
> > > > On Sat, Aug 10, 2019 at 3:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sat, Aug 10, 2019 at 03:38:08PM +0300, Oded Gabbay wrote:
> > > > > > Now that we don't print the queue testing messages, we need to print when
> > > > > > the reset is finished so whoever looks at the kernel log will know the
> > > > > > reset process was finished successfully and the driver is not stuck.
> > > > > >
> > > > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > > > > ---
> > > > > >  drivers/misc/habanalabs/device.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> > > > > > index 9a5926888b99..1fac808c2546 100644
> > > > > > --- a/drivers/misc/habanalabs/device.c
> > > > > > +++ b/drivers/misc/habanalabs/device.c
> > > > > > @@ -907,6 +907,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
> > > > > >       else
> > > > > >               hdev->soft_reset_cnt++;
> > > > > >
> > > > > > +     dev_info(hdev->dev, "Successfully finished resetting the device\n");
> > > > >
> > > > > Really?  For doing things "properly" there is no need to spam the kernel
> > > > > log.  Only spit stuff out if an error happens.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > I beg to differ for two reasons:
> > > > 1. Reset happens very rarely, if at all. So this message (that get
> > > > printed after reset is done) will definitely not spam the kernel log.
> > > > 2. When a reset starts we print an appropriate error message. I think
> > > > it is expected by the user that we will also print if and when the
> > > > reset has finished successfully. I really believe that lack of this
> > > > printing might be deceiving for users.
> > >
> > > How is anyone going to parse the kernel log for anything to know if
> > > something happens?
> >
> > Actually our jenkins server parse the kernel log and look for bad
> > messages from the driver...
> > But the main reason for this, IMO, is for developers (in userspace)
> > that run with a terminal open on the kernel log to see if something
> > bad happens while they run their applications.
> >
> > >
> > > How do you trigger a reset?  Is it done by userspace?  If so, just
> > > notify them then.
> >
> > Reset can be triggered by two main reasons, but a userspace
> > application is *not* one of them.
> > It can be due to a command submission not finishing in time or from a
> > major error in the device (e.g. double ECC error).
> > That's why I think it is important to tell them the reset +
> > re-initialization flow was finished successfully.
> > Of course all this information, let's call it operational status, can
> > be acquired by the INFO IOCTL the driver provides, but it is *really*
> > convenient, IMHO, to see these type of messages in the kernel log
> > while they happen.
>
> Ah, yes, if this is something that userspace can not trigger then it's
> ok.  But you should then make it a 'dev_warn' to match up with the
> message level when the reset starts.
>
> thanks,
>
> greg k-h

Sure, np.
Thanks,
Oded
