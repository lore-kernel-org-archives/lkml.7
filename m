Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B94C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B5206DF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 16:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHQQnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 12:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfHQQnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 12:43:53 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0CC0205C9;
        Sat, 17 Aug 2019 16:43:51 +0000 (UTC)
Date:   Sat, 17 Aug 2019 12:43:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190817124337.6dd820a5@oasis.local.home>
In-Reply-To: <1982627598.23941.1566057221039.JavaMail.zimbra@efficios.com>
References: <00000000000076ecf3059030d3f1@google.com>
        <20190816142643.13758-1-mathieu.desnoyers@efficios.com>
        <20190816122539.34fada7b@oasis.local.home>
        <623129606.21592.1565975960497.JavaMail.zimbra@efficios.com>
        <20190816151541.6864ff30@oasis.local.home>
        <621310481.23873.1566052059389.JavaMail.zimbra@efficios.com>
        <20190817114218.5cb3912b@oasis.local.home>
        <1982627598.23941.1566057221039.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2019 11:53:41 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> kernel/trace/trace.c:tracing_record_taskinfo_sched_switch()
> kernel/trace/trace.c:tracing_record_taskinfo()
> 
> where @flags is used to control a few branches. I don't think any of those
> would end up causing corruption if the flags is re-fetched between two
> branches, but it seems rather fragile.

There shouldn't be any corruption, as each flag test is not dependent
on any of the other tests. But I do agree, a READ_ONCE() would be
appropriate for just making a consistent state among the tests, even
though they are independent.

-- Steve
