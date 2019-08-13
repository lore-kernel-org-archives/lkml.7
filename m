Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC5FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850D220578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klCDEHZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfHMNYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:24:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42355 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfHMNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:24:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so956238pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0tOfAuaq4Yg1tlCptrYIfw0VPXXaj1XYpLOsoh7Qpw=;
        b=klCDEHZpmWkJPPQidkakgEgXbx7K+mh+kxAzIh4mApMDpWykbkRBjiipvjbq7rjP51
         m2taFhkUE1KGOYFg1a8NeEYl6nUtvdPOqfV2bgCU1E0NzElNHgRnlnJQuaCJA+LZg7w/
         CAQXl/PI/D1mDXUpwqNAkqoeBN5La26kLFpU1NDstEGUotyjJAuYzRmbHKzN5EJ+JDGk
         Pxu2vo1+Ew/7cY8UOFFk3sg4SvYp59P16Bdkis3auQvx6w1k0sX56M21hP5VsgEJ2mEo
         yZda03lIPx3Q5tCaFFG67kI/lFLHhgkkA4AZBoRKsjCzqziCTNgyA4K6M2+fd1Hh+AJY
         xlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0tOfAuaq4Yg1tlCptrYIfw0VPXXaj1XYpLOsoh7Qpw=;
        b=FVvFAFsNBTVQ65PL/djZj9RtRXmeoZefFynaAAWmk7PosLv+Q3/C1VdqosBoxwVo/6
         WKcGKWf2jG4x/CIVtjkmz4Bm+jnmJxklApKyPOOx5lBy3mznzCGqk6N/EBq5Mg5Rdpdd
         zfLCqCQlpq28I8kgXsfRJRTihT1XyPJSXVMU5aM4Dn68cyu0qbSmkLILK8oz4VMTNbmr
         cjf75J8PUR8v0HGkfeObEscHhpARF+lWcR5UZG4MWJGoQiLexJwVOVlabzseLiGnsie6
         Jq4p45bNRu1m7VBbmr2nxqHqjShE1PGILxDdn2c18Q4SFVWnxvPetDVsjAlOnKmwAwEX
         4yKg==
X-Gm-Message-State: APjAAAX3njkXa1S9LK8CalQz2jkac34s6m1a5CDm9zolK3VtMDvEZCjs
        87s1WNnsLwZ8hlvJOg48RWq5JUlq3fvT1v05BUoIrQ==
X-Google-Smtp-Source: APXvYqwXL9Y3zSaqYKpVcJ8Y7vJU0SJwj8kSb4tTv/tyCDGR3E1dijhh0Fh6x/iutCA7Kyx9g/dHhVlw+huCTmjW4n8=
X-Received: by 2002:a63:3006:: with SMTP id w6mr34868777pgw.440.1565702657198;
 Tue, 13 Aug 2019 06:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+yPJR2kZ5Mkry+bGFVuedF9F76=5GdKkF1eLkr9FWyvqA@mail.gmail.com>
 <Pine.LNX.4.44L0.1908080958380.1652-100000@iolanthe.rowland.org>
 <CAAeHK+xVKZ-pnGcijYJPpWQ_haWbuVSpD81TJhtRosOZsg-Rwg@mail.gmail.com> <1565702535.7043.9.camel@suse.com>
In-Reply-To: <1565702535.7043.9.camel@suse.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 15:24:05 +0200
Message-ID: <CAAeHK+yMFGh8F-e9o-VHxg652Ka3f3C8UzFupvD0zZMwffRc_w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 3:22 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Dienstag, den 13.08.2019, 14:42 +0200 schrieb Andrey Konovalov:
> > >
>
>
> [..]
>
> > On Thu, Aug 8, 2019 at 4:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > Ah, that looks right, thank you.  The patch worked correctly -- good
> > > work Oliver!
> >
> > Great! Just a reminder to submit the fix :)
>
> I did last week:
> https://patchwork.kernel.org/patch/11084261/

Ah, perfect, thank you! Apparently I've missed it.
