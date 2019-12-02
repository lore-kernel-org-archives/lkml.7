Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E13F2071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="zYz7ylXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfLBQgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:36:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38167 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLBQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:36:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id b8so110828qkk.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFUIXTaxHxhBf92NWy9ixW4qKlXFsdRPI/ziEawghmo=;
        b=zYz7ylXEeDcPZteFmTUBUONfDyk9NWNLdI4gcq+meztW7nWtopkAe257F4Fvvb5IbD
         wDKT7SyInwk4vDTQS0+v3hQx426cTB4cirN2n3TpPleaJWxhY+7SQwyJtFff77lJlb7n
         vlrQcrpxXW6r5RSDWs8TRRW3BURORhNwS9lZojfyqjgnGEjD7g8hOSU6DvXDojgCzcay
         WUTU20O4DCcTueeK6rSBMBcb5pFtMy7WYQetSmDcOCbpsEFBrRi2wlEuYVi69BK0zIM1
         dypK+eg/+gXn4W1vfXTWdb6PC8xa5HUVyFYpiYYLYcUON9n1c7V8fBiFtxwsG7e3dtrD
         kHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFUIXTaxHxhBf92NWy9ixW4qKlXFsdRPI/ziEawghmo=;
        b=Yx/9iTHW+NG6b6suQffIem5xmRHJHFgtJR/e6EiXzePAuDOTEd9iYGrjZGH6E4Yzje
         J3B/2UFUk8sfXd1MoFPbHgHTy/hFKMWP7G0/Bc2LQcg9uB1HgEPwEWdQeV3okOIw9HLl
         I9d9kWZbMphjmokpF95gLymCNVEOTNs5ODS6mb83abmjdb1/em8c5CEBkT1rDfm2uc/U
         wUGk5hn+dDBG1N0w+U548dihGO/fwPp/psVPgJCoaksBKlb9MSmR0/+iWQ15+i+lkVUw
         0V7lE9/MEAmXO92uP7llM4Qal1h0c9kjjWrTPTlIfruuy6tZ+KGDPpyJNMizudpXRYkI
         3QOg==
X-Gm-Message-State: APjAAAWNZJgyHK9fxr8At+uGLfPfuoYcjASwLrgfz/4IFQrlKrzeOb2+
        d0T+tBNcrZ+Xrmx+kUoHduUuXK6VMxfxIpt455X62AAe0iE=
X-Google-Smtp-Source: APXvYqxs29/a51bRsGJMtEpepGA3LsMtTGV56DyzsQxbaavrE8HpSDRUwcCJOe81Ejh4MXikosqfRt3QTzZjJYPQQso=
X-Received: by 2002:a37:6e86:: with SMTP id j128mr34628727qkc.265.1575304600825;
 Mon, 02 Dec 2019 08:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20191201094246.GA3799322@kroah.com> <20191201193649.GA9163@debian>
 <20191202075848.GA3892895@kroah.com> <CAG=yYwn3nYn2CmV7BWOJdBWicYPuK2DwBgz6p=bDC9nWOt6vqA@mail.gmail.com>
 <20191202133649.GA276195@kroah.com>
In-Reply-To: <20191202133649.GA276195@kroah.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Mon, 2 Dec 2019 22:06:04 +0530
Message-ID: <CAG=yYw=hwnEXyfFjxTTNkS0yVdRZAfLEoyrh=fCVp6DsuWr27w@mail.gmail.com>
Subject: Re: Linux 5.4.1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 7:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 02, 2019 at 06:32:30PM +0530, Jeffrin Thalakkottoor wrote:
> > On Mon, Dec 2, 2019 at 1:28 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > You tested the performance of what?
> > i tested the performance of  5.4.0 and 5.4.1
>
> By running what specific test(s)?

i  compiled  the following  5.4.0,  5.4.1, 5.3.11,
kselftest-5.4.0-rc1, linux kernel sources, three at a time, together.
when running together i did not start the sources at the exact same
time. may be atleast one second gap.

-- 
software engineer
rajagiri school of engineering and technology
