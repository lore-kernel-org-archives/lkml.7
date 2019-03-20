Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC60C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC692183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmuJS4dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCTQLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:11:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37568 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:11:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so12236618wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PdN8bZNJMWdZ4Zi7pWsi2wFU/QM5+o2MrnWrqwYPdW4=;
        b=LmuJS4dQCG9Dt5f6sbosls3tYtFPHtCcWa8S4C7jctPZZYJFT5z6VMC5enCEyD5ap6
         xsZ7aM39Z4cWXXk94Mm1+FgwC+IxecgE+8AbEmhyxake/iLPvR0qqiZdyk1OOkAxxTxM
         nc/k+4DRDvsrSgD76P/WrbEE3Q4OLz9FrWT2e7g1cy/gFiazYkMxhJPCC4/BoyTaMN1p
         mEiBcrUec5i0QY7LESQnW3+iWJhSrTUIXxk09H13c9TMSr/8U3IH6EvQIQWTZ92u0gFD
         hcKhXlCC9MNXQiUbIhOq1f5vjZg9oaoh4K875NwNNNufrOeXf302Q2e2KXcZW1F4OJce
         Kxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PdN8bZNJMWdZ4Zi7pWsi2wFU/QM5+o2MrnWrqwYPdW4=;
        b=AhNR5jtRerEzsPhbu3gh5dIlmbuB95S6JV189Nh5cfCe87/DBbXl2VbYzuRCpAOzk3
         qV5vvj2bbJbR1w48Ydi6M/uZhlwzQoGxqsOLuO6CGJrZgrY+uEGXrYs1+HODx+/ntbwr
         Hb01a9sy/93u5wjyGg2T7BLqylUL0J3ej3S6nK/9gxZDvZIO9G6bkxKLHfqS+kTgwH2C
         lEWBCSxvEe+DsOIFKW3Qz6oXs/Hh5LmS33Yxa/khCH42BYipuzX+PKM9yZbpI+g5P3GX
         BxbetPgavb0zEVOAqzuBY8H6RuvxGzkz5Pvhu/4g6suXBEBnYaTTk4viwg5F0RDixH5v
         9Y9w==
X-Gm-Message-State: APjAAAW+OuWulFfN5fpXHcmPi5fUr6tS5JfM2a+MNRqcuBbEQQxyJBR6
        xhurklaOPaWMlAwuI9Es/E6VEm2hG0qb0jd5/Beraw==
X-Google-Smtp-Source: APXvYqxBbNi+dbSbGM+A8sly6AIun8ogCPygRl2G/URsrUtsQ8sKif3ehMrQ7SZmBYAyW7xd8biJLC0K2Hv6efV3GU8=
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr9328232wmh.9.1553098302879;
 Wed, 20 Mar 2019 09:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
 <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
 <CA+M3ks7q8QnNirk_WkaE5CmFWkEPn4uu5Hfb2kP+4d5qapHvrA@mail.gmail.com>
 <c51be371-086a-bd5b-b70a-5579f5b95320@ti.com> <CAF6AEGss21WmpF7sHGTxOEjuadSNpM6M_Z-WweK2W68FEHOFdA@mail.gmail.com>
 <CALAqxLVbdpj+T4u3jZ_5Uqda5La1Py-ZGpXSep_CCoLzWyap8A@mail.gmail.com> <CA+M3ks61BGPkPjNd01g32LV7YZfDpy8t100KxQhScOFgGO4KjA@mail.gmail.com>
In-Reply-To: <CA+M3ks61BGPkPjNd01g32LV7YZfDpy8t100KxQhScOFgGO4KjA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 20 Mar 2019 09:11:31 -0700
Message-ID: <CALAqxLX-ooNmHBmSr3iRvHhBwP+rinc7WOe0Aw1dKKyKZWE0iw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, "Andrew F. Davis" <afd@ti.com>,
        Alistair Strachan <astrachan@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chenbo Feng <fengc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Marissa Wall <marissaw@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 2:16 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Le mar. 19 mars 2019 =C3=A0 23:36, John Stultz <john.stultz@linaro.org> a=
 =C3=A9crit :
> > On Tue, Mar 19, 2019 at 2:58 PM Rob Clark <robdclark@gmail.com> wrote:
> > > For at least some hw the importing driver needs to configure things
> > > differently for secure buffers :-/
> >
> > Does the import ioctl need/use a flag for that then? Userland already
> > has to keep meta-data about dmabufs around.
>
> To secure a buffer you need to know who is allowed to write/read it and
> hardware block involved in the dataflow may need to know that the buffer
> is secure to configure themself.
> As example for a video decoding you allow hw video decoder to read in
> a buffer and display to read it. You can also allow cpu to write on the b=
uffer
> to add subtitles. For that we need to be able to mmap/kmap the buffer.
> Using a carveout heap for secure buffer mean that you reserved a large
> memory region only for this purpose, that isn't possible on embedded devi=
ce
> where we are always limited in memory so we use CMA.
> In the past I have used dmabuf's attach function to know who write into
> the buffer and then configure who will be able to read it. It was working=
 well
> but the issue was how to in generic way this behavior.

Given the complexity of the configuration needed when allocating the
buffer, instead of trying to make a generic secure buffer allocator,
would having per-usege heaps make sense?  It just feels there are so
many specifics to the secure buffer setup and configuration that maybe
there can't be a generic configuration interface.  So instead maybe we
let the heap implementations provide set usage configs?

This doesn't necessarily require that you have separate pools of
memory (they can share the same backing store), but by having multiple
per-config heap devices, maybe this could avoid trying to fit all the
options into one interface?

On the import side, I'm not sure how much the importing device needs
to know about the specific rules here (out side of "secure buffer" or
not), so maybe that's another catch.

thanks
-john
