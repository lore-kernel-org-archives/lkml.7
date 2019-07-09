Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E033C73C60
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFB820844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxZvY3uD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGIXBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 19:01:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40126 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGIXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:01:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id e8so197729otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 16:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PeGKkIn3nmmMYef/FrqOaIDK6KPh8SlUVgUINlK5aBA=;
        b=KxZvY3uDE+LA1zWbKYAIprZHLZUQ5yL0JDRF61UdQRs6F6+ZZWyYE3QAf3fonjjMiC
         k7+rt8eMtGL0zo/mNYdXeKEuvYsNUYrVICrsueVDI6WLq0QCs/PpjGvnr73nJnNrMg4w
         laetoXdGTuHiycAzEp23FC7rTooqVSR6+LvB3Pc23tUHZfdrlvY/LkbfD218f1k3aI/K
         MJIRLaBNLZBv6rJAemNSN661UvwfmPkjBznMRgCzA5H9sOzJaurd4L4Gn7CP8VI0aE/V
         +R1DATzlPbAlBeQl4VHJNphaaCJHZZq89Ydbsn4tMD5HaC6pQFPYGcNgiEcUP9Cw7R4u
         rwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=PeGKkIn3nmmMYef/FrqOaIDK6KPh8SlUVgUINlK5aBA=;
        b=enQW9v+mWm0UiM+zehyGIpiTiNJQQ2XqoKGBFnCrwMmlnaYS4lYE0Elzm766lCY9Vu
         vmzz7GTMwTh6Hiw3Vr+8a82fZDdJ7fsrfDOJCPj9LzCgO7/ZmjhL+njkwYcNfnwhWzBX
         ZC5OCKOcM12yegjtC6f/2AkkLt1UA/d3ScOKR738w6+PnijEvMAsCNT/ooptihEjBLCO
         eVxKyhdGHzRGsE5hoApasWgW8TZO/gcD00O0plcMfEY5U9K9IZLsXi0+1gOIVYYXM0/i
         c6OwguJl0IMawhD0aWQZWyNSUw0zEIUbb3Rfw3RcEH+pbBVf95PWx0LmUv8maUqwIdxg
         nHow==
X-Gm-Message-State: APjAAAUTO/JUMcVwq2Rdz3TK8QCJsLV5eDSl8td3vJKxGnNx8FxLYOg4
        jzqsGwoOYol6DHCenchTbchombg=
X-Google-Smtp-Source: APXvYqydYtXUkGchDKV5xlYEDRn9FIHtYBqR7QLRy7lk7t0PzcZHXrxmc78Y3gT4/Ha5gG28gBs3Xg==
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr20303973otq.284.1562713307015;
        Tue, 09 Jul 2019 16:01:47 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m31sm247003otc.7.2019.07.09.16.01.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 16:01:46 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:6c89:b9b3:d6b4:3203])
        by serve.minyard.net (Postfix) with ESMTPSA id 131591805A4;
        Tue,  9 Jul 2019 23:01:46 +0000 (UTC)
Date:   Tue, 9 Jul 2019 18:01:44 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190709230144.GE19430@minyard.net>
Reply-To: minyard@acm.org
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709220908.GL657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709220908.GL657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 03:09:08PM -0700, Tejun Heo wrote:
> Hello, Corey.
> 
> On Tue, Jul 09, 2019 at 04:46:02PM -0500, Corey Minyard wrote:
> > I'm also a little confused because the CPU in question shouldn't
> > be doing anything else if the schedule() immediately returns here,
> > so it's not wasting CPU that could be used on another process.  Or
> > is it lock contention that is causing an issue on other CPUs?
> 
> Yeah, pretty pronounced too and it also keeps the CPU busy which makes
> the load balancer deprioritize that CPU.  Busy looping is never free.
> 
> > IMHO, this whole thing is stupid; if you design hardware with
> > stupid interfaces (byte at a time, no interrupts) you should
> > expect to get bad performance.  But I can't control what the
> > hardware vendors do.  This whole thing is a carefully tuned
> > compromise.
> 
> I'm really not sure "carefully tuned" is applicable on indefinite busy
> looping.

Well, yeah, but other things were tried and this was the only thing
we could find that worked.  That was before the kind of SMP stuff
we have now, though.

> 
> > So I can't really take this as-is.
> 
> We can go for shorter timeouts for sure but I don't think this sort of
> busy looping is acceptable.  Is your position that this must be a busy
> loop?

Well, no.  I want something that provides as high a throughput as
possible and doesn't cause scheduling issues.  But that may not be
possible.  Screwing up the scheduler is a lot worse than slow IPMI
firmware updates.

How short can the timeouts be and avoid issues?

Thanks,

-corey

> 
> Thanks.
> 
> -- 
> tejun
