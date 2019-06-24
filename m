Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F18FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D20208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcnlKm6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfFXKyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:54:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46845 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfFXKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:54:39 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so60777iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvdMwkq9kuI2sDIx3QKOUTZy+R8mh2VJCHVGv1QYqB4=;
        b=hcnlKm6i5GqDrXUr6P2g5Fk27msTNikgjZMhHjv4nax2XzMdhJ+2m2RwInyveVXB7o
         m06xwgRax1aNAm/VgGWdi9muU7UvC9pf7K6/vYoergAkIiQvb8jWMfWMnCFzQ6WdH8c6
         OCQFOh9HDAx5q6DWfsn8ACfDBiWaS2Grw/M6SfwixpO/zAlqZGC39j6kxGlet3QRQmFn
         bMXSdhfQuyXKQNGkLmo764b449ZHYQtS+kJ4m21o8NGTp0FbQhae6tT4Wjv4lJKYKarJ
         2y5TItNNQWww9/A3TqHJLT3cnwbv2ljPq7P+L5iH4j/9Ys0MGR71iMAcX/eGTFotIBpC
         PuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvdMwkq9kuI2sDIx3QKOUTZy+R8mh2VJCHVGv1QYqB4=;
        b=flj0Y4yqxUTXk5R8nVs2PXzM6m5+RAT4F3rolQSFyRhoPV3spK6EgRpCYnwU6VZfK5
         VFhqzQy02Mia1UKB1nnXCfbjGuQEHTHzgP0H9w+3jPhNe1rZd6iO9ilUTzrGq5rBW6oc
         hYYsZ+3zxiVD7Qqsp8Ht/E6F4mQymL6SOX3l4WQn3uRjrbIECrrGRKUqJbcs4J4g+7qj
         vTQkNmeBX+ew1G+UusaYLdtHxsxF1zJkj50Fax0EdzrfB2WrMaGE9LW3zgTEZf4pDeX6
         8/qLnteMdO3JFLJC5fKqp/d7PIyc0X7MEZKjgY/sYWlw2N6D+VVfZPP0LTHrjxHWETjS
         Zgcw==
X-Gm-Message-State: APjAAAUFdG+kI6iqkPqMUvlZdPTX89f3PPcnViVveIO8qUG6OGSGipjL
        lXG6Hko4TdDO9KQLx5+DYBIjlhQoJ2jkV0QatJfB76798gc=
X-Google-Smtp-Source: APXvYqz/4lEop8zPzP0IRk55Anzi8uao/p42JXWpmclmQcnINvPJlyxlWzgtssZzhHnZAGF5a+qPi2FpQh5G5Cn7kwE=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr37035083iog.266.1561373678104;
 Mon, 24 Jun 2019 03:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d6a8ba058c0df076@google.com> <alpine.DEB.2.21.1906241130100.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906241130100.32342@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Jun 2019 12:54:25 +0200
Message-ID: <CACT4Y+Y_TadXGE_CVFa4fKqrbpAD4i5WGem9StgoyP_YAVraXw@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in netdev_freemem (2)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+c4521ac872a4ccc3afec@syzkaller.appspotmail.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        amritha.nambiar@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ido Schimmel <idosch@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tyhicks@canonical.com, wanghai26@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 24 Jun 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    fd6b99fa Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=144de256a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c4521ac872a4ccc3afec
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c4521ac872a4ccc3afec@syzkaller.appspotmail.com
> >
> > device hsr_slave_0 left promiscuous mode
> > team0 (unregistering): Port device team_slave_1 removed
> > team0 (unregistering): Port device team_slave_0 removed
> > bond0 (unregistering): Releasing backup interface bond_slave_1
> > bond0 (unregistering): Releasing backup interface bond_slave_0
> > bond0 (unregistering): Released all slaves
> > ------------[ cut here ]------------
> > ODEBUG: free active (active state 0) object type: timer_list hint:
> > delayed_work_timer_fn+0x0/0x90 arch/x86/include/asm/paravirt.h:767
>
> One of the cleaned up devices has left an active timer which belongs to a
> delayed work. That's all I can decode out of that splat. :(

Hi Thomas,

If ODEBUG would memorize full stack traces for object allocation
(using lib/stackdepot.c), it would make this splat actionable, right?
I've fixed https://bugzilla.kernel.org/show_bug.cgi?id=203969 for this.
