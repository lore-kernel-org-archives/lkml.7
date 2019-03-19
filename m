Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8664C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782E020857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmDAK/SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCSLxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:53:09 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53392 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCSLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:53:08 -0400
Received: by mail-it1-f195.google.com with SMTP id w85so1350194itc.3;
        Tue, 19 Mar 2019 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcafNnHHdbcpX/bRqQlKFp5EIosE0272N1uHCfgd0R0=;
        b=mmDAK/SRI8lgY1NqEbHt6Rl2tWWD6pka5LOCSRiej5FBpkijXDlw0sEo45MKGINagD
         BtlbWqwziNxe+9LOeMd5BWGVuKLeABAVPFxvL6J4BlPl7TDzN/3knKr/UcJYTu7O8nY7
         NNn4W4a/3FR1KvY7h3nmOABQRgqqTHwB1gKV9tNxvOIH2SckKDBnWLPvZ3FpjSpG4Rbq
         8fR+np/4rfTBhTNMhI3r4o4vfCO06fjPMIThF/NocJTPcY3RpgesA9stO1ZM4jpRjGhu
         4ohbMJK4iE6fvxkE+wqLmxqiIwGM08VFKWm3Op0E3hg6pW/HClCzSxY8krCVfHDHAaZT
         k4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcafNnHHdbcpX/bRqQlKFp5EIosE0272N1uHCfgd0R0=;
        b=CwxmuxOgREwBGt2za7pBM/snVvpp1TcYHg3okpM+f4ftzSItidLbhgn3O+uOlkdzgG
         woLzt/nSyXYzqs7e3LwUV935v5ZNuOWu8llXREJT4WoD+bGfaAJ/2PxmS/aOiR0Yv8G7
         iFkda3HsYiL0kQ0hYduM+ml75wVb+97YuaqgTuWakiQ/eTg/157PDN46JTUPnroiRVfD
         0MCpp5qOaVelpTX7TDYTPobeh1c4zWwPCpmO433YR6AdtNzkaknY7J7Fx+gd5sWuwDs6
         EUUQB2BA8ukF1yxZqjDW1wiHjSudJAPQSdphkHl+FXOQyG4sCMjlsB23i4SX0tIjXVuZ
         jnpw==
X-Gm-Message-State: APjAAAUVTVk8YJF9BBigMw7eA3hN8iZRfIhxrz7uyCxIe6O39pS2iTD5
        cZ8rfZA0pK18afA4ZI0haBuGqfgvAWfROtu/PXw=
X-Google-Smtp-Source: APXvYqxX2gIdPzY89M4pHKPi2yDJWHBBJ6cNtZY0gXKmdX+1Vx/NKbk8cvjp/qkmep88JpCRobLfuq+lIQZnp9my18Y=
X-Received: by 2002:a02:8a13:: with SMTP id j19mr1124991jak.21.1552996387501;
 Tue, 19 Mar 2019 04:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <1550928949-11879-1-git-send-email-laoar.shao@gmail.com> <20190319104030.GA20138@quack2.suse.cz>
In-Reply-To: <20190319104030.GA20138@quack2.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 19 Mar 2019 19:52:31 +0800
Message-ID: <CALOAHbAp5XSABEGU6dnvYWFzO179TtonhLjuXQ5xvt645HVaig@mail.gmail.com>
Subject: Re: [PATCH] writeback: expose cgroup info in trace_writeback_pages_written()
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 6:40 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 23-02-19 21:35:49, Yafang Shao wrote:
> > With cgroup v2 writeback, we can know these pages are written from which
> > cgroup.
> > So expose the cgroup_ino for better tracking.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Fine by me. You can add:
>
> Acked-by: Jan Kara <jack@suse.cz>
>

Thanks for your review :-)

>
> > ---
> >  fs/fs-writeback.c                | 4 ++--
> >  include/trace/events/writeback.h | 9 ++++++---
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 36855c1..e98a33e 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1973,7 +1973,7 @@ void wb_workfn(struct work_struct *work)
> >                */
> >               do {
> >                       pages_written = wb_do_writeback(wb);
> > -                     trace_writeback_pages_written(pages_written);
> > +                     trace_writeback_pages_written(wb, pages_written);
> >               } while (!list_empty(&wb->work_list));
> >       } else {
> >               /*
> > @@ -1983,7 +1983,7 @@ void wb_workfn(struct work_struct *work)
> >                */
> >               pages_written = writeback_inodes_wb(wb, 1024,
> >                                                   WB_REASON_FORKER_THREAD);
> > -             trace_writeback_pages_written(pages_written);
> > +             trace_writeback_pages_written(wb, pages_written);
> >       }
> >
> >       if (!list_empty(&wb->work_list))
> > diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> > index 32db72c..a806713 100644
> > --- a/include/trace/events/writeback.h
> > +++ b/include/trace/events/writeback.h
> > @@ -255,15 +255,18 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  DEFINE_WRITEBACK_WORK_EVENT(writeback_wait);
> >
> >  TRACE_EVENT(writeback_pages_written,
> > -     TP_PROTO(long pages_written),
> > -     TP_ARGS(pages_written),
> > +     TP_PROTO(struct bdi_writeback *wb, long pages_written),
> > +     TP_ARGS(wb, pages_written),
> >       TP_STRUCT__entry(
> >               __field(long,           pages)
> > +             __field(unsigned int,   cgroup_ino)
> >       ),
> >       TP_fast_assign(
> >               __entry->pages          = pages_written;
> > +             __entry->cgroup_ino     = __trace_wb_assign_cgroup(wb);
> >       ),
> > -     TP_printk("%ld", __entry->pages)
> > +     TP_printk("pages=%ld cgroup_ino=%u",
> > +                __entry->pages, __entry->cgroup_ino)
> >  );
> >
> >  DECLARE_EVENT_CLASS(writeback_class,
> > --
> > 1.8.3.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
