Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A36EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4263D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UbmkUVhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCTJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:40:16 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36829 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfCTJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:40:12 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so9315992itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiJTbM/+OvQR660JbWl6+zVuyfxyoOgolYDHrTppv9o=;
        b=UbmkUVhQ6gqRKw15CYlRVu/W4JQgjq0CvncfH5C4DWuhC3EqeR0RaRxF5yfkGexfa1
         Mht8+edc7MKM8X+UomJlChY9JyDYqK0gn50DGg4XkRREhhKYShGssew6ccaX74Z2Q6ph
         EODVRAEjPF4hueSKa+rsMnG8lx7HMZ9qzr73+6uyZfbQHmLqAs6Wla5/gs0vRZSQXDLD
         wQbv5czx8u+7ltp0yCTFMU0MwH6Ft4FQMlO1apyrGGpvzmiLEFZ3f2OHAoo33tQzd5gW
         8nzBVcBNlNrCKiJ77Q9EJDOBHOyJ94rx8J1SE5DtPtnXZhZ32wTrPEbbQefiTldH8kIN
         acFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiJTbM/+OvQR660JbWl6+zVuyfxyoOgolYDHrTppv9o=;
        b=aLTek3NPvXQR0JAJgHm+XO+aIaDWzyA+VF+3cq7Zc70gL9cQPm+G+EhdN3NFNhdWhM
         zqTto1aqLa+Ut3p7S/rwV72RUpLC2lt95uu7kdjaKViVnqoB5GC0Y2NQzfItuDD/PULa
         VmCkg0hZcZSuGr0GpsYdSKsw3DxmvpbieMVio6rzp6ZkkafgFDEKUuXIsAzU9XGaa5DN
         p9Svflu7I2rWYT1Qlz1gKETfMva2jm+QY5E1qLHUhhrH9FDjsrxHM9jrjI0go56/r5CQ
         4at4eKoI2ANB/YRkiHW5UKItazlxE69PmRIRJmx10PYs9lPiB+gIXrjFWd7R/2jNYEiJ
         ruvw==
X-Gm-Message-State: APjAAAUAPt3x5W2S+3DGOc558fSzDIgwkBvb0pSuYYWSLRP7gGe26RDn
        6yTGd35Cetp+BJSrsCLUIg9UnYQYuAYhWtsv4jarIQ==
X-Google-Smtp-Source: APXvYqzS7Q49tQ/6IJEY6eYWMi5dAcdCwJpyJ5vkanjlZIIbSt6Hovwuy+RiHNXZtgd+VUix3Y4Z6127Wx3Hjbo7jHM=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr4297591ite.12.1553074810833;
 Wed, 20 Mar 2019 02:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f7cb53057b7ee3cb@google.com> <000000000000c7bd5c05847bfcab@google.com>
In-Reply-To: <000000000000c7bd5c05847bfcab@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Mar 2019 10:39:59 +0100
Message-ID: <CACT4Y+a=9DQhgq243k9c6SPiyAhDQG5y2GqT4Da_P97t5n4Brw@mail.gmail.com>
Subject: Re: WARNING: bad usercopy in corrupted (2)
To:     syzbot <syzbot+d89b30c46434c433dbf8@syzkaller.appspotmail.com>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        David Miller <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-net@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:49 AM syzbot
<syzbot+d89b30c46434c433dbf8@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> Author: Stefano Brivio <sbrivio@redhat.com>
> Date:   Thu Nov 8 11:19:23 2018 +0000
>
>      fou, fou6: ICMP error handlers for FoU and GUE
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a57f83200000
> start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a57f83200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c36a72af2123e78a
> dashboard link: https://syzkaller.appspot.com/bug?extid=d89b30c46434c433dbf8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170f6a47400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e1df7b400000
>
> Reported-by: syzbot+d89b30c46434c433dbf8@syzkaller.appspotmail.com
> Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")

That commit caused lots of crashes that look completely differently.
Now all that is fixed. The last crash for this bugs happened 2+ months
ago. So let's just do:

#syz fix: fou: Prevent unbounded recursion in GUE error handler also
with UDP-Lite
