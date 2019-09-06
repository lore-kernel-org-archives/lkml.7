Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26912C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEA120842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1gmX8qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394010AbfIFTyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:54:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41726 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfIFTyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:54:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so4079235pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VpEKZIToJcJNtnrt6GtVJ64TAfq7GPSof5ZG1aF07lE=;
        b=D1gmX8qhzlfB/Pv7zyAZj4Fdbl/Ww/xUcMUcOizFDGiz+svCTiSk/J5vhlLzfJy0Fj
         mQU4m/XKA8lbeph7b0Djr18inpjH01goTUNDbFmzlzPlravDK0d/QCxXlfRpROLz4n2p
         XbwNqzzZwfNRQoe/5bo+dJVhCjyvS6YqH5L98KFp2qbCc0jMtRsbPozPmb+0/hnwJCRh
         UhE4Igys1vXpOkk/JgAyeR/7M86hqQLiZiZgIF97NUxxeNzaZ36E4dT1dhOGVEVDj0tI
         Q0YIRbW9gQOeHMgI1w3SJvA0vU5qJ54bzYnlkawU+fP6Ikbey+r7jjvVuDyoNkWQKDgo
         oGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VpEKZIToJcJNtnrt6GtVJ64TAfq7GPSof5ZG1aF07lE=;
        b=JJxrMOQ3Br3XZq5QPJcC82Dc51bvQou20cQ2zKdEif9UhZdTSPNslkm0Q8TieDUcKF
         grOHGHh00WjmmsMAo5yzHOA/6phWwRJ9FmhE5H3QmmbnRQ5xmFp+8KSu1+WHxVkRB6YY
         ONZHByEIADFYubNRc36H5t11vmF/n1b9sB2yawmQPQtyasv4BJ1gSXE/ZAkD4uoVOy83
         YQ9F27dpx0jxv2wD/USIAkxngmLfGb+aihKTchs16e0eXmwzLs1MyBlbPCQQNqZcMBag
         g1WXpclEC1hJQKLODWQ8iwt7+3+Ok8eHChJtyt2WrnshmyI8d1z97CZnYoSqY1ceo2IN
         c+5A==
X-Gm-Message-State: APjAAAWxZWLYfQULsSZX+3UzrzoVw/hudvWBEVA3dkguJzakL1RtLYeT
        XcUz0N1ObGBEroIqthHTFBo=
X-Google-Smtp-Source: APXvYqxNtcNcExy7Z7dsvZlivPZODRshEiZdXLLiHzW3C0Sb63CyGltsOeH3x/I+o5Cj4kpWO2opUg==
X-Received: by 2002:a17:90a:8a02:: with SMTP id w2mr10511834pjn.131.1567799642060;
        Fri, 06 Sep 2019 12:54:02 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id g2sm7614527pfm.32.2019.09.06.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 12:54:01 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 7 Sep 2019 04:53:59 +0900
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190906195359.GB69785@tigerII.localdomain>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <20190906090627.GX2386@hirez.programming.kicks-ass.net>
 <20190906124211.2dionk2kzcslaotz@pathway.suse.cz>
 <20190906140126.GY2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906140126.GY2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/06/19 16:01), Peter Zijlstra wrote:
> > 2. The simple approach works only with lockless consoles. We need
> >    something else for the rest at least for NMI. Simle offloading
> >    to a kthread has been blocked for years. People wanted the
> >    trylock-and-flush-immediately approach.
> 
> Have an irq_work to wake up a kthread that will print to shit consoles.

Do we need sched dependency? We can print a batch of pending
logbuf messages and queue another irw_work if there are more
pending messages, right?

	-ss
