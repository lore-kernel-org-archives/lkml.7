Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5282FCA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 00:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6832086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 00:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572569289;
	bh=l/T2Eo7NBRTCHTpxC4Vn6W0SQHUz3JHpxcLyo1mPb7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mAkKUnTZjTEy1pC9eTvIPz3WpWums70flql3j0zxiO2riI8aRfN+6gvKlLtrvwWyu
	 WJWs8FrHiYDm2Hypc2N+18+snDxl0bpqEsMO41M7smNoYRMBHYZJ4qa0JgKkivn+Sa
	 t3fnyjyOAgq8jM/yzx0RjisdU42Sz97h1EXWostU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfKAAsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 20:48:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54910 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfKAAsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 20:48:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id c12so3269493wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 17:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDcOoW8/vlglme1diIrYvcv1YvXU5Io8xV2HIpph938=;
        b=cgIvAdZuUV1fPd0PaBE3MA1gBAOGhnKyw6aaaTr5bFYRq8LMHOYTIL2YyMcndnnbRw
         Fo1+QfleJcoQNdA1L6P9bRRH+Mm+yuCIQUK+CV2SQPowXOWy0EVHGkFkRfyEmGWEcwXW
         0vuSHGxkcQkb47q7kK094hWvfjG2DjEoPeNkjHt+ROKkNDgTI+Zg+gkJTPWlXPnOiEJB
         2NYQWwQohC8NGvxkbbHs9LBT6+mF/N/rZH3CyyZ3JuokxEq9qlZUDD+8jg7acMkI+Za8
         5TTNmAxnWYrAS1KjoPBlqZnHyfPA9K/X4Bym3LsIGHnQ/al+S2VCEQ9IGtwlOK5dlxCz
         FoIw==
X-Gm-Message-State: APjAAAVsGJbHDsoQgODTo6GhQjkppURjyHAEND+Ccw3Nw+36yc2lOXhj
        vw7EXXctIlZ08ESQ5k5AoAMzF2yP9161H2Zofg4=
X-Google-Smtp-Source: APXvYqyFXMW4YTYm8Ru+2ngdCwqEnFaOn00xb8Kyb/FbCpc0gaoQJO6iMZ6LOAuAk2FLrTM5pmxnGdJVLInk6Mi+8x0=
X-Received: by 2002:a1c:7ec2:: with SMTP id z185mr7713347wmc.79.1572569280606;
 Thu, 31 Oct 2019 17:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191016125019.157144-1-namhyung@kernel.org> <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com> <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
 <20191025110623.GH3622521@devbig004.ftw2.facebook.com> <20191025184714.GJ3622521@devbig004.ftw2.facebook.com>
 <CAM9d7cguuEC1bpYgqX58KqX-H9C2B=XQE+grkxdsG2MQ8WyJnA@mail.gmail.com>
In-Reply-To: <CAM9d7cguuEC1bpYgqX58KqX-H9C2B=XQE+grkxdsG2MQ8WyJnA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 1 Nov 2019 09:47:49 +0900
Message-ID: <CAM9d7ci3vXGGYD-Kgpc6-EmggSpc31ZETyB5dwfmAf26kSM6rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Sat, Oct 26, 2019 at 8:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Sat, Oct 26, 2019 at 3:47 AM Tejun Heo <tj@kernel.org> wrote:
> > So, something like the following.  Just to show the direction.  Only
> > compile tested and full of holes.  I'll see if I can get it working
> > over the weekend.

Any update on this?  In the meantime, I played with it and
managed to run the cgroup selftest.  I uploaded it to my tree at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

on the "cgroup/id-rework" branch.  I can send it to the list
if you want.

Thanks,
Namhyung
