Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D8B20665
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obLTwYgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391182AbfISPTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:19:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35311 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388706AbfISPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:19:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id y10so458619plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIx6RSMcBx+AkpCbzjzq7BE2iXvqoNefszXIBP0DlaU=;
        b=obLTwYgu2ct6C15EVBrPLKx2xA1kewtCk+U74Njt7jA+dfkH2VFSEpjuc1dx+MsPWx
         o6kLi2E0YBHvu0lQrHy1eHY6ZXjvmjpKStHgK16A5b9tx7jM9509QmrevE1y/rcX1hoQ
         OZ8YTj/bDtP7rbvwtycofFZ6nd1E5suzksPx1StXaH3hwH2GTn8ZEhfYlXl0xyf1YYE0
         AO5oKPuXXA3D2nDB8T4qG9ElDsCItYCUtNjkWGZSQ+E9GWH5JYkDJ6UCKY/cqb65JdmY
         r4hBXoIqEV8HwCBJfOmMkBA5jTjoEc0TWMpy+mLOIL/h26k5uGiJfasSqhIUEk2rz+79
         tNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIx6RSMcBx+AkpCbzjzq7BE2iXvqoNefszXIBP0DlaU=;
        b=QespbRnd//fnfnwFhwjAS73wH8rm5Y5Vmqn/G1oNApaNIc4E7ci1pVGArD/YQV3EUG
         WF2YVXPHdAkfOgiSY+XylhT28q4rVRvtKsduTowdBqqT+Rwz1klAIzzWYI2J06ut8+si
         7AFv0zuimZML1ZrvzZlbAsamlh0g4m2f4nLAP2fFmXsLJ1GQupLPX5agOn3HGFqC2xgO
         OQE//ngLhYLWey6lzCCDZ2+aAN7R+kP9pG/AB696EHlNJUpZXrGlELTa9sG1MbuVw3+5
         72JrkbQayDd1loAXf5DQQsYwoA9NFlBH7T0RZ17ndK/DICXkrBcNDjOZv/ppKHurh6sX
         A73g==
X-Gm-Message-State: APjAAAWsQ3Q7mYLohNu06xSr57uqjZ3gTsRJL6nfawnUd0a6MJCg8c5R
        h1RCA5TAXOh6M1B5tC2xVAvx7G2lpKpdsjbnFmmI+g==
X-Google-Smtp-Source: APXvYqyiDWT+CRfk1TTP/9assNZVatUd4spJEhVcFXVa6XgsJHQVrDSX/rZS90PdEOTkSyC/w0c3pcRCV31KmmTzUPA=
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr10346338plq.336.1568906363888;
 Thu, 19 Sep 2019 08:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000001595b0592c41731@google.com> <Pine.LNX.4.44L0.1909181454300.1507-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909181454300.1507-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 19 Sep 2019 17:19:12 +0200
Message-ID: <CAAeHK+xcJjE_+U7tTs76CkV1v95r8J+eKXhMj00iyrHA2cxGmA@mail.gmail.com>
Subject: Re: general protection fault in usb_set_interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, mans@mansr.com,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 8:57 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 17 Sep 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer still triggered
> > crash:
> > WARNING in sysfs_remove_group
> >
> > ------------[ cut here ]------------
> > sysfs group 'power' not found for kobject 'radio0'
>
> Andrey:
>
> Is there any way to tell syzbot to run the reproducer but with only one
> device instance (that is, only one dummy-hcd bus)?
>
> Or can you a new, modified reproducer that will do this?

AFAIU there two bugs here and you've fixed the first one, but the
second one gets triggered.

I think the second one got reported separately here:

https://syzkaller.appspot.com/bug?extid=5b9bba68c833c84a1135

That one has a reproducer with a single dummy-hcd, so you can try
running your debugging patch against that report.

I'll see if I can run it manually in the meantime.
