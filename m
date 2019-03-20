Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA72CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634712146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZgU3UPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfCTQgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:36:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43975 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfCTQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:36:25 -0400
Received: by mail-io1-f66.google.com with SMTP id x3so2551611iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zK3m59msUd5J1Vw+pk52gVloL+TG4hs6bcJfMxyuJZY=;
        b=dZgU3UPYjSNNcZoNoLZ/CMz66RqNDd+/qOMfG4TnOPdKAOAMmVkXvYgs7Kn2c08rgB
         1xZdZxLESA8ATmCYVJ0ZPRxrjoFF68pkRq/gWLopA19n6wjnI89UNXClOYiWcF3TcKjf
         UeSU5x266DmfZPVQe+4U/D0ZD9ep1qoz4uz5TbBuKNrOVEhH2ngVZL9q2QII2RD78Bzn
         d/IROCgNzsu1AEdnnoJExZo4CHW/xeJfjAkqyzSOfVXL+8RMehM8ztF3wLXMB1tdOKsj
         UIYRCes0s8FUC38zeLcEHVacH4APrkkrF7mcYjC0dWYIm4sHe3OZs+2fWdrbeupVukr/
         rK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zK3m59msUd5J1Vw+pk52gVloL+TG4hs6bcJfMxyuJZY=;
        b=JYjHPM59+vJIcWr7zLRUsNhtrE7P86qw0vYlIiDSubE+92i610gAx8OGFUxGJD0k1/
         542JigAqqUtZknBNoUYLBz6IjUSq49VkvATINEjzevE88JzmMASw2SyxJqpM1FjcoK7V
         K+iF6TleEyOX7oqqbCtg8ghxKKNcZn7bcV8AS/zJuIIw3SeMNk+YTH9XNMcrkobYelAA
         Vca1Dx2fZbWHY6n8ZygUHIYRjL/kgDJtMS1NGN+MD3XnBR+TkeZ0Oom91tuBjpoJcXqQ
         92GKl7U5duyQlBKq3iabgjVrBai/GBcUbMBgBSXvKZ1p+podfzqjAI70/8xbBzCEPG6d
         FqFg==
X-Gm-Message-State: APjAAAUwzuaQ4uBqSYajk+k6f3R4amDmSEWsH/RDdAU7a2H9K0jDxRVX
        LLmjv0Hhs+NxxLQf2EDa3TsCpr3glOoc4Vg3hmFMxA==
X-Google-Smtp-Source: APXvYqxx3SnpTVZLFEMPfmZ32mEwDm3eFQ8/TslX+dWqOO16nUKmZbp5Kd23Qqrm83ywlf/h/JJml+IYWXb0xTkDPG8=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr5723526ior.271.1553099784226;
 Wed, 20 Mar 2019 09:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000352b7e057cc0a13f@google.com> <00000000000060a659058475c57e@google.com>
 <BL0PR1501MB200344EF36F7E6EFCE435F4E9A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
In-Reply-To: <BL0PR1501MB200344EF36F7E6EFCE435F4E9A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Mar 2019 17:36:11 +0100
Message-ID: <CACT4Y+Zrr6AHWh6+ULMoY_Vrpkb0yAjO0nBd-C-=iiYsSWwVEg@mail.gmail.com>
Subject: Re: general protection fault in dst_dev_put (2)
To:     Jon Maloy <jon.maloy@ericsson.com>
Cc:     syzbot <syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@gmail.com" <dsahern@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pablo@netfilter.org" <pablo@netfilter.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 4:43 PM Jon Maloy <jon.maloy@ericsson.com> wrote:
>
> This one points to a bug that was fixed in commit dc4501ff2875 ("tipc: fix a double free in tipc_enable_bearer()").
> That commit was applied to 4.20, but is not present in 4.16, which caused this dump.
> To get further with this I need a dump of the actual crash in 4.20 or 5.0.
> Maybe we are looking at two different problems here?

Hi Jon,

The latest crashes are available on the syzbot dashboard (see dashbolard link).

>
> ///jon
>
>
>
> > -----Original Message-----
> > From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org>
> > On Behalf Of syzbot
> > Sent: 19-Mar-19 18:24
> > To: davem@davemloft.net; dsahern@gmail.com; Jon Maloy
> > <jon.maloy@ericsson.com>; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; pablo@netfilter.org; syzkaller-
> > bugs@googlegroups.com; tipc-discussion@lists.sourceforge.net;
> > ying.xue@windriver.com
> > Subject: Re: general protection fault in dst_dev_put (2)
> >
> > syzbot has bisected this bug to:
> >
> > commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
> > Author: Jon Maloy <jon.maloy@ericsson.com>
> > Date:   Thu Mar 22 19:42:52 2018 +0000
> >
> >      tipc: obtain node identity from interface by default
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1631fc2b200000
> > start commit:   52dfae5c tipc: obtain node identity from interface by defa..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1531fc2b200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1131fc2b200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=9d4c12bfd45a58738d0a
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17254878c00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171ca5df400000
> >
> > Reported-by: syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com
> > Fixes: 52dfae5c ("tipc: obtain node identity from interface by default")
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/BL0PR1501MB200344EF36F7E6EFCE435F4E9A410%40BL0PR1501MB2003.namprd15.prod.outlook.com.
> For more options, visit https://groups.google.com/d/optout.
