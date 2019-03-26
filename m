Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7600C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C352084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CB6mIR8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfCZIab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:30:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44982 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfCZIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:30:30 -0400
Received: by mail-io1-f67.google.com with SMTP id u12so9998504iop.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u96/XQWaO743CQx0zQrII7tRo50afqDt59PdQotFCIA=;
        b=CB6mIR8YphRDYR2hBlUkNjK3fCHHG7rBfksisjzvUSwOf8gwtQIoG51aiGBThXiWU7
         R+wFGVbUNbfKBXHBYLPLk02QgktT0mlOwrsX9hSD1R4nNIgBU23eJKMQZV167cDK0BWK
         LKFKpY1F7j6EpRKYl4wV2SouwGPvPncbmFhTyh7iAxSK+cT+CG+euh8O2mQsiTFdeunT
         zoE2xXNn8Ev/Xo8DtlPHRgzx/xFNaYfROnJY56D1hGJWi9vrB1UN3eg+2Nfet+4o/p1L
         Yf+rFVwwbnKYnQ8XBGfFewlA9cU7e0XO2+YVSzITf6MlO5Y5L2hPYSSW0EPAyf8VJFKA
         4c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u96/XQWaO743CQx0zQrII7tRo50afqDt59PdQotFCIA=;
        b=onDaLzNDaH11Mos+zqsSBkF23WS+Io0C+NtjYCgekBejC2FNJQT39NnghaGMRu6MB0
         +/NRyD/Bvg0OUpmj8hjFAuUpi/2A3MXbZgz1FGTCmxU4lcJ6VuFtwoTCJLn9CU49rxAn
         TF17tx0N4n46pkh5+na6Wk9Zwrb2xcpf87u3TUpqQwCpm94fTfKtsWTxvDa33RHo6wzd
         nxu0qLOdLsu0uTHWbeGqp7/ybPLN/WbjVsR+F0PLDf5l1S2y85R3GHICQSugFFWH9kyy
         c5nhXHt22qRNgInPBWrJsGYOeR/4xDzPKWo934XSgpYxhj6U24SkWvh4X3N0+JTkM+5P
         8EBw==
X-Gm-Message-State: APjAAAVN0jw8cscTxttdTOiFodGh9/8goDKFHa6+y7/Ime+fCXSWQX9u
        7JILsJ/KIEzM8xs6HgvffGMQKU8WJ0EGnoAMGEfMVQ==
X-Google-Smtp-Source: APXvYqyakt+XhEnLW8Dz1cBNdjuL8IrEMJDOAgPgsXzO2R9f19orCOVA+KtCuSot+00YXPHZnHoOMWrDDvZlVQMydgw=
X-Received: by 2002:a5d:9457:: with SMTP id x23mr3564593ior.271.1553589029810;
 Tue, 26 Mar 2019 01:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003749360584c395ba@google.com> <e3d9d95fd07502cccf8ef97ba7b2e2adb4eefbb3.camel@baylibre.com>
In-Reply-To: <e3d9d95fd07502cccf8ef97ba7b2e2adb4eefbb3.camel@baylibre.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Mar 2019 09:30:18 +0100
Message-ID: <CACT4Y+ZWY973sS7645uo8gNsU+wOddutZttXzYc9DjvqfPjqgA@mail.gmail.com>
Subject: Re: WARNING: bad unlock balance detected! (3)
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     syzbot <syzbot+f3e3434787332dfc1c47@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-amlogic@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, robh+dt@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:54 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sat, 2019-03-23 at 07:14 -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit ec01fb69ac8034ad6e839b31f9df167a110f868b
> > Author: Jerome Brunet <jbrunet@baylibre.com>
> > Date:   Wed Jan 16 17:59:47 2019 +0000
> >
> >      arm64: dts: meson: s400: fix emmc maximum rate
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10afb7cf200000
> > start commit:   065b6c4c Merge tag 'devicetree-for-5.1' of git://git.kerne..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=12afb7cf200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14afb7cf200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4067c9a08ae046
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f3e3434787332dfc1c47
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a10577200000
> >
> > Reported-by: syzbot+f3e3434787332dfc1c47@syzkaller.appspotmail.com
> > Fixes: ec01fb69ac80 ("arm64: dts: meson: s400: fix emmc maximum rate")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> Hi David,
>
> I'm not sure I understand what the problem reported is but I don't think a DT
> patch could be the cause of a locking issue on x86.
>
> If I missed something, feel free to let me know.

Hi Jerome,

I think you are right. It seems that other unrelated kernel bugs have
diverged bisection into the wrong direction.
