Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F217FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9388217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569026692;
	bh=Te/m6/7GJlv2oDlu3hgb6EgQIQM9jUE/siwDpYLg5hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LHhLG4a5cNOUxaPwGLFFfxRbl4nDs+eyIGEyA5BA30RCFh8Btjr/8iJpchv1nC6sA
	 xJR4TbqWWYpBtcIV+2TyFRLasv9e9dx7JGOVvUtEyOmi7sMllUHwVJ5dD7KwwYcBH3
	 6kz9w+qX+6jUYqY7GBauxEX66/NfVbfUwN6KKo/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394081AbfIUAou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 20:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389377AbfIUAou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:44:50 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A6D217F5;
        Sat, 21 Sep 2019 00:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569026689;
        bh=Te/m6/7GJlv2oDlu3hgb6EgQIQM9jUE/siwDpYLg5hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juD0b7fgFedKIs6LWD3J6/PIqf9qQw6cGJFk/AWUZ6Z+kb+d/XS1i4gc+Ppsq9KfZ
         ZPxQ9T8KuRO3BoQodu/Xjf10T4PHl/mbbaugxIsj4mFfbcv31DDj/Pd58ZYLOJqEpU
         mpAQCchnkOdbXxwMZiiuasNM9h0et2gK84jvA9fk=
Date:   Sat, 21 Sep 2019 02:44:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 3/6] posix-cpu-timers: Restrict timer_create() permissions
Message-ID: <20190921004445.GB6449@lenoir>
References: <20190905120339.561100423@linutronix.de>
 <20190905120539.888798188@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120539.888798188@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:42PM +0200, Thomas Gleixner wrote:
> Right now there is no restriction at all to attach a Posix CPU timer to any
> process in the system. Per thread CPU timers are limited to be created by
> threads in the same thread group.
> 
> Timers can be used to observe activity of tasks and also impose overhead on
> the process to which they are attached because that process needs to do the
> fine grained CPU time accounting.
> 
> Limit the ability to attach timers to a process by checking whether the
> task which is creating the timer has permissions to attach ptrace on the
> target process.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Makes sense. I hope no serious user currently rely on that lack of
restriction. Let's just apply and wait for complains if any.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
