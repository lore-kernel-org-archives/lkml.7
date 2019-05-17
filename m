Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D79C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44092082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCbydxhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfEQOIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:08:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39151 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbfEQOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:08:49 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so12175170itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnE5ugQSV+EX8NJq3bXAxc5+808EKDRQWDkjcFDm76g=;
        b=bCbydxhIRSNOt3TwDd4BdgsvwmO+IYfUOtPAEAjE2b/cMzWleRTqkn3UbY13DGYF1K
         x4yKjJrT6J8shR6+H2q3zQgZGYdC9a0WvJmPeCQ4S0ffoyFISZ2B0V76p9gorMUSQ6ER
         bRKXGBesi4Znrw/l7X+0AcOZOXjCjR7CaV4xUbio+/j3wXC0fnhOlLLnTQyxz5/dsx5U
         oSqt/pSv99S0Oftm7Z+LRef9zrwxu9hleDGUMXzjoDfyHveXTeVIn3F3wfTR3OL6TJGu
         082bIphpUtJ9LlQ5xRROlabqAeWGtZVRZrntcO9m/4dBEXkJ5cyyPS6SNomLQs8wNpZ8
         Xw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnE5ugQSV+EX8NJq3bXAxc5+808EKDRQWDkjcFDm76g=;
        b=EDas/L8YMVgiXAA+Fni5SzK1rhns0bTSY3fp33bUBi/lskJUDsCe0XOX8jakwKvA7k
         zMrECTz54eQDbjYh8n+A+4ztzZollNCa92q4J+/Fv70klbeyVbxFsJh/j7OY6JPiuX42
         0/9unRklfhCx9f+3XjyE6lDLRp/qrxUCxLuNJyTUbZsqxzWiCRFDWa0vHS2wHOQkw/sh
         IbkDh/jxOyp2CC/d5tOCAw0N/t8bvi0lidPeAyUpBCP2ID4unKNxb98HXwpuOOB0FUiY
         DXREfqIDnzERNupdxtWNO/bG4XNtIBJBaW4XjeZN4ZDfy4A+aJOLYgg+d5uXJ0xwmVwQ
         4ssQ==
X-Gm-Message-State: APjAAAUwXDa9mWBs+j3Nhg4lj+MScMXsluRS3msuWFF+YqkGXDFCfOg+
        y6wk5dbR7rdvvVi3levI7k3T9+vBMPswUend2SXe0w==
X-Google-Smtp-Source: APXvYqzuUfMi8lV0T0lwvRZljXNCxDfrTqM5N220cNATHJKTOwPJxnkJlmO1e5pjoYWFu4RheZnomcXVJ0T1qE6Tsfg=
X-Received: by 2002:a02:412:: with SMTP id 18mr1390107jab.82.1558102128480;
 Fri, 17 May 2019 07:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014285d05765bf72a@google.com> <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk>
In-Reply-To: <20190517134850.GG17978@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 May 2019 16:08:35 +0200
Message-ID: <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 3:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, May 17, 2019 at 03:17:02AM -0700, syzbot wrote:
> > This bug is marked as fixed by commit:
> > vfs: namespace: error pointer dereference in do_remount()
> > But I can't find it in any tested tree for more than 90 days.
> > Is it a correct commit? Please update it by replying:
> > #syz fix: exact-commit-title
> > Until then the bug is still considered open and
> > new crashes with the same signature are ignored.
>
> Could somebody explain how the following situation is supposed to
> be handled:
>
> 1) branch B1 with commits  C1, C2, C3, C4 is pushed out
> 2) C2 turns out to have a bug, which gets caught and fixed
> 3) fix is folded in and branch B2 with C1, C2', C3', C4' is
> pushed out.  The bug is not in it anymore.
> 4) B1 is left mouldering (or is entirely removed); B2 is
> eventually merged into other trees.
>
> This is normal and it appears to be problematic for syzbot.
> How to deal with that?  One thing I will *NOT* do in such
> situations is giving up on folding the fixes in.  Bisection
> hazards alone make that a bad idea.

linux-next creates a bit of a havoc.

The ideal way of handling this is including Tested-by: tag into C2'.
Reported-by: would work too, but people suggested that Reported-by: is
confusing in this situation because it suggests that the commit fixes
a bug in some previous commit. Technically, syzbot now accepts any
tag, so With-inputs-from:
syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com would work too.

At this point we obvious can't fix up C2'. For such cases syzbot
accepts #syz fix command to associate bugs with fixes. So replying
with "#syz fix: C2'-commit-title" should do.
