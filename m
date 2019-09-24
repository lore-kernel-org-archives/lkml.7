Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF1BC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBB32054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ksxAq+zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394335AbfIXRBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:01:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38714 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfIXRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:01:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id u28so1977146lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EOVspAXPFO/zP7zLE0+rol5UDYlko14RFhVFd10Q2Y=;
        b=ksxAq+zBjdwwrnH3JeNQN5NwYIoqkKJ/d3Bn9KLZgMkl+xH/Wm4Mm5cMg8qJgsyPbW
         u6ZxwQqSyJR4HbbXChiRgn9x1DEySEOmOO22P5jviHDghj4KHLKXg7YnjvYHWJ8WMCFg
         U+e34zrOhmCAcKeJ1Xrev6mNPqfboH+hGUcfH9qKyKlgQdr9Kga2ppE+DuwjujOhE0/F
         TiXRc6+/GtD2Xo0IWbH7Arqgbs/kx4APenttK+QHwOfzypNcikS9fNvWSKAyCNTSdLf5
         P82I40rA+irHnaP/YtEFRkI3RrfDhKf/8bjn+mKFWCmmfnRYDAZEInIDwErjLuufs8Hj
         biDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EOVspAXPFO/zP7zLE0+rol5UDYlko14RFhVFd10Q2Y=;
        b=ss2I7+QleSdLBRyDz4AyJpLQqV1DRZ+8fATj9oYoK2DG0sKoh6L+1wm5SFz8GZT+2V
         sYWFHNMDpJLbot/XRvShsTOaahuyAsv1+uvTD3NcuEZrOsIGiE5709+MPQNk/u81n6Z0
         FtKtzdjcYKdJULMB0KBKhXVoQ4oo0RClnTv/K1dDXwcEaM0L6nw6q/8Fok97OZP6mUE+
         oVQwI4+GboACpg6J1nDB6qKLGn4cK0acGFHXxIJN5Vq3mGHSdxT8wUQM8AH+2qtvgEs2
         mB9fE6QyYjNhQZWlVJH+wEjDhVAdFtGH0sMGUT6Wt2NXNnaaILA9V1FdMhfB35zSGGUd
         XO5g==
X-Gm-Message-State: APjAAAXMj6wv2LvN4tq4G7GutwGDrnEvHyF0AoOo2jpvoLHTrCmMRtBS
        iHF8ruyTgmGck/jjUvr4mZ8/6GTpsRH6hOT3/Bay
X-Google-Smtp-Source: APXvYqy/OZ/D54rGYNX1/ukfNHPhBFFMJ+yOSTZaOKPuXsMrieUkTSeTREvrtjq1r8xs3uTGM6icZeNhXfgyNLh3cbs=
X-Received: by 2002:a19:cc15:: with SMTP id c21mr2529427lfg.64.1569344497225;
 Tue, 24 Sep 2019 10:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190923155041.GA14807@codemonkey.org.uk> <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <2130348.JY4ctgmguH@x2>
In-Reply-To: <2130348.JY4ctgmguH@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Sep 2019 13:01:26 -0400
Message-ID: <CAHC9VhQBeb6V-RLad+Y92P_a=a_pcZi2b+_VAGzxpbqwBvURUg@mail.gmail.com>
Subject: Re: ntp audit spew.
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 9:19 AM Steve Grubb <sgrubb@redhat.com> wrote:
> On Monday, September 23, 2019 12:14:14 PM EDT Paul Moore wrote:
> > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk>
> wrote:
> > > I have some hosts that are constantly spewing audit messages like so:
> > >
> > > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset
> > > old=2543677901372 new=2980866217213 [46897.591184] audit: type=1333
> > > audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
> > > [48850.604005] audit: type=1333 audit(1569252241.675:222): op=offset
> > > old=1850302393317 new=3190241577926 [48850.604008] audit: type=1333
> > > audit(1569252241.675:223): op=freq old=-2436281764244 new=-2413071187316
> > > [49926.567270] audit: type=1333 audit(1569253317.638:224): op=offset
> > > old=2453141035832 new=2372389610455 [49926.567273] audit: type=1333
> > > audit(1569253317.638:225): op=freq old=-2413071187316 new=-2403561671476
> > >
> > > This gets emitted every time ntp makes an adjustment, which is apparently
> > > very frequent on some hosts.
> > >
> > >
> > > Audit isn't even enabled on these machines.
> > >
> > > # auditctl -l
> > > No rules
> >
> > [NOTE: added linux-audit to the CC line]
> >
> > There is an audit mailing list, please CC it when you have audit
> > concerns/questions/etc.
> >
> > What happens when you run 'auditctl -a never,task'?
>
> Actually, "-e 0" should turn it off. There is a general problem where systemd
> turns on auditing just because it can. The above rule just makes audit
> processes inauditable, but does not affect the kernel originating events.

The 'auditctl -s' output was lost when I trimmed/replied to DaveJ's
original email (sorry), but it appears that audit_enabled is already
'0':

> # auditctl -s
> enabled 0
> failure 1
> pid 0
> rate_limit 0
> backlog_limit 64
> lost 0
> backlog 0
> loginuid_immutable 0 unlocked

Original post from DaveJ:

* https://lore.kernel.org/lkml/20190923155041.GA14807@codemonkey.org.uk

-- 
paul moore
www.paul-moore.com
