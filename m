Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4D5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218AE214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573145724;
	bh=9Qx3vmFd4+b4Sv1z9J23Cc5K7UoVjXFQY2SKmavGJh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fKSCy8AKEBR5JTfi5ozXo+rHJFdPVtaTf9PdJcnyj32PuDnZxIkTxJbumfP5rpzcK
	 62UjfjaBYeKi7CkSaqWwWBMkcp45WY28DrY8Eqt9HEnqfgWQPGBwkbeph7tVMcJ/Gh
	 FbefwTq1uqTB73T0YDz2Fxrrj2vnqbuPd59alOFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbfKGQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:55:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35043 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfKGQzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:55:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id i19so2614975qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=40D2HnLK9UafcSefJMy/uC7cBWC9QZTIxI56cVPOeuc=;
        b=WKAX2juoFaRBQOgbIfuHmV4wQjMyq3ooDWDpbItmlf1q5bA08z2G1sN8bNIszXmNje
         tA6mmuEMl08JI5BQHkoSfU5e3ZJb/QGxX/0xZO1r7BAelQPkjxeXS9zgRM9alLOwIqIv
         CpEqxPFMLMzrAPonuNKbQKXJ4g6k7sFSSX1GElxoBZcBYKa7o7ae1eX7xMquzrL2QYwc
         V5lRX7H4fEWqF8ymNgaRYiXE1AeMScWVnSBAsSAhXNx0pM/8cqwbo+BoqO3j3+toBp14
         XdSZ+1Qp0fG6lQa5sh11+gTNRR3xVbPZKoD0dXF9Ak8tdtz3mfSk2aJ7uEcBkqCRKgwf
         jrLQ==
X-Gm-Message-State: APjAAAURbiz0h3xQynqLi1WmuHqJCh6/YNPN6wJYjwUNyk7Abe6sBuBI
        RaJZE0a0BzIaU/ObppzFH2w=
X-Google-Smtp-Source: APXvYqxKgFkNVtel6CxBLRl5CUG7wk4STDC80hHFEp5Q1GrGM9htmtlbCC1VSi/niLEcNWLMFQzLkQ==
X-Received: by 2002:a37:96c1:: with SMTP id y184mr22815qkd.44.1573145721641;
        Thu, 07 Nov 2019 08:55:21 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::3:db5f])
        by smtp.gmail.com with ESMTPSA id y29sm2141100qtc.8.2019.11.07.08.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:55:20 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:55:19 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191107165519.GA99408@dennisz-mbp>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
 <20191107161749.GA93945@dennisz-mbp>
 <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 05:28:42PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-11-07 11:17:49 [-0500], Dennis Zhou wrote:
> > Hello,
> 
> Hi,
> 
> > I just want to clarify a little bit. Is this patch aimed at fixing an
> > issue with RT kernels specifically? 
> 
> Due to the implications of preempt_disable() on RT kernels it fixes
> problems with RT kernels.
> 

Great, do you mind adding this explanation with what the implications
are in the commit message?


> > It'd also be nice to have the
> > numbers as well as if the kernel was RT or non-RT.
> 
> The benchmark was done on a CONFIG_PREEMPT kernel. As said in the commit
> log, the numbers were mostly the same, I can re-run the test and post
> numbers if you want them.
> This patch makes no difference on PREEMPT_NONE or PREEMPT_VOLUNTARY
> kernels.
> 

I think a more explicit explanation in the commit message would suffice.

Thanks,
Dennis
