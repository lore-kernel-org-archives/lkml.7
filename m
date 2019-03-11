Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA872075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avFj40jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfCKNuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:50:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37168 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:50:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so4094245pgq.4;
        Mon, 11 Mar 2019 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOOTq5oygx3K7ryDBNkseZFFGRYwImzfXcS07JM5dDc=;
        b=avFj40jS5DOV2K+nzBFIkZWHIErpGQoPBlB3Utf9KTapeedZEYtVNw0PCm1Ppt6LZI
         RvZupyHcwvAkLMQmBL0gh3kI7VGaOEyo6imf7tABMiCgCqFW/YlV3XpRdb+VHgfreMqK
         N0dVEyAo8ih3/hKFQ06yCRTEI/eKm+en0DDhT634vXWAXDl/gg+QNtM5pISzGkvgpssr
         FTgBUPaNYHaPvZWnEoAp+FJa20cgx0t7ZhsMp/PxjA6Run7UJH0kGxGZyE/C07gy4LyK
         JenuSRGFnguegP8QqX3elRa0SP5peqtqH9mFusHMbPaMYtLTbnXRI8fvNM93fjVK9e6t
         Sr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOOTq5oygx3K7ryDBNkseZFFGRYwImzfXcS07JM5dDc=;
        b=P4I475QZ6A9CcaXLNjmWa3Z9pUlIpiLwL6N9RCtQlRO7MhvaiyY7BR/ybIx1KAbGcI
         2MEs5uXr5rpAewmi/aleE0Ib7LEvRlZEu0LlKoN6tajsMv8NB1sgCD2zb6gvGSuMPd9T
         jxkSNfMO23iifWhKriQEj447z7oZyRS41u9mo0fIZAzWzC45jjTcP537cqiROmC+4f/e
         1R5iKyhotGRnwKajfOvb/xIaUtih8WfhwTMaWXVNXejP9ZOJtz8x5qHWyLLv+xUTMAtK
         7zdo58eNgqZXzBr252hJh+2ZrYZD7zydtsX/z2J6ZwtfuowqsvkFrB7oXonbXCSvrDuR
         2f0g==
X-Gm-Message-State: APjAAAWOGp8UhDuqZEN+NT5GMhUSlXSe1epd3jaNYj+pXefFICaL11RR
        hYMG8TdXX1DH5o7P0fKQ03AqlpgqjoMV2JRn6Ow=
X-Google-Smtp-Source: APXvYqzjqa5R0bPrZRyEOkTXYYB4JFzx1DGH+slkcbj8DxdVleDrest7RRtOViRKoTfGGqMqHkAyMHTzvQ6d63rEWUc=
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr34611346pll.311.1552312204294;
 Mon, 11 Mar 2019 06:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000086d87305801011c4@google.com> <0000000000001d3a060583d187dd@google.com>
In-Reply-To: <0000000000001d3a060583d187dd@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Mar 2019 15:49:52 +0200
Message-ID: <CAHp75VcBAxcB8G1Dr2-nPF6N9W27O=BY4buORs_nqTM=md1=oQ@mail.gmail.com>
Subject: Re: general protection fault in __bfs (2)
To:     syzbot <syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jon.maloy@ericsson.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Brown, Len" <len.brown@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        netdev <netdev@vger.kernel.org>, puwen@hygon.cn,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        tipc-discussion@lists.sourceforge.net,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:27 PM syzbot
<syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 2646b90de5c3492db2ead71337fd4c7d7f549ebe
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Fri Oct 26 08:41:22 2018 +0000
>
>      gpio: Add global TODO file for GPIO
>

AI is not ready to conqueror the world!

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12589f8d200000
> start commit:   2646b90d gpio: Add global TODO file for GPIO
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11589f8d200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16589f8d200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
> dashboard link: https://syzkaller.appspot.com/bug?extid=c58fa3b1231d2ea0c4d3
> userspace arch: amd64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bab650c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a331df400000
>
> Reported-by: syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com
> Fixes: 2646b90d ("gpio: Add global TODO file for GPIO")



-- 
With Best Regards,
Andy Shevchenko
