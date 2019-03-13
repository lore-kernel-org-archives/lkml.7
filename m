Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84379C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB312146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552517255;
	bh=jOM7YFbP7b87c9/WtmjV6Nv0aLqZCF7mhZK4c23ri4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ukb2cPppCVq8TdkPrcShgGRkXCtdjJHmnM/oEGkDueA/XXBOQ89XDwhMSA89lFQEP
	 1DJCMTZVZgD03Tu8ockZTp7AQAMjmdcXTinhcLrLys8Lis6TpROiuGhmKxAGsqHoFp
	 rcIjTXrkM9RSc4JP8EWPXjwEMW//5Xj+O0s0D1OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCMWre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfCMWrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:47:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F532087C;
        Wed, 13 Mar 2019 22:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552517252;
        bh=jOM7YFbP7b87c9/WtmjV6Nv0aLqZCF7mhZK4c23ri4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bFO5argsAfj9TDcDPgTKQMx6NHVKLYeMHGnK1r0ZYk+j5qkzGVU1oWbzpwCjl8bci
         PY0Dm/aUnfdTd+W2v5yOdf3LjgqrLvDr20edP75PG6krf6weuhaiUv2TYYWyvBeavs
         j3SCsQNrUIE5e2FEmWcrNxHnYVsqFNFxm5kw74ag=
Date:   Thu, 14 Mar 2019 07:47:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] tracing/probe: Check event/group naming rule at
 parsing
Message-Id: <20190314074728.2e58af676503c2fe05d1f485@kernel.org>
In-Reply-To: <20190313112346.0b3fc25f@gandalf.local.home>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
        <155248009231.10815.12287201787254147977.stgit@devnote2>
        <20190313092355.6f434c9f@gandalf.local.home>
        <20190314000402.3b14693f9030e891648124f1@kernel.org>
        <20190313112346.0b3fc25f@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 11:23:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 14 Mar 2019 00:04:02 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > >  		strlcpy(buf, event, slash - event + 1);
> > > > +		if (!is_good_name(buf)) {
> > > > +			pr_info("Group name must follow the rule of C identifier\n");  
> > > 
> > > What do you mean by "C identifier"?  
> > 
> > I meant "the naming rules of C language identifiers". It means
> > that the name has to start with alphabet or "_" and only contain
> > alphanumeric characters and "_". Does it clear?
> > I couldn't think of a good word. maybe "naming convention"
> > does not fit...
> 
> Ah, OK that now makes sense.
> 
> > 
> > Would you have any idea?
> 
> I think I was more confused by the way it was stated. What about saying:
> 
> 	"Group names must follow the same rules as C identifiers"

OK, I will update it.

> Saying "the rule of C identifiers" made me think more of "the rule of
> law", and thought that this had something to do with rules of C
> zealots, and those that identify with "C" ;-)

Oh, I got it. :-)

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
