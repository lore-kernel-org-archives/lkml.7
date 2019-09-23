Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB0FC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1489320B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569253578;
	bh=FiqxO5vOFpfEajpmFyifFKLOjMPLxhdkC+SAEI/lKXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HUpY9KS/BkgUZvSICLnjcvgzpCbhAul73bBdFIat+hMgSdPUa30kr1cexiUbqDTfm
	 Tvp/mr7jKLPgcIxLfmWUpFbs6H7yHfVoBeOpxjszqRtTwLUPQmXsIjDlyiPzUSGzph
	 uQPW1qi6VeEaISAoi/QN30etYZdQaBehbjuXo7AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfIWPqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732703AbfIWPqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:46:15 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E78042054F;
        Mon, 23 Sep 2019 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569253574;
        bh=FiqxO5vOFpfEajpmFyifFKLOjMPLxhdkC+SAEI/lKXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vT4NIUL8bKRmTKNBMLTV+r1V4quP6JJ67WPCeJNnNDEks2Ynn+IdscSLWO9CMFgBz
         euwJrlAde7Bz+zw1Wmd4+dEIT4u0OZhz7f2t0xuIjdGSUj2DZRLBE47BkYqoPK0vtS
         FP2qMH5OUpyOMfxE8TKbdWc+yiSTuJoULqFSP8hY=
Date:   Mon, 23 Sep 2019 17:46:12 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 6/6] posix-cpu-timers: Return -EPERM if ptrace
 permission check fails
Message-ID: <20190923154611.GB11264@lenoir>
References: <20190923145435.507024424@linutronix.de>
 <20190923145528.963075294@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923145528.963075294@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 04:54:41PM +0200, Thomas Gleixner wrote:
> Returning -EINVAL when a permission check fails is not really intuitive and
> can cause hard to diagnose problems.
> 
> The POSIX specification for clock_gettime() and timer_create() requires to
> obtain the clock id first by invoking clock_getcpuclockid().
> 
> clock_getcpuclockid() can return -EPERM if the caller does not have
> permissions. That does not make sense in two aspects:
> 
>  - Nothing prevents the caller to make up a clockid and feed it into the
>    syscalls
> 
>  - clock_getcpuclockid() is a helper function in glibc which just mangles
>    the PID/TID bits to the proper place and glibc cannot do any permission
>    checks at all for this function.
> 
> In order to prevent abuse the kernel has to do the permission checking in
> timer_create() and clock_gettime(). Those functions have only -EINVAL as
> documented return values, but returning -EINVAL for a valid clockid when
> the permission check fails is not understandable for programmers.
> 
> So ignore the POSIX specification and return -EPERM when the ptrace
> permission check fails.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
