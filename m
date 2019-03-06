Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF473C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBB520840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJNDFgmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfCFQ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:57:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36434 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfCFQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:57:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so14242355wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 08:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Blkvnz+Gqia4b6LuRXmE1gWAtD7ntvEWDlxrsHxK3c=;
        b=YJNDFgmf1xIbn1Ab7vHlvT0BzEaM9Zdtm81M4uGipmJAtRXlPlcllktkHvmEt+3FuZ
         CHbZ9wfubNKjTwrBNldZrGxz9wV0rPH+fxyKAVAw/IXhYIdMpsZPHNAAMDfEbKkRixxj
         tElYCxYdY6bAtJW/lozWSPk8c0mY+Hnk4/65AVszevyh00m3uczob6HNM/HlY2KS1DEf
         ClhxR+8TaPewFrITIQwN97brTa8Q83eRHGGDmWp+LKsXmYZD0eAf0vbKN5TKHwjL2diS
         S+THVVQhIQPlRtB0OJ50RvFBTN+Vr6AI3O7ExROvIEm+B4dbX0YhmOC59K61kz9FeWNV
         8tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Blkvnz+Gqia4b6LuRXmE1gWAtD7ntvEWDlxrsHxK3c=;
        b=mADVdsGk5qNXcKB/rTUgBp3Z9Kc0qPYCwKqqSlSk3tMJk1eY4AuRmGgUq/z8nNVlKm
         rcIr2AKkmZtulFNByeY/FCKWRklw/bywRTe3efhtHTyCpsEUdR+U+FWH9/34HCVavhyJ
         ZFbLrSy5pkQX23lfo7etOCclSjvDp/Q5U11N+JvtfMog5BsJO2GGXMfzX+PS7zEptAGU
         vB/YdQJmKKy/kykQZU8if0nFBy9UMnIVDH2M7xfdbrIEMjPFbLYerXjbNFPCVuTNKjHC
         WNTmLLuxZXrU42tsZ0g2i2z/PiTtlIZfXX4/xe94Aev6m0jSgIT4aLSZYPqp/UpUxB1z
         CJOA==
X-Gm-Message-State: APjAAAVAtT+YmXa/1F4CqQpf6I+gM6rmkDdeM0sOjbkWqJ3xMXnG5UHD
        5lllo7mFfKKwBHclKThuOmsAJ7q4AfE6XN/Sl0t3DA==
X-Google-Smtp-Source: APXvYqwIrS/i7NFFxqqBmqqiOWb5Ec9xduvNvG7FPhypWWqDmTYly4RAGFA/c54nzJB/9nOqriy6e/xFqCuwnMk8kqU=
X-Received: by 2002:adf:a2cc:: with SMTP id t12mr3703564wra.253.1551891474441;
 Wed, 06 Mar 2019 08:57:54 -0800 (PST)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org> <CA+M3ks57qbTwQiBSiChZmn_Z_O0r9bWZVd0wKkz+2WZeNyZBmw@mail.gmail.com>
In-Reply-To: <CA+M3ks57qbTwQiBSiChZmn_Z_O0r9bWZVd0wKkz+2WZeNyZBmw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 6 Mar 2019 08:57:42 -0800
Message-ID: <CALAqxLUfvdwg=OQP+DqHB1Vgcb3Qa+p3bbv=kbbkFUyW7xCOSQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 8:12 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Le mar. 5 mars 2019 =C3=A0 21:54, John Stultz <john.stultz@linaro.org> a =
=C3=A9crit :
> > +/**
> > + * DOC: DMABUF Heaps Userspace API
> > + *
> > + */
> > +
> > +/* Currently no flags */
> > +#define DMA_HEAP_VALID_FLAGS (0)
>
> I think here you need to allow flags like O_RDWR or O_CLOEXEC else
> mmap will fail.
>

Hm. So I meant for these to be just the bitmask of valid flags for the
allocate IOCTL (used to make sure no one is passing junk flags
accidentally), rather then valid flags for the heap open call.  But
this probably suggests I should call it something like
DMA_HEAP_ALLOC_VALID_FLAGS instead?

thanks
-john
