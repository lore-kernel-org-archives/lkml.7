Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78F5C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F522086C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LVB7PDYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfHQPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 11:55:19 -0400
Received: from mail.efficios.com ([167.114.142.138]:43298 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfHQPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 11:55:19 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AF08024A834;
        Sat, 17 Aug 2019 11:55:17 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id IlTT-HoeBecy; Sat, 17 Aug 2019 11:55:17 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6328924A831;
        Sat, 17 Aug 2019 11:55:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6328924A831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566057317;
        bh=IXj9aIP4CDlW09NzFVepAs4bAF1HIVB6vbPQmCTYr08=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LVB7PDYfR1E6QBCi5GqHGYa5CFkQoztNv+GzgMNfSo0hnp75jLCC8zq0+vkqOmxhq
         eEZvViKz9xSkOVGve6U6axrBmC1EXgUQRNS01RVtMfChuVgPcMfPEH2nY7OOIqP9br
         +Y2G8LVL/qbmXZ822mkgtQzx5mS64KyyfQa6gbJx1vhwrLQkgnyr4a0B7zowVFjtGx
         xe2RwgI+8mO/zCEG06/IzzowCC5eiWEe/8o0XrnPSxGE62uBilcKIZsA3J3++sDBTU
         0QxbF9orwVGu+X3vujBR9VZGv02uFp1mH4p64/V8YqE33DmsqG6Pz5s/5uGD8wmr9h
         RVcfKh/ryNswQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id pM-6Tg_GbXPD; Sat, 17 Aug 2019 11:55:17 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 487A324A825;
        Sat, 17 Aug 2019 11:55:17 -0400 (EDT)
Date:   Sat, 17 Aug 2019 11:55:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Message-ID: <1360102474.23943.1566057317249.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190817112655.2277a9c5@oasis.local.home>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com> <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com> <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de> <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com> <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com> <20190816221313.4b05b876@oasis.local.home> <39888715.23900.1566052831673.JavaMail.zimbra@efficios.com> <20190817112655.2277a9c5@oasis.local.home>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: /ttfitEg37QJgo98J+HXx1jpWFojDw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 17, 2019, at 11:26 AM, rostedt rostedt@goodmis.org wrote:

> On Sat, 17 Aug 2019 10:40:31 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> > I'm now even more against adding the READ_ONCE() or WRITE_ONCE().
>> 
>> I'm not convinced by your arguments.
> 
> Prove to me that there's an issue here beyond theoretical analysis,
> then I'll consider that patch.
> 
> Show me a compiler used to compile the kernel that zeros out the
> increment. Show me were the race actually occurs.
> 
> I think the READ/WRITE_ONCE() is more confusing than helpful. And
> unneeded churn to the code. And really not needed for something that's
> not critical to execution.

I'll have to let the authors of the LWN article speak up on this, because
I have limited time to replicate this investigation myself.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
