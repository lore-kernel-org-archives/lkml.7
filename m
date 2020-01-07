Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7861C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA26C2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRKTOX73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgAGQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:02:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41916 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgAGQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:02:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so43070719qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 08:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5L2Z7dBLaHFaGhh6t90np+r+vB2C1fkHc9c1XkE5eA=;
        b=SRKTOX73kQ0C7bZJyVEQPX5lrHCfn6wtB+TUgnlKYaqAcPOJxRX9W33hvgPLf/Cqni
         20bWZcvpVtp+u3kVVCy8Pr6p5WX771zG/aaYNm3a43PBoZMEWPkVUdafi6z8zdNbP875
         wtMMQXxTZrS4EHq5APXk2wYx3oJy+7yGEHag0xh0L78KeLuZ6Up0ZEKAeisMiKKEo5bD
         GnoA9zsPeHtXte1J8C12L3Ve4R2yJhPrmNnqIh1xILeh06Iq5UCkFiirkFczmkS1Durt
         VPuB0v7XEVsThI6kRHNHza1+1T1XUR1zTV2kSimviYK2TK4yxqHmw1gQJk9t+jf8ah8+
         YhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5L2Z7dBLaHFaGhh6t90np+r+vB2C1fkHc9c1XkE5eA=;
        b=jV2F+j5BstkhS7WmyAlpYu/6Zw1INEQKvI1QDhJ5D8YKKQTEYBFrisdDfDkR1Y8Jmu
         fKdPdIgSBNldckkyOFJDVG9yjv8RpKfWSG0Qq6rgGW83WM6961PBupuPFLggKjCSeZr5
         ECgATYJWAwMGaidWYVe4OX9RF7vJCzyTim3eFSFtFM8wFUmOUiluMdS+z/nDwYbZrYZL
         N4bUYOLIAbsvVbyS1/NSubmG7/P2P3Ciq1BJI0M5oMZ16f3kIpPukAeE8MwYNG9e2Ryn
         lag+Mb1XXlALXr/I5K3oSAnoHbA4f4XTKxlYszCiw5i5stQKaduPw+enOI0S9snvIWha
         +1YA==
X-Gm-Message-State: APjAAAXjVfrCvZsFRcVRCka8ByiYH4QA8YhR7/CUEnODKtuy3wzI9vHT
        yy6suuIqZOguHtkDLAKHN1/bUGcBZDiI1JbrrqMGRA==
X-Google-Smtp-Source: APXvYqzUW7seMxUlfo6okJae/fU1ZwL/kM+/uzTVDw6txhjzZH1cXINZE4qkaz5ynFXQaozCcU2Y+HQm3/FNG88d/6Y=
X-Received: by 2002:a37:e312:: with SMTP id y18mr18264qki.250.1578412928223;
 Tue, 07 Jan 2020 08:02:08 -0800 (PST)
MIME-Version: 1.0
References: <00000000000082b80f059a56da1f@google.com> <0000000000002074ef059a5c86e2@google.com>
 <20200107154755.GB43062@phenom.ffwll.local>
In-Reply-To: <20200107154755.GB43062@phenom.ffwll.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Jan 2020 17:01:56 +0100
Message-ID: <CACT4Y+arQyPjzHSFy1MkVF2jNPJbu262_FTL5ma9AnWkXosY1g@mail.gmail.com>
Subject: Re: INFO: task hung in fb_release
To:     syzbot <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>,
        Rex.Zhu@amd.com, David Airlie <airlied@linux.ie>,
        alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        christian.koenig@amd.com, david1.zhou@amd.com,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 4:48 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Dec 23, 2019 at 02:31:01AM -0800, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit e3933f26b657c341055443103bad331f4537b113
> > Author: Rex Zhu <Rex.Zhu@amd.com>
> > Date:   Tue Jan 16 10:35:15 2018 +0000
> >
> >     drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs
>
> Pretty sure you don't even have that driver loaded ... from the config:
>
> # CONFIG_DRM_AMDGPU is not set
>
> :-)

Yes, it seems the bug is very flaky and flakiness changes over time.
And this is combined with non-deterministic kernel build bug:
https://github.com/google/syzkaller/issues/1271#issuecomment-559093018
It builds the same kernel, but gets a different result, so it's like
"nope, this commit very much affects the kernel so could be the root
cause"...




> Cheers, Daniel
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b5a799e00000
> > start commit:   c6017471 Merge tag 'xfs-5.5-fixes-2' of git://git.kernel.o..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b5a799e00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16b5a799e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7f6119e2e3675a73
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d130c4a0890561cfac5b
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b1925e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b9623ee00000
> >
> > Reported-by: syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com
> > Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage
> > support in sysfs")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200107154755.GB43062%40phenom.ffwll.local.
