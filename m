Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B90C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FE72054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbfsWLdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfFZCCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:02:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41627 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZCCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:02:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so398484pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YgdasZ6jAiJRAHqc5yjW6MwsimmpaTQ3r1nC06VpzE8=;
        b=IbfsWLdo1Sf9kTnugQk4adJXp0TbmxkYHoB88DiGrULINdDaKROWKW0l5Bv2sgTtCY
         rv4oEF+4vT/b4pYpDEsdOD/AMtN5PTTfRFvpMLA8r5uRcFNMtbqCZjHcES2hI8CI1Yip
         jlWK6+x+5n25+uS36ta4nTZ2ZpPVpA8X1qa8SXx+t3ZR7sqqTrVFDjQUloDBDp8Id5w1
         ja5BnAP7d64/4SW4cVhHTCQAzGPGTRtChgwohKdZ886i8q+xP+6O0pqa3x6n1jnOzJwp
         4icu3vNxxfLWbcBWkmR4IX5FVdkhbU2OC+Ys1Ph4UYHWyBP4Pw/iHD8L5WtjYcaKwa7l
         81Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgdasZ6jAiJRAHqc5yjW6MwsimmpaTQ3r1nC06VpzE8=;
        b=P+HYhPTe3Sfe3eG24LH/1PQbAQQJcI1PNwNnmug4bqkucRRICJLKeh00rrnnHxeE7t
         Bm+C+iS3bra7jrQw7CMEo5Dv9PGe9XldGxet+8MWmMMAJvEOUEOVTWBtuGlS5bow5+/f
         Jn28QYlcy7SAu16aTDHCOjOX9cXtUOi0iY+FYCjHMf/vMbHGqWjkt/ynJt3ekznUpPZX
         twdWwF+AGOrKW/tShFVYvma8Qecf1AJN0Rb9Hi6PhGuSEgIyx0ttiGBKH4Su4dDfdo2J
         rYwqLzEDefSHb3W8VNg6eNqEbmWQ6r6ZcD3frjirbDXRzd5yxM9kMNJkgSRZJjsmMVkV
         UyeQ==
X-Gm-Message-State: APjAAAVWy0ikSjabBs6ZkBjqYe7vGFix+9RCrOHknmilS8INN6Q1GJgf
        uf1rdYaLch2s9Nowj7JIrCk=
X-Google-Smtp-Source: APXvYqy+LvdiR3ZkyVJjkcAjPcQFnDrzNQwA7SUl0zw8JoUzYpgdP1PJVpV48EwB7/E1LNFyPBRcAQ==
X-Received: by 2002:a17:90a:d814:: with SMTP id a20mr1256604pjv.48.1561514543279;
        Tue, 25 Jun 2019 19:02:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n5sm33045024pgd.26.2019.06.25.19.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 19:02:21 -0700 (PDT)
Date:   Tue, 25 Jun 2019 19:02:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Eric Dumazet <edumazet@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Steam is broken on new kernels
Message-ID: <20190626020220.GA22548@roeck-us.net>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com>
 <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
 <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
 <20190622073753.GA10516@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622073753.GA10516@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Jun 22, 2019 at 09:37:53AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
> > On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
> > <pgriffais@valvesoftware.com> wrote:
> > >
> > > I applied Eric's path to the tip of the branch and ran that kernel and
> > > the bug didn't occur through several logout / login cycles, so things
> > > look good at first glance. I'll keep running that kernel and report back
> > > if anything crops up in the future, but I believe we're good, beyond
> > > getting distros to ship this additional fix.
> > 
> > Good. It's now in my tree, so we can get it quickly into stable and
> > then quickly to distributions.
> > 
> > Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
> > tcp_fragment()"), and I'm building it right now and I'll push it out
> > in a couple of minutes assuming nothing odd is going on.
> 
> This looks good for 4.19 and 5.1, so I'll push out new stable kernels in
> a bit for them.
> 
> But for 4.14 and older, we don't have the "hint" to know this is an
> outbound going packet and not to apply these checks at that point in
> time, so this patch doesn't work.
> 
> I'll see if I can figure anything else later this afternoon for those
> kernels...
> 

I may have missed it, but I don't see a fix for the problem in
older stable branches. Any news ?

One possibility might be be to apply the part of 75c119afe14f7 which
introduces TCP_FRAG_IN_WRITE_QUEUE and TCP_FRAG_IN_RTX_QUEUE, if that
is acceptable.

Thanks,
Guenter
