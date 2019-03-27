Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE31CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFCA213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553649178;
	bh=tbmc6N+Ba9QLx5qC/HdtUY3NQBGbPdk01TGWATRrEOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v5cVYzBRBSiJVSm0O4s7Ks6Y3tx8qmpObscy6+kt7c1OuJqMAy2eLYLG9SgduJQQn
	 HGoOkRfqO8uzR3Htck+rwWKfR8ad6i+qUQy8O8w1O12AHsURjkWcU8kbVNQEeB7o4Q
	 1KbPz58v9f7E0af8cVnkJcyQFmkeQBFzX4cyCQAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfC0BM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfC0BM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:12:56 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727B5208E4;
        Wed, 27 Mar 2019 01:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553649176;
        bh=tbmc6N+Ba9QLx5qC/HdtUY3NQBGbPdk01TGWATRrEOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNu5ppDiwteIUYheXnJW+opTzRyyFwrxvKAnlVjO3ZNwHwZLdwAdEWs4j7WhUapow
         oV5SBqiGjjQuvOFGSHaR2roFKyhqi1FwluHmLpqKTmRuHe+EsFvKifGuN8F2LaqVRm
         dx/ZkRM5LpWFAi/xYAtBX8toht3M/pU7PJkbKv/Q=
Date:   Wed, 27 Mar 2019 10:12:51 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Micheal Kelley <michael.h.kelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [patch 2/2] x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y
Message-ID: <20190327011251.GB3099@kroah.com>
References: <20190326163604.348882514@linutronix.de>
 <20190326163811.598166056@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326163811.598166056@linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:36:06PM +0100, Thomas Gleixner wrote:
> The SMT disable 'nosmt' command line argument is not working properly when
> CONFIG_HOTPLUG_CPU is disabled. The teardown of the sibling CPUs which are
> required to be brought up due to the MCE issues, cannot work. The CPUs are
> then kept in a half dead state.
> 
> As the 'nosmt' functionality has become popular due to the speculative
> hardware vulnerabilities, the half torn down state is not a proper solution
> to the problem.
> 
> Enforce CONFIG_HOTPLUG_CPU=y when SMP is enabled so the full operation is
> possible.
> 
> Reported-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Konrad Wilk <konrad.wilk@oracle.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Micheal Kelley <michael.h.kelley@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/Kconfig |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
