Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC37CC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9062A21734
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565029135;
	bh=PvvQIrdlb9AEbjRhyvm06RUNUNrYnsq1UocRxeHCGKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qp0DVEG0NxdxZpRGTWNOfBQqZuJqoYgImNYsJ7e9VWXnX4SXwaaT/VoOgCOBSx0Iz
	 YwFZHh8/gMnKpfbNm7qOtXq4uE0ivKP85JTZfNFprEErLtSoP5cSMISq/uxiDUgcfA
	 YHUfdAFGBUx/xq54MoDIQRvGYUun+qiqfE4S6iKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfHESSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:18:54 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37464 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfHESSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:18:54 -0400
Received: by mail-qk1-f175.google.com with SMTP id d15so60814566qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WaiMpJM6wmUrTlGb1M5WnJo1GmhESZg0oc856bSZaeI=;
        b=VhG2X0bjL7c7zyfuEQEH7WHjMT/El0t1r90O2Ygdv1S9Yp8rULuUqTO0TRE6eZkYH8
         c8J72/M4cbxh9au+cSSMCrMKlN8YMQEdgaDB3oViwzoe3R1WidRQPCizUcjVM2tzqV66
         33QWkPmb55QoUX2Geg+mVF0lGpDa8EK3Db6Ky4LcSxeb5lbbCRaP+lFHv0nYHtSMR3hC
         9pI9OtlClLGzXdhN4IZtZeuWr5PVw12MY9DGp8EjaEI85JDg4qHG1dUZmoUGX7ZZUNKu
         QQKZqG29mS5rtVx9Aevl7FiJo4oQ8aMh0eLYAzdZxo0ZJY+8WtcDATXkswJ7oSrz1aQz
         D+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WaiMpJM6wmUrTlGb1M5WnJo1GmhESZg0oc856bSZaeI=;
        b=PIuYDzEk1BmFWYgKRULWXIFzMOjWMMdi3HRzMiAS/LphcT9Oel9whI9M+4D/xKO5JB
         6rsOiEuTNHIo2mIgfxJSRZbL71EfgcsaueNsyjUhFVkSpjSrg0BDswQDuZZnXuxKAdlS
         ZPz1s6YUgHTsVzzK++d9X6nbFZlgL5rIbkkUkdf7RsZGUk0L0VN6rRfwGG30A+B7qfP2
         dURKf7h++fsuQJVkoQET6y0Das8UPR9NrLX3UIzumg3YrJZkpJ2msvbMPY54hVJgZG5e
         qkQRtzVBtdlg+05K2dusawRi+nh1fX7++msqaQyQiuLT5/sYlCao9fKIuLlAd1Em7pfB
         SzDg==
X-Gm-Message-State: APjAAAWtgiPz9yhLX+J0XSCbW9rrvQa6+0CxiuPihVW4rEhEXADZYSgW
        suC+L2Kx3Urxap9GoUnRXCI=
X-Google-Smtp-Source: APXvYqzjIA0DKIHR/Qh6C4C36/MpQFi9/z6kf8TgvCA6b67TRh+R/U2pGzyk/D7AjGDmNJXAXIc7aQ==
X-Received: by 2002:a37:61c3:: with SMTP id v186mr97547335qkb.158.1565029133207;
        Mon, 05 Aug 2019 11:18:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::39f3])
        by smtp.gmail.com with ESMTPSA id l63sm35761964qkb.124.2019.08.05.11.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 11:18:52 -0700 (PDT)
Date:   Mon, 5 Aug 2019 11:18:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190805181850.GI136335@devbig004.ftw2.facebook.com>
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709220908.GL657710@devbig004.ftw2.facebook.com>
 <20190709230144.GE19430@minyard.net>
 <20190710142221.GO657710@devbig004.ftw2.facebook.com>
 <20190801174002.GC5001@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801174002.GC5001@minyard.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Corey.

On Thu, Aug 01, 2019 at 12:40:02PM -0500, Corey Minyard wrote:
> I spent some time looking at this.  Without the patch, I
> measured around 3.5ms to send/receive a get device ID message
> and uses 100% of the CPU on a core.
> 
> I measured your patch, it slowed it down to around 10.5ms
> per message, which is not good.  Though it did just use a
> few percent of the core.
> 
> I wrote some code to auto-adjust the timer.  It settled on
> a delay around 35us, which gave 4.7ms per message, which is
> probably acceptable, and used around 40% of the CPU.  If
> I use any timeout (even a 0-10us range) it won't go below
> 4ms per message.

Out of curiosity, what makes 4.7ms okay and 10.5ms not?  At least for
the use case we have in the fleet (sensor reading mostly), the less
disruptive the better as long as things don't timeout and fail.

> The process is running at nice 19 priority, so it won't
> have a significant effect on other processes from a priority
> point of view.  It may still be hitting the scheduler locks
> pretty hard, though.  But I played with things quite a bit

And power.  Imagine multi six digit number of machines burning a full
core just because of this busy loop to read temperature sensors some
msecs faster.

> and the behavior or the management controller is too
> erratic to set a really good timeout.  Maybe other ones
> are better, don't know.
> 
> One other option we have is that the driver has something
> called "maintenance mode".  If it detect that you have
> reset the management controller or are issuing firmware
> commands, it will modify timeout behavior.  It can also
> be activated manually.  I could also make it switch to
> just calling schedule instead of delaying when in that
> mode.

Yeah, whatever which makes the common-case behavior avoid busy looping
would work.

> The right thing it do is complain bitterly to vendors who
> build hardware that has to be polled.  But besides that,

For sure, but there already are a lot of machines with this thing and
it'll take multiple years for them to retire so...

> I'm thinking the maintenance mode is the thing to do.
> It will also change behavior if you reset the management
> controller, but only for 30 seconds or so.  Does that
> work?

Yeah, sounds good to me.

Thnaks.

-- 
tejun
