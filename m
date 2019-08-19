Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C66CC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0495A20843
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfHSKev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:34:51 -0400
Received: from foss.arm.com ([217.140.110.172]:52222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSKev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:34:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B538B344;
        Mon, 19 Aug 2019 03:34:50 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 454FC3F706;
        Mon, 19 Aug 2019 03:34:49 -0700 (PDT)
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     paulmck@linux.ibm.com
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
 <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
 <20190817045217.GZ28441@linux.ibm.com>
 <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
 <CAHk-=whjEq6uEt0o0Ur9Epa7EKVvEFUVJVFJ+heJCv9ehV7pyA@mail.gmail.com>
 <1065930957.23914.1566054178444.JavaMail.zimbra@efficios.com>
 <600fd72f-11a0-ff1a-c87a-b26349f6f54a@arm.com>
 <20190817230034.GK28441@linux.ibm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d57ed540-2001-724d-ed22-eee35354840f@arm.com>
Date:   Mon, 19 Aug 2019 11:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190817230034.GK28441@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/08/2019 00:00, Paul E. McKenney wrote:
[...]
> Linus noted that he believes that compilers for architectures supporting
> Linux can be trusted to avoid store-to-load transformations, invented
> stores, and unnecessary store tearing.  Should these appear, Linus would
> report a bug against the compiler and expect it to be fixed.
> 
>> I'll be honest, it's not 100% clear to me when those optimizations can
>> actually be done (maybe the branch thingy but the others are dubious), and
>> it's even less clear when compilers *actually* do it - only that they have
>> been reported to do it (so it's not made up).
> 
> There is significant unclarity inherent in the situation.  The standard
> says one thing, different compilers do other things, and developers
> often expect yet a third thing.  And sometimes things change over time,
> for example, the ca. 2011 dictim against compilers inventing data races.
> 
> Hey, they didn't teach me this aspect of software development in school,
> either.  ;-)
> 

Gotta keeps things "interesting" somehow, eh...

Thanks for the clarifications.

> 							Thanx, Paul
> 
