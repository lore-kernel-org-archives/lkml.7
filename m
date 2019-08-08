Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22951C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74E621880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565284320;
	bh=n9N+2ogYvhjh6Z7m4NA+9Lykt626vgxp8SEb6zzXmko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d4vAklBE6+PxUbZMRIsPWT+Oyjzmyj6BV2bAada7A7JnhaCmdtR3sOJbwLaKdd0we
	 P//Tuj5qyQaLRAOy2TS/r+SrNqnTkZOa9/gvih7k/GkTUFi728w0kld/oWyEKk67S4
	 cZl6RlcMLCClFAjJlR2iIaWMLj9Imh1ADGVktiXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404243AbfHHRL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfHHRL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:11:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E8C2184E;
        Thu,  8 Aug 2019 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565284317;
        bh=n9N+2ogYvhjh6Z7m4NA+9Lykt626vgxp8SEb6zzXmko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/yMtJyJrKNNoBZaCJtq/N72+wRPgLi+tUAHyqDBNzPVnuv+Ph4gypls757QGqzcx
         0rp4W96bJWgQYuTItbVaiY3aum2fpiB9Ikr+vej8fdUIOJ29djofDrIueS612UJa8A
         IrmeIIT4+RZZVcaa5Mangm1Pu1U1igCM8QSxRhf8=
Date:   Thu, 8 Aug 2019 18:11:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Jiping Ma <jiping.ma2@windriver.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] tracing/arm64: Have max stack tracer handle the
 case of return address after data
Message-ID: <20190808171153.6j56h4hlcpcl5trz@willie-the-truck>
References: <20190807172826.352574408@goodmis.org>
 <20190807172907.155165959@goodmis.org>
 <20190808162825.7klpu3ffza5zxwrt@willie-the-truck>
 <20190808123632.0dd1a58c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808123632.0dd1a58c@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:36:32PM -0400, Steven Rostedt wrote:
> On Thu, 8 Aug 2019 17:28:26 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > > + * Note, this may change in the future, and we will need to deal with that
> > > + * if it were to happen.
> > > + */
> > > +#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1  
> > 
> > I know it's long already, but prefixing this with FTRACE_ would be good so
> > that other code doesn't use it for anything. It's not the end of the world
> > if the ftrace stack usage statistics are wonky, but if people tried to use
> > this for crazy things like livepatching then we'd be in trouble.
> > 
> > Maybe FTRACE_ARCH_FRAME_AFTER_LOCALS, which is the same length as what
> > you currently have?
> 
> Note, it would still need to be prefixed with "ARCH_" as that's the way
> of showing arch specific defines.
> 
> We could make it more descriptive of what it will do and not the reason
> for why it is done...
> 
> 
>   ARCH_FTRACE_SHIFT_STACK_TRACER

Acked-by: Will Deacon <will@kernel.org>

Thanks, Steve.

Will
