Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D85CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4383A2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvhypy4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfJ2KZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:25:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43660 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfJ2KZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:25:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1so5534011wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Tn/VVMmRjmEpU72/PP+0DOD99ZkAIL+sJmfdc1SevY=;
        b=rvhypy4FIQfjiYeZ4plidaSIM4JrY4orvXUW6HjHg6kevotVv9VGQd4BgsRA7F11+R
         +8a+WkS1dWV8QQqPpCt2OjlK+kWDuoNnmgZAms8s/8q1qYY1jeJ3Qt4Z537cp4+rusfQ
         FSCMQ9/McSCpYXjFNnAbguHqwyZh16rPv3N4oWNEJdNHmJMvQ+acHezUpMSCDP4c1gX4
         ZCj9HeWg5SLFeph3IsZvumFAbxxoy7JOVIHrb+rqcav5TAlW+e/s/jEkduiy/6mAkNYt
         ReOJLrbIg0jaNMt5hwgB1PU1Ty404vy9KJ5Wkpgito8kUatOIAOxNm3YevOrrrDmRUUS
         M8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Tn/VVMmRjmEpU72/PP+0DOD99ZkAIL+sJmfdc1SevY=;
        b=hrnUoP6OJKeESKL7ykniFmvXheevP5iL61aR4LlyeDelbJMpsR7nBvEV8F70fgnmq1
         6om3kkY8mxYIcW+Og5Sxul+xwRI6MDZna6ZiW/yIrMrCPaIJczsD0iHWHn5YRMDb8xXO
         3zfu6hevWMP6+yZhzK1bpENEyXYhKRXksQeG+j+cXY4TJn1nKBSYDrnXRFOf+MfMzQLL
         U9BlDwgm3Dt4mep4SUOPC3PvwhRquequYcS+w4XJs1gt8TCdvCqZSEivLD3X3ODM7n/m
         uFT7Xc9ugoMYU0B5iEsVrCOLmrnRAB7Rje9+byaI5MeCQo2v8N/YNXoekyfSIzxcT/Fd
         EShA==
X-Gm-Message-State: APjAAAWEHSHkCEaproMtgnovRQjSxK8CUnftpDBNc3HFRz0b8PIdd9bi
        dtRvr3cl20tvxofI4zZl7QBzie9EuEN9ZgD4NBo=
X-Google-Smtp-Source: APXvYqyTfX+zvg5GKT7khe/58ghBg7R+IUnRQc+w+xUJytYgX47l/lQXueYYGK52tfE+KkQhPHHq510Fm6DAb3m3UXk=
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr18366035wru.4.1572344713587;
 Tue, 29 Oct 2019 03:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <1572339670-68694-1-git-send-email-chengzhihao1@huawei.com> <20191029092057.fsklsibqrmbmacar@pengutronix.de>
In-Reply-To: <20191029092057.fsklsibqrmbmacar@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 29 Oct 2019 11:25:01 +0100
Message-ID: <CAFLxGvw2UAXjz4uZ49gpxavBVjm7f8rT1agtmESsBkH70M-DaQ@mail.gmail.com>
Subject: Re: [PATCH] ubifs: do_kill_orphans: Fix a memory leak bug
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 10:21 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Tue, Oct 29, 2019 at 05:01:10PM +0800, Zhihao Cheng wrote:
> > If there are more than one valid snod on the sleb->nodes list,
> > do_kill_orphans will malloc ino more than once without releasing
> > previous ino's memory. Finally, it will trigger memory leak.
> >
> > Fixes: ee1438ce5dc4 ("ubifs: Check link count of inodes when...")
> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> > ---
> >  fs/ubifs/orphan.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
> > index 3b4b411..f211ed3 100644
> > --- a/fs/ubifs/orphan.c
> > +++ b/fs/ubifs/orphan.c
> > @@ -673,9 +673,11 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
> >               if (first)
> >                       first = 0;
> >
> > -             ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
> > -             if (!ino)
> > -                     return -ENOMEM;
> > +             if (!ino) {
> > +                     ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
> > +                     if (!ino)
> > +                             return -ENOMEM;
> > +             }
>
> This solves only part of the problem. There are several places in the
> loop that just return instead of jumping to out_free. These need to be
> fixed as well.
> I am not sure if it's worth it to allocate ino on demand. It would be
> more straight forward to allocate it once initially before the loop.
> Not sure though what Richard prefers.

Yeah, allocating it outside the loop once would be the best solution.
I don't know why I did it in the loop. ;-\

-- 
Thanks,
//richard
