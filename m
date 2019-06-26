Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC876C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778F02147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGjJLH7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFZCIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:08:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39922 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZCIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:08:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so481316pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XuWQUH8JO1My/hziqtFzijpXAic/yIwdWsCsK+nonzM=;
        b=KGjJLH7ccDtu3GEy1Y3TQpJmBYzXNW/b1SqbwdKLD1cRf7In+97nZ5tUjlc1RgplMt
         UfB7Wmhciq5X1fPicY6M9W3OOEXveQSIdUoIGqN06lEM9ThJLDQ/Jmv24GWS0d+CVu6R
         N+udjXFTG8xrjcoNPK6/bzV5LJYj5+bvQ7NBTx9xVzhIx+cQ8yLojsmdfMrpP9qpvVbH
         wjowa2hwnLEPm8YJh6xoHgPRls2FubXMOi6uC8R090dkUtslVx9x4/kcdFCrXD2MZvHW
         ch8YCgRD8nQ+Rad+qSpfmf7QcRG+eGOUI5V7IPPVhVL3JqpU1uBhKHpfVFnCT7vaVfRF
         vikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XuWQUH8JO1My/hziqtFzijpXAic/yIwdWsCsK+nonzM=;
        b=YmmE6b4KGMCcJmy1rctOzoLJG8hLUOrL2mh1HS+36G5Kk0/f8QtM/xOjTEmhqSBR3v
         JUmfUl2hV5q6KXoe4DFOkP6EkPzzSxyz1nR1TONSmHaLuwBmbtgWvDl/ymNFtzBYIn0o
         qS2HOGlwqeZ4OCNJRFpNNCKSUivXCHVmIWGdi4ENcl+13J4rMOV/pYU5qpDy5Gkap4iX
         RhGMRmrN+LvdUMaK+O4OHrKSm7rc2q0/vKYo+D6yU9jtGXR2i85iZqxaIpW0KEW2MAPc
         WxDFpUQYSZeVhLf2l/zfSsvs3wYpYpnhiZWKBePJv6Y1X4KHURZVj/cPknsUJH0aCmPt
         ln7A==
X-Gm-Message-State: APjAAAW1CNt0o/0p/ZW03LEag6SgYGXLFr0qW2UyvDE/KwAix5NkIqPo
        PbIOCVRaFTcnPzOwHHUYVxg=
X-Google-Smtp-Source: APXvYqwa+4mT58cDpNxpiJjT5DkXClbDj+li4S14zoo91krOjy/0Qbkju+7LyQOVN1pQbjS54F4Jjg==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr1995628pls.318.1561514922145;
        Tue, 25 Jun 2019 19:08:42 -0700 (PDT)
Received: from localhost ([175.223.45.10])
        by smtp.gmail.com with ESMTPSA id x3sm319311pja.7.2019.06.25.19.08.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 19:08:41 -0700 (PDT)
Date:   Wed, 26 Jun 2019 11:08:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190626020837.GA25178@jagdpanzerIV>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618045117.GA7419@jagdpanzerIV>
 <87imt2bl0k.fsf@linutronix.de>
 <20190625064543.GA19050@jagdpanzerIV>
 <20190625071500.GB19050@jagdpanzerIV>
 <875zoujbq4.fsf@linutronix.de>
 <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
 <20190625100322.GD532@jagdpanzerIV>
 <87woh9hnxg.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woh9hnxg.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/19 14:03), John Ogness wrote:
[..]
> > CPU0								CPU1
> > printk(...)
> >  sz = vscprintf(NULL, "Comm %s\n", current->comm);
> > 								ia64_mca_modify_comm()
> > 								  snprintf(comm, sizeof(comm), "%s %d", current->comm, previous_current->pid);
> > 								  memcpy(current->comm, comm, sizeof(current->comm));
> >  if ((buf = prb_reserve(... sz))) {
> >    vscnprintf(buf, "Comm %s\n", current->comm);
> > 				^^^^^^^^^^^^^^ ->comm has changed.
> > 					       Nothing critical, we
> > 					       should not corrupt
> > 					       anything, but we will
> > 					       truncate ->comm if its
> > 					       new size is larger than
> > 					       what it used to be when
> > 					       we did vscprintf(NULL).
> >    prb_commit(...);
> >  }

[..]
> In my v1 rfc series, I avoided this issue by having a separate dedicated
> ringbuffer (rb_sprintf) that was used to allocate a temporary max-size
> (2KB) buffer for sprinting to. Then _that_ was used for the real
> ringbuffer input (strlen, prb_reserve, memcpy, prb_commit). That would
> still be the approach of my choice.

In other words per-CPU buffering, AKA printk_safe ;)

	-ss
