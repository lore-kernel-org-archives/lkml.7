Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D02C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD88208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfFNNgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:36:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45939 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfFNNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:36:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so1628624qkj.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LlmkYnjQ09lYvGpUcAqj3kA1O47a4djevWb989ZA1w=;
        b=Gm1u+ybMh2VskSrhXZ67RaTfUFYjISKsmM8Izpd8e/zj/yUKti+JzaS63ak9rRB8bx
         l0+a9SUF1MycTPVLRTXYijiu8D9aORve/fLFc71pX/+ssEnsoQGaoVB90h5PYez0o9TA
         0I9RV14j8p4eZEXHl701H8LTWHwNj1HqSR+WVrZNIniOXACQAONFzluacP+y1nxtngl4
         Qb5IdPqGxVT6NjKSk7inQECAVmoTCNCm1TOipgZQIguuH4J9zEEbh+nazBnWZZet6byn
         4YE9f60dNivYsVcGEkmVhd0CgD+vqW4I3WD6hIROP9EB2MmFiXOxmwvbPwG+9PmI+/sk
         Sclw==
X-Gm-Message-State: APjAAAXASf1bJi9ar7uhzo49rgLD79qHFS2wxTGOS0UFpgquBufxagvZ
        G9hNv1if+q3b5atnehHcNzH5OeRTnD4VPzE9Up/D9g==
X-Google-Smtp-Source: APXvYqxiuI0SUUQnJRSwm7z5cWkb4lnXy0zELVp/wWllW/D+t1xRaQpRqi09nRRT6VR/fXxGrSPtZB8M1COZHqcgneE=
X-Received: by 2002:a37:8e03:: with SMTP id q3mr78142534qkd.234.1560519375030;
 Fri, 14 Jun 2019 06:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190611121320.30267-1-nsaenzjulienne@suse.de>
 <CAO-hwJLAiC1o-kZ5epZHtO2GK+zc5x28pYbZH-XsY4yAuBmHWw@mail.gmail.com> <5346893.KeHrH3GHoD@linux-lf90.site>
In-Reply-To: <5346893.KeHrH3GHoD@linux-lf90.site>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 14 Jun 2019 15:36:03 +0200
Message-ID: <CAO-hwJ+Nm+i+ehGurAxD3EQBX8-TFQ7p4J-1rV55fVA=NazgAw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: input: fix a4tech horizontal wheel custom usage
To:     wbauer1@a1.net
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfgang,

On Thu, Jun 13, 2019 at 1:49 PM Wolfgang Bauer <wbauer@tmo.at> wrote:
>
> On Tuesday, 11. Juni 2019, 16:42:37 Benjamin Tissoires wrote:
> > On Tue, Jun 11, 2019 at 2:13 PM Nicolas Saenz Julienne
> >
> > <nsaenzjulienne@suse.de> wrote:
> > > NOTE: I CC'd Wolfgang as he's the one who can test this.
> >
> > I'll wait for Wolfram to confirm that the patch works before pushing then.
>
> My name is Wolfgang, not Wolfram... ;-)

ouch, sorry for that (I am more used to talk to the I2C maintainer apparently)

> But never mind.
>
> I tested the patch meanwhile on top of kernel 5.2.rc4, where the mouse wheel
> actually worked.

Actually, I am a little bit lost here.

The patch mentions a fix of c01908a14bf73, which is in 5.1 final.
So if your mouse works in 5.2.rc4, I am not sure how
HID-a4tech-fix-horizontal-scrolling.patch could break it.

Could you be slightly more specific in what "works" and what doesn't?

Do we have the report descriptors available somewhere?
And if not, could you run hid-recorder from
https://gitlab.freedesktop.org/libevdev/hid-tools and attach the logs
when you move the horizontal wheel?

Cheers,
Benjamin

> As the patch didn't apply cleanly (it's obviously based upon
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=abf82e8f7e9af40a49e3d905187c662a43c96c8f , called "HID-
> a4tech-fix-horizontal-scrolling.patch" below), I added that patch as well.
>
> My results:
> kernel 5.2.rc4 works
> kernel 5.2.rc4 + HID-a4tech-fix-horizontal-scrolling.patch is broken
> kernel 5.2.rc4 + HID-a4tech-fix-horizontal-scrolling.patch +
> HID-input-fix-a4tech-horizontal-wheel-custom-usage.patch (i.e. this patch)
> works again
>
> kernel 5.2.rc4 + HID-input-fix-a4tech-horizontal-wheel-custom-usage.patch
> works as well.
>
> So AFAICT this patch seems to be fine.
>
> For completeness, this is my mouse as listed by lsusb:
> Bus 003 Device 002: ID 09da:000a A4Tech Co., Ltd. Optical Mouse Opto 510D /
> OP-620D
>
> Kind Regards,
> Wolfgang
>
