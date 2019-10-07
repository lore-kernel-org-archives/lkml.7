Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E8ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C9A206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="uG7p6wHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfJGTLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:11:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51686 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:11:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so629986wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DbRc2uG6vwGHor8rUOgYQjnnzlCy4EGXZk7gH7qQMpM=;
        b=uG7p6wHrB7n4cOy0ooYUcAyhlMa4wqdOKblRbs4syBkt4iGNIKdZ4LZy83ATMVQr/C
         MhN2PoiPrwm0uhYfIxGwBt62WGgpnYmhr3bVb9sZP8KEV+3Rqk4MMy2BgeD0KdtzXwYR
         6aiGQCKbZZHnhXPxoCDR4jSkXOPudKnJiQhsKyNJyeeI/WwYi6nkNVPUTMbqsjCTwWRD
         7iSQuZB5zY67jJhfd6gBYrM4a1C0HiEtFQV4RESx5E+KABjOn/30wu61awX7UD8BxFwg
         XhQfcswg9XntS5sfSKlsvKutdC8dBQVvp9aj4eT3q+WF0pgcGBMe61zlkpA/eRlM4QpF
         HH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbRc2uG6vwGHor8rUOgYQjnnzlCy4EGXZk7gH7qQMpM=;
        b=rf76lqha5RcPEP7WkJL7EoBmfriwsMdEzA29PCZW4FhXbTnlCBtOn6gHrVm5T978xW
         N8ZU2Cngf5Tu49qDEpYBWYquvOYKxvgHUBBGefRbVRpfHkVHmp7r6s7GECejyxh7Q1ir
         TT5wVleOQGMFeIGjlgO5TTI610zqTpCXwWNoCvQhLjTJjaHLHU5oE6vD1ivUilScz3TI
         l3n9lKSOMN3onB2qc3qb+HhwzLWyMBbMw+yn5+fYWNzEDHO9Y8dTOKGkuQFz2LZcqQP0
         bfrwrDKmlqlF7EOhzMfDg+jZ10h5Wv09CUu0Y4W6SLcsw6xSAcYZ8h8ic9YBWW+yal0U
         +e2g==
X-Gm-Message-State: APjAAAX4KoDJGL7cjPtJmb0p6KHUZl1HOSZfUHdxQhF4e+sDupUgS8yI
        j3CHxWS2J/1+mwnWaIhYuRWa3g==
X-Google-Smtp-Source: APXvYqxjJiO6p74kvRlrae8mHexJwU/dwR9MeEs4DdgIIFJsV/o0Y+jflfVCyFAzb2a3GDMBwXy8uA==
X-Received: by 2002:a1c:d8:: with SMTP id 207mr572307wma.65.1570475463803;
        Mon, 07 Oct 2019 12:11:03 -0700 (PDT)
Received: from localhost (ip-213-220-235-50.net.upcbroadband.cz. [213.220.235.50])
        by smtp.gmail.com with ESMTPSA id j11sm20777978wrw.86.2019.10.07.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 12:11:03 -0700 (PDT)
Date:   Mon, 7 Oct 2019 21:11:02 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     syzbot <syzbot+896295c817162503d359@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, jiri@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in devlink_get_from_attrs
Message-ID: <20191007191102.GD2326@nanopsycho>
References: <000000000000b11343059456a5f5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b11343059456a5f5@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Oct 07, 2019 at 08:59:11PM CEST, syzbot+896295c817162503d359@syzkaller.appspotmail.com wrote:
>Hello,
>
>syzbot found the following crash on:
>
>HEAD commit:    056ddc38 Merge branch 'stmmac-next'
>git tree:       net-next
>console output: https://syzkaller.appspot.com/x/log.txt?x=1590218f600000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=d9be300620399522
>dashboard link: https://syzkaller.appspot.com/bug?extid=896295c817162503d359
>compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a6a6c3600000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fd50dd600000
>
>IMPORTANT: if you fix the bug, please add the following tag to the commit:
>Reported-by: syzbot+896295c817162503d359@syzkaller.appspotmail.com
>
>kasan: CONFIG_KASAN_INLINE enabled
>kasan: GPF could be caused by NULL-ptr deref or user memory access
>general protection fault: 0000 [#1] PREEMPT SMP KASAN
>CPU: 1 PID: 8790 Comm: syz-executor447 Not tainted 5.4.0-rc1+ #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>Google 01/01/2011
>RIP: 0010:devlink_get_from_attrs+0x32/0x300 net/core/devlink.c:124

This is fixed already by:
5c23afb980b2 ("net: devlink: fix reporter dump dumpit")
