Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC64C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47F2208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Llr5jUJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfJJFC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:02:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44256 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfJJFC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:02:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so3737309otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 22:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjW7ziVilYJdZpiDvd1smbXvtrxiM7zdXhwkDBnPRFs=;
        b=Llr5jUJ4l4/fU1kz0XiobhfE22pYSQy9QUkCVXR/Im1do7QInZf3+ZbdN6EXt2HvMX
         MPIK59NaM7vsMj7+yuNm60rDrbUsTeGvvh2WBySmlQfzrzGWlbjmXIhCQmtEvTdtHbRf
         Jp2cLpwsl8Izf6VzJoMv6vu/c7CCJG1OVY7PvdJlaPMDdTH9L6oP9orU6EiW3s7N9bLa
         biKf/bQL9bE14OWJgLjV8GsIqnF5NepAApH2OOeFzuqZncqfraF0yoqf48GUSe6mFW+Y
         PwFoyeuut73bMp0lwfvsNYSZnx3R2mkYylApQ8rbkRovj/ljzyvI3EMrEASwCd6o+uG4
         dU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjW7ziVilYJdZpiDvd1smbXvtrxiM7zdXhwkDBnPRFs=;
        b=JQLrQAHe7sQak7beXvZMghAi2LJIZqsM16EaDz+E+RGh1xfaqHjfIHbjfyej7DbPNV
         OcYeJsXglhCtVJ/MErVJREzItjb/e91MMA356NfU+r5Nm+mSrbDL0sLUqk4WVedipcMV
         Gy9VOGa5TwuwUUpPzy3IXNIDNYozhLgl4RaQKlnZQI28Zzx4wcA9mJIZw0Wfc5xQUkD9
         f2jbsr76QPIajEuH0e7L371WxfjnXxvnyFk9iZfLPNcgw66c3IsdXDimdqWRoparLs0T
         q/USqJNXKf3E3P3UrdXn51yjhTq3RwwGrQLoIOuRgwK9v1wAd4E/y0Ljq4P2BD/w20Lc
         BUvw==
X-Gm-Message-State: APjAAAWySzwBOAvZgRtHJ9XTFVl5PBdtD+lc/ZnhCgVbwcRa4YdAma2g
        BRukk71KgnaxnV++yj3n3zTC6sxZN00e9jSTSRYWUsg6
X-Google-Smtp-Source: APXvYqwW15SupgQ8irr5DzZotEtjK70n90wen29XCmFPxuANRc9KH8E0GHiNAQbv3hbLw9b3VMQD0d875ShEXQElo5Y=
X-Received: by 2002:a9d:6e92:: with SMTP id a18mr6062925otr.313.1570683778522;
 Wed, 09 Oct 2019 22:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190929095659.jzy3gtcj6vgd35j6@XZHOUW.usersys.redhat.com> <20191008165100.GC5694@arrakis.emea.arm.com>
In-Reply-To: <20191008165100.GC5694@arrakis.emea.arm.com>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Thu, 10 Oct 2019 13:02:46 +0800
Message-ID: <CADJHv_vLYGCpsUYuSbZn95rRXXsz_nL3NwDDRqRfNrmtcuDk0A@mail.gmail.com>
Subject: Re: [PATCH] mm/kmemleak: skip late_init if not skip disable
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 9, 2019 at 12:51 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Murphy,
>
> On Sun, Sep 29, 2019 at 05:56:59PM +0800, Murphy Zhou wrote:
> > Now if DEFAULT_OFF set to y, kmemleak_init will start the cleanup_work
> > workqueue. Then late_init call will set kmemleak_initialized to 1, the
> > cleaup workqueue will try to do cleanup, triggering:
> >
> > [24.738773] ==================================================================
> > [24.742784] BUG: KASAN: global-out-of-bounds in __kmemleak_do_cleanup+0x166/0x180
>
> I don't think the invocation of kmemleak_do_cleanup() is the issue here.
> It should be safe schedule the clean-up thread in case kmemleak was
> disabled from boot. What you probably hit was a bug in
> __kmemleak_do_cleanup() itself, fixed here:
>
> http://lkml.kernel.org/r/20191004134624.46216-1-catalin.marinas@arm.com
>
> With the above patch, I can no longer trigger the KASan warning.

Got it. Thanks for noticing!

>
> --
> Catalin
