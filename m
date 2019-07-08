Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB55C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0984020659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="RgQ7pDHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfGHDeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:34:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32908 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfGHDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:34:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id u15so11525511oiv.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 20:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkIf/4d4XoQcXWNvxNaAongy4aNo7OFBScY9cTS8ZR8=;
        b=RgQ7pDHD+4h0crwwiPkH/DqNHQaRqM5BuFD3KVrCdw5JSZqaSVtkv/PKlix7BoX2Gl
         n3IJohJx3XQr+ErVc+lyFHz8W1RD92KAgpKoa8RtQJ4am1gLzg5oY5cfKKU30fInpNhe
         qGGJJm2RxeBUpKRellKe4QVMoT31fHPk7MJ3HbtNdx0aALA0w814MFlxMwOwQvQdPSNR
         yZaoub5PfXnOKybIxAvTqTzrf0BdlV7WX2hNj6nTTByFAkzy8yolBKGf8eFQLtO4BdXk
         TezI1ASXbJfQugxNr15fZQ7SwRS7fhgPTRIag5Yc4iPsOBVxsMSNj2iB5xalBDn7C0hi
         baOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkIf/4d4XoQcXWNvxNaAongy4aNo7OFBScY9cTS8ZR8=;
        b=RXkxNY4+RcXRPE6R9jfq2mz5hCrTp5eGHWFh6HUORDCgsJwhsuAqMxCkgU3KzmeE2i
         bwiuVApa3ghOyQKyFohifa0BoLOd6bKcxl0Jm04JJaDEHl6fRNA6hEDf5Z+h8SzEzfM6
         oLQxUhGqc4rZafaUPq+aYrymtypkH4maCmgFMl0DA4PctL4p/lTo6RGIjxRNbdfVCvI/
         W8jifFUnXkF83hPRJBC83TdcTarTX/djR6AjN98SiSRBVGZadPH88H9GA+KYKxufToZD
         au1/C9S0jWE0cv2XOxkLnShe1Kc1/AhSq4en+xL5l5rZYcuVbuZR6MENLXaVVKaTnAkw
         8Hzw==
X-Gm-Message-State: APjAAAVEd8/YXoSHXGeX6p/9TE9It74ajZ+k/NBt2irf4nizvSwx8U81
        dLTRm3Tu2bX/6BCyamge+JUrCfW2LSj3TU4Ztbwwaw==
X-Google-Smtp-Source: APXvYqw1WulD4u8DtuHK5p44+YCtiMFiJED8lZffzDI7s23QrInNyg0FnMg8wYsAmNPpyEBNKIS22UEKVsJkIB5GAe8=
X-Received: by 2002:aca:50c6:: with SMTP id e189mr8127125oib.63.1562556846882;
 Sun, 07 Jul 2019 20:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190627000412.GA527@kroah.com> <20190627225335.72107-1-trong@android.com>
 <20190628151040.GA14074@kroah.com> <3451189.hAX5mKGt1u@kreacher>
In-Reply-To: <3451189.hAX5mKGt1u@kreacher>
From:   Tri Vo <trong@android.com>
Date:   Mon, 8 Jul 2019 12:33:55 +0900
Message-ID: <CANA+-vAxU5jp6PQ26NU+UMc6iyw6KkBS9nbd6wj0qqkO-1WhYg@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>, kaleshsingh@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 7:31 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, June 28, 2019 5:10:40 PM CEST Greg KH wrote:
> > On Thu, Jun 27, 2019 at 03:53:35PM -0700, Tri Vo wrote:
> > > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > > blocking wakeup sources over device's boot cycle. This information can
> > > then be used (1) for power-specific bug reporting and (2) towards
> > > attributing battery consumption to specific processes over a period of
> > > time.
> > >
> > > However, debugfs doesn't have stable ABI. For this reason, expose wakeup
> > > sources statistics in sysfs under /sys/power/wakeup_sources/<name>/
> > >
> > > Embedding a struct kobject into struct wakeup_source changes lifetime
> > > requirements on the latter. To that end, change deallocation of struct
> > > wakeup_source using kfree to kobject_put().
> > >
> > > Change struct wakelock's wakeup_source member to a pointer to decouple
> > > lifetimes of struct wakelock and struct wakeup_source for above reason.
> > >
> > > Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> > > source statistics in sysfs.
> > >
> > > Signed-off-by: Tri Vo <trong@android.com>
> >
> > Ok, this looks much better, but I don't like the use of a "raw" kobject
> > here.  It is much simpler, and less code, to use 'struct device'
> > instead.
> >
> > As proof, I reworked the patch to do just that, and it saves over 50
> > lines of .c code, which is always nice :)
>
> Thanks for taking the time to do that!

Thanks a lot, Greg!
>
> > Attached below is the reworked code, along with the updated
> > documentation file.  It creates devices in a virtual class, and you can
> > easily iterate over them all by looking in /sys/class/wakeup/.
>
> That actually is nice - no need to add anything under /sys/power/.
>
> > Note, I'm note quite sure you need all of the changes you made in
> > kernel/power/wakelock.c when you make the structure contain a pointer to
> > the wakeup source and not the structure itself, but I just went with it
> > and got it all to build properly.
>
> I'm not really sure about it either.
>
> > Also note, I've not actually tested this at all, only built it, so I
> > _strongly_ suggest that you test this to make sure it really works :)
> >
> > What do you think?
>
> I agree with the direction. :-)

I'll test things out and send v3 of the patch. Thanks!
