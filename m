Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B7C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCBF2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0yQPRrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfG2VDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:03:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37016 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbfG2VDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:03:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so43008559lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLwaZEH25wNqGZTB2HC+4XfUpsEwrKsTiwJGEkrXZM0=;
        b=h0yQPRrjNKlXGfFBoWoylITmjbz4SK0JegbN37szOKfhSVCcgDFpmM6/f4t2Mu9tMG
         ZWd1EFVeGSDBJhC5biZ3ZtwATb2l99NNxnlGXA9y2m7IcmKrIXcPQs0AB2aVeLDcxgIp
         zH57jcOguVqz4e5oNCbnoYI9t15QxN/XOs5TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLwaZEH25wNqGZTB2HC+4XfUpsEwrKsTiwJGEkrXZM0=;
        b=J8vY7CcJPcu7ZN0qAySrQP7aH8XSjlS8N23ZaDYXhJrg2MLNhuwg4DszjYyHZxTkf2
         9M9LLWDahzy5J1JDlB71/osB9YFYXxu/hBYfAaX7nQyEIgZzwkfiAfaAXd6Ajcu6Ufvz
         7YcD/hBKARqzD+U7/0ZEJFXIFmGrC1x21A4sRYLXF92j0JDxwDZRjHCdiz4yKBHGUH7K
         SCK386N/IgXmcgPBLnqX0Hh53JQaeLWefzq88OL45h9VSGfp1+ESbGfuArLCxPKMySQ9
         M3lzibPTnf8iHBmIwGV6zviuYa8jpr0fG7aNw9jXSGZyJvNXJNKv/UD/00kMvFWla27Q
         Ym8g==
X-Gm-Message-State: APjAAAVdVEGS6N6mXgVyRG/3FrQRvfG3PEORk7I4s5FoH0QJRrDPiEcE
        Pxenz8z+FBoa4hcnlCOiSFq7ygUf1CI=
X-Google-Smtp-Source: APXvYqyyEtqF4xG9kj0KJs9qFMqqjPRZjmz7HRkDpmHZQwsyteaFatvMdk1yL8Bejp4IjE/gfVDP5g==
X-Received: by 2002:a19:a87:: with SMTP id 129mr50881415lfk.98.1564434230255;
        Mon, 29 Jul 2019 14:03:50 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 11sm12962981ljc.66.2019.07.29.14.03.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 14:03:48 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id h10so59960016ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:03:47 -0700 (PDT)
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr31685480ljg.83.1564434227544;
 Mon, 29 Jul 2019 14:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190729204954.25510-1-briannorris@chromium.org> <20190729205452.GA22785@archlinux-threadripper>
In-Reply-To: <20190729205452.GA22785@archlinux-threadripper>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 29 Jul 2019 14:03:35 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOOqOAWg9LnSPUs9d9Ai8G_4xkdUGC+CCduQQLBzC4kQA@mail.gmail.com>
Message-ID: <CA+ASDXOOqOAWg9LnSPUs9d9Ai8G_4xkdUGC+CCduQQLBzC4kQA@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: return -ENXIO for missing GpioInt
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Salvatore Bellizzi <salvatore.bellizzi@linux.seppia.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enrico Granata <egranata@chromium.org>,
        Enrico Granata <egranata@google.com>,
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

On Mon, Jul 29, 2019 at 1:54 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Mon, Jul 29, 2019 at 01:49:54PM -0700, Brian Norris wrote:
> > Side note: it might have helped alleviate some of this pain if there
> > were email notifications to the mailing list when a patch gets applied.
> > I didn't realize (and I'm not sure if Enrico did) that v2 was already
> > merged by the time I noted its mistakes. If I had known, I would have
> > suggested a follow-up patch, not a v3.
>
> I've found this to be fairly reliable for getting notified when
> something gets applied if it is a tree that shows up in -next.
>
> https://www.kernel.org/get-notifications-for-your-patches.html

I didn't send the original patch. I was only debugging/reviewing
someone else's patch, and jumped in after its authorship (as it hit
issues in our own CI system). So it was more of a "drive-by" scenario,
and it doesn't sound like that page addresses this situation.

Brian
