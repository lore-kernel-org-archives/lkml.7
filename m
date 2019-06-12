Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0B3215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="w5d1TU14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409538AbfFLR0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:26:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39935 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407690AbfFLR0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:26:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so15812161ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/wD0QJ9RiffS4UzglPccxwbPf6d8Ks2XdoeuHLmBXs=;
        b=w5d1TU14lrrj3HnnDDQnOEVkkcfWbBYc25cgBf5VCq3WlJPM/3lH8Dc2z7+CywYv91
         bitBEBToOHg/te9pzmS0UINedWbYyLD06OVQZYGI8XIAVcL3z1DNSkFA5+nuS+dgolja
         Trv4Nm9jbbqEcSLXVcnokHkneU4+vsAR4FEBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/wD0QJ9RiffS4UzglPccxwbPf6d8Ks2XdoeuHLmBXs=;
        b=M594tUIWvQmg5HwTfCTS2WEh3dekWqsYgmAEqu2+f2OGduT9wkl3QZYPSRnfYa6DRo
         xO2B2XtIA0tCdDTwV32UkEloYGMEjZPA67sDgCn2+q5dgTIQ+nFkui9+6B2nhuQVOfj4
         T6XrFL0NS7mbP/gnWXrbZdTj57RVRsSs5q74m5OvQ9Q0OPPCRppXj2vv/NOo6ri1CYB4
         BBflN+8QXzwWgcB6xmHuDaFDRxDRyUQuzOjsggumwjQvFv7EkOfC7MThcRBtLRZ9Lk8s
         +G6qU/V+8U3XOK8nKq+vc+IQjUhZB+yUiP5IhfUndcDTeBJGK7tbfhwYl+ztrUkbC0De
         DPmg==
X-Gm-Message-State: APjAAAUCyOiZaiRL3NgI385yRT6wXXb13v0crd4VNVpsRUmNKv9Iej5U
        8FVHreizY3Om99sKu9cGG6Pi+ISA6UbbsDQd5TM1fg==
X-Google-Smtp-Source: APXvYqxwBbbf2tchhGee7G+BUcoLVr9gIao9rlePNt1eVtRJzm0B8Rh8KeE9uvRZV56v3hZvGI+ucGuZ1HdNBOt6cYU=
X-Received: by 2002:a2e:50e:: with SMTP id 14mr25364375ljf.5.1560360410333;
 Wed, 12 Jun 2019 10:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190612153513.GA21082@kroah.com> <20190612165819.GA123863@google.com>
 <20190612171026.GB6986@kroah.com>
In-Reply-To: <20190612171026.GB6986@kroah.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 12 Jun 2019 13:26:38 -0400
Message-ID: <CAEXW_YRyUc6Wavf8CrQtVZ4izkEQei4XDqu4BYfJDCAt+YG1bg@mail.gmail.com>
Subject: Re: [PATCH] lib: debugobjects: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qian Cai <cai@gmx.us>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Zhong Jiang <zhongjiang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 1:10 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 12, 2019 at 12:58:19PM -0400, Joel Fernandes wrote:
> > On Wed, Jun 12, 2019 at 05:35:13PM +0200, Greg Kroah-Hartman wrote:
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > >
> > > Cc: Qian Cai <cai@gmx.us>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > Cc: Zhong Jiang <zhongjiang@huawei.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  lib/debugobjects.c | 14 ++------------
> > >  1 file changed, 2 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> > > index 55437fd5128b..2ac42286cd08 100644
> > > --- a/lib/debugobjects.c
> > > +++ b/lib/debugobjects.c
> > > @@ -850,26 +850,16 @@ static const struct file_operations debug_stats_fops = {
> > >
> > >  static int __init debug_objects_init_debugfs(void)
> > >  {
> > > -   struct dentry *dbgdir, *dbgstats;
> > > +   struct dentry *dbgdir;
> > >
> > >     if (!debug_objects_enabled)
> > >             return 0;
> > >
> > >     dbgdir = debugfs_create_dir("debug_objects", NULL);
> > > -   if (!dbgdir)
> > > -           return -ENOMEM;
> > >
> > > -   dbgstats = debugfs_create_file("stats", 0444, dbgdir, NULL,
> > > -                                  &debug_stats_fops);
> > > -   if (!dbgstats)
> > > -           goto err;
> > > +   debugfs_create_file("stats", 0444, dbgdir, NULL, &debug_stats_fops);
> >
> >
> > One weirdness is, if dbgdir is ever NULL, then debugfs_create_file() may end
> > up creating the stats file in the root.
>
> Yes, but dbgdir can not be NULL.

Makes sense, thanks for clarification,

- Joel
