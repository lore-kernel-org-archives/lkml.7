Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D68C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1987B214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfHEN7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbfHEN7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:59:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E502120B1F;
        Mon,  5 Aug 2019 13:59:19 +0000 (UTC)
Date:   Mon, 5 Aug 2019 09:59:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jiping Ma <jiping.ma2@windriver.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, takahiro.akashi@linaro.org
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch
 in arm64
Message-ID: <20190805095918.3942c45b@gandalf.local.home>
In-Reply-To: <20190805112524.ajlmouutqckwpqyd@willie-the-truck>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
        <20190802112259.0530a648@gandalf.local.home>
        <20190803082642.GA224541@google.com>
        <20190805112524.ajlmouutqckwpqyd@willie-the-truck>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2019 12:25:25 +0100
Will Deacon <will@kernel.org> wrote:

> So, I completely agree with Steve that we shouldn't be littering the core code
> with #ifdef CONFIG_ARM64, but we probably do need something in the arch backend
> if we're going to do this properly, and that in turn is likely to need a very
> different algorithm from the one currently in use.

And I'm perfectly fine if someone wants to tear up the current
implementation, and make one that has callbacks to arch code (with
defaults for those that don't need it).

But it has to be clean. We worked hard to get rid of most "#ifdef"
being scattered in the kernel, and I'm not bringing it back in my code.

-- Steve
