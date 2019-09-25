Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB40C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0521D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="praqDt56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393299AbfIYUgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:36:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33636 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfIYUgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:36:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id i30so649242pgl.0;
        Wed, 25 Sep 2019 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAtkA8nDrn9I4KTY7uTd6CmJSg4Ilm+vbh5B0ecoufY=;
        b=praqDt56LVvOt5maDOKiv60FehuiGIiUyMMgakA4/n4F1Y5Wu9lt23v7I6P2wFuYYl
         L+VJ0XzVGjhz0dCCWnLL6SAVVsPUnXbE9mJUSVOx3y+PwdNFrf/9fDLNYoRojyTNMNrX
         PIq8mJGr70AUKg2iZHkeivrk7CrYEOzmc0UH6IHGmd1LQzCXzm/UQ0l8+SDQhxqQu17S
         U6spqDB/w9HYEEjsKQYWtVE1ZDe65WKF/tcy5t1Az+eD7xVRHGlvNlskozTV4YiEutmB
         ABrWBqRlcmLDsmIXt0y+SDX/58lF8LmU+eDGu96u/N+O6dJgkm/m9iXKpOZE6y7QEiCK
         Lmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAtkA8nDrn9I4KTY7uTd6CmJSg4Ilm+vbh5B0ecoufY=;
        b=MSVAYLZJEIJ27PiksS+8nBbpaG//RBgSs3X19o/6kENYkowou21sWRv8BbB2c7dKmU
         4PkPfSnznsKPXUuXsa9oWvAFvCUNoO49xL7oaCM3r/FQ+X7RMUCsCEICKsvWqR72Oa9C
         uV+APxUIcRcFOGwT6C+CBudHE7mDN5cBoE1gZnfPmkNFU0rYKHaMZeEaVEJ1Q6jBHpr3
         XwE74vdMko/ORSq0k6PKDK+iC9zjNzsZ69Snxwx0/12mPheS2808SZT3uTb9gJlYy7nD
         0kYntnjaG0U3NWj1J46bQKJSVzPT2SFNbOgkeMH8k3Uo45/Q/Sca73PzORVyeqsngfWq
         FB9Q==
X-Gm-Message-State: APjAAAXLfyIfZrOT/XM3mnqTGccYbQBzx/RubjCxB+BRKPILj0O1279o
        0YIAX47X+2T98AAqBdmEyA3qW6wNroFyZOS2JB7AnzeQ
X-Google-Smtp-Source: APXvYqwM82U/8nEK/BZofUrgB+RMaz6wUEX2FJXf3Zbu5MKYj+xia3+fSRhdQWJbAv5tFqwFHgGDNDK5TrGg53m69no=
X-Received: by 2002:a17:90a:630b:: with SMTP id e11mr8844512pjj.132.1569443801994;
 Wed, 25 Sep 2019 13:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190920223356.6622-1-jekhor@gmail.com> <20190920223356.6622-2-jekhor@gmail.com>
 <1cca117d-1951-0335-1aef-ac994c3c757b@redhat.com> <CAHp75VcoS2OFr8kwM7vq0iCqf6BpyJ4SO7peAUHKxAXdgA7CMA@mail.gmail.com>
 <20190925162712.GA3653@jeknote.loshitsa1.net> <CAHp75VfL0RUgMhZk=gesxBcBfRkfV8kC1zsN9TNg53qpUNVU0w@mail.gmail.com>
 <20190925195617.GA8666@jeknote.loshitsa1.net>
In-Reply-To: <20190925195617.GA8666@jeknote.loshitsa1.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Sep 2019 23:36:30 +0300
Message-ID: <CAHp75VeeVb5oaAGohLFHcT==fSr5M9tssbU7oY6FgfzRkq=yjg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 Micro-B and Type-C variants
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:56 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> On Wed, Sep 25, 2019 at 08:42:03PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 25, 2019 at 7:27 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> > > On Wed, Sep 25, 2019 at 06:02:22PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Sep 21, 2019 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > > > By some reason it doesn't apply.
> > >
> > > I have checked, and have no issues when applying this patch to the current
> > > torvalds/master and linux-next/master branches (351c8a09b00b and 9e88347dedd8
> > > commit IDs).
> >
> > It doesn't apply to the subsystem tree (for-next or my review branch)
>
> Yes, it doesn't apply because this subsystem tree doesn't contain commit
>
> "78cd4bf53635 platform/x86: intel_cht_int33fe: Use new API to gain access to the role switch"
>
> which was accepted to torvalds/master tree already.

I see. Please, resend this after rc1 is out.

-- 
With Best Regards,
Andy Shevchenko
