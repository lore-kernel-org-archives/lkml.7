Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD326C3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 01:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7462133F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 01:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LOOCBIjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHQBly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 21:41:54 -0400
Received: from mail.efficios.com ([167.114.142.138]:58622 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHQBly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 21:41:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 100EF2C8AF7;
        Fri, 16 Aug 2019 21:41:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 4bD5tckrquQn; Fri, 16 Aug 2019 21:41:52 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9F0DD2C8AF0;
        Fri, 16 Aug 2019 21:41:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9F0DD2C8AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566006112;
        bh=zQ5kyX3BoMU/lSWt7IJaEAtR2KYAxnW2BoyNEmvTJ4E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LOOCBIjZw9wxRsKgJFnZPyQEnqaJSJBImiW0nZvLV5nhOisNhgPjvrwYiPlBstpDO
         Ffuu04MO7f7IiE3l8B8R2LfH5bm2/syblflE1XUWN+vjKbkKuyt32cLvaXft0o9TpW
         HClLV+F0uvirnqh29FlT34Hi1xn1UOedDq+QPeH9UZLMtgZ1Y/9efdugP8xGD2U3Be
         EAyKc/Yzhlq3tCJoQzUhXejQpWiuemyVdKADgl/iUjy0ZESKj+JNc5+dnAgsTOmofj
         YFR0PJmG+nKOnAYlsBeC6ix084nurvE7S/UkCncLFgNBUR/d8EygXBMTbia2pKFnYQ
         rW/mZyu89f6ng==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id fYlpQYeqH44y; Fri, 16 Aug 2019 21:41:52 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 81BBD2C8AE7;
        Fri, 16 Aug 2019 21:41:52 -0400 (EDT)
Date:   Fri, 16 Aug 2019 21:41:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Message-ID: <1498719317.23412.1566006112307.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com> <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org> <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com> <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de> <20190816205740.GF10481@google.com> <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com> <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: q5fyonBR6qpJ86alw/RmiuKF3F1/lQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2019, at 6:57 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> So in general, we very much expect the compiler to do sane code
> generation, and not (for example) do store tearing on normal
> word-sized things or add writes that weren't there originally etc.

My understanding of https://lwn.net/Articles/793253/ section "Store tearing"
which points at https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56028 seems
to contradict your expectation at least when writing constants to a
64-bit word without a volatile access.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
