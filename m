Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CC5C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04892086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="b+RfaTs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfGOVsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:48:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45513 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfGOVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:48:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id m206so13891765oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6e7DRMuQdVok4h9s3bFzY/fVAesWrHCG++TXs3wwJc=;
        b=b+RfaTs//kWIhveDSusgI4qjyvX0eUrbNXorBAg27bcO9UpmJ4T2qDep9avaJUwfT0
         kDsl4ZumaPNqw0I4YBrS5IYFs7EQ0wuzE7vNuHJlS2uF7TGlPuB637tG1TeAWyIvfr0c
         pgoY6TuZDTvWTjE1RXRX7i/OB/omeFq2khiE7Md2ZgKF/7ZpBpZMXp5f696nB/um3kHH
         smsCwp1vvsLFB+dxz3LlQoeg9++1+xgff51PUlsDp7OLXqD9qfRSTgIYtx5ahOx6/qqe
         8VBAMiFgtbMey8lFx4HCeQ0hOruTIX4l1lqLgEQnNkJS3n3AqxsHc/mPiYs51Bi45pnb
         2T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6e7DRMuQdVok4h9s3bFzY/fVAesWrHCG++TXs3wwJc=;
        b=nh7aJF0IYh81wIqaQDyim+OtIz2At1APWZAbPZpPCzzh3uMTS+5bzggOnYW9q4J7XW
         /0gf/aCne1lh+faZ4RWUcrnevZytEBYyhv7fblHiPmHT6G1bHdcaBJ08wlmllcrpjpF/
         ZuzXORyumgsIWwCctZlXCsQkwbCCAcAUMAZxiiliCbGTmF2zVeOTNyeTHCt4Rl6xGFAL
         Uji4RoU2qgePJgk6TjoWTGk89NEPFToODQcRIxxVtteAac+UwFU9du0O+ZdYffi3SHrS
         iqWDFM7NCY7dRAZ8xu4EqLQd3NWL1e2o+2x3KjmR8B3yyatMMbEqtPq6o76agydp8vHz
         bJig==
X-Gm-Message-State: APjAAAWqwcGbOAOxVCfvdDSS9vW7BXcR5TPnjkZV8koiCNkfdA7fTcQt
        qQaMt/Odi4evRIkdPrFRWR04pw2L64mjwQWYfB0=
X-Google-Smtp-Source: APXvYqw9dke1ghFxnHX6HAV2lmdw3RdzqwaSF9V28TbiYgFTCr6s6WN4r5ruqE3Ue2Mqdc0xMnuCjFZwdezWm01SCQk=
X-Received: by 2002:aca:3509:: with SMTP id c9mr15286738oia.179.1563227304035;
 Mon, 15 Jul 2019 14:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vAxU5jp6PQ26NU+UMc6iyw6KkBS9nbd6wj0qqkO-1WhYg@mail.gmail.com>
 <20190715201116.221078-1-trong@android.com> <20190715203651.GA7513@kroah.com>
In-Reply-To: <20190715203651.GA7513@kroah.com>
From:   Tri Vo <trong@android.com>
Date:   Mon, 15 Jul 2019 14:48:13 -0700
Message-ID: <CANA+-vC+_Gp4RwdLH_XYDAepRONB66PdekvaCxNT3ZVGx73G6A@mail.gmail.com>
Subject: Re: [PATCH v3] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>, kaleshsingh@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 1:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 15, 2019 at 01:11:16PM -0700, Tri Vo wrote:
> > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > blocking wakeup sources over device's boot cycle. This information can
> > then be used (1) for power-specific bug reporting and (2) towards
> > attributing battery consumption to specific processes over a period of
> > time.
> >
> > However, debugfs doesn't have stable ABI. For this reason, create a
> > 'struct device' to expose wakeup sources statistics in sysfs under
> > /sys/class/wakeup/<name>/.
> >
> > Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> > source statistics in sysfs.
> >
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Tri Vo <trong@android.com>
> > Tested-by: Tri Vo <trong@android.com>
>
> Co-Developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> perhaps given that I rewrote the whole file last time?  :)

Thanks again for the help!
>
>
> > ---
> >  Documentation/ABI/testing/sysfs-power |  73 ++++++++++++-
> >  drivers/base/power/Makefile           |   1 +
> >  drivers/base/power/wakeup.c           |  12 ++-
> >  drivers/base/power/wakeup_stats.c     | 148 ++++++++++++++++++++++++++
> >  include/linux/pm_wakeup.h             |  19 ++++
> >  kernel/power/Kconfig                  |  10 ++
> >  kernel/power/wakelock.c               |  10 ++
> >  7 files changed, 270 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/base/power/wakeup_stats.c
>
> What changed from v2?  :)

Oops, my bad.

> And I am guessing that you actually tested this all out, and it works
> for you?

Yes, I played around with wakelocks to make sure that wakeup source
stats are added/updated/removed as expected.

> Have you changed Android userspace to use the new api with no
> problems?

Kalesh helped me test this patch (added him in Tested-by: field in
latest patch version). We haven't tested beyond booting and manual
inspection on android devices. Android userspace changes should be
fairly trivial though.
