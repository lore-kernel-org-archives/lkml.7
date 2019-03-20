Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3064213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UywNX07N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfCTQlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:41:14 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51165 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCTQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:41:13 -0400
Received: by mail-it1-f194.google.com with SMTP id m137so16943157ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcz2X3rYB5zZtDIi8EJT+BJ0Pk5ZKo4YGjuBqA9GmJA=;
        b=UywNX07NpIqXq9KKOTUtnJBxgsz+VWQ1iZnqnL/XEgvyDEaL2niy0l592t0EmSt2DT
         zg/1H2jU2pv32VdKmNwfNDzLVI+Px8KW6PY1+gIHG1QQ8hcL0eUKhi/ULi3ImZSIn5Z9
         HNrJFpzt4e6M+ri/sPGbREenPyL8OJsIrEkG2qNYmbjM6LIU+SfgihL3/NiZ+9lP9Oyr
         iLLGa3H93rZ+ddSIr5ZfdDAcr+GAdJXIPAsPzIVWF2WumwYU2U3Q6ksaWjiPU0/u+ewY
         OosrNPKlHipbtGoMQogz8RM3z725uT1GyqgBUs8QFqpeQlwWxmslwFlr32afZLrU3xmh
         414Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcz2X3rYB5zZtDIi8EJT+BJ0Pk5ZKo4YGjuBqA9GmJA=;
        b=HbqV5nscsDeOcWpVZKc+5HbpQTPgOX2bMeCT2G7W2EfdLjaqT38Nbo0HOi/JdKqy9o
         3uEqLfo2YaB+b8AwWXkF7QFfV2kYz1jr7SaaN7bcacxM+SqqngJrlCCCmoUSbqmIOYhN
         Wts+8fd8jcDhgsGbwtEjnudj2o6HBh0HkPEz4LoToWN3vFLZCIcHf/gpa3LsxHE5TM40
         0OnzgY/2xH2cqC0YZjDmQis0tT0M1ztmBdKdpjURysQMr3s1ZzS4ScZ6MB5WpYJ4earA
         lu1TvhAJwDVCR4ExrvYZzfYgUYT3iqV1zFC5Zz2+XdNViaQouTXJrNhX3HZuNyI7VEU/
         3zag==
X-Gm-Message-State: APjAAAX8DVuGtpI2oHESoaTQi1CUm17mlQYejYgTYX9BjjnsxAuhZmn7
        tH4lCaXoJBThu3IoIxzf65AQ7r+NSHtYEaFy1lRV+Q==
X-Google-Smtp-Source: APXvYqx/GCS2GW6b16PQG8tu9E3hqQL567rBNhBjPN1d4PXV+UqVzJrG8Zct5d+XMxGH1ypx2deNBcGYqi1BKnuBffQ=
X-Received: by 2002:a24:3281:: with SMTP id j123mr2010716ita.166.1553100072185;
 Wed, 20 Mar 2019 09:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dbe73a057cd65da2@google.com> <00000000000010f4270584595484@google.com>
 <BL0PR1501MB20039998B662DCC11E2B38D79A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
In-Reply-To: <BL0PR1501MB20039998B662DCC11E2B38D79A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Mar 2019 17:41:01 +0100
Message-ID: <CACT4Y+anbSEh89LaFeT2Bi4qVM1Maf_0x11ynrfCk9PNvg9UXw@mail.gmail.com>
Subject: Re: general protection fault in fib6_purge_rt
To:     Jon Maloy <jon.maloy@ericsson.com>
Cc:     syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>,
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

On Wed, Mar 20, 2019 at 4:59 PM Jon Maloy <jon.maloy@ericsson.com> wrote:
>
> This one identifies the same culprit as syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com, but points to a different bug.
> That bug has also been fixed, in commit adba75be0d23  ("tipc: fix lockdep warning when reinitilaizing sockets"), applied in 4.20 but not present in 4.16, - the source of the dump.
> Once again, a dump from 4.20/5.0 might be a help.


Looking at the bisection log maybe this reproducer triggers multiple
kernel bugs.
All crashes including the latest ones and other info are always
available on the dashboard.


> ///jon
>
>
> > -----Original Message-----
> > From: syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>
> > Sent: 18-Mar-19 08:28
> > To: davem@davemloft.net; Jon Maloy <jon.maloy@ericsson.com>;
> > kuznet@ms2.inr.ac.ru; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com; tipc-
> > discussion@lists.sourceforge.net; ying.xue@windriver.com; yoshfuji@linux-
> > ipv6.org
> > Subject: Re: general protection fault in fib6_purge_rt
> >
> > syzbot has bisected this bug to:
> >
> > commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
> > Author: Jon Maloy <jon.maloy@ericsson.com>
> > Date:   Thu Mar 22 19:42:52 2018 +0000
> >
> >      tipc: obtain node identity from interface by default
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1116d2a3200000
> > start commit:   52dfae5c tipc: obtain node identity from interface by defa..
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1316d2a3200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1516d2a3200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8b6073d992e8217
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=a25307ad099309f1c2b9
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b2c56f200000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b8890b200000
> >
> > Reported-by: syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com
> > Fixes: 52dfae5c ("tipc: obtain node identity from interface by default")
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/BL0PR1501MB20039998B662DCC11E2B38D79A410%40BL0PR1501MB2003.namprd15.prod.outlook.com.
> For more options, visit https://groups.google.com/d/optout.
