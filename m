Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D3FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847C32173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BurrVXPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEINBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:01:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43289 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEINBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:01:48 -0400
Received: by mail-io1-f66.google.com with SMTP id v7so1504585iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVx7ZoW5hiGrgUVoRycI1AsV20RlQNkbPPM427dqnNY=;
        b=BurrVXPKDJWGamfAcikJ+exlkR0IQkubcyg1vpSZCwjgF3pbzzvL6Q8D3b2+HG8l9x
         sKIws5nNnFOyoQU2CaLtmyJcYCDI5i9G1UyyRbhInThBu1DC1RbF5jopRm6vbqr08VdS
         L0mDxm+xSM2o1nQ7M1m+na6LrLoGDzZLrOHWh6woW5byBb+xJrnGXAhBBxuYFQSL+Mhb
         ZcmTdiaOk4gkNG0j95CXnypMaVHTbeglMvrxkzwR7eHXCgUBN6XkQMQg6eQMXgJUtTcE
         NkfCLKvWXqeOpRxi7rDVWLYbJBjqeie/uKPo5WDpJsNDVMrHLLZvI+ZgK2lah4k6y9ag
         X6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVx7ZoW5hiGrgUVoRycI1AsV20RlQNkbPPM427dqnNY=;
        b=KGX1QKyAurdbcg1RwHjY5zo+jTSsI2Nv2axl/jNs2HlWa+i/IQAXmYxUNVa56VcJaZ
         bgZy/e3SAMA6c119Ok0Y+K7G1Ls7uqopwinUStl2Isj7H8IXE0KjTHUY/Dj6nIfknt2K
         sK4wjNgRUcnc32lsw62jXn5RAhrZ4kLG6g9tDT6hbLYA38tDc2q3cPc1HyNb8zyl/B4/
         GAbD9hbTqJKLBQ/ZlSdDYPKJqsE+E5E/rVlemrdQJciiC/ItTSzpzS505fJFjsokp9sJ
         60c1XnXUJfVJWK9jMyCP/U1Zs2ZNdFu+7NThg4O+ciidajastyxKT1Wr0/Q7oPHiIyA0
         GkHQ==
X-Gm-Message-State: APjAAAXvULkUnC4Gu32RBwKUsPxzMYC7ZMXy8BGJ0nYTr3N1jBpdA1NS
        KnuPLTI5i42YkTsa1X6XNu2T7eE03CJUFeMpdzu5dw==
X-Google-Smtp-Source: APXvYqxUuiBLctRM7HeT7BpLXNkcpVG5z/yekVPem8+j0eMDpqkFGqrhfxcubw3nDGgcOF5RhAMdHH+Zis/USw9PiwM=
X-Received: by 2002:a5e:d60f:: with SMTP id w15mr2152398iom.282.1557406907069;
 Thu, 09 May 2019 06:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bc227a0582464e62@google.com> <0000000000003d44980584c6c82a@google.com>
 <BL0PR1501MB20033F21FB21816CC2F50AA49A5E0@BL0PR1501MB2003.namprd15.prod.outlook.com>
In-Reply-To: <BL0PR1501MB20033F21FB21816CC2F50AA49A5E0@BL0PR1501MB2003.namprd15.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 May 2019 15:01:36 +0200
Message-ID: <CACT4Y+aYfsTVCo3U9VJcQ2X0456FPtTH+2Sqd_J93CXrqvQhkg@mail.gmail.com>
Subject: Re: WARNING: locking bug in icmp_send
To:     Jon Maloy <jon.maloy@ericsson.com>
Cc:     syzbot <syzbot+ba21d65f55b562432c58@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maloy <jon.maloy@ericsson.com>
Date: Mon, Mar 25, 2019 at 5:34 PM
To: syzbot, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
syzkaller-bugs@googlegroups.com,
tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
yoshfuji@linux-ipv6.org

> Yet another duplicate of  syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com
>
> A fix has been posted.
>
> ///jon

Let's close this too:

#syz fix: tipc: change to check tipc_own_id to return in tipc_net_stop

> > -----Original Message-----
> > From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org>
> > On Behalf Of syzbot
> > Sent: 23-Mar-19 19:03
> > To: davem@davemloft.net; Jon Maloy <jon.maloy@ericsson.com>;
> > kuznet@ms2.inr.ac.ru; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com; tipc-
> > discussion@lists.sourceforge.net; ying.xue@windriver.com; yoshfuji@linux-
> > ipv6.org
> > Subject: Re: WARNING: locking bug in icmp_send
> >
> > syzbot has bisected this bug to:
> >
> > commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
> > Author: Jon Maloy <jon.maloy@ericsson.com>
> > Date:   Thu Mar 22 19:42:52 2018 +0000
> >
> >      tipc: obtain node identity from interface by default
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b6dc5d200000
> > start commit:   b5372fe5 exec: load_script: Do not exec truncated interpre..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=13b6dc5d200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15b6dc5d200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=ba21d65f55b562432c58
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c90fa7400000
> >
> > Reported-by: syzbot+ba21d65f55b562432c58@syzkaller.appspotmail.com
> > Fixes: 52dfae5c85a4 ("tipc: obtain node identity from interface by default")
> >
> > For information about bisection process see:
> > https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/BL0PR1501MB20033F21FB21816CC2F50AA49A5E0%40BL0PR1501MB2003.namprd15.prod.outlook.com.
> For more options, visit https://groups.google.com/d/optout.
