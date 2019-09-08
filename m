Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43FC4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F229C214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpbl52co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfIHUH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 16:07:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45472 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbfIHUH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 16:07:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so8809100lff.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuHIWFdcsxUJqPswaYj4b0GivTB6Jcoizn7SrmAv+OI=;
        b=hpbl52co8tDUVi/7gHuODZirz/kPjg5s1T3Nnm+ujNoC3UW8LeJuFgjmu/QfpDpg6F
         9KL5/fR9vyl6YVuwMxlmHCaPhitd5He6n/wXCO+wtNHY8gG9J6M+aOF6ofQwA0cxvSgq
         xJwLdoNj8/+6d4ae319EYmqQyKdMAiDOnk8BdDMr4nPvyOQ4Y3VurcTOljU1a63qoKOc
         OfzWgjijnGzIXdF0CBAxxaDM3F1mQnCu8BDmc82CqiVRB5AJ5YbcaRruZUOgs4HnWeKe
         YZZWUzgDTPEfUWlQjZsBLu/seUOX81ornseYt+nkA4KJ8zLa7vLu9/GQyej9jXErdvfZ
         Rf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuHIWFdcsxUJqPswaYj4b0GivTB6Jcoizn7SrmAv+OI=;
        b=adbvppcLeHmn1/xXYThTt535PtBBAtA7U4SjSkOtrKQJFyMORllnCeG3G2so08bQj6
         AbcFJsl4rubEXZ+4pBIvS6lIL9bNNRc9Gqkzr3jtHtOA2kfNQQY+LMoAFq3ZVa0H1xTX
         zPzv1dIhCHcgGLpTE1ebF4dmediDolf4LxoR/8KVeFDcc6Nw/yt/bJQzx+32Q1S9EY4y
         Hh/nmSqq11Uc1NXQHDq7t5cMLJg928RMPN/GQKzR/YI5NkEBKnX1jMXBKC/gL+2Aee5y
         9/8ID5frIp7VW95eHmJdtIV4ADyCJdCk3EX0bsaEh7EfNkD3/fJ+z+9pFEAsFlfALsnf
         e5Nw==
X-Gm-Message-State: APjAAAWWCXGyOWSQJExKX5BQ3lPXpJm5tpFv8N9FlnppzQkNut/WANvW
        F2i42zh2DtcJM8eWzXSE9Ls/T23LiTnS1zx2jLl99w==
X-Google-Smtp-Source: APXvYqz4xrYJV1IQUAk4dL9wEqpbEkQlxchr8/PvxBR9Y0AhwcXiPbiIw1LJ1wLsH0U4GO0jlz888uTPJr7by6oxYNw=
X-Received: by 2002:ac2:4352:: with SMTP id o18mr14106857lfl.164.1567973244230;
 Sun, 08 Sep 2019 13:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
 <20190628033413.8058-1-rajatja@google.com> <CACK8Z6GYwPhz-+7zxxe-aG673Tbin=GYUvVZyL9cTgjqk_EXqA@mail.gmail.com>
 <CAHp75VdPY83U5dWJbca_ZCJwT6z8L+V4R+fY0aZTOkM=vNweYQ@mail.gmail.com>
In-Reply-To: <CAHp75VdPY83U5dWJbca_ZCJwT6z8L+V4R+fY0aZTOkM=vNweYQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Sun, 8 Sep 2019 13:06:47 -0700
Message-ID: <CACK8Z6F5wjT0CE2ftjaB0_zEhK+P8UTSmzmzWZS3LD1688kgRw@mail.gmail.com>
Subject: Re: [PATCH v7] platform/x86: intel_pmc_core: Attach using APCI HID "INT33A1"
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 10:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 23, 2019 at 1:44 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > On Thu, Jun 27, 2019 at 8:34 PM Rajat Jain <rajatja@google.com> wrote:
> > >
> > > Most modern platforms already have the ACPI device "INT33A1" that could
> > > be used to attach to the driver. Switch the driver to using that and
> > > thus make the intel_pmc_core.c a pure platform_driver.
> > >
> > > Some of the legacy platforms though, may still not have this ACPI device
> > > in their ACPI tables. Thus for such platforms, move the code to manually
> > > instantiate a platform_device into a new file of its own. This would
> > > instantiate the intel_pmc_core platform device and thus attach to
> > > the driver, if the ACPI device for the same ("INT33A1") is not present
> > > in a system where it should be. This was discussed here:
> > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html
> >
> >
> > HI Andy, Rajneesh, this seems to have fallen through the cracks. Any
> > comments here on this patch?
>
> % git tag --list v5.3* --contains b02f6a2ef0a1
> v5.3-rc1

Oops, my apologies, I failed to notice it.

Thanks,

Rajat
>
> --
> With Best Regards,
> Andy Shevchenko
