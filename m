Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C06C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F302183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx9mEwly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCVPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:42:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43153 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:42:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id c20so1459267qkc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M0fEWqxL7lrTONyLPblza9/+UBbL6cScbNRCjuIAsKk=;
        b=Xx9mEwlyGH4YCzVza6XH4HaUGrW2ijYvD/F7mtTK/cPZkZVMX6UOgf4H5GtBHdsOSq
         Au31TH7GOZBiwosDxaZv9q2oU8WMF9symtnA6XK2hOWCn3gNlKZiwfyzT1s9LfSGLfN/
         k+NkzM6TbLRUx0Q3vCNX+J5lx2WJCJ0FzW2DrxI5joI3gUyvLpOyIvR07Gg+Y0vfQUVA
         6Wb5GJqKFoYxQ56cJYharsTRWDwXO8kMzYkDEC0gZWXRNmKjF4v6GwHJhNp1CwHRXmr/
         aKvzbg7JiZoDTdL64IH3jJR6l8WOpjRLvggc/Wc7a7yIH1XTH8N03ayhn2IoSeN8AL/2
         bVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M0fEWqxL7lrTONyLPblza9/+UBbL6cScbNRCjuIAsKk=;
        b=ZEjHquyuo0K4DpQXZ4Qcd2FN1wrFPKjbdkwTtTdVgtR/xNfePXYdLEM910dWB+L2Gc
         6mrlbA6iI6qep5irZ5DcBu3jVO/Qkq7bewVUEk/t1x0qR4MezkWUkzIsek/32UEcM5kc
         za6ehjzfWW5FotpKgtildG3kXbxJiflNGY4Ztz5HsUTOPMxBvwzXNmdYGjuBnBI6ORwg
         V3ULX5Wv941jQl5laFHEaaVww0WynsQuiehgMgrM0jzA0DrJK/E0+f8AQiCCILUug6T9
         LCd6Y/ZLfmY7P3+cqayzhpHlz/e6URkAJXuyqi0mqilGKn0Q21IlSqo1Jhk2SgmbxJ1D
         GIqg==
X-Gm-Message-State: APjAAAXKj0ZXQej0JttHhXBqy0JDhn+Uw12ziajWdLreHm5VoNq+BuqI
        Dw/HY3k/BaedIRQHu6z+20B+oiSX70zp8bYfMPdVMQ==
X-Google-Smtp-Source: APXvYqyGh9HPna5OwO1nB4fj1IFdCNOBldeHn4qI4QnoiL0VoGpRTBSnxWvqkLVZSQ8kAARBGSqYRC55QQ1H3b30pj0=
X-Received: by 2002:a37:47cb:: with SMTP id u194mr4257608qka.358.1553269369842;
 Fri, 22 Mar 2019 08:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190320212030.43682-1-evgreen@chromium.org> <20190320212030.43682-2-evgreen@chromium.org>
 <CAFqH_52vsfsxGRQNNzLGjLySHeTXVjdqjBn+1v4EaGMt5ipkbw@mail.gmail.com> <CAE=gft7zievpC-Zzsat6mn_R9VRGeHGhL-gkn76Vr6_fEbQLjQ@mail.gmail.com>
In-Reply-To: <CAE=gft7zievpC-Zzsat6mn_R9VRGeHGhL-gkn76Vr6_fEbQLjQ@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 22 Mar 2019 16:42:38 +0100
Message-ID: <CAFqH_53pQD5FS-LojvET=sMNkvkRwykwhwY3eoDEouds=Ju=MA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Missatge de Evan Green <evgreen@chromium.org> del dia dv., 22 de mar=C3=A7
2019 a les 16:38:
>
> On Thu, Mar 21, 2019 at 2:31 PM Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
> >
> > Hi Evan,Thanks for sending this upstream, one comment below.
> > Missatge de Evan Green <evgreen@chromium.org> del dia dc., 20 de mar=C3=
=A7
> > 2019 a les 22:24:
> > >
> > > Introduce the command and response structures for the second revision
> > > of the host sleep event. These structures are part of a new EC change
> > > that enables detection of failure to enter S0ix. The EC waits a
> > > kernel-specified timeout (or a default amount of time) for the S0_SLP
> > > pin to change, and wakes the system if that change does not occur in
> > > time.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > >
> > > ---
> > >
> > >  include/linux/mfd/cros_ec_commands.h | 59 ++++++++++++++++++++++++++=
++
> >
> > We're trying to sync kernel cros_ec_commands.h with the EC protocol at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/inclu=
de/ec_commands.h
> >
> > Gwendal send a first patch [1] and a second version will be sent soon.
> > I don't see these definitions in the mentioned patch neither the
> > master ec_commands.h from the EC firmware repository. Is this a
> > feature that didn't land in the EC firmware yet?
> >
> > [1] https://lkml.org/lkml/2019/2/27/723
> >
> > Thanks,
> >  Enric
>
> Hi Enric,
> That's correct, this feature is hot off the presses. It's being
> reviewed here, I expect it to land soon:
> https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/15015=
12
>
> It seems like it would be easier if I based this series on top of
> Gwendal's. I'll plan to do that for the next spin unless I hear
> otherwise.

Yes please, if is possible base the series on top of Gwendal's patch.
If for some reason the Gwendal's patch lands before, you can send it
separately but I'd like to see applied in EC repo. The purpose for
that is to maintain sync the includes. Thanks,

Enric

> -Evan
>
>
> -Evan
