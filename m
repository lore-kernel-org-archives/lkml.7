Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4C72087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgqm28YU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfCLCvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:51:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfCLCvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:51:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so691992pff.11;
        Mon, 11 Mar 2019 19:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tA9SBm+Jyd/X8VPj7ujDcbfalc7kOHnD2aDkOiE5ong=;
        b=Kgqm28YU08s/KyNnAhJ2JZd1u1pElhHo460i5oXSCsoQjlt9XpVcmQCS/hPWg8DUTd
         4JmAo0PrF4gAFUXK1N+sMJFE+fOLfRIpQetdjO88Vy6DE9ttOmtevyFgPShN7Xa2pddx
         yz2oVXrBu0fv9/k0EDhbhj2fpLX0soK87yilK0sm8tzPdc0ktq4YGuHGaenVk4CimRnY
         JFexaCjypP/uso7dxdfq0cwsj6rxObYlxjaVUbXm146wOcytIOhDIUJCEXNR/muanHJq
         kQFjvjpdLmo8l6iTob3UzASHt9bgtMJHUCSyiWUNFSV+L/ZsKrS8OsiTVuC2QE9jzage
         8szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tA9SBm+Jyd/X8VPj7ujDcbfalc7kOHnD2aDkOiE5ong=;
        b=DVIMZzTc0e6bPmTmErkWbLd6e8p1Z8OVbc2fIKfc1UgMTbBvat2U/4EqszYaeAZurl
         Xp1/3fHwZzdCc+q+gDL8OCw4vdAIXaMOqytSmFyJZl2Z1i3Gr+3jM1OMqwDHLPIFZA5W
         iwgll1sPQN9ZGRY/bIh4q42tMGysg5xDYFK0Cdzc72Yualti+YED9h+e3siLQ4aEXs4N
         +eZvGiZeDzfH6XOSdjAIELUih0s3LU0d8DViBXhkbvBnsL+mYGAg/6IeDT3VCQU92zBg
         bII9Tg1DdTrYy5QW0errwArklqSj7dUQUPlp8S3b4L642KVl1q3ZNbE7JPlOZeVx5VW9
         /w5Q==
X-Gm-Message-State: APjAAAWDiJkPzCbPPZhHOC0VSpvqGlU9YOQ2nIR9x6sywJtYNZFv3bc2
        4k6paYUEbxQSvt5SKYbRO5o=
X-Google-Smtp-Source: APXvYqwkPfYsh5H8CmR/yDFxywqDRK3xA47Wq1gvh9PBN1dE8WCsAbc+cHBwbpgJJ6v1WkLgGtZQOA==
X-Received: by 2002:a63:104e:: with SMTP id 14mr32735877pgq.185.1552359096930;
        Mon, 11 Mar 2019 19:51:36 -0700 (PDT)
Received: from localhost ([175.223.22.108])
        by smtp.gmail.com with ESMTPSA id l19sm9315253pff.185.2019.03.11.19.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 19:51:36 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:51:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 19/25] printk: introduce emergency messages
Message-ID: <20190312025128.GC4146@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-20-john.ogness@linutronix.de>
 <20190307073029.GA489@jagdpanzerIV>
 <20190308103127.txsgv3d6lqlf6pad@pathway.suse.cz>
 <87k1h5zkfn.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1h5zkfn.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/11/19 13:04), John Ogness wrote:
> > Great catch!
> 
> Yes, thanks!
> 
> > I think that it is doable to guard the list using RCU.
> 
> I think it would be enough to take the prb_cpulock when modifying the
> console linked list. That will keep printk_emergency() out until the
> list has been updated. (registering/unregistering consoles is not
> something that happens often.)

console_sem can be a bit more than just registering/unregistering.
Especially when it comes to VT, fbcon and ioctls.

$ git grep console_lock drivers/tty/ | wc -l
82

$ git grep console_lock drivers/video/fbdev/ | wc -l
80

	-ss
