Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A19C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F37218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b69Cfj+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCUGBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:01:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38986 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfCUGBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:01:39 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so2551287ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 23:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8yka95Zs5/G/4g4CsGYvZobKgmLiicU7E8QxndI42w=;
        b=b69Cfj+zye3jMkzvOw2QTHKFgF7sLq3hJcpUxmzyHpoqzWqvyRzJhBiJkrMyyEY0rJ
         TBSaYRJ6S8JpSxVvnkKHvhhF4/+yIIDPpMk9c/xLxcLqN3A69pJwEEr9p3OqHgg0ZFxV
         6sPEutOBAIoe5yrCgPikUDA2hUnX76xB+mygIBIuH/CR8pnCDh5M1oE/nDnrEetcw0za
         Qu4/mXEZxVhF9UeI8JEgPjhc1IlGlza/5VsRV10YuxbwgByi3sovmYtaXZYEO8F4l19W
         8iQapgGONXjhKpT/kdeBA8pIHG6dA2DUHrzN7Zg7XE8akpkqdl0JML2xOFhliwbGx/JY
         R/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8yka95Zs5/G/4g4CsGYvZobKgmLiicU7E8QxndI42w=;
        b=gPIm+cy1ZyzpAYK66jKg+b/M64rSXhEPx8g71WqR8B5lVRDcGKzRFFxjvHVtVTPEuA
         w+aZA7VJA+WYf7gYXCiaF7yyw88JxWw2N86FhQSJdjrwEFr3rdHYmhw36YK7TCjUeXSy
         +eYFOG3WEk1CZSPmDWnOlSfk+/ADiNcrUCuwWh/ZHbuCT75zsHq7XGwFyyYOkQzLEBvB
         V7rvPWipVfm+Q2HaBUec/WN2YK1rEuWPcQyayOew0yoogpHf+U6qEPk8BDaxFRw5hYjX
         s8uBkne/KcUIc72EjmgLfPQHwME3a5Y7JBmg/Lv1a1/5ar43VBqUHVJnlKia858YWIFQ
         /FYg==
X-Gm-Message-State: APjAAAUQI4McveRfp9A+zNgqLAbCm8M36pxS+BVxpJWAPJyQbsyaVPah
        W6WldYxplZnBZnIWCmiJ4JkA2XBU6PON7sqIOXMyyA==
X-Google-Smtp-Source: APXvYqwi6kxOMIapZftylCPHZQuhGlSTbOsaU32OoCSeDkYeVZw+KEORSpzEZWMM+yroBaMHPH4EewaUU7P/KbyMElw=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr1549248ite.12.1553148098459;
 Wed, 20 Mar 2019 23:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fd464c057a679adb@google.com> <000000000000b93e5a05849268b9@google.com>
In-Reply-To: <000000000000b93e5a05849268b9@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Mar 2019 07:01:26 +0100
Message-ID: <CACT4Y+b6qd7SOkcTrbDUo4bid6qJdJRVUHUONkErNEixj=1g8g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in update_blocked_averages
To:     syzbot <syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 4:34 AM syzbot
<syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> Author: Stefano Brivio <sbrivio@redhat.com>
> Date:   Thu Nov 8 11:19:23 2018 +0000
>
>      fou, fou6: ICMP error handlers for FoU and GUE
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e33c17200000
> start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
> git tree:       net-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=13e33c17200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15e33c17200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dcbea7daf3ea3e3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=0dbf864d3b52555e8265
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ae6d5400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dbd77b400000
>
> Reported-by: syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com
> Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")

That commit caused lots of crashes that look completely differently.
Now all that is fixed. The last crash for this bugs happened 2+ months
ago. So let's just do:

#syz fix:
fou: Prevent unbounded recursion in GUE error handler also with UDP-Lite
