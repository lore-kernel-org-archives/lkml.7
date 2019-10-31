Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF6ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE252080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfJaNAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:00:30 -0400
Received: from foss.arm.com ([217.140.110.172]:48184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaNA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:00:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2D1B1FB;
        Thu, 31 Oct 2019 06:00:28 -0700 (PDT)
Received: from blommer (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD8B03F71E;
        Thu, 31 Oct 2019 06:00:24 -0700 (PDT)
Date:   Thu, 31 Oct 2019 13:00:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Torsten Duwe <duwe@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, Jessica Yu <jeyu@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 2/8] module/ftrace: handle patchable-function-entry
Message-ID: <20191031130022.GB3477@blommer>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-3-mark.rutland@arm.com>
 <20191030150302.GA965@suse.de>
 <20191031090231.GA3340@blommer>
 <20191031114223.GA11684@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031114223.GA11684@suse.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 12:42:23PM +0100, Torsten Duwe wrote:
> On Thu, Oct 31, 2019 at 09:02:32AM +0000, Mark Rutland wrote:
> > I agree that the CC_USING_PATCHABLE_FUNCTION_ENTRY ifdeffery could be
> > simplified, and that it would be nice to consistently use
> > FTRACE_CALLSITE_SECTION if we can. However, the generic linker script doesn't
> > include anything, and I don't see a good location for that to live.
> > 
> > What I could do is add an explicit comment:
> > 
> > /*
> >  * The ftrace call sites are logged to a section whose name depends on the
> >  * compiler option used. A given kernel image will only use one, AKA
> >  * FTRACE_CALLSITE_SECTION. We capture all of them here to avoid header
> >  * dependencies.
> >  */
> > #define MCOUNT_REC()						\
> > 			. = ALIGN(8);				\
> > 			__start_mcount_loc = .;			\
> > 			KEEP(*(__patchable_function_entries))   \
> > 			KEEP(*(__mcount_loc))                   \
> > 			__stop_mcount_loc = .;			
> > 
> > ... which should make the dependency clear. Does that sound good to you?
> 
> Beautiful. I just didn't want to miss the opportunity to have this cleaned
> up as well, and deemed this patch "closest" because of the definition of 
> FTRACE_CALLSITE_SECTION. Put it where you see it fit best.

Sure. I've folded the above into this patch, and pushed out an updated branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace-with-regs

Thanks,
Mark.
