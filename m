Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FF820815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t31tm6V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCDMJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:09:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39187 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:09:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id i20so2893610pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 04:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kCijApWmfTy5EWKasj6QTCk3F1EyfVJ+yEhrHLGOkIo=;
        b=t31tm6V7FnZsQBPiY3VNIiTEghzUSpWrhHxhgNJKVfNApJLqTNmhd5biqHs+2ZeDOi
         ZwEdr3mA2k3nAHOjy1+o3miT5MywTT7lDNjeeNvjvhkznhPMEquOzPEIan7xLg76+iOd
         08p39+TbQRMMUoFS2JA2geNVx7s2d65N9+pfTboDmUP6gyhDAdfLGObVUuZdNYHW7l9S
         alLH3pd47f4BKWEoOkXb6IpZiqZucS9zWTwfEpsSl2tG837N8/h12D34MWC13s4bWgdm
         6Crp4bV+UJZH9bntVgUdNEVn0WrLiNMLNBpQi2vAe8lj7kM8gFIbiDT0pcS43s4Gbnlt
         sgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCijApWmfTy5EWKasj6QTCk3F1EyfVJ+yEhrHLGOkIo=;
        b=f4uGf01Xage3ZWqHKXTh51LQGP1g0Dg3z+jaiRIku+qAwf4t26t3R4FeqQWBObzEmD
         7NvuZRd79n3OQVvyQaUuj7fRVUMXSONuUAlEWxfL4GgneJud0p2/jYg0Qo4W0Rth5Ep5
         jHrQb9kHuto972N3P5WfMy67lEd0dbthOkRA9ULdufHHVlNhhtfMBO/+9hcm5HbTfl+Z
         qjfkgRsS1tNyLmPpzUW20bKMzN/LqinTQx/zIiJrvcVZe5nAw3p6JRevY1lEwmpsUVH/
         7w4zjCaVt2dFo1A3k747KJzosvVDuc9Su3v0/Y5eGaPxXqyVnwf2yiWuyYslrKu+pC8j
         U42Q==
X-Gm-Message-State: AHQUAuZCXF2Ut8XbKC39ULxBnMsxXPSQ06/75QnUnHoihohovEGBCLzS
        esybIMQhAnox3yEjk+fw6/XL3TBE
X-Google-Smtp-Source: AHgI3IYtEvcN2eki0oIcDX+mLBYf/QZrVO9ug3CISYjD41H9vNxhRobG1MwNvEDZhRxiCk1ZABnp9Q==
X-Received: by 2002:aa7:9259:: with SMTP id 25mr19464994pfp.221.1551701348803;
        Mon, 04 Mar 2019 04:09:08 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id g6sm9393913pgc.22.2019.03.04.04.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 04:09:07 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 4 Mar 2019 21:09:03 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190304120903.GA971@tigerII.localdomain>
References: <1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190304032202.GD23578@jagdpanzerIV>
 <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/04/19 20:40), Tetsuo Handa wrote:
> On 2019/03/04 12:22, Sergey Senozhatsky wrote:
> > On (02/23/19 13:42), Tetsuo Handa wrote:
> > [..]
> >> This patch tries to address "don't lockup the system" with minimal risk of
> >> failing to "print out printk() messages", by allowing printk() callers to
> >> tell printk() "store $body_text_lines lines into logbuf but start actual
> >> printing after $trailer_text_line line is stored into logbuf". This patch
> >> is different from existing printk_deferred(), for printk_deferred() is
> >> intended for scheduler/timekeeping use only. Moreover, what this patch
> >> wants to do is "do not try to print out printk() messages as soon as
> >> possible", for accumulated stalling period cannot be decreased if
> >> printk_deferred() from e.g. dump_tasks() from out_of_memory() immediately
> >> prints out the messages. The point of this patch is to defer the stalling
> >> duration to after leaving the critical section.
> > 
> > We can export printk deferred, I guess; but I'm not sure if it's going
> > to be easy to switch OOM to printk_deferred - there are lots of direct
> > printk callers: warn-s, dump_stacks, etc; it might even be simpler to
> > start re-directing OOM printouts to printk_safe buffer.
> 
> I confirmed that printk_deferred() is not suitable for this purpose, for
> it suddenly stalls for seconds at random locations flushing pending output
> accumulated by printk_deferred().

You are right. printk_deferred() is usually bad news. It may kill the
system, it doesn't care that much. If there is no other printk() caller
to hand off printing to then we can stuck in console_unlock() printing
loop from IRQ context. printk_safe() is, basically, same thing.

> Stalling inside critical section (e.g. RCU read lock held) is what I
> don't like.

I see. Yes, we might hold off grace periods when RCU read side
section is getting interrupted and then we stuck in printing
loop from IRQ.

> dump_task() is the OOM critical section from RCU perspective.
> We can minimize RCU critical section by just getting a refcount on possible
> candidates and then printing information and putting that refcount after
> leaving RCU critical section.

Can do, I guess.

[..]
> > Note, logbuf size is limited - 2G. Might be not as large as people
> > would want it to be.
> 
> Are "machines which want to use 2GB logbuf" hosting millions of threads such
> that even 2GB is not enough for holding SysRq-t output? If yes, then I guess
> that tasklist traversal under RCU read lock would lockup even without printk().

640K^W... 2G is probably enough.

	-ss
