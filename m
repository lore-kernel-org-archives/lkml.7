Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88E8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB9E20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glWb7RlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfG2VJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:09:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34573 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfG2VJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:09:52 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so123300495iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YrqMlHNqZAaGdeVX5EfmeYkFQLdlx9m477jCrUkqDI=;
        b=glWb7RlNO8QHe3Kd15SImmSGdttxS5VwsK9LBdSYpUeFXTdnyopO9CQKUwsIvsFW8b
         jjY2cj9+GtlbZ0QIybP3UYT5qzWKUxwoeBtypQM9bMFhc/+y5BsL8Mp6zmFZmzlchcl9
         dl8Nr090TKl3xad3/4IdW+2o3TeGVpjzW4bken0Wm3ETbmAkXlYRX82n2x6w7PdrG+Ln
         wQNsesgvR5iPZsd0b9NGn0y2vX7ToqjAALSnmk7M3+GF3pQb/KlPgviAfm9eGux49OrT
         3KfSK3GSzd30IbwYMfqNOoNOcYUn5/zR5ok4bqmGozTAAmoJfiXDoi+EfLsrKjXEoQYS
         VrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YrqMlHNqZAaGdeVX5EfmeYkFQLdlx9m477jCrUkqDI=;
        b=YW8CezlGG6DuGguV52GQW4FmO6RFfvlAYl2BHVZOUe2ebm9bcc43ABC3JoKNar5KCS
         oLxCKI8HeX/SLSV/PXbaU8lA10kHOFIIOZ9LKKoS5UCurgZzKvyp1jQ5l/V13uR7oE9G
         RAo6fOwEuG19Y/5RjkGdTeDWTnGF6v9UD+BuFOdvl0+ayod/8OtuM/IyUv1Gk4rXyIFY
         0Sz+I3R9+/pDfKqB7jZ0A5zfUdyntj8tTtnXNKS/Au5GeIpl5Z1jYdhONtC9/dGmwcgG
         7xFR5DHMCV1RelOyR+2segiH80yvyoic+2c2iPwFit67V4xVdgH6g01T/XwQEgYRlboi
         XSZA==
X-Gm-Message-State: APjAAAXhAR4OIkCXZHW0jGqt9aATngxXkvPNz+icZVPOZPEXGLcC6AiG
        IBcY+D8FQT5Gdl2DZAQd+nmqV+yCf3mFGwg/gI/I9w==
X-Google-Smtp-Source: APXvYqxhlUj+a11+YzuMwWDnq9y2Do3Qn7frG9IgBVh7BEzf0sUkKNrCTQmU131fes0GT8rMVdTm+jm9ljeWEL5ZQro=
X-Received: by 2002:a6b:6b14:: with SMTP id g20mr73770321ioc.28.1564434591860;
 Mon, 29 Jul 2019 14:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190729204954.25510-1-briannorris@chromium.org>
 <20190729205452.GA22785@archlinux-threadripper> <CA+ASDXOOqOAWg9LnSPUs9d9Ai8G_4xkdUGC+CCduQQLBzC4kQA@mail.gmail.com>
In-Reply-To: <CA+ASDXOOqOAWg9LnSPUs9d9Ai8G_4xkdUGC+CCduQQLBzC4kQA@mail.gmail.com>
From:   Enrico Granata <egranata@google.com>
Date:   Mon, 29 Jul 2019 14:09:41 -0700
Message-ID: <CAPR809vmOBeJPArfjM=Fh_Kiqsew-shfF9ZpOtRJ-sU7QgUneQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: return -ENXIO for missing GpioInt
To:     Brian Norris <briannorris@chromium.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Salvatore Bellizzi <salvatore.bellizzi@linux.seppia.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enrico Granata <egranata@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 2:03 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Mon, Jul 29, 2019 at 1:54 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Mon, Jul 29, 2019 at 01:49:54PM -0700, Brian Norris wrote:
> > > Side note: it might have helped alleviate some of this pain if there
> > > were email notifications to the mailing list when a patch gets applied.
> > > I didn't realize (and I'm not sure if Enrico did) that v2 was already
> > > merged by the time I noted its mistakes. If I had known, I would have
> > > suggested a follow-up patch, not a v3.
> >
> > I've found this to be fairly reliable for getting notified when
> > something gets applied if it is a tree that shows up in -next.
> >
> > https://www.kernel.org/get-notifications-for-your-patches.html
>
> I didn't send the original patch. I was only debugging/reviewing
> someone else's patch, and jumped in after its authorship (as it hit
> issues in our own CI system). So it was more of a "drive-by" scenario,
> and it doesn't sound like that page addresses this situation.
>
> Brian

Your assessment sounds about right - I suspect the tl;dr is that *I*
(the original patch author) should have subscribed to that bot, so I
could figure out that v2 had already merged, and done the right thing
sending out a follow-up CL once you brought the issue to my attention.
