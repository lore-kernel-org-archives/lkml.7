Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D773C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62375205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="MbrvW8fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEFIqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:46:50 -0400
Received: from onstation.org ([52.200.56.107]:48060 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfEFIqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:46:50 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id ADD7F3E941;
        Mon,  6 May 2019 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1557132409;
        bh=xI56e4hzg4jsRuD6zEwMlE664g9qNhVDQ6VNP1rTbBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbrvW8flOyL19oI0XQSJXHxCE4aknvmEvXhDIrAnh2i+7wuAD1LOHt7sh+PzCSKsZ
         6w54mSq6UnjAv9pT7IriI5tFztg2ea6akIdw++qmqmwJAItsPw4o6CkTgYry+K6eqJ
         bI0/YPJ1okYTxaDvcGPjj3HqDlx8j3eEeBrTA90U=
Date:   Mon, 6 May 2019 04:46:48 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/6] ARM: qcom: initial Nexus 5 display support
Message-ID: <20190506084648.GA270@basecamp>
References: <20190505130413.32253-1-masneyb@onstation.org>
 <CACRpkda=JTfKC4z=1Gmt1BE5adwd8XGZ4ERTgapWX_BN9TFESw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda=JTfKC4z=1Gmt1BE5adwd8XGZ4ERTgapWX_BN9TFESw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 08:42:36AM +0200, Linus Walleij wrote:
> On Sun, May 5, 2019 at 3:04 PM Brian Masney <masneyb@onstation.org> wrote:
> 
> > mdp5_get_scanoutpos() and mdp5_get_vblank_counter() both return 0, which
> > is causing this stack trace to be dumped into the system log several
> > times:
> >
> >     WARNING: CPU: 0 PID: 5 at drivers/gpu/drm/drm_atomic_helper.c:1430 drm_atomic_helper_wait_for_vblanks.part.1+0x288/0x290
> >     [CRTC:49:crtc-0] vblank wait timed out
> >     Modules linked in:
> >     CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.1.0-rc6-next-20190426-00006-g35c0d32a96e1-dirty #191
> >     Hardware name: Generic DT based system
> >     Workqueue: events deferred_probe_work_func
> >     [<c031229c>] (unwind_backtrace) from [<c030d5ac>] (show_stack+0x10/0x14)
> >     [<c030d5ac>] (show_stack) from [<c0ac134c>] (dump_stack+0x78/0x8c)
> >     [<c0ac134c>] (dump_stack) from [<c0321660>] (__warn.part.3+0xb8/0xd4)
> >     [<c0321660>] (__warn.part.3) from [<c03216e0>] (warn_slowpath_fmt+0x64/0x88)
> >     [<c03216e0>] (warn_slowpath_fmt) from [<c0761a0c>] (drm_atomic_helper_wait_for_vblanks.part.1+0x288/0x290)
> >     [<c0761a0c>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c07b0a98>] (mdp5_complete_commit+0x14/0x40)
> >     [<c07b0a98>] (mdp5_complete_commit) from [<c07ddb80>] (msm_atomic_commit_tail+0xa8/0x140)
> >     [<c07ddb80>] (msm_atomic_commit_tail) from [<c0763304>] (commit_tail+0x40/0x6c)
> >     [<c07633f4>] (drm_atomic_helper_commit) from [<c07667f0>] (restore_fbdev_mode_atomic+0x168/0x1d4)
> 
> I recently merged this patch:
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b3198c38f02d54a5e964258a2180d502abe6eaf0
> 
> I noticed that DSI is sometimes way slower than a monitor, even  in HS mode.
> On the MCDE this happened on the first screen update, which was slower
> than 50ms.
> 
> Check if your vblanks are simply slow, try bumping this timeout even higher,
> I spent weeks finding this issue which boils down to an assumption that
> the vblank will be fired from something like a monitor at 50 or 60 HZ
> ~20 ms so 50ms seemed like a good timeout at the time.
> 
> On a DSI display this is dubious, absolutely in LP mode, and even
> in HS mode.

That did not fix the issue for me, and I went as high as 5 seconds.
That's good to know though since I would have likely ran into that same
issue down the line.

Brian
