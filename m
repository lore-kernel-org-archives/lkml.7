Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AC9206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lI5Xe3q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfDVKMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:12:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40531 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfDVKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:12:16 -0400
Received: by mail-io1-f68.google.com with SMTP id i21so8577016iol.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2i8kj2NVYwRKC/cOc/aZ0aiYghuUcmWK5HC0hmW/0qU=;
        b=lI5Xe3q/W3kF/Ac0lf6GEYESBArIjm5K1CY9/bTiiwOd9E+Va/bOlIQW+Qm3TyxvcU
         0TIfQSTHGul3N2xYfLiRmQKkfJxMKl6oRMcFwHeguVeXEETQKtLMTxo1SH0F4LXfp1jn
         3zQF0q0BDiBBFYk4rCjZMtdoVhpTyMMahwdQFtwVSUjs6+V1EV1STHtNgnJ4IeAN16Wt
         gtn6dOKOFh7/sVvdPeWLpuCwecjkL0+k0QywqeC5wH0M+SheLrC2fKg7KXqVMrxd+qdD
         5UG2cr77ZemteVF1gtY0S3z9Aopz4OH35sBYz8RWocLGJnhBIAd7XYjMVbwVLzDixerv
         rlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2i8kj2NVYwRKC/cOc/aZ0aiYghuUcmWK5HC0hmW/0qU=;
        b=WGWTbRz3Mxb2I1KBp6cfnSJb3BFN6crvG1K20ZCH80zikU3JqesM+jTaFfXK1y2klr
         OSrdj/cj/usC2VlLNxw8SDDzWlypdwJTkxsI+jAdaIQfEYIrEdpu/1G9i2prn9ujX0nU
         8Z7B5Bu7HLeG/GkNvPCD7fGTt/4YnSocQSMPUp63OpRE7Z9G7YzRlsT13R6qkbCc/xFm
         JpwGAQWLEn5bJk5XvLFZdqu55FC3CQJ6yZbKc1vEbbzCgVGxoPoTXACnJ4bj3SSTg0y0
         LIM/1tUzz2RIY8SwIAlKBLaU+8uw7OUIUE7zOV/5GRLfti7R1nR0XIFqoMbXmU0JfZdW
         oykg==
X-Gm-Message-State: APjAAAWCCwLl/dRp97A1iJ+joxyH3iPqeZgaBo4JFBzyBXgbd+WwDAY8
        RSRU+oGAwBAQTqZUc62ppXIeJDOowYXdBmcuW9rzrw==
X-Google-Smtp-Source: APXvYqxiKvdOWnfllePL4B9iYc/3pOBIqd1nMs13wK3atQLdrkEIxXGCMols+Yu2ZvGBQI5be4VHPhMyM+2oRyGXVrI=
X-Received: by 2002:a05:6602:2042:: with SMTP id z2mr94276iod.282.1555927935654;
 Mon, 22 Apr 2019 03:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000064bcf057a59e3b9@google.com> <0000000000004f7f7c0584fe33c0@google.com>
 <CAOQ4uxjOm+VFyTbm=2k1d0774qu2tK5gzEgKNnRPjd0GvMnihA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjOm+VFyTbm=2k1d0774qu2tK5gzEgKNnRPjd0GvMnihA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Apr 2019 13:12:04 +0300
Message-ID: <CACT4Y+bcm2PuX0=1miyXa4pSb2jU0nvp+9eyYwmavVncxB5JXQ@mail.gmail.com>
Subject: Re: WARNING in ovl_instantiate
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     syzbot <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 11:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Mar 26, 2019 at 2:10 PM syzbot
> <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 01b39dcc95680b04c7af5de7f39f577e9c4865e3
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Fri May 11 08:15:15 2018 +0000
> >
> >      ovl: use inode_insert5() to hash a newly created inode
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176da0cd200000
> > start commit:   de6629eb Merge tag 'pci-v5.0-fixes-1' of git://git.kernel...
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=14eda0cd200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10eda0cd200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000
> >
> > Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
> > Fixes: 01b39dcc9568 ("ovl: use inode_insert5() to hash a newly created
> > inode")
> >
>
> Dmitry,
>
> The root cause of this bug is that repro is mounting overlapping overlay
> layers (i.e. upperdir=./file0,lowerdir=.:file0).
> Miklos claimed that the fix should be to fail such mounts.
> Below is a patch to test:
>
> #syz test: https://github.com/amir73il/linux.git ovl-check-overlap
>
> However, I see that this specific overlapping layers mount has already
> mutated to several other repros out there, like the ones in this bug:
>
> https://syzkaller.appspot.com/bug?extid=a55ccfc8a853d3cff213
>
> I believe that disallowing overlapping layers will silence some
> bugs, whose root cause may be different.
>
> Besides doing the overlapping layers mount, this repro family also
> does extensive access to overlay underlying layers concurrently
> with overlay access and *that* is the root cause for most of these
> "possible deadlock" bugs (some false positives and some real).
>
> Assuming that ovl-check-overlap will get merged, you may need to
> hint syzkaller that overlapping layers is no longer a valid input or
> maybe it will figure it out on its own?...

Hi Amir,

It should figure it out on its own, it's coverage-guided fuzzer. And
unlearning things is easier then learning them :) But thanks for
thinking about this.
But maybe there is something else important in overlayfs that's not
covered. Here you can see the current coverage of overlayfs:
https://storage.googleapis.com/syzkaller/cover/ci-upstream-linux-next-kasan-gce-root.html#e2f448f0ca2e4397fd609ff8c42d4cd118411148
