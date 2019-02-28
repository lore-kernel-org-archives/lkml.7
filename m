Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59C4214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nddhtO0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfB1MSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:18:12 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34826 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfB1MSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:18:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id p48so23181896qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b05xL9kAscZWSXME5xLV21YU+wuPfJsoBMrudB8xb2k=;
        b=nddhtO0plXrg8JVPWN+1PPIvX75CXZwqMmcma15R+teQZGU1+2IriA8QnjOLfBZ2iG
         izn1qwC54sfTW0xyOymnZC3d52+8bKBxlr/CUNHgZeAFjeu22UODrmYEHSZCkEP4zNsY
         PKYnfrumEeE17WEf0xJahTwf9BW5AuQq1uQPP9kjwQEpKL37HxVS5RAxt04nK/zyC5Z3
         9xZAULQ3Alyx3pmUk1j5jFmulR/aMULpzZBjBc9MNBF4I0nIaoVXfJWbXTRi5Nr2GI8V
         dA5dNsuMQAb53q6wUH1Zkmn8kBOKk3jobiFSzEZzKDTgFCTebIgJ5tV8hg587br/8NYs
         3Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b05xL9kAscZWSXME5xLV21YU+wuPfJsoBMrudB8xb2k=;
        b=Qvtn4VCoGcRcpcPAWF34Q+6u2TBMJ4NhTmSvkKAgDVAf8/o8oRNsncKVSsxo4zL0NL
         UKbMpTiFtLUQIaRP4ZNYYp858jXi6EZYJl7NIwpWr+J+Q4PrZyeclzYuZtLvBPqD5gn7
         XCm6ZIsAl2eKpGZGQ1m5wIVzGA3+26A8eKASV+YD6ydq2kvUt6K8dSH/HF8MHvwTRl9Z
         1XIdPpxaWjqOqrwRXEmqUx30xBRvPeGrYMW0MEw0dbOD5CR8U1uQbtejYeXCgEpc9KFr
         iuK9RS13j74kzrwH8yvgcmtCwkoeVyR/yybynPWfEhUYNl9a07JGwx2LQt8lFAldRWmQ
         4N1Q==
X-Gm-Message-State: APjAAAUcRqgc7e0Jp4Z5d3Z6/YnZWL6dSDg+AgDxl3+pFSCKSz2kuvWa
        VxdwI6hZPGXRmeDRg5+p3SwEteBhYQg4eZ0jiUA=
X-Google-Smtp-Source: APXvYqwZcpCb0Ej+IAIRDBs+Rr9ywf8e7v9Lnx7a2frw5xa9cfFPbAhJGyzMy4DAxB+HsR61R9L2KeezRf2SsTyq2ck=
X-Received: by 2002:ac8:34eb:: with SMTP id x40mr5831821qtb.389.1551356290903;
 Thu, 28 Feb 2019 04:18:10 -0800 (PST)
MIME-Version: 1.0
References: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CABXOdTdprS1OL534XQq8yHTFDzXdWWODq3VGrSEHYe2wmV5zfg@mail.gmail.com>
 <CAK+PMK67rWZarOV31n=yYbRMq3wo9vDyMTQ93PFZ7PRUMS66Ng@mail.gmail.com>
 <CABXOdTdbev2nKNjocqxOyPcGOU8zbWpQ7uALWZdEHL0CXkYDgA@mail.gmail.com>
 <CAK+PMK5U4YRtJNUbsQu3ARJFxwai7W=DjPfjuX_AZMFcUZ-c_A@mail.gmail.com>
 <39dc9be2-808e-4800-b4bb-605d5bf94e12@collabora.com> <CAK+PMK4ov8jJh7wZoTErikuztf=eOruG8xYt6umjt35f9EaGaA@mail.gmail.com>
 <3959820e-cf43-2370-7cea-7afd01b2933c@collabora.com> <CAMHSBOXF_PtSTpcnVcJE7bMRA85TCqZdJL3Md4Z_Cd4Djjkw1A@mail.gmail.com>
 <CAFqH_53CF2rOVt8G=amQXC2_0mNXZw2m8_kvkM2wMjx6GyWSaQ@mail.gmail.com> <20190228075656.GA9224@smile.fi.intel.com>
In-Reply-To: <20190228075656.GA9224@smile.fi.intel.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Feb 2019 13:17:59 +0100
Message-ID: <CAFqH_53Ued9vyBZDkpEzdFo=hRQs8J7QSQ-o7XRnDc2meb1GiQ@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jett Rink <jettrink@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
Missatge de Andy Shevchenko <andriy.shevchenko@intel.com> del dia dj.,
28 de febr. 2019 a les 8:57:
>
> On Thu, Feb 28, 2019 at 12:05:35AM +0100, Enric Balletbo Serra wrote:
> > Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dc., 27 de
> > febr. 2019 a les 19:37:
> > > On Wed, Feb 27, 2019 at 10:08 AM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > > On 27/2/19 16:13, Jett Rink wrote:
>
> > > You're right, the cros_ names are based on what the EC provides.
> > > cros_ec for generic EC, fp, tp for fingerprint, touch pad
> > > respectively.
> > > ish is for standalone sensor hub [it does not have to be Intel Sensor Hub].
> > >
> >
> > Thanks for the explanation. I didn't know that and I assumed the 'i'
> > was for 'intel', maybe would be good call cros_ssh or cros_sh to avoid
> > confusion?
>
> i is for Integrated. There is no confusion.

Ok, thanks for the clarification. Now that is clear to me I'll send
some reviews of this patch in a minute.

Best regards,
Enric

> It seems you misread what was written in [] above.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
