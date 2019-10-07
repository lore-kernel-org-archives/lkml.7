Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF701ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87311206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GZmS8zvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfJGPda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:33:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34574 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfJGPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:33:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so19790117qta.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pf3HidEZefDIwyo1ct6xxi1YCNmJ5UEixxdYI9lLLog=;
        b=GZmS8zvsKrQg/EXVKUpvi9NoGYRQVaqarluPnzYaGy8sXqu/b78tsk8TbGuAjsKtWh
         LaDmXTJaPhM5CnQTtqSw8SluhxxQRqnMaWzGllY79Gn/MVL2xxS9gc+a3/QBJHZF6I2N
         YZtO/LYBHfCYVCeq9hZsLspTMNt6kY78pStYw9FHJAXsVg9an1sW0fLJ7ATIH8cqQKTp
         t3/v267Rm+v7hnQqNnnX8q/UFJxHj0eAUEpowfEBjt2r3nwY0amuNZ/hIn9Q+DjLFwCA
         i/oCmBdYmHs+Z34JUw+19flXawnZv2b0G96TDIdpkQqx8jzntHvEZ27RqlqhIefg2IGL
         2Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pf3HidEZefDIwyo1ct6xxi1YCNmJ5UEixxdYI9lLLog=;
        b=J2IaVPpTeXBwPXs2Xr7tYjyiwDly/lUK1VolODQ68QXrT1ILzUudI9h4qmGOvjNbjN
         Evem3LMwMpVqrEN8lLxrTyd8U4C7H0443bOqRWGdBP767psVU3jWGCn1+SY+OT0YPdWk
         vWGJI+T38XSrAQ0mAYTUP0xTXJm2D3BeQuXYdgWlzQ7AC4jA5zJrkKqxi0Ov9q6zA9i0
         3AJEbpYB0gNAJwPzg4hoXmAyVQBwsmCPYglqijg5PnA8SHX6V1PRv12AwQ8x8ZBDm/sa
         pYiERMiF/eBDblR2aQv2jcrP0kq6Owd9msLALt3uQ8fKjO2W5v0rtOljHmZ2DnhPO8Y4
         r4nw==
X-Gm-Message-State: APjAAAXzLkL7FFTU9NF8PkS3GdJNH6CXxX+11c1jgTcXihVY8LICP6s+
        Tl7MEupjFJDSSdZOzk4q5Sctbg==
X-Google-Smtp-Source: APXvYqxTsKh02JLIerAgCwtRbcf9vnECQ9HqfotHtN2SVfmR+nR4wgF/+cawR4VwwkxWvATxuzWDpQ==
X-Received: by 2002:ac8:5147:: with SMTP id h7mr30349757qtn.117.1570462409073;
        Mon, 07 Oct 2019 08:33:29 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 207sm8926467qkh.33.2019.10.07.08.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 08:33:28 -0700 (PDT)
Message-ID: <1570462407.5576.292.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Oct 2019 11:33:27 -0400
In-Reply-To: <20191007151237.GP2381@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <1570460350.5576.290.camel@lca.pw> <20191007151237.GP2381@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 17:12 +0200, Michal Hocko wrote:
> On Mon 07-10-19 10:59:10, Qian Cai wrote:
> [...]
> > It is almost impossible to eliminate all the indirect call chains from
> > console_sem/console_owner_lock to zone->lock because it is too normal that
> > something later needs to allocate some memory dynamically, so as long as it
> > directly call printk() with zone->lock held, it will be in trouble.
> 
> Do you have any example where the console driver really _has_ to
> allocate. Because I have hard time to believe this is going to work at
> all as the atomic context doesn't allow to do any memory reclaim and
> such an allocation would be too easy to fail so the allocation cannot
> really rely on it.

I don't know how to explain to you clearly, but let me repeat again one last
time. There is no necessary for console driver directly to allocate considering
this example,

CPU0:              CPU1:    CPU2:       CPU3:
console_sem->lock                       zone->lock
                   pi->lock
pi->lock                    rq_lock
                   rq->lock
                            zone->lock
                                        console_sem->lock

Here it only need someone held the rq_lock and allocate some memory. There is
also true for port_lock. Since the deadlock could involve a lot of CPUs and a
longer lock chain, it is impossible to predict which one to allocate some memory
while held a lock could end up with the same problematic lock chain.

> 
> So again, crippling the MM code just because of lockdep false possitives
> or a broken console driver sounds like a wrong way to approach the
> problem.
> 
> > [  297.425964] -> #1 (&port_lock_key){-.-.}:
> > [  297.425967]        __lock_acquire+0x5b3/0xb40
> > [  297.425967]        lock_acquire+0x126/0x280
> > [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> > [  297.425969]        serial8250_console_write+0x3e4/0x450
> > [  297.425970]        univ8250_console_write+0x4b/0x60
> > [  297.425970]        console_unlock+0x501/0x750
> > [  297.425971]        vprintk_emit+0x10d/0x340
> > [  297.425972]        vprintk_default+0x1f/0x30
> > [  297.425972]        vprintk_func+0x44/0xd4
> > [  297.425973]        printk+0x9f/0xc5
> > [  297.425974]        register_console+0x39c/0x520
> > [  297.425975]        univ8250_console_init+0x23/0x2d
> > [  297.425975]        console_init+0x338/0x4cd
> > [  297.425976]        start_kernel+0x534/0x724
> > [  297.425977]        x86_64_start_reservations+0x24/0x26
> > [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> > [  297.425978]        secondary_startup_64+0xb6/0xc0
> 
> This is an early init code again so the lockdep sounds like a false
> possitive to me.

This is just a tip of iceberg to show the lock dependency,

console_owner --> port_lock_key

which could easily happen everywhere with a simple printk().
