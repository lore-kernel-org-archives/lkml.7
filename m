Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00AEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1DF20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QScICi4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfCVPiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:38:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46473 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfCVPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:38:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id r25so1674322lfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ldDWOmAj8jwPVsBwSQANvWclxD57ppweNrb50y+NB+8=;
        b=QScICi4c4upBcagk1NBgGvf6uq3UGZeaKnIcn1rHH4yhT1EAMwtdU2uZuffRHUkQbX
         5WBkXYBwAblCzKAGBVsAlAgsj/OmUJbmN6H2CNxMmAWLytcBMC4sKU6BqJPBxHAfuGAr
         8SjTwagf3d2r/o+SUQ86t1H7mjJ9md4AjOXV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ldDWOmAj8jwPVsBwSQANvWclxD57ppweNrb50y+NB+8=;
        b=Nz8ehcoHjRtmqScyf7zrdUJkIuOuKETahJTchrbmpb7MFJ1NRQHM1iOdNo9hf40RPb
         qsOUlveXhDbbwWKiQFSfYJ3WW3ZxJxspnjVKKV92HwN6h3XbQsjfX1jeA2BdoN851MQW
         mgeiRwfZachzOiCojtUIOnJYmrmDvsPWvuFVwsPCcbs3Lc1CCsmHbUfZucY+5q15hcUS
         B7EVq69Ff8b1o3fybyJgBk6vTZ2ltsBW4FbAy+rc0Qiz6+P8YMHuHLrMNboUwkJ61pI2
         X9i8bS3FESlvlVfqtTelDgyYxJ55cfkuz/WXcULshyEuJL/rFefZsToSVrsrN1qLBYvP
         Wj3g==
X-Gm-Message-State: APjAAAVuvfmrjlEb4laTjquAIpGzYojtHb1lH+jNxiXAqTh1ITXlgN5Y
        RTDoDQOk+m4KyOaf+k5PNXjUl1NUzhU=
X-Google-Smtp-Source: APXvYqxPg1/BxG/DBxeCmu/sSeYGaIxaNW2DwU5tN0S0mZWcGefh6uquHAopNDWKigbiRTut7+MZwg==
X-Received: by 2002:ac2:515b:: with SMTP id q27mr5518879lfd.110.1553269085541;
        Fri, 22 Mar 2019 08:38:05 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id i190sm1750260lfi.43.2019.03.22.08.38.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:38:04 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id f18so2410840lja.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:38:04 -0700 (PDT)
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr5591640lje.126.1553269084543;
 Fri, 22 Mar 2019 08:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190320212030.43682-1-evgreen@chromium.org> <20190320212030.43682-2-evgreen@chromium.org>
 <CAFqH_52vsfsxGRQNNzLGjLySHeTXVjdqjBn+1v4EaGMt5ipkbw@mail.gmail.com>
In-Reply-To: <CAFqH_52vsfsxGRQNNzLGjLySHeTXVjdqjBn+1v4EaGMt5ipkbw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 22 Mar 2019 08:37:27 -0700
X-Gmail-Original-Message-ID: <CAE=gft7zievpC-Zzsat6mn_R9VRGeHGhL-gkn76Vr6_fEbQLjQ@mail.gmail.com>
Message-ID: <CAE=gft7zievpC-Zzsat6mn_R9VRGeHGhL-gkn76Vr6_fEbQLjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
To:     Enric Balletbo Serra <eballetbo@gmail.com>
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

On Thu, Mar 21, 2019 at 2:31 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Evan,Thanks for sending this upstream, one comment below.
> Missatge de Evan Green <evgreen@chromium.org> del dia dc., 20 de mar=C3=
=A7
> 2019 a les 22:24:
> >
> > Introduce the command and response structures for the second revision
> > of the host sleep event. These structures are part of a new EC change
> > that enables detection of failure to enter S0ix. The EC waits a
> > kernel-specified timeout (or a default amount of time) for the S0_SLP
> > pin to change, and wakes the system if that change does not occur in
> > time.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > ---
> >
> >  include/linux/mfd/cros_ec_commands.h | 59 ++++++++++++++++++++++++++++
>
> We're trying to sync kernel cros_ec_commands.h with the EC protocol at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include=
/ec_commands.h
>
> Gwendal send a first patch [1] and a second version will be sent soon.
> I don't see these definitions in the mentioned patch neither the
> master ec_commands.h from the EC firmware repository. Is this a
> feature that didn't land in the EC firmware yet?
>
> [1] https://lkml.org/lkml/2019/2/27/723
>
> Thanks,
>  Enric

Hi Enric,
That's correct, this feature is hot off the presses. It's being
reviewed here, I expect it to land soon:
https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/1501512

It seems like it would be easier if I based this series on top of
Gwendal's. I'll plan to do that for the next spin unless I hear
otherwise.
-Evan


-Evan
