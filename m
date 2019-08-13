Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AADC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAEF20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfHMRsD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfHMRsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:48:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33BDC2067D;
        Tue, 13 Aug 2019 17:48:01 +0000 (UTC)
Date:   Tue, 13 Aug 2019 13:47:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jiping Ma <Jiping.Ma2@windriver.com>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] tracing/arm64: Have max stack tracer handle the
 case of return address after data
Message-ID: <20190813134759.68009352@gandalf.local.home>
In-Reply-To: <20190813173114.himeal2ublebx7ea@willie-the-truck>
References: <20190807172826.352574408@goodmis.org>
        <20190807172907.155165959@goodmis.org>
        <20190808162825.7klpu3ffza5zxwrt@willie-the-truck>
        <20190808123632.0dd1a58c@gandalf.local.home>
        <20190808171153.6j56h4hlcpcl5trz@willie-the-truck>
        <20190808132455.5fa2c660@gandalf.local.home>
        <21530ce5-3847-c669-2a64-7c59ffb45f35@windriver.com>
        <20190808222440.2f99c50e@oasis.local.home>
        <20190813173114.himeal2ublebx7ea@willie-the-truck>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019 18:31:14 +0100
Will Deacon <will@kernel.org> wrote:

> Hi Steve,
> 
> On Thu, Aug 08, 2019 at 10:24:40PM -0400, Steven Rostedt wrote:
> > On Fri, 9 Aug 2019 10:17:19 +0800
> > Jiping Ma <Jiping.Ma2@windriver.com> wrote:  
> > > On 2019年08月09日 01:24, Steven Rostedt wrote:  
> > > > On Thu, 8 Aug 2019 18:11:53 +0100
> > > > Will Deacon <will@kernel.org> wrote:
> > > >    
> > > >>> We could make it more descriptive of what it will do and not the reason
> > > >>> for why it is done...
> > > >>>
> > > >>>
> > > >>>    ARCH_FTRACE_SHIFT_STACK_TRACER    
> > > >> Acked-by: Will Deacon <will@kernel.org>    
> > > > Thanks Will!
> > > >
> > > > Here's the official patch.
> > > >
> > > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > >
> > > > Most archs (well at least x86) store the function call return address on the
> > > > stack before storing the local variables for the function. The max stack
> > > > tracer depends on this in its algorithm to display the stack size of each
> > > > function it finds in the back trace.
> > > >
> > > > Some archs (arm64), may store the return address (from its link register)
> > > > just before calling a nested function. There's no reason to save the link
> > > > register on leaf functions, as it wont be updated. This breaks the algorithm
> > > > of the max stack tracer.
> > > >
> > > > Add a new define ARCH_RET_ADDR_AFTER_LOCAL_VARS that an architecture may set    
> > > 
> > > ARCH_FTRACE_SHIFT_STACK_TRACER is used in the code.  
> > 
> > Ah, I did a s/x/y/ to the diff of the patch, but not the change log.
> > Thanks for pointing that out. I also need to update the comment in 2/2.  
> 
> Are you going to post another version of this or have you queued it already?
> Just want to make sure it doesn't slip through the cracks.
> 

Ah, it's in my queue. I should post a new version :-/

Thanks for the reminder.

-- Steve
