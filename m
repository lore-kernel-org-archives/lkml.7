Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61C7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8367C206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbP1WOn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbfHARkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:40:07 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:46664 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfHARkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:40:07 -0400
Received: by mail-pg1-f173.google.com with SMTP id k189so15550315pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CV5KJuMKRvWixx4ezJXBxyoNVGaMRk943Xwor61oWZ0=;
        b=GbP1WOn7/9PbIdwzkuN3chiaHFkVcDH4NKdncXl3s7kSJdiV0EEUoJZC2VqgFk60VL
         Yov+7ppDp+2EHRdy1Lm951VSrXGW4vAim5laato1MVSD0uv0DAdp/psPC/BHwey0vLJh
         bzese9evswLR5zaJ/OoTR2rVvExaDbATR/q+Q+tyySHqyS3m8XVF7/dvrzhXeU4EvTp+
         p87YTxAEHBgktCoCuDblWGazQ7iy/PKCt3NkfQN5WUcemvyhOJxlUKBYhC3aD+PLkBA+
         nBI12Flko+joy8/C0UMWYycemDIGK4P9JBLCfK6mUMgOHlZWoLtVAakH7NjaHzbpIzDu
         yMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=CV5KJuMKRvWixx4ezJXBxyoNVGaMRk943Xwor61oWZ0=;
        b=ResP684md9jLap6vCB39A1OYJhfwNy7VQ67DJZ0wjsWLFJ8y/7qPZp1FRXlOTF1aZ5
         92TZTAeuWZRXYsHayQERvo3YGTHoIUqoSEsmxfvmidBTmnV2vCIRJwYjjXI5tMFsOl6C
         V8y681oinlicq3qlHJBSVSW58l7SghfIKXA/V5b3LQDafaSWMqAnLSzlOiUIJXiijNVN
         RTdT1RVZx9t2usdXmbHTAAfKgp5b7IA9DgKFwOgNojfV4VQEf3+3GRDa+q21Vc6jhC37
         LBN9OieQbomviuekrzHtgvALh0yaJ8hAOZthBTlPTeJTTgGOEZB2hPkL2qROiNtICR09
         ppwA==
X-Gm-Message-State: APjAAAX+PoimFfGi6uxnPBMM3hDaB8exYRSXWQJAFIEY5YI/H/v+hM/5
        QXUaW8279xPppEryuu9raQ==
X-Google-Smtp-Source: APXvYqyaoMJ8U5sAG1dzNMGShf6YvDYPBBsDeYcG2HtyD3zlzFDQ0i1obCTsJ8125fdPc2XwL2U9KQ==
X-Received: by 2002:aa7:8e17:: with SMTP id c23mr55055415pfr.227.1564681205765;
        Thu, 01 Aug 2019 10:40:05 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id j12sm63983783pff.4.2019.08.01.10.40.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:40:05 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:7163:ab94:3829:eba3])
        by serve.minyard.net (Postfix) with ESMTPSA id AB2B3180039;
        Thu,  1 Aug 2019 17:40:03 +0000 (UTC)
Date:   Thu, 1 Aug 2019 12:40:02 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190801174002.GC5001@minyard.net>
Reply-To: minyard@acm.org
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709220908.GL657710@devbig004.ftw2.facebook.com>
 <20190709230144.GE19430@minyard.net>
 <20190710142221.GO657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710142221.GO657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 07:22:21AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 09, 2019 at 06:01:44PM -0500, Corey Minyard wrote:
> > > I'm really not sure "carefully tuned" is applicable on indefinite busy
> > > looping.
> > 
> > Well, yeah, but other things were tried and this was the only thing
> > we could find that worked.  That was before the kind of SMP stuff
> > we have now, though.
> 
> I see.
> 
> > > We can go for shorter timeouts for sure but I don't think this sort of
> > > busy looping is acceptable.  Is your position that this must be a busy
> > > loop?
> > 
> > Well, no.  I want something that provides as high a throughput as
> > possible and doesn't cause scheduling issues.  But that may not be
> > possible.  Screwing up the scheduler is a lot worse than slow IPMI
> > firmware updates.
> > 
> > How short can the timeouts be and avoid issues?
> 
> We first tried msleep(1) and that was too slow even for sensor reading
> making it take longer than 50s.  With the 100us-200us sleep, it got
> down to ~5s which was good enough for our use case and the cpu /
> scheduler impact was still mostly negligible.  I can't tell for sure
> without testing but going significantly below 100us is likely to
> become visible pretty quickly.

I spent some time looking at this.  Without the patch, I
measured around 3.5ms to send/receive a get device ID message
and uses 100% of the CPU on a core.

I measured your patch, it slowed it down to around 10.5ms
per message, which is not good.  Though it did just use a
few percent of the core.

I wrote some code to auto-adjust the timer.  It settled on
a delay around 35us, which gave 4.7ms per message, which is
probably acceptable, and used around 40% of the CPU.  If
I use any timeout (even a 0-10us range) it won't go below
4ms per message.

The process is running at nice 19 priority, so it won't
have a significant effect on other processes from a priority
point of view.  It may still be hitting the scheduler locks
pretty hard, though.  But I played with things quite a bit
and the behavior or the management controller is too
erratic to set a really good timeout.  Maybe other ones
are better, don't know.

One other option we have is that the driver has something
called "maintenance mode".  If it detect that you have
reset the management controller or are issuing firmware
commands, it will modify timeout behavior.  It can also
be activated manually.  I could also make it switch to
just calling schedule instead of delaying when in that
mode.

The right thing it do is complain bitterly to vendors who
build hardware that has to be polled.  But besides that,
I'm thinking the maintenance mode is the thing to do.
It will also change behavior if you reset the management
controller, but only for 30 seconds or so.  Does that
work?

-corey

> 
> We can also take a hybrid approach where we busy poll w/ 1us udelay
> upto, say, fifty times and then switch to sleeping poll.
> 
> Are there some tests which can be used to verify the cases which may
> get impacted by these changes?
> 
> Thanks.
> 
> -- 
> tejun
