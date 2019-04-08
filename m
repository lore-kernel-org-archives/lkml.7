Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43D021473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554736242;
	bh=EKpT785ZLjUmMCMjDY46/ivjsr8FzlRFFl9usJre3lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HwXoscg/QFaf2qRl8deasdCVtFoKCZH7GV9Ritj54xqKQqWWk9rPsL4PALlF8cRRN
	 K6xQNRwnwpJ6OozfasndO5zD9ALDtBEESz69HvLI/kWDsUgVAo123DB+C+hH7OCmFT
	 qzajqELvdywb+tCI1dLSvmzO0rIt6Btqbm9z2+gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfDHPKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:10:41 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:32996 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDHPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:10:41 -0400
Received: by mail-yb1-f193.google.com with SMTP id i10so5294919ybk.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9m4FOQLfq7QfTKu/uMXz/CdulaGpOhzU3DCk+O7A7Xg=;
        b=pN+HkcLnV8ezBOW1/NsYLNwrJxtlO/qc4IIPyzFdhmcUWnfkXggQ7Xp+b0tas9V+fh
         Y10NgLybZkPZNOfwdVIoV+i6jx2kV3qInL49aVAeSazFG8Vyby3YVjkEokkSLphQC56G
         aEPR+pM9+rHX5qtf+eb3h0ks7Nw9TvUSlH4qWNQ7og/sFqHKUxJ2aCkwvQQ8x+XNf3Cn
         lF+DCpY+4T7994iUvZWbviLxfnZs31RYCRE5AqCjA7tUasXDopBUMClc0KXD6DxkL8FW
         kRJt0biVb0qPK/iib/WY9xLlPyPIZObe3KGbVxExoEHu869sljGa4skUlU1iBQVt2AZM
         rsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9m4FOQLfq7QfTKu/uMXz/CdulaGpOhzU3DCk+O7A7Xg=;
        b=XGF6Fui9VnFcKbYctdXIqwmVxjpBF6Wa+7YOiVvnGkVbUhx0qwIvzH916b58TMS7GE
         ThyzbDMMyW/oq1C9IBLryi00RpnHimOqekLUg6sK4K9+RJbNX8SrEidWvOW8uPkrbRWL
         laWLclIkBm9J1svdueg7aeZkg7MbE70Ko09eZ7Qa3+QvaWJ1Nf5/LgvHrkIq7k84BJ1D
         rRoQOrM5pBnrclHslDxDexSJz+t5ENzXJHrEskoiwc/9PcsAXC1VgBXhwsknjuYtu9Va
         7UquXMsL0pQEuQszcZvzOlFSmPuGqhtTC4XkpI+yMiL7Gh3LcBaAmaN+UOwI3DRY09c5
         ANXw==
X-Gm-Message-State: APjAAAVGG+NrEHlVDX3TCxWmVSz5Z4qqyi3LZgFkGhvx3TQyTHDq1CGd
        XB8cwwM6+xHaTu9kGq/1zJ4=
X-Google-Smtp-Source: APXvYqzyC6L4oXjjyLLMrTIPMzcyInhtygGxy5lMNqxtJUBmyjyunnG0fL8zAk0xfSg3i1kVNwmnlQ==
X-Received: by 2002:a25:81c9:: with SMTP id n9mr5893691ybm.246.1554736240054;
        Mon, 08 Apr 2019 08:10:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:135c])
        by smtp.gmail.com with ESMTPSA id l82sm10590289ywl.6.2019.04.08.08.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:10:39 -0700 (PDT)
Date:   Mon, 8 Apr 2019 08:10:37 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] workqueue: Use normal rcu
Message-ID: <20190408151037.GH1975820@devbig004.ftw2.facebook.com>
References: <20190313165548.19713-1-bigeasy@linutronix.de>
 <20190313165548.19713-2-bigeasy@linutronix.de>
 <20190321205935.7ndo5k5zumc77h37@linutronix.de>
 <20190322174334.GC69236@devbig004.ftw2.facebook.com>
 <20190322175923.5o6y53yiseo3phif@linutronix.de>
 <20190405144218.gvfft6aw36ciogfi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405144218.gvfft6aw36ciogfi@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sebastian.

On Fri, Apr 05, 2019 at 04:42:18PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-03-22 18:59:23 [+0100], To Tejun Heo wrote:
> > On 2019-03-22 10:43:34 [-0700], Tejun Heo wrote:
> > > Hello,
> Hi,
> 
> > > We can switch but it doesn't really say why we'd want to.  Can you
> > > please explain why this is better?
> > 
> > there is this undocumented part. Avoiding the sched RCU means also we
> > are more preemptible which is good :) Especially on -RT where we can't
> > disable preemption across the whole critical section.
> > 
> > Is this good enough?
> 
> a gentle ping.

Heh, yeah, sorry about dragging my feet on it.  The patchset itself
doesn't actually improve the upstream kernel (except for the obvious
bug fix where it's using the wrong call_rcu right now), so I've been
constantly on the fence.  At the same time, it doesn't really worsen
anything either.  Imma look through the patches once more later today.

Thanks.

-- 
tejun
