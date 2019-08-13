Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69AAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B898920844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565717481;
	bh=VX8Z2lloO6l5GDML3vLgzlVdObVx93RSyJ7TafutxOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sdPZ8ULkVPqtHy/WeWPI0RYhZmvHsQwVmwP/few39aVJd1EfarfHSHGR2+1au+Sm1
	 sWZqtbi92v3nFes53z1slJimM7B23DMIBjJ28kpMkJg+mQUMGeScf7Btv00IN8v0qW
	 OvJPzKaVEUvXpYzkIjbg5pf6rglz3D6TTBHqM2Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfHMRbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfHMRbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:31:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5DE620663;
        Tue, 13 Aug 2019 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565717479;
        bh=VX8Z2lloO6l5GDML3vLgzlVdObVx93RSyJ7TafutxOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tn8d5Q/fIY4PODBCqR+sIAz5un/FsWAS5Ky8s12p4cV7/Cf8Z2dpD1EaMiLRtOuhZ
         nDoJG/qtaKMBCWd69mYTHLRPMOn4vj3Hjvz1Ha0rDIXxIg7jv/ia1ngjzCLDEdIbgT
         M6gjrOqtlxY8OGQDlwgiYYDZe7g+/ErZ4VlmjSpg=
Date:   Tue, 13 Aug 2019 18:31:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiping Ma <Jiping.Ma2@windriver.com>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] tracing/arm64: Have max stack tracer handle the
 case of return address after data
Message-ID: <20190813173114.himeal2ublebx7ea@willie-the-truck>
References: <20190807172826.352574408@goodmis.org>
 <20190807172907.155165959@goodmis.org>
 <20190808162825.7klpu3ffza5zxwrt@willie-the-truck>
 <20190808123632.0dd1a58c@gandalf.local.home>
 <20190808171153.6j56h4hlcpcl5trz@willie-the-truck>
 <20190808132455.5fa2c660@gandalf.local.home>
 <21530ce5-3847-c669-2a64-7c59ffb45f35@windriver.com>
 <20190808222440.2f99c50e@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808222440.2f99c50e@oasis.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, Aug 08, 2019 at 10:24:40PM -0400, Steven Rostedt wrote:
> On Fri, 9 Aug 2019 10:17:19 +0800
> Jiping Ma <Jiping.Ma2@windriver.com> wrote:
> > On 2019年08月09日 01:24, Steven Rostedt wrote:
> > > On Thu, 8 Aug 2019 18:11:53 +0100
> > > Will Deacon <will@kernel.org> wrote:
> > >  
> > >>> We could make it more descriptive of what it will do and not the reason
> > >>> for why it is done...
> > >>>
> > >>>
> > >>>    ARCH_FTRACE_SHIFT_STACK_TRACER  
> > >> Acked-by: Will Deacon <will@kernel.org>  
> > > Thanks Will!
> > >
> > > Here's the official patch.
> > >
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > >
> > > Most archs (well at least x86) store the function call return address on the
> > > stack before storing the local variables for the function. The max stack
> > > tracer depends on this in its algorithm to display the stack size of each
> > > function it finds in the back trace.
> > >
> > > Some archs (arm64), may store the return address (from its link register)
> > > just before calling a nested function. There's no reason to save the link
> > > register on leaf functions, as it wont be updated. This breaks the algorithm
> > > of the max stack tracer.
> > >
> > > Add a new define ARCH_RET_ADDR_AFTER_LOCAL_VARS that an architecture may set  
> > 
> > ARCH_FTRACE_SHIFT_STACK_TRACER is used in the code.
> 
> Ah, I did a s/x/y/ to the diff of the patch, but not the change log.
> Thanks for pointing that out. I also need to update the comment in 2/2.

Are you going to post another version of this or have you queued it already?
Just want to make sure it doesn't slip through the cracks.

Cheers,

Will
