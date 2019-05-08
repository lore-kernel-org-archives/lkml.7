Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC642C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997D7214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557291568;
	bh=g+Z9HqyXU24GVjs9nPnhk2hGHsa82QLxMRpZllwwn6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VQAkjTQJapRMSsqoitWL3E3sFlEWhSMWWHq6RJvyBY4FhI8QbM8hUnQGOsdZTwwxb
	 GyyK6wtJY82UeNeeC42uvMQWM8Lh0ZfkeYbKQb4c7oAUlTHwgKi8GX39FGHDPIGj38
	 xJq9Z9FP2CeoCl8EgacjSXxJ65PdIYvzbGU1UxCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfEHE71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfEHE7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:59:25 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433482053B;
        Wed,  8 May 2019 04:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291564;
        bh=g+Z9HqyXU24GVjs9nPnhk2hGHsa82QLxMRpZllwwn6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SmOAG6e0x1HKYQQy76n7fDPSqeRprxQowAEPSHH8AnFujwSjL4Y7YxPvR+rKeRk80
         vMtEZERJOoFMRcTtIAsxrdjs6xsWGqG+vYnFdOyJYqkqkHAnS1wWFrgh7DSiBtM7nl
         O5vxJfE5Hm2wweaqc7XJKfiSl74V3bVEUWVwH/F8=
Date:   Wed, 8 May 2019 13:59:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] tracing: probeevent: Fix probe argument parser
 and handler
Message-Id: <20190508135921.83b451dca88c79a1ae8e4fd4@kernel.org>
In-Reply-To: <20190507221006.17126aff@oasis.local.home>
References: <155723732200.9149.10482668315693777743.stgit@devnote2>
        <20190507221006.17126aff@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 22:10:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  7 May 2019 22:55:22 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here is the 3rd version of series to fix several bugs in probe event
> > argument parser and handler routines.
> > 
> > In this version I updated patch [1/3] according to Steve's comment.
> > 
> > 
> > I got 2 issues reported by Andreas, see
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899098.html
> > 
> > One issue is already fixed by Andreas (Thanks!) but $comm handling
> > issue still exists on uprobe event. [1/3] fixes it.
> > And I found other issues around that, [2/3] is just a trivial cleanup,
> > [3/3] fixes $comm type issue which occurs not only uprobe events but
> > also on kprobe events. Anyway, after this series applied, $comm must
> > be "string" type and not be an array.
> >
> 
> Thanks Masami,
> 
> I applied these to my queue.

Thank you, Steve! I'll rebase other series on that.



-- 
Masami Hiramatsu <mhiramat@kernel.org>
