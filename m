Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5447C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9AD218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohI59Hp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCPO6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:58:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34514 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfCPO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:58:00 -0400
Received: by mail-it1-f194.google.com with SMTP id l4so5947924ite.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqNuOcONm2jWu25it3fsvccpcGtkuXyVvZc3t7gminQ=;
        b=ohI59Hp9Xqa9mZzWhUUzp3wgphcKvo9b9v66irOMPpbSsgxHUK5yltufRlP769NHeS
         W0YOFcg5prs3MHdeMkRRKYSmmOwrKh1E90A3wJpM3UZh4jJ8bCtBY6TyEkVecLZEoVhG
         MUvCoAA0SExDiczWmtnECWHl+PYHsAFoSWcr7FaqWYLmixKRoqPjUQ/NO4TSk0p3LkrS
         gn3jy3pF0nKdMQxW7mqpE5XNoEgjShUptqOmW2p3GAtVBGZVu7kIblVJisCURB4Yc+1I
         ahVhGbf3lEEj5s3N+U1U+YbKdlPgNz2CBb8xUHrJuxzW59aHvYQvIot4+sVGZgekr/XQ
         tynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqNuOcONm2jWu25it3fsvccpcGtkuXyVvZc3t7gminQ=;
        b=ffqh/Eu4xYMH4/1F6vi9yo+WhkSrx80AQbt4gPAAhCGPRHNq+PSefbjk2U0E7RgZBm
         YMhdvMj8ZPi0meWf/+UIrhW69meSQWvCRd5bZLK2s4GKGTi5jwKKQDrnUELeVdxDp0BQ
         /0ydel/D6jLdh05u7ckpw79v4me17tZjExBmjoKZCMlgr+YEC3WScqhhP6SrlwZMUg7S
         83b45eYlvk/n2QT6ZYQ/Gk+bpw+qQrK8PKneLkS+/iPqoMdIWUJRqD0IiWXDrtDmLNxU
         JDJqZlGQmyfM+QgVFS3vewNASTIHJr+UEekLZqFUj0vSfzqDdnOBQ93hNsE3r7XPm5cH
         Bwxg==
X-Gm-Message-State: APjAAAVR6zvflUZKDThQzzsFOeBZNQyt22x2z/rrNDnhbEXkxS5LrrD+
        BJlyqWGYYENpvAi+mtx+tY/mFLb4c4feDQ7GIJM4+g==
X-Google-Smtp-Source: APXvYqzPOP2gOOc5DBV9XuzuV2a193mEHyb528qgbNc3Bp2i3MBfGzuYoxuk7o/48MumZcUSZcljDgINrFTYeIRh34Y=
X-Received: by 2002:a02:94a1:: with SMTP id x30mr5818458jah.82.1552748279613;
 Sat, 16 Mar 2019 07:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
 <CACT4Y+ZBpfLpk0FRp7O8Ut=mmf-uddK_fLMDHtPkf6FnMGMqPA@mail.gmail.com>
 <f015f007-2402-27a0-1694-93b1bcffe84b@i-love.sakura.ne.jp>
 <20190316141410.GA18654@tigerII.localdomain> <CACT4Y+YEx5PF7QqaLdYpkyBCr_eBgp1n2yuY2LyrN9iZANXgzQ@mail.gmail.com>
 <647012f4-c221-addf-51ab-586014e8f435@i-love.sakura.ne.jp>
In-Reply-To: <647012f4-c221-addf-51ab-586014e8f435@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 16 Mar 2019 15:57:48 +0100
Message-ID: <CACT4Y+Zg4RVbV=ePRYff9BbpqAg0bOUS79Os5kzQXF39z_KSLw@mail.gmail.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 3:53 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/16 23:16, Dmitry Vyukov wrote:
> >>> Maybe try running with "ignore_loglevel" kernel command line option added?
> >>
> >> Right, that's something I would expect 0-day and syzkaller to do.
> >
> > to double-check: enabling this won't lead to verbose/debug level of logging?
> >
>
> I don't know what "verbose/debug level" means. But enabling this option causes
> KERN_{EMERG,ALERT,CRIT,ERR,WARNING,NOTICE,INFO,DEBUG} be printed equally.
>
>   "ignore loglevel setting (prints all kernel messages to the console)"
>
> static bool suppress_message_printing(int level)
> {
>         return (level >= console_loglevel && !ignore_loglevel);
> }

Then I don't think it's suitable: there will be too much output.
