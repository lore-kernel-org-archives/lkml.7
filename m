Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F31CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 10:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FDC2173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566730144;
	bh=EGXjesknDjQ3X9Y1jN4dtN19eOCjf4sdQsdHYvPLCoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=at74N7ibPn4MVqpv/7QycI7HWpB8IiQNCmATuRq4vfzuxcO8Gay/1qmJzFH+Qdwmk
	 +uTbPKIN68W7+z3VfFyuiJ2kFnNjkrP3CIxvP0zE6f6l0POPn2RSfRHRz79cBThGL1
	 v0jWV8kZwMgZTzOeVm37hh1A7Okm8PjCSEiRM++I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfHYKtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 06:49:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54543 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 06:49:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so12779059wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EuOrk7OFqMZzRP0gnD8pxO4CA4pMLfqEW2VZlPeV5Do=;
        b=BJxNzxHhkLL9+WFcEOrqDGJ8Aua5n7uIXugDlxRngFZlh60beDCM7q6LbidNMpCQzx
         jwk92LU75FD7xHeXmOPo1/HKJT7PT0i1e//SkFQ7MmiBCql5Fjcl+IlOWqdxHkbZSm9Q
         2mGZ3m3kJ7WomzaauNg6kbE6iVQkBNXxINoOtXEAFcYmrbQrXx6rKmgb5McNSrN9KYTr
         ruzM0y4I5zy0tDIIGz5yZZ7O1/2eRgmj8NE/Wmr46p7ALgZpM8gNhLI9x5PmTRwWAjsA
         Hk7BfX2ulwmEqv7L9hacXYRg69BMqkgtwMmlmzoPDUeGGZDr+J17PpqIg4B6J3TPNAQj
         dT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuOrk7OFqMZzRP0gnD8pxO4CA4pMLfqEW2VZlPeV5Do=;
        b=OecWpM86NWn+o9A+F+B8o3OS19+lqyhfvdPw9U/eRXTOuu5IZ18CvPylaupOb+T+Tu
         i/+XJ4AhE/D5wRGHgcmjB9HdmFR89hwJEJT1sOdIugaGOjac0pKwac8L8lAQfbSislj7
         hPi3Zv9NxwDLgDSzyXdyivdk1MyjzLWmNS2vBgMxDXi75NfUgwjwVYdAUlUP2VACropu
         f7ku+6DhGkuQEQJwBfdm2vi8M0LW2ZBzZ3IVTw1/PFsZxgrVAnemU+sBnRO7fYj4+Nf3
         NbsngJC13kcQSE09gHd8fYUj+GmzqOzZqq5egRiQz1NlK0ZwsbmsHGpknxlzxy/7TppO
         Yi1A==
X-Gm-Message-State: APjAAAWRBORbRDwalumQHnlbX5kzGlTQ+88PEyb47VbsmJNJs1bn02Ge
        1v51BDpvtvf02IXQ9V/VqIaEL8Jv
X-Google-Smtp-Source: APXvYqyL7eeA2qdDKZoDyAH6Nu/iUfbBhNeJ/hfjMT66OfHp3Yd+vs6QKBLQ1p5jfjF8bE7SlrUy1A==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr15200845wmg.20.1566730140613;
        Sun, 25 Aug 2019 03:49:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m19sm7606361wml.28.2019.08.25.03.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 03:49:00 -0700 (PDT)
Date:   Sun, 25 Aug 2019 12:48:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190825104858.GA119494@gmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
 <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com>
 <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
 <20190825095908.GA116866@gmail.com>
 <cfc26ac5-b674-5d42-05f8-c978613aaf29@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc26ac5-b674-5d42-05f8-c978613aaf29@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> >  - We should probably separate out a third 'fatal error' variant: for 
> >    example if copying to user-space generates a page fault, then we 
> >    clearly should not pretend that all is fine and return a short read 
> >    even if we made some progress, a -EFAULT is more informative, as we 
> >    might have corrupted (overran) some user buffer on the failed copy as 
> >    well, and ran off the end into the first unmapped user area.
> 
> Is it possible that copy_from_user() corrupts user buffer in a way that userspace
> cannot retry when kernel responded with "there was a short write"? It seems that
> these functions are difficult to return appropriate errors...

In the cleanest implementation I believe should be done is to 
differentiate between 'kernel side errors' and 'user side errors':

 - 'kernel side errors' are conditions that relate to the layout of 
   kernel memory: some areas might not be readable, and there might be 
   cachability restrictions - or the kernel ran out of memory. In this 
   case it's not user-space's "fault" that they ran into an error and 
   returning a partial read might improve the whole read process, as 
   user-space can decide to continue reading at the last offset that was 
   read - and would also be able to extract all information that can be 
   extracted.

 - 'user side errors' on the other hand are conditions that are probably 
   a user-space bug: such as trying to read() too much data into a too 
   small buffer, running off the end of it and potentially generating a 
   -EFAULT. In this case the kernel should not return a short read, but 
   escalate the error immediately - bugs are easier to find the earlier 
   the condition is reported.

So this is why I think it would make sense to have two error labels: 
"failure" and "fatal_failure". The "failure" case would return a partial 
read if possible (and an error if not), the "fatal_failure" would return 
an error immediately.

This is probably a tad over-engineered, but since you asked ... ;-)

Thanks,

	Ingo
