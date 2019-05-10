Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E2EC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7A421479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XXg5hUW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfEJJRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:17:03 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53324 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfEJJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:17:03 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so6871563ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lhVHhThFn1rIUGZz4Q7y5btU3hSDK1sEgnb8gtisfwA=;
        b=XXg5hUW9Bxh/wdsHDo1cJt/Xa74dG229KSnO+XhiiBNTW33pvtb/1NiD9zT0JV+lDT
         lNdWv3o6BLRLWCoXsDhAaT6t1uQt42Ops1u1ClMKKavcF9FrkzXEFWJJzVlLeUUEK6OQ
         3DoaXpEYk+yHYo8w7rSAIXpEt5YAZg7Eu4MvuIQCCz0Nxhl0J6GRFFBIJxnrv+Sw1Ipj
         bzb1pHH9XPClyb7YMwBxlYNsviq5oj2MklSzE1KY9lSFKvFbOBi0g33NOOURGeWIRIKl
         XpuGMOXdrdXtkj7ukD9j9y+TTsXVw6yTUwYR7pMc04PMeztpU2zPetmF/LAJce//aGOe
         ZsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lhVHhThFn1rIUGZz4Q7y5btU3hSDK1sEgnb8gtisfwA=;
        b=AHD/Q0W8zg9GhmXuySkWc5B7HJvWG/XGqEs2eLPfcYAvevsSOhRapUC++L8IYhi4dC
         hGJ4I5vOQLLWDAprAMJZMWMc/ucDnJeJzIp0+Dp6OHinZsTlZMCvKitzvDJ0RXNDKnrH
         IZzj5348KwlW4TGCe9HCGOvLCkihvhU/TVnO8IZN/ThvoV0Qz+JMe1rLsC/UkLrXEu+3
         YlUU7QqDpOCEwRkyLFDn3acDsqBPxVmD/KdII7IC/BJNt4hvFgK82TKe7iGz9jlLl9II
         me6fAqcQ0cY+nohTwrllzmpscYVWBGuXhWPlDUs2p8PTcCi5LM2ExoRekVzuI7VDg3jY
         OEMQ==
X-Gm-Message-State: APjAAAUvm5kWCEISHupORlj5NcBrnv+dUsMSQ6YCJGwzvXe+FZIy5Ewm
        kUZivME9Y/vtLugBKlvipGxZmj6m0WPPtCXQeezwUg==
X-Google-Smtp-Source: APXvYqwZ10sapMahIUyanhXDaNAcwp19JxoBLrBUGyd4TP058WLPPG3v+q9GWxsQTou0ejq0XxtOl74m+LPCDXAjf8U=
X-Received: by 2002:a24:4d85:: with SMTP id l127mr7286884itb.53.1557479822398;
 Fri, 10 May 2019 02:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190411094944.12245-1-brgl@bgdev.pl> <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
 <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com> <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
In-Reply-To: <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 May 2019 11:16:51 +0200
Message-ID: <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
To:     Richard Weinberger <richard@nod.at>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 8 maj 2019 o 09:13 Richard Weinberger <richard@nod.at> napisa=C5=
=82(a):
>
> ----- Urspr=C3=BCngliche Mail -----
> >> Can you please check?
> >> This patch is already queued in -next. So we need to decide whether to
> >> revert or fix it now.
> >>
> > I am looking at it. It passed tests in my case (I did the usual round).
>
> It works here too. That's why I never noticed.
> Yesterday I noticed just because I looked for something else in the kerne=
l logs.
>
> Thanks,
> //richard

Hi,

sorry for the late reply - I just came back from vacation.

I see it here too, I'll check if I can find the culprit and fix it today.

Bart
