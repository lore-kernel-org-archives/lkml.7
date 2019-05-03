Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30112C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004C52070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rSOqH7Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfECNzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:55:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37666 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ALgcqCtqCqOGvegvBJbnoppT5gDBB9wFVtxlPQfWxJ4=; b=rSOqH7Y7dB0q+WGGArvuwubx2
        xfwvuCL173N0TCzBY+atLybyrLySXjcFgnAuDB8FDkwz4P83zwvfLEkfttt19qPsUaWk5BhfDDiZi
        fwMATyBMZIZlT7lGLCH4dQUagQ1e0fofItj807gvtD9qhAIg7T5COxrdTkex45Rl/8wR4o+bxZHBr
        L5vye6VwsVHFezQ4IAAkyAjxOp3Wev/avoiLulN2JVhOpNyubPm7SwSRpzdiC6BbT9PwzkVrfW+2I
        cbxla5CLXbdTIL9z3iQtQuWGZkybFsRssW+yWrR41P9r6XKD5NHS/ztQeHc1Qo6fnYI6u+kUPj5Xr
        DGW79aGQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMYdw-0007F7-1b; Fri, 03 May 2019 13:54:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39C93214242EB; Fri,  3 May 2019 15:54:26 +0200 (CEST)
Date:   Fri, 3 May 2019 15:54:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org,
        Michal Gregorczyk <michalgr@live.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Mohammad Husain <russoue@gmail.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        duyuchao <yuchao.du@unisoc.com>,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC] bpf: Add support for reading user pointers
Message-ID: <20190503135426.GA2606@hirez.programming.kicks-ass.net>
References: <20190502204958.7868-1-joel@joelfernandes.org>
 <20190503121234.6don256zuvfjtdg6@e107158-lin.cambridge.arm.com>
 <20190503134935.GA253329@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503134935.GA253329@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 09:49:35AM -0400, Joel Fernandes wrote:
> In
> particular, we learnt with extensive discussions that user/kernel pointers
> are not necessarily distinguishable purely based on their address.

This is correct; a number of architectures have a completely separate
user and kernel address space. Much like how the old i386 4G:4G patches
worked.
