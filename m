Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4E4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2977C21903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEwSdhqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCPOOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:14:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37315 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfCPOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:14:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so8387632pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iqSv3VwnLzmUHJiY0agWx/Nu4MIVi/KllnQytijL1sA=;
        b=sEwSdhqcWBnBdue9yoCAG8iy9LoqbGzhrJZyOXZDEyL0dCzFBPk51I5xld/wKLMvNU
         DuY6RKuhnwcnhjQWpKODUN8paX1O+xp8OavRy8X20VMA8b1Q+egEM5IogkOSY/9GrdC0
         ltrBJOG0eSVYb7arN9NxMfa9QQNQbxgQF8wQ7p/OVVrdbW/5X28bxlQoDofn5Yk0Pf/T
         CoevqKMI8hDO5XxEAuBuyTiAjLElk0S8xno84AOg/9psHHK/0h50bZDUUACIMTzlUB06
         F45M9uquIiEg5hMOEYZbdcTfiKPkmSGi4+576zLzCmqNEVRURLj7Ska40y8ksUsPur06
         DwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iqSv3VwnLzmUHJiY0agWx/Nu4MIVi/KllnQytijL1sA=;
        b=VMYkVyP56sRqnaUqc1z3Gle774WY0jinQOCDOaUrEIaNb1keYwLXElu4duKh0Cvfy1
         cmvu6UWg2kyGe9vKqbkNjF8JJYuIPfXHmABSvfLmctHtBv2BivK1Js4L/blEUC9Ed9lX
         PJk3C/y6FXklV/2Sz5jEgh1A37kmeBoApSCdim9MkaSfnd9Cds98pMOX0Xr30SxcWhOz
         26sWPfoRPMPawx7guknT/JeezxGTJ4rzm1cWtFCuYAr86pOMyQ6enAx3HyV9spI0cLT7
         A7OCE+TTv7XENscvBLQBebpvGcMrEHxEobyC2lXiA3u5FzgnXTrk0GBcom5uMrdluFR+
         b1Cw==
X-Gm-Message-State: APjAAAWBO8u46ruGw1ZaIQWV45+sOmF0QZzNwdf6Gdqz+TU7rYk7tMVm
        jbRXcw9Y+NC8h6yofGDOksA=
X-Google-Smtp-Source: APXvYqyrcR+RSB9zCTyOO8OTYON9M50iwxPHDr0JXvaRH54yTiVL7/JTqbsu3wCJYCSvavJrEnzGcw==
X-Received: by 2002:aa7:885a:: with SMTP id k26mr9622649pfo.70.1552745655023;
        Sat, 16 Mar 2019 07:14:15 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id z6sm6147159pgp.8.2019.03.16.07.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 07:14:13 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 Mar 2019 23:14:10 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
Message-ID: <20190316141410.GA18654@tigerII.localdomain>
References: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
 <CACT4Y+ZBpfLpk0FRp7O8Ut=mmf-uddK_fLMDHtPkf6FnMGMqPA@mail.gmail.com>
 <f015f007-2402-27a0-1694-93b1bcffe84b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f015f007-2402-27a0-1694-93b1bcffe84b@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/16/19 19:18), Tetsuo Handa wrote:
> On 2019/03/16 18:11, Dmitry Vyukov wrote:
> > Such reports showed up always with low frequency. For all that I
> > looked at we also always had a normal  non-truncated version, so I was
> > never too worried.
> > 
> > If something would write from userspace, that would show up in the
> > output, or not?
> > 
> > Perhaps syzkaller somehow manages to lower console output level?
> 
> panic() calls console_verbose() before calling
> 
>   pr_emerg("Kernel panic - not syncing: %s\n", buf);
> 
> line. Then, someone might have changed console_loglevel enough to
> suppress printk() output.

Hmm... sysctl, may be?

> > I figured out that we should restrict it from doing
> > syslog(SYSLOG_ACTION_CONSOLE_OFF). And I also restricted its access o
> > /dev/console. But maybe there is something else? It _should_ not be
> > able to write to random sysctl's.
> 
> Maybe try running with "ignore_loglevel" kernel command line option added?

Right, that's something I would expect 0-day and syzkaller to do.

	-ss
