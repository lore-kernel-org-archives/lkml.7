Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A19BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239242070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvFne6Ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfFTKsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:48:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33759 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfFTKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:48:11 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so520116iop.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C28hrFVtjUhKIunxod04yxNRITvcCbSlVw48Ln4UVNM=;
        b=hvFne6ArB35ze4xoP1VCRnd7RUmzT9611grtpD0tQTl7dv4MMDP9M9w9vnJNpatVWL
         OJsoELozsc7E5Fr2R2MaKEnqtTCkdTQajIXvwUZzjjE/Acb2LtidPR9vr16QdoO4IxQp
         ReYPvaFnqJ+2GwkkMw0JTkogvIfXzN4dz0rKYGblGY46ul/dlvV1FQxZlfzOUZOaFqJv
         PDMFj2dZKuSrEojC2sqg9Wolpn14In/KceJYw/93k1xz6BYyJa3af4c4jlhvfQAwz++g
         PuO2nO6zJmwCD8j568e0aQ3lrjxfrKKtw+akQFfKa6xueXT/qG2Q2zyBegDjcH7CRpyD
         NcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C28hrFVtjUhKIunxod04yxNRITvcCbSlVw48Ln4UVNM=;
        b=r+NtZ9671EloC1dciwIO6EjJVnzQ/PVgSKP36hDYYnmR3jD5+NtF13ifUrYkUjnlNx
         RhdWP61hPx41IuIcJPhsCIII43Y9GpocxOR761f0chJIkirT/GGA5b2vlFRkHpNIc3UX
         ZTrvXCkQjMIZutME9VisCFpeVDJh6KFAU/4xJhao5TNe/rcgpP6HGECu0qEZEpW6GrRz
         5qSmAqP06P8KdEj3uM6kjsoc00bABAbKayt9VIEy1D2u3pM1xoAlZPLsJuMUISHkDH6W
         slCm5vt5xNeRSCUvpOOgKBAosGEjTnfZDW9D9eNHVckqMLWXG3yQccV6PGvCkIpeld9+
         zrWA==
X-Gm-Message-State: APjAAAUvc8OOFaMzUjg75ikIx+yiRMcZvsxgoYSbg/H2ik4eHc2u9/wz
        LvtSW6NzXFeth/AGjY5Ba8AyCazrGMFPrh2BCJw=
X-Google-Smtp-Source: APXvYqz4ecBm/0uZtWuFPMYi6ItzBQDnvCKzViadGRWJJlOcoTUzprK/0ctU680a9f2o21mgvsdIi0tJ1k0d1Oxh9ME=
X-Received: by 2002:a5d:8451:: with SMTP id w17mr14250011ior.226.1561027690741;
 Thu, 20 Jun 2019 03:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <1561010100-14080-1-git-send-email-laoar.shao@gmail.com>
 <e5c695c9-2006-f2cb-e3e2-7ea8ee465817@i-love.sakura.ne.jp>
 <CALOAHbCe9J0pOCW03dW+C4NK__amTKttAs=eNHXwvPPf5Lpwhw@mail.gmail.com> <ac52f383-697d-8102-a6af-6aa172ee2a6f@i-love.sakura.ne.jp>
In-Reply-To: <ac52f383-697d-8102-a6af-6aa172ee2a6f@i-love.sakura.ne.jp>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 20 Jun 2019 18:47:34 +0800
Message-ID: <CALOAHbAAJ4EaZ1NaR3Kpms1Yu78gA7UBoYAfTgxDD1JxWEArmw@mail.gmail.com>
Subject: Re: [PATCH] hung_task: recover hung task warnings in next check interval
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 6:23 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/06/20 19:10, Yafang Shao wrote:
> >>> With this patch, hung task warnings will be reset with
> >>> sys_hung_task_warnings setting in evenry check interval.
> >>
> >> Since it is uncommon that the messages are printed for more than 10
> >> times for one check_hung_uninterruptible_tasks() call, this patch is
> >> effectively changing to always print the messages (in other words,
> >> setting -1).
> >
> > If sys_hung_task_warnings can't be recovered, does it make sense to exist?
> > In which case do we need this setting ?
>
> Someone might want to print the messages up to only a few times because he/she
> does not like the ever-repeating messages.

But some new difference hung task information may be missed.
And the reason of the new hung task may be different with the old one.

So I still can't understand it.

It would be better if you could give some use cases in the real world.

> But automatically resetting will
> forbid his/her wish to print the messages for up to only a few times.
>
> >
> > Btw, why the default value of this setting is 10, instead of -1 ?
>
> I don't know. I guess just by historical reason, for this variable
> has been existed before support of -1 is added.
>

I think we'd better change the default value from 10 to -1,
because this is the common use case.
And then the user don't need to write it into sysctl.conf again.

Thanks
Yafang
