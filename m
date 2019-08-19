Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A738C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6160120989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfHSJiJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:38:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSJiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:38:09 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 368362EF169
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:38:09 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id 100so1981672oty.18
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 02:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=60rRVige5JMKARBYqg7mGnVhhfClBN8pbmqimK57PFo=;
        b=nh9mwUa3aBb/Xuu3qb9uGwnAQcYCZQ76W6WgSzyAQVIlfzqJOyV1IezI5/hM9OAaog
         Fn/2oowwLXzc8oVnYRy2QvljiAQLb6JFkL5WbyUrI36vdlAo7/3rVe/b1ApKyJZN0TRX
         hclTx6PvbTLEXGRtcpL2APX/YtoPmq4CoLoWBy4OQbU/ZR4R9fKA8YDbkDwuSupJ3wxF
         MNWZXCNFPEvYJzmGVjgJLYKtQl8A5rQQMuTewg/z79eJgSFBQGjgNAMPmChdKtMHGM9B
         z2hd8lJSVRcs1tfx4v2EScIPxAZO1sT8VMSX5tUWxUDM3jXkPBV6PGYRpZ+yNqvgUMu/
         vpUQ==
X-Gm-Message-State: APjAAAWwPBz6MVRfbuuSA6I/bZYIcPIefHrsjyHytrrK5/gdklALBpjc
        y+6KQUI2zZE9tzyXMV2QqVjj5kuwpntWBkIRhJALh79xGosVcqTWb4QYuJVY6Wchf9zX3YIbCU7
        uX073mhsz2xIY7ZW5JB+GLrwuAhVDvSM28UWgvkkA
X-Received: by 2002:a05:6830:22f4:: with SMTP id t20mr16486571otc.58.1566207488755;
        Mon, 19 Aug 2019 02:38:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyu7VWpm/ykQLhkCx5IuTRbTXVXAVHJxIU8g8KdVoHhsAoxNxwhFjKCfa+WWEcSsyKU+NovpXcf+CMXuqXBX3c=
X-Received: by 2002:a05:6830:22f4:: with SMTP id t20mr16486561otc.58.1566207488604;
 Mon, 19 Aug 2019 02:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-4-arnd@arndb.de>
 <CAHc6FU5n9rBZuH=chOdmGCwyrX-B-Euq8oFrnu3UHHKSm5A5gQ@mail.gmail.com>
 <CAK8P3a3kiyytayaSs2LB=deK0OMs42Ayn4VErhjL6eM3FTGtpw@mail.gmail.com>
 <CAHpGcMJ2EScNiPapyugC_fz+AEhdpKmx3VmYjTH_2me8WLxB2A@mail.gmail.com> <CAK8P3a3iOnsW43qt9yjD8Tyv800svBZF8ZEnqvk-F56vv5yqtw@mail.gmail.com>
In-Reply-To: <CAK8P3a3iOnsW43qt9yjD8Tyv800svBZF8ZEnqvk-F56vv5yqtw@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 19 Aug 2019 11:37:57 +0200
Message-ID: <CAHc6FU77RO3YJgc3mVoRtec6Gmb=TYY46zL3BFennxDUfogm0A@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] gfs2: add compat_ioctl support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Aug 18, 2019 at 10:17 PM Andreas Grünbacher
> <andreas.gruenbacher@gmail.com> wrote:
> > Am So., 18. Aug. 2019 um 21:32 Uhr schrieb Arnd Bergmann <arnd@arndb.de>:
> > > On Fri, Aug 16, 2019 at 7:32 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > > On Wed, Aug 14, 2019 at 10:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > +       /* These are just misnamed, they actually get/put from/to user an int */
> > > > > +       switch(cmd) {
> > > > > +       case FS_IOC32_GETFLAGS:
> > > > > +               cmd = FS_IOC_GETFLAGS;
> > > > > +               break;
> > > > > +       case FS_IOC32_SETFLAGS:
> > > > > +               cmd = FS_IOC_SETFLAGS;
> > > > > +               break;
> > > >
> > > > I'd like the code to be more explicit here:
> > > >
> > > >         case FITRIM:
> > > >         case FS_IOC_GETFSLABEL:
> > > >               break;
> > > >         default:
> > > >               return -ENOIOCTLCMD;
> > >
> > > I've looked at it again: if we do this, the function actually becomes
> > > longer than the native gfs2_ioctl(). Should we just make a full copy then?
> >
> > I don't think the length of gfs2_compat_ioctl is really an issue as
> > long as the function is that simple.
>
> True. The most important goal should just be to make it easy to
> add the correct handler the next time another command is added
> to the ioctl function.
>
> Just let me know which version you want for that:
>
> 1. my original patch
> 2. the version from your reply

That one, please.

> 3. my version below with compat_ptr() added
> 4. ...
>
> > > static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd,
> > > unsigned long arg)
> > > {
> > >         switch(cmd) {
> > >         case FS_IOC32_GETFLAGS:
> > >                 return gfs2_get_flags(filp, (u32 __user *)arg);
> > >         case FS_IOC32_SETFLAGS:
> > >                 return gfs2_set_flags(filp, (u32 __user *)arg);
> > >         case FITRIM:
> > >                 return gfs2_fitrim(filp, (void __user *)arg);
> > >         case FS_IOC_GETFSLABEL:
> > >                 return gfs2_getlabel(filp, (char __user *)arg);
> > >         }
> > >
> > >         return -ENOTTY;
> > > }
> >
> > Don't we still need the compat_ptr conversion? That seems to be the
> > main point of having a compat_ioctl operation.
>
> Right, of course. Fixed now in my tree.
>
>          Arnd

Thanks,
Andreas
