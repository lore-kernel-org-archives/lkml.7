Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38140C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0404120663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="S8hTTQ4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGAUnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:43:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45111 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:43:31 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so31863804ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aAHYEpAwmFfykw4UsHqlxHV8LEbj/P9Jk/ruDIlZAEI=;
        b=S8hTTQ4Yv+QWKNdV9zonpCua6hSUSWbkSIpRpYvKM7PA6gqfiIB2pFk0FVLrIMDVeT
         UpyQboZIXvc6NWF6NY4CiF/ZperHfBl1mpziMP1FGD4KLrtHZXc0x+OZfYY/3SiudjUf
         8QoxzdhwCe8j3+eJ84bCHV5oiUHsatYhfm0rv9o1wYggzySHoJsLHrr5A3RF0PGScoC5
         gRfc9VI5YCXaLwwgaFLR45pfp+P4rOF6YraAXLcSnXy3avDHDsepwJfwWGJiofFg9O+k
         b0gvJvgQhjvF3nZU3TLNdofmpLbeMI9SaRrXuD6QxF4fxTjtMsCFcViXg3Q85SwYZjuk
         N5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aAHYEpAwmFfykw4UsHqlxHV8LEbj/P9Jk/ruDIlZAEI=;
        b=pHX0sUByxUXEuVig+nt8rsdi1bMVZ+uJnMfTzjfM8Upop699htY6dRqSzz1LXm7Vra
         SVbiv0lZwlh7l+J2YaHTESgo6Pa5edNz2zgUwLtJBmLf1HXJudSVBh+ir+0mwdNXlaap
         DU3idnFBMZ8X00/SACLdRomJHRxVu63Sa/X0NikHLpyETvUKtQUUFAo3w1m1W399WnWD
         GtS00oOTw3kSDgKeWZtm3l+7L88YJn3mCw0Ew9s8sYeiyCylT7g+q5r/ECG5wXpCeRTn
         YjEpUPf8WkOj6YZssmcOyqtmcNTyVuNR18gCKLy7v/xREkSxIuMvPoOmzLVCHmTmsG9n
         QnVA==
X-Gm-Message-State: APjAAAUlFchkowCTmleeObrfegq6cdeUjIP6MhSbzWhDH/fs+LfUB8p/
        EUM9VKrgdLheGNepqEM74fRV4A==
X-Google-Smtp-Source: APXvYqzF5o60A5qeHHxcOxgsNO5bJ8Npeh4wXwP+G+CaK8cmAiMBoKhra/XQ1iqIYhF77nJyzJTikw==
X-Received: by 2002:a6b:14c2:: with SMTP id 185mr29942445iou.69.1562013807868;
        Mon, 01 Jul 2019 13:43:27 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:9575:16b6:1dd6:2173])
        by smtp.gmail.com with ESMTPSA id s2sm9598124ioj.8.2019.07.01.13.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 13:43:27 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:43:25 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Corey Minyard <minyard@acm.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190701204325.GD5041@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190509193320.21105-1-minyard@acm.org>
 <20190510103318.6cieoifz27eph4n5@linutronix.de>
 <20190628214903.6f92a9ea@oasis.local.home>
 <20190701190949.GB4336@minyard.net>
 <20190701161840.1a53c9e4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701161840.1a53c9e4@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 04:18:40PM -0400, Steven Rostedt wrote:
> On Mon, 1 Jul 2019 14:09:49 -0500
> Corey Minyard <minyard@acm.org> wrote:
> 
> > On Fri, Jun 28, 2019 at 09:49:03PM -0400, Steven Rostedt wrote:
> > > On Fri, 10 May 2019 12:33:18 +0200
> > > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > 
> > > When I applied this patch to 4.19-rt, I get the following lock up:  
> > 
> > I was unable to reproduce, and I looked at the code and I can't really
> > see a connection between this change and this crash.
> > 
> > Can you reproduce at will?  If so, can you send a testcase?
> > 
> 
> Yes, it wont boot. There is no testcase as I don't even make it to a
> boot prompt. I applied the patch and it crashes, I remove the patch and
> it boots without issue.
> 
> Attached is the full dmesg and the config used. I applied it to
> 
>   ae97a0ba0197fb424008a317b79bebacd6a50213
>   Linux 4.19.56-rt23
> 
> It works fine for 5.0.14-rt9 where it was added.
> 
> -- Steve

I show that patch is already applied at

    1921ea799b7dc561c97185538100271d88ee47db
    sched/completion: Fix a lockup in wait_for_completion()

git describe --contains 1921ea799b7dc561c97185538100271d88ee47db
v4.19.37-rt20~1

So I'm not sure what is going on.

-corey
