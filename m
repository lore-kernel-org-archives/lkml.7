Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC3EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E8C204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmrHSx/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfGOS2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:28:14 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40329 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfGOS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:28:13 -0400
Received: by mail-lf1-f43.google.com with SMTP id b17so11712283lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZIog1Mvh3lUi4/RzCGQ/kW0L9u/W2zjWZcp30VMENo=;
        b=cmrHSx/chP07OGY5ck533woHYSzk1JADL55gJ6bx5/mRhRUNpVkETGFkgUTovdSIj4
         AAHNALIMSyu8BkSmRGl+ZjsDU6PubyIXY39vb/8pu9dm5ern2Ocx4SHeFeCgYVTy0hu/
         rTDbuaJYJaXg5FXmI8O4V+p1CUPe/uz8V7L3A5EdTkf5ZqHALu5VZ7ckdANrBAit1T8H
         GWxphmhxhRGIDWx7Myb96eHyf7QXt06n1b1pUw9jkdtX76xnRqlXNw6+rlpYhI8subKh
         5bJ7aO1n71cfnvPUDKNCZ4BlcdqHMz/Ti/EoO1b/VldfAs5r8fMWR17TsXkxDHRDpDLO
         O+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZIog1Mvh3lUi4/RzCGQ/kW0L9u/W2zjWZcp30VMENo=;
        b=rkTAOaFPZxJe1rkKTcWRC2bk1poiP41RY/pzenmeL0DzVxvtR0FYkscOFyBbK9qRk+
         T+FkM/LDiks/Insgovie8pt7J0RxK+gl5S1ChoCnnc4J9IOAc/Ux3l2di8dktQuvGECC
         /bttjhDsVxgZIntuza7yuWErl+oDUT/+dmg6H2RjrzHCAB9LAn6yzrZ3GYv6VPHzVCJx
         kOttBkv2//+vwu/hgeNaMTqadxOkqR9/3doU8Z8Cq3WsmIlL8yHEkrs/Q07mFpUYcsng
         Wcnuu5GRZ6wHu1Hk/3ClujQ5G1E5RTDiUkpZC5mUsChKOLG4ONEidJgUG0LKYXeBL7Gc
         FReQ==
X-Gm-Message-State: APjAAAX90joDFtDk0r96SVYPWndWthSEUN3xmP5t3DQj4UjVgxYTFftZ
        TlQDSzMgjsty1bACZCbeS3lW1Mn7/D9ii5eep3Mwyw==
X-Google-Smtp-Source: APXvYqzvD8yqDkUBTqN7WBaHdVE+p2R6KZiWjpuKnTZcdWROs75uHPYKbHDXgO2CkCrT67XHNkdOf+Bc4P7F51uZHu4=
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr12661850lfb.67.1563215291451;
 Mon, 15 Jul 2019 11:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com> <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
In-Reply-To: <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 16 Jul 2019 04:27:59 +1000
Message-ID: <CAPM=9ty8kbEouQCwAedk+6jgByoiK4iBny=P_Hz9iB7Qy=dYww@mail.gmail.com>
Subject: Re: drm pull for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 at 03:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jul 15, 2019 at 12:08 AM Dave Airlie <airlied@gmail.com> wrote:
> >
> > VMware had some mm helpers go in via my tree (looking back I'm not
> > sure Thomas really secured enough acks on these, but I'm going with it
> > for now until I get push back).
>
> Yeah, this is the kind of completely unacceptable stuff that I was
> _afraid_ I'd get from the hmm tree, but didn't.

Looks like we were all focused on making sure hmm tree was good, I
really dropped the ball watching the other ball.

I pulled stuff in from Thomas quite a while ago, and his pull request
did say it had been looked at by mm devs, I looked back
a week or so ago before the flu hit me badly and went hey this isn't
as good, but removing it is a mess I better ping some people, then I
promptly fell into a hole.

It's bad though so I'm just going to revert it all out.

I'll send a new PR today with it reverted, rebuilding the tree might
be possible, but you'd lose a lot of testing confidence in the rest of
it.

> I'm not pulling this. Why did you merge it into your tree, when
> apparently you were aware of how questionable it is judging by the drm
> pull request.

I totally over trusted Thomas on this, I glanced at the helpers when I
merged them and went they seemed reasonable for the vmware address
space coherency model, and they'd been posted to linux-mm a few times
and had some feedback,

I caught it more last week when I was re-reviewing all the stuff in my
tree and I was like hey that isn't right, but removing it might be
tricky, then I spent a week with a couch and no brain.

So I'm totally responsible for this crap landing in my tree, and
Thomas will be getting a lot more push back in future.

Dave.
