Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F19C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E7A20640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXWTvzBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:42:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46849 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:42:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id 38so2912864qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRtvDaubhKMLsinpUhhIgN2f+Mjhkw2KgaEk+i6x64s=;
        b=oXWTvzBEcP/kRj50+pmeAL2NaG9Yw3hzt7a2ADoE2FFJRrMTHHEDVBcDpCp24ksoEj
         I5YMWQPSXgVcNEdB4GmzvezYKY3oaCa3x/3tIHF7415fm09OTTNZEed1Irfv/ljezjKq
         OJG93KZHcd5gHsECgwFKRkhoaa0n+NsKXp0+pg+fuAjdwLFHrc4+hs6J54v8Aar8hwMd
         Y/acpeTUrAFp4WH8ZEL0bXXid8O8qXTMgk/ooQv8mgoUkXLkcdoMA/6aS8NUwnzfkPLP
         144ODpwlJ6Hz2lTtWUIKignt0+pojEbao7L/SKti11A3x5fu1lxixfSGfaxJWyT4hjFJ
         hD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRtvDaubhKMLsinpUhhIgN2f+Mjhkw2KgaEk+i6x64s=;
        b=Sig/osa/mN6P6AxHdZoGQYCvgIQVy9mXIzOhc/bi4a17YpmOK2k4jpybz8AaFPBYqT
         tS+fQRmuUzBiDMEzy6ZqfI007shPFWuJkUcVN2TD5SIrh9Mun8FIngeFbzmV0M/s5r8q
         cbltjFDgrSVAIzWftJLNTmBGcoRNLKo/nwg8lncymIMipInPMuSuZNUccd8rs8EQY5Pu
         5yoLBTVL2txXHP+Gr2AhCdTsfLScJEjlUqIuO43wKPVps0q0MrmJRGianmiFVNxMa2k3
         +DWRcVBMQD5Aa1SgcXEUaNvSoC2Jxyqizvnkz6KhmS7ky4WZ0DOr2yJOQjDWBv6mzlub
         66tw==
X-Gm-Message-State: APjAAAW1HRnkd8GpwWtoLVn/Gpn6Hnmql+f+L2/8+VwOMgynTR52CGGW
        phXS8q01b1/7qTyLUeueu4KafWLLTSJTm+ZurbmUQw==
X-Google-Smtp-Source: APXvYqwuTfimEU8gymcthDGHJy6fAwXsVAzJea4UVojRBIMQu07+jSaOROWe/wd8DHo6lNHCfZAQa/aDLt+qAPiQUZc=
X-Received: by 2002:ac8:ccf:: with SMTP id o15mr3961228qti.380.1575362545833;
 Tue, 03 Dec 2019 00:42:25 -0800 (PST)
MIME-Version: 1.0
References: <001a114372a6074e6505642b7f72@google.com> <000000000000039751059891760e@google.com>
 <CACT4Y+Yrg8JxWABi4CJgBG7GpBSCmT0DHr_eZhQA-ikLH-X5Yw@mail.gmail.com> <20191202183912.GC377783@localhost.localdomain>
In-Reply-To: <20191202183912.GC377783@localhost.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 3 Dec 2019 09:42:14 +0100
Message-ID: <CACT4Y+ZpZVYgA-oiE_YYC49LRA2=iTQLxOaKTA3TEYBt8KjFbw@mail.gmail.com>
Subject: Re: kernel BUG at net/core/skbuff.c:LINE! (3)
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     syzbot <syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>, mvohra@vmware.com,
        netdev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        William Tu <u9012063@gmail.com>,
        Vladislav Yasevich <vyasevich@gmail.com>,
        websitedesignservices4u@gmail.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 7:39 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Sat, Nov 30, 2019 at 04:37:56PM +0100, Dmitry Vyukov wrote:
> > On Sat, Nov 30, 2019 at 3:50 PM syzbot
> > <syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this bug to:
> > >
> > > commit 84e54fe0a5eaed696dee4019c396f8396f5a908b
> > > Author: William Tu <u9012063@gmail.com>
> > > Date:   Tue Aug 22 16:40:28 2017 +0000
> > >
> > >      gre: introduce native tunnel support for ERSPAN
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158a2f86e00000
> > > start commit:   f9f1e414 Merge tag 'for-linus-4.16-rc1-tag' of git://git.k..
> > > git tree:       upstream
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=178a2f86e00000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=138a2f86e00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=34a80ee1ac29767b
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b2bf2652983d23734c5c
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147bfebd800000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d8d543800000
> > >
> > > Reported-by: syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com
> > > Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > Humm... the repro contains syz_emit_ethernet, wonder if it's
> > remote-triggerable...
>
> The call trace is still from the tx path. Packet never left the system
> in this case.

My understanding is that this does not necessarily mean that the
remote side is not involved. There is enough state on the host for L4
protocols, so that the remote side can mess things and then the bad
thing will happen with local trigger. But that local trigger can be
just anything trivial that everybody does.
