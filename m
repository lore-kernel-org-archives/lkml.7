Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FBDCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F9A2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFfD5MFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfKDS55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:57:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43140 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfKDS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:57:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id l14so1018753oti.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3NXmbQZe9ZnT7fbe+EIvkpInJMLKjVbW03x8y81A38=;
        b=fFfD5MFPiJ1kIysRVmZVrDEnc3iHR5WePrk035gRLGZj4EECNcsralgOCLF45h65vB
         zenyoBMjR85Vqj/x36CUNK59ZtiTlUDkITY/CzP1ZxrbI2sdcj5VZxH1Ya8f7y2/oRMU
         04v6lxIY4znf+l+FSL39uRNT+VCYMGLoV4IJWITuemgu0AOvHpJ00pkatCucMRC4FUzE
         BNujdNj2j/A6MvTohDixsW5gE1mGAsAqbwSkfhATzBtYiaSmed2IpcJMFzTXOb9qzd8w
         CO73Iet24BAdstCgmFamT2zFZemCUpQlyCiE1E2zt4+1yTYhn8JvFB20wFSLRl7NL0Jf
         U8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3NXmbQZe9ZnT7fbe+EIvkpInJMLKjVbW03x8y81A38=;
        b=NG3bg13hP7nPidUwyi08rY8b5+4RcEa6EN7VQusYEqzhYIb0F4EcHr8eXRko5lFvZO
         j/nRUmaTQfIx4HZe08VusN13ZlTVBz8mlZUv6H20EXOpWmE/6C0YWIGWjd4U+jfOBtL5
         nX7K05uw9p85GHnniulIUmuhVrP83toQwfwcPytVGYwjwxWTdfEwOAjYOz7IYvTVGwxY
         ukMONCzbxdldu6wYaG24VuyNlP/eAoTeue41Eaq2VEdI4b99Ln4jHAKWenFhLwganoFk
         arBkRUVhV+HPwQwkYnmJomOe6IAY7uFVuBYBy39rMLDGGTJUvBEmnEXRNR58m9FFkf5f
         uYcg==
X-Gm-Message-State: APjAAAV5mUsvi4u+vzdJhPhdMfAL8L4gkjwK3TLcS+UtbqvbsPUNC/mV
        CP+cCIK+wlSvo/tu6Dor2boatRa0Oim39qvVaRoelQ==
X-Google-Smtp-Source: APXvYqwd8cmeVMOTe+JQ+j2QX+t3I35Dixid5qlgqiNrKFgTlCT0qjVcLrqc+RT374J9gbd5lphfL5RyiFI2gFJjRPk=
X-Received: by 2002:a9d:630c:: with SMTP id q12mr19353256otk.332.1572893875375;
 Mon, 04 Nov 2019 10:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org> <20191104095823.GD10326@phenom.ffwll.local>
In-Reply-To: <20191104095823.GD10326@phenom.ffwll.local>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Nov 2019 10:57:44 -0800
Message-ID: <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] Allow DMA BUF heaps to be loaded as modules
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
> > Now that the DMA BUF heaps core code has been queued, I wanted
> > to send out some of the pending changes that I've been working
> > on.
> >
> > For use with Android and their GKI effort, it is desired that
> > DMA BUF heaps are able to be loaded as modules. This is required
> > for migrating vendors off of ION which was also recently changed
> > to support modules.
> >
> > So this patch series simply provides the necessary exported
> > symbols and allows the system and CMA drivers to be built
> > as modules.
> >
> > Due to the fact that dmabuf's allocated from a heap may
> > be in use for quite some time, there isn't a way to safely
> > unload the driver once it has been loaded. Thus these
> > drivers do no implement module_exit() functions and will
> > show up in lsmod as "[permanent]"
> >
> > Feedback and thoughts on this would be greatly appreciated!
>
> Do we actually want this?

I guess that always depends on the definition of "we" :)

> I figured if we just state that vendors should set up all the right
> dma-buf heaps in dt, is that not enough?

So even if the heaps are configured via DT (which at the moment there
is no such binding, so that's not really a valid method yet), there's
still the question of if the heap is necessary/makes sense on the
device. And the DT would only control the availability of the heap
interface, not if the heap driver is loaded or not.

On the HiKey/HiKey960 boards, we have to allocate contiguous buffers
for the display framebuffer. So gralloc uses ION to allocate from the
CMA heap. However on the db845c, it has no such restrictions, so the
CMA heap isn't necessary.

With Android's GKI effort, there needs to be one kernel that works on
all the devices, and they are using modules to try to minimize the
amount of memory spent on functionality that isn't universally needed.
So on devices that don't need the CMA heap, they'd probably prefer not
to load the CMA dmabuf heap driver, so it would be best if it could be
built as a module.  If we want to build the CMA heap as a module, the
symbols it uses need to be exported.

> Exporting symbols for no real in-tree users feels fishy.

I'm submitting an in-tree user here. So I'm not sure what you mean?  I
suspect you're thinking there is some hidden/nefarious plan here, but
really there isn't.

thanks
-john
