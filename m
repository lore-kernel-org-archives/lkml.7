Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D572C49ED7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10F12085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CZ78pD0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfIKAbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 20:31:04 -0400
Received: from mail.efficios.com ([167.114.142.138]:60804 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfIKAbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 20:31:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 58B03BD795;
        Tue, 10 Sep 2019 20:31:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id XrPThBl8tjVC; Tue, 10 Sep 2019 20:31:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 16B8ABD790;
        Tue, 10 Sep 2019 20:31:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 16B8ABD790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568161862;
        bh=ZOSuBOtnx5tmUa5F/y7B4GyOM6B9EVZ/X0moEBPnBkY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CZ78pD0Rexjepon13fo0YGJ4gEoHZTudCec6djL4In/r0hugkoiYLDmY901If39TL
         qvMpJTsLob6p2hMJbWm1VhN42XeFetkGXgtCAi0/jomSuvaavugP0I94iCjvRnhFZc
         OYw5fsDbHWdut6C1XqLNE2Xokw5s2oSH6CMHHe+A3FXBuAp9l2jAKrsyJnyKsuLyjo
         Plk9ICKdNCtSMKa8il45VMpkP54f1MXyFsc7ub6FYsP0AuloPNdr2Qh6ZEAhyMCGH3
         SlAmcYov8/M2eGqGURmvJHqkovwo8BOoNTBJoCBRXKSHREhXWU26BpRiWXVKLLjZnO
         DSPKEUg/skahA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id OhzEgqO9byjV; Tue, 10 Sep 2019 20:31:02 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id F070DBD787;
        Tue, 10 Sep 2019 20:31:01 -0400 (EDT)
Date:   Tue, 10 Sep 2019 20:31:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <248314994.16.1568161861658.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190911002744.8690-2-mathieu.desnoyers@efficios.com>
References: <20190911002744.8690-1-mathieu.desnoyers@efficios.com> <20190911002744.8690-2-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 2/4] rseq: Fix: Unregister rseq for CLONE_TLS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3829)
Thread-Topic: rseq: Fix: Unregister rseq for CLONE_TLS
Thread-Index: c0VdxbY5ZA77HRlxK+q7z56h9NwCIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Of course, this patch title should read:

  rseq: Fix: Unregister rseq for CLONE_SETTLS

----- On Sep 11, 2019, at 1:27 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

 
> /*
>  * If parent process has a registered restartable sequences area, the
> - * child inherits. Only applies when forking a process, not a thread.
> + * child inherits. Unregister rseq for a clone with CLONE_TLS set.

and here CLONE_SETTLS as well.

>  */
> static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
> {
> -	if (clone_flags & CLONE_THREAD) {
> +	if (clone_flags & CLONE_TLS) {

.. and here.

Thanks,

Mathieu

> 		t->rseq = NULL;
> 		t->rseq_sig = 0;
> 		t->rseq_event_mask = 0;
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
