Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1ACC341B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1136246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ftJJ7cj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLMMLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:11:39 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43900 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLMMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:11:38 -0500
Received: by mail-pj1-f65.google.com with SMTP id g4so1119671pjs.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 04:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r3y5b2vXMIRb8oNblHHWyiR/x9JBMIKMp7Nl/AMSRg=;
        b=ftJJ7cj5skjnr4OfwFizJQnyDilL8KDJLUSdnajj31APdfbww2kYdJaC5q7N2wedfa
         HkoO/nl7SIDvINoANdm2hSw3WnaoPBko5o3vkkgaNBaA9koBKRUPSUQ0ueMwMuAnRSNc
         g/GE0hCDxB+nXjFmP/aZSP0oYJ22nLzaChBYHTio+9S8oof8F4cYfcYLDNxYFwk+Dyj3
         NSLGahEYWM7sQbGlFL59techMRpz00kQeHMO4rGpIuWTMVa7dzjE7fzVhBMsUWa7B23o
         T9D+Wh8sI54DIfEDt7YgD9M5hrEMA/0x4gzlacknbtyZEDeJYyB66MZyeSq2UYTGXfHf
         QJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r3y5b2vXMIRb8oNblHHWyiR/x9JBMIKMp7Nl/AMSRg=;
        b=WWCEMcZdc6Gu+ajWNybY4agCC8cwspVjNQCdnb+iLccVeSNitTxx5tWyVQDBoWdkSf
         SPGjp5qF4gOQzb92K1JquqBCLAiiY9TuK+i0OgoLt/BzRIEdoWOuJqxvjY01GmlSikmu
         8QDFcNrQ5TWet97Ejrv59pV1oCdzmjBojJNKyc0UdoTaposLbJyzFOJKjQA3zWgGfDOT
         WFLShHReFQwqRyBGAn+1OpEAQJPRA10Uw/6XYo0ELOMH8DW4+1yOs1MsgcR3Hsg4GH4h
         AtRxkMwUA9l0pXVJRRaNxHH96wF667wg4gdHjwYyWt2Xam1VmVdcNAua5TJRQS30bCa6
         9+lQ==
X-Gm-Message-State: APjAAAWApyJ1uXJu0WAi9I/RokNvhjboGp7cyOIa2TCTYVeEpopLDpVN
        E/kxKADk+09nIkt+ZVqV0+mVc0jMHPDhiS05IE6+pg==
X-Google-Smtp-Source: APXvYqzkX7D2D12zjMDASh4roJ/9SPGGMP8O/ZGu02LjcJLBvXA42frjpmL1JwEN3xx2P2+PjH8NqE+WnQngBKa56Yc=
X-Received: by 2002:a17:90b:150:: with SMTP id em16mr15813824pjb.123.1576239097699;
 Fri, 13 Dec 2019 04:11:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576170740.git.andreyknvl@google.com>
In-Reply-To: <cover.1576170740.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 13 Dec 2019 13:11:26 +0100
Message-ID: <CAAeHK+xkvQ3Jxot15pw1_EHZgZ2i539pLSxgXujDLWO0x0DrRw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] kcov: collect coverage from usbhid interrupts
To:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 6:15 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patchset extends kcov to allow collecting coverage from interrupts
> and then uses the new functionality to collect coverage from usbhid code.
>
> What I'm not sure yet about this change is if we actually want to
> selectively annotate some parts of the USB stack that are executed in
> interrupt context, or maybe we can do this with some common approach.
>
> For example patch #2 in this patchset annotates all functions that are
> passed as completion callbacks to usb_fill_*() in drivers/hid/usbhid.
> Maybe instead we could redefine usb_fill_*() in a way that would handle
> all such cases without manual annotations.

Although looking at this again today, it seems much more logical to
add kcov annotations around the complete() callback in
__usb_hcd_giveback_urb(). Don't know why I didn't think of that. Will
do in the next version.


>
> Any suggestions are welcome.
>
> This has allowed to find at least one new HID bug [1], which was recently
> fixed by Alan [2].
>
> [1] https://syzkaller.appspot.com/bug?extid=09ef48aa58261464b621
> [2] https://patchwork.kernel.org/patch/11283319/
>
> This patchset has been pushed to the public Linux kernel Gerrit instance:
>
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2225
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Andrey Konovalov (2):
>   kcov: collect coverage from interrupts
>   HID: usbhid: kcov: add annotations for coverage collection
>
>  Documentation/dev-tools/kcov.rst   |  16 +--
>  drivers/hid/usbhid/hid-core.c      |  25 +++-
>  drivers/hid/usbhid/usbkbd.c        |  15 ++-
>  drivers/hid/usbhid/usbmouse.c      |   7 +-
>  drivers/usb/gadget/udc/dummy_hcd.c |   1 +
>  include/linux/sched.h              |   3 +
>  kernel/kcov.c                      | 196 +++++++++++++++++++----------
>  lib/Kconfig.debug                  |   9 ++
>  8 files changed, 192 insertions(+), 80 deletions(-)
>
> --
> 2.24.1.735.g03f4e72817-goog
>
