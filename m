Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9F3C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAB1206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPDKQ7pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbfHBKTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:19:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37907 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfHBKTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:19:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so72319579ljg.5;
        Fri, 02 Aug 2019 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGBuTFqAyAj2SvbKj/G2jivACOslP7MbhI6gu5H3H9I=;
        b=MPDKQ7pD9hLCaB4mMrjjDD4pDd5I1b0v86GUrdk+9H51jnm2oDXwo37FqTFWTgsZ84
         RMB6ALfrxUdW6R/f+flRuhuYV1Xpo843krtmq0d3TdhL6KIAgPkV8SLJmh2lAzITNwuE
         Fte5IKFXZmElEo9bLC7S9syxay5R4u+qJCkVd/iUpQ8goLajV54hdbOUWO3WAiYNoL3P
         7zvfES4AZ4beDbi46U99a0tz2CNnwUKqkIVtLrp0JqAmkb6/lGwTmQGjljJ7nO/enbMM
         rHsVwLlytDQK6Tc0TmRlObyQxYLj0kW1rdVBtspdUIomaoxFXPfJDC2OnZc/Yt7xhM7I
         OOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGBuTFqAyAj2SvbKj/G2jivACOslP7MbhI6gu5H3H9I=;
        b=B/7JF2qd+iZSBzR+W/Din8ht8iBVC9hRyTS7KFMmFedXea3GOYfBXW5c7Ho5cysjHb
         OdEzlV8mO+rVD+ShFpvRC3/GMfByGjhyDN3L9ax5eiHh74V5MhOev2SCG36MH5NF4jrr
         x6rFLoRV7fEHX3iBgKeo6nUT8LMEmQMHDtTciTKMlt8vxszZvgHaZdvWbYQ+D/3LnrIY
         nfGRlqXPpfFbgCgkvXaaC4yyPuqBUL+MhhEgNiLFzqcT4UoS12VH3diLEK1ZQ+KfCCmq
         wyrUxmzdr12YqgU63wo/H6dQfxLF/hsjWxhqMYL/NIY/Q7tKy2pCd0HlKtrIZ0O7u8ZR
         hHiw==
X-Gm-Message-State: APjAAAXFuekID4k9MWmTsonD2HeyhVIpejV1EeCjML4DI/ZZlIytlKVC
        itMZlaKpeM5lktBNkPniZeCxX/mufZ8I0z2HpvKM9mC1
X-Google-Smtp-Source: APXvYqzzKlttQbwJtenbmXL7wZ9ffMLL+Cel02QakOlRtlFS2m8PpyPnLg15CyLpoJT0GFJPQPVlfYezNARFbzNMjfo=
X-Received: by 2002:a2e:9198:: with SMTP id f24mr72249856ljg.221.1564741185385;
 Fri, 02 Aug 2019 03:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <259986242.BvXPX32bHu@devpool35> <20190606185900.GA19937@kroah.com>
 <CANiq72n2E4Ue0MU5mWitSbsscizPQKML0QQx_DBwJVni+eWMHQ@mail.gmail.com> <4007272.nJfEYfeqza@devpool35>
In-Reply-To: <4007272.nJfEYfeqza@devpool35>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 2 Aug 2019 12:19:33 +0200
Message-ID: <CANiq72=T8nH3HHkYvWF+vPMscgwXki1Ugiq6C9PhVHJUHAwDYw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Linux_4=2E9=2E180_build_fails_with_gcc_9_and_=27cleanu?=
        =?UTF-8?Q?p=5Fmodule=27_specifies_less_restrictive_attribute_than_its_targ?=
        =?UTF-8?Q?et_=E2=80=A6?=
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Greg KH <greg@kroah.com>, stable@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 10:17 AM Rolf Eike Beer <eb@emlix.com> wrote:
>
> Am Samstag, 8. Juni 2019, 14:00:34 CEST schrieb Miguel Ojeda:
> > On Thu, Jun 6, 2019 at 8:59 PM Greg KH <greg@kroah.com> wrote:
> > > "manually fixing it up" means "hacked it to pieces" to me, I have no
> > > idea what the end result really was :)
> > >
> > > If someone wants to send me some patches I can actually apply, that
> > > would be best...
> >
> > I will give it a go whenever I get some free time :)
>
> I fear this has never happened, did it?

No. Between summer, holidays and a conference I didn't get to do it.

Done the minimal approach here:

  https://github.com/ojeda/linux/commits/compiler-attributes-backport

Tested building a handful of drivers with gcc 4.6.4, 8.3.0 and 9.1.1.

Greg, I could backport the entire compiler_attributes.h, but given
this is stable, we are supposed to minimize changes, right?

I tried to imitate what you do in other stable patches, please check
the Cc:, Link: lines and the "commit ... upstream" just in case.

HTH,

Cheers,
Miguel
