Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6D4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE2D20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl4PTXyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfEHMh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:37:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44632 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfEHMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:37:56 -0400
Received: by mail-io1-f67.google.com with SMTP id v9so13092168ion.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VSLwYO4ajiCw1Y1sGYTbNpEZFeZdK3LyxgFKcQp7zw=;
        b=Fl4PTXyWhYB3k7R9TiGqUO3gRiqHndIFQx5R/XH4YBppV2hu7K24dX31qw3e3yFsXy
         gu1lb1qkaH7CVg8ns8F4x2VFATP4t2ksvNFcuwqG0E5sVgmMMQQAKY+vAFk2f4SKwVhb
         SuFD9vUX3LBGQvUXQInG8fGA/r+xOsbS4JGpWt9KVFd32gCUvEGaquV9QGWcw8bJqAJC
         5CiUkBfNndHNPa5EqKWQHJS/wfUDJGgD837bHNQf7WGoZlXiRm0Kp2LM9H4V+m8uyob5
         aGRtOS0J9+pmsnWOi9Ec1EznWi34ylxBaPH2R8jN5aPjPO3tu3Kk05EO7itnAU5v8KQu
         s+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VSLwYO4ajiCw1Y1sGYTbNpEZFeZdK3LyxgFKcQp7zw=;
        b=if+aanh5Ak+IBd1+orQRFjkxipyFC6Ahic0Z4OQLBTJjk1YXjlbxGFzpFYKX4GVK4t
         zjZ0MBwJAMWCndcQxW0HvJ7ADFFn9kQ1ol7HEKjMig4SxxoPJ3dnCFx6VD8Ghu7it84o
         6F72oqRQMqkvIKrGzDRA3GIj9K0anbYWqmRB6aMkDFnuXjDfCbQoUnuU+KbnoxLjiZ5E
         Ro2vKMYR9wTRKxpSu6Ogq867tHQX6l6tD/h4skFm250P+q05Ua3u4+rL3Hsnl6mHcJde
         Ci4gE9goncuWbW0w8l8KUy7G7qjtllNZhdm0TTHrKEmlXJegT1sJPSH/yqBz/6zzYVIx
         YT/g==
X-Gm-Message-State: APjAAAUMY0EN51GL7vddK4gFIeiCZyiJvPIKSghfcHd/irPOfjGjgZql
        rSpOFZRFaOXjsMywBySdOUno9Q0EsdSk+ikt7ASVrw==
X-Google-Smtp-Source: APXvYqwqgwN1WWnNZT1cKjwLh1pp35JJJ6nWlhlapspRTelB16v8EwXOj1fRgTsrnQ96pGz0gUiC6BN8mPrfk7czTNo=
X-Received: by 2002:a6b:6d06:: with SMTP id a6mr9810801iod.11.1557319075568;
 Wed, 08 May 2019 05:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f70a0e0571ad8ffb@google.com> <0000000000007b03eb058653caea@google.com>
 <20190412130112.GA8384@amd> <alpine.DEB.2.20.1904121520350.22857@hadrien>
In-Reply-To: <alpine.DEB.2.20.1904121520350.22857@hadrien>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 May 2019 14:37:44 +0200
Message-ID: <CACT4Y+bcdEg_M5RNVKQvYPVLs1skvatGW-yTht7yDexR=Hjnyw@mail.gmail.com>
Subject: Re: WARNING in untrack_pfn
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Pavel Machek <pavel@ucw.cz>,
        syzbot <syzbot+e1a4f80c370d2381e49f@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jacek.anaszewski@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        rpurdie@rpsys.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall
Date: Fri, Apr 12, 2019 at 3:21 PM

> On Fri, 12 Apr 2019, Pavel Machek wrote:
>
> > On Fri 2019-04-12 04:42:01, syzbot wrote:
> > > syzbot has bisected this bug to:
> > >
> > > commit c68729119f4d2993bec3c9cb999ad76de5aeddba
> > > Author: Julia Lawall <Julia.Lawall@lip6.fr>
> > > Date:   Sat Jul 15 09:58:19 2017 +0000
> > >
> > >     leds: tlc591xx: add missing of_node_put
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cda0f3200000
> > > start commit:   23203e3f Merge branch 'akpm' (patches from Andrew)
> > > git tree:       upstream
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=11cda0f3200000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16cda0f3200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e1a4f80c370d2381e49f
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17836d15400000
> > >
> > > Reported-by: syzbot+e1a4f80c370d2381e49f@syzkaller.appspotmail.com
> > > Fixes: c68729119f4d ("leds: tlc591xx: add missing of_node_put")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > Can you revert c68729119f4d2993bec3c9cb999ad76de5aeddba on master and
> > see  if it fixes the problem? Because this is hard to believe...
>
> Likewise, it seems hard to believe that the change is a problem.  But
> could the problem be elsewhere and triggered by this code?

Looking at the bisection log, this looks like a hard to reproduce,
flaky crash. Most likely the crash did not fire on one of the commits
and that diverted bisection in the wrong direction.
