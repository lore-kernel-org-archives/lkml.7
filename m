Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A07C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C53208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSFcdsCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfGKTzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:55:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34990 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfGKTzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:55:35 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so15317871ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKEGvB7hbPfo85nCRcTIzY9GkrcRv222RzSOPFab/us=;
        b=QSFcdsCwzkkOtVTYGSJYNE6+HBuA3J1EbnAKN2dFJngEjaIMob6GJDSNuJ/GesoNxR
         5dswstzk1JkVPKkVWmoqvsIUODWvMjgcPYH1MCRPpOLAnmuu+A/eCr0svcIL8ES1+ovy
         WN3fyp89Zmgvy2pJg4/RFbtwItAgfHMqg1G1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKEGvB7hbPfo85nCRcTIzY9GkrcRv222RzSOPFab/us=;
        b=Ou5cLC6maBAmYNoVNSToWOKd3PrcH00IpABMesRhlSRlMIMydvs5c1LkvVIbyL7nUs
         B4zO2OW+ejcrwn3l2SCfDKOLif+z23mo8qnELlagbyCzHpJwdbDrEvx7q3np0QUhJHmZ
         mmlI5RikGLVruGtsBQWXZoJLe3Kk7YKmxp0eH/IPePfwLJ64wjyREUYOCywESStiZAa8
         +xtmVEneLB7SRgUcx+4UBvZ45gpE5qeRlbquylnKrnBhbry3vzOmpgyip2Q37LCJSXNh
         25b0HKzhi0/hn2TfUZOQqOmXy++kP7koETARvSq89WiGvQ+p3kfDVhMLhX9LaBcOsbjq
         p3rw==
X-Gm-Message-State: APjAAAW6JnNd3UAHkWnxrYNc2t2iza97TTL5+h/BmHw99XvCnQLkQZcd
        3RZlK+87bPJPeTWeQ9q50LcukQ4zF2g=
X-Google-Smtp-Source: APXvYqwFwfOw+k46/bxO6gZr/2kUeHSJLRGBroQ5VRL2mZ+YDeVcuq1eeZdKIieVdDhmVXU25yrLHA==
X-Received: by 2002:a02:914c:: with SMTP id b12mr6755071jag.105.1562874933789;
        Thu, 11 Jul 2019 12:55:33 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id u17sm5486537iob.57.2019.07.11.12.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 12:55:32 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id k20so15220535ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:55:32 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr2268109iob.142.1562874931799;
 Thu, 11 Jul 2019 12:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190711162919.23813-1-dianders@chromium.org> <20190711163915.GD25807@ziepe.ca>
 <20190711183533.lypj2gwffwheq3qu@linux.intel.com> <20190711194313.3w6gkbayq7yifvgg@linux.intel.com>
In-Reply-To: <20190711194313.3w6gkbayq7yifvgg@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Jul 2019 12:55:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vja80tuLkojoCbrE=vfqvD8EMnzgKiQ1SGcM-2jMGZUw@mail.gmail.com>
Message-ID: <CAD=FV=Vja80tuLkojoCbrE=vfqvD8EMnzgKiQ1SGcM-2jMGZUw@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, "# 4.0+" <stable@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Andrey Pronin <apronin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 11, 2019 at 12:43 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jul 11, 2019 at 09:35:33PM +0300, Jarkko Sakkinen wrote:
> > > Careful with this, you can't backport this to any kernels that don't
> > > have the sysfs ops locking changes or they will crash in sysfs code.
> >
> > Oops, I was way too fast! Thanks Jason.
>
> Hmm... hold on a second.
>
> How would the crash realize? I mean this is at the point when user space
> should not be active. Secondly, why the crash would not realize with
> TPM2? The only thing the fix is doing is to do the same thing with TPM1
> essentially.

I will continue to remind that I'm pretty TPM-clueless (mostly I just
took someone else's patch and posted it), but I will note that people
on the Chrome OS team seemed concerned by the sysfs locking too.
After seeing Jason's message this morning I dug a little bit and found
<https://crbug.com/819265>

-Doug
