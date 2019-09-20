Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79202086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989908;
	bh=yZN+q4axeMiwVzlLBYpHfRquCL3wJLr+zC1LNASvKfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P7QBCDJgKbXVReeyXJDadISCQUsxRe2id4GCe8x1Cfa5phOJ7Zx0gkMJjuMTHCgGg
	 J65RKvtMitn/xxwwxBDYNrEOlc7gBQJ24kZlkW2UPtW9HdI1A5IHBGuyKOqznj+pb2
	 Tps4dau+U7jUYsmm9dc2EZu3JcHaKBfV0Ao/7trc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391295AbfITObr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:31:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32802 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391248AbfITObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:31:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so5243559lfc.0;
        Fri, 20 Sep 2019 07:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0D+HcS3eYRO8w2KAABy0yZn8AP90c9VP4mZxrrQxx3c=;
        b=XsfcY41kHNFIQAqijkXWBwr1CkxFPA9eUyJCUETuXiI8njZs/yO+3oRTr3Xiaxl96Q
         PO5zqnzvwsqee7Mdx+3aUTJGZSMDHXkKBVaJ1zFhqnlwRMS0aEn8JqecUuCxgnLp9q+9
         62yu3YMoBGG572N2HHbq15KI7ejXtNXM80IQV/SAJgaEhqOjOtmm1WI8uGg0usEO1i1b
         a7nFXf7QDD0ThrDIsLMFL8SryMS0OyAE6oibfx9H0LaVgytDCpSkrfD2loctyS6zuXk/
         TCA5RuICeViq9yb02zctVnyJQJ8dZkbcaL0f7smsLfhqSGF9MIxmJtvLd+kyB0Ge8hBe
         x6JQ==
X-Gm-Message-State: APjAAAUrnw0U1AeAIsSRjqhwcArWocQusETWVL6RKVialpXaIyeF6lbf
        IDNs9jAZ/wHz6EdOB7ui7HI=
X-Google-Smtp-Source: APXvYqw0csjT0HMNGuHMynPlZ5ASphurdIOkZe7dZTq5s+cv/iGYo6NhkbI4z0KU2hYq2OuvT8yQRw==
X-Received: by 2002:ac2:5487:: with SMTP id t7mr2960893lfk.96.1568989903063;
        Fri, 20 Sep 2019 07:31:43 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id y13sm482490ljd.51.2019.09.20.07.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 07:31:41 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iBJwk-0004Ml-5n; Fri, 20 Sep 2019 16:31:42 +0200
Date:   Fri, 20 Sep 2019 16:31:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Johan Hovold <johan@kernel.org>,
        syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        dmg@turingmachine.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in adu_disconnect
Message-ID: <20190920143142.GR30545@localhost>
References: <20190920090803.GM30545@localhost>
 <000000000000174fe60592f893e1@google.com>
 <20190920100233.GP30545@localhost>
 <CACT4Y+a18nm92r889vJNrwq2518FYMV-cOqiKPQ53VwqwK0oMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a18nm92r889vJNrwq2518FYMV-cOqiKPQ53VwqwK0oMA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 12:08:30PM +0200, Dmitry Vyukov wrote:
> On Fri, Sep 20, 2019 at 12:02 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Sep 20, 2019 at 02:20:00AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer still triggered
> > > crash:
> > > KASAN: use-after-free Read in adu_interrupt_in_callback

> > This looks like a separate issue, which should be fixed by a separate
> > patch. Not sure how to tell syzbot that. Dmitry?
> 
> There is no way, but also no need. There is nothing it can do with that info.
> If you think it's a separate one and you fixed the first one, mail the
> patch with the first fix.
> Optionally, you can fix the second one as well, and then ask it to
> test a patch with 2 fixes (but you will need either to squash them or
> point to a git tree with both commits).
> 
> > There's is indeed another bug in the driver, which could lead to crashes
> > in the completion handler after clearing the struct usb_device pointer,
> > but possibly also to the above use-after-free if a new device is probed
> > immediately after a disconnect.
> >
> > The below patch addresses both bugs, let's see if that helps.
> >
> > #syz test: https://github.com/google/kasan.git e96407b4

Ok, so I was using an old syzbot kernel from when this was first
reported and apparently hit a second issue which had since been fixed by
Alan.

I was starring at usb-next and couldn't see how it was possible to
trigger this, but that code had Alan's fix 303911cfc5b9 ("USB: core: Fix
races in character device registration and deregistraion").

Guess I had to bitten by this to learn the syzbot interface. ;)

Johan
