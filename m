Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F2C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F29B2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZRHXZYI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDISEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:04:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:40220 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDISEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:04:13 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 007AA1BEAA2;
        Tue,  9 Apr 2019 14:04:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id EySNUnMEFT8q; Tue,  9 Apr 2019 14:04:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 565AE1BEA9C;
        Tue,  9 Apr 2019 14:04:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 565AE1BEA9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554833051;
        bh=VfQA+VZW6DRvoaNiqMwxD824ovVtDIRsG2jjoOuGPXo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZRHXZYI26hRLoWHRZVE/9nTaVn+1xTlV2AHPy5o9HcprGLM44GCn+ml7MeLDmhXhC
         2JPgsm5dJ8Mv6cwaj2hfkoPlStSqdnMI7lGSGgiEMkN0Nb9UDmAmCc0kGrQzcWHN8Q
         Y8XfVJzQuGnu4cvU9WaCbp89CCkX2aJBEhcCuZ6Bv2nu7E94LyKM+F+2Z3y84QK219
         QwdmXjt47Wofi8c/x6LL11Csk3J8BMPK7D5gZNPbIP4zjlHZ5t+fSOgwI9tpsjJUvf
         lUx+dq248LNITxJW4axeaf2hxyIl/wGFWsqMth0J11na7Vq0FsZ6pQwWGExPou8yIo
         qCB6XTJPIqZLQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dhzaK3gRoEbG; Tue,  9 Apr 2019 14:04:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2F2101BEA8E;
        Tue,  9 Apr 2019 14:04:11 -0400 (EDT)
Date:   Tue, 9 Apr 2019 14:04:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Message-ID: <1445093299.2510.1554833051142.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190409175549.GG14111@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com> <20190408154616.GO14111@linux.ibm.com> <1489474416.1465.1554744287985.JavaMail.zimbra@efficios.com> <20190409154012.GC248418@google.com> <534133139.2374.1554825363211.JavaMail.zimbra@efficios.com> <20190409164031.GE14111@linux.ibm.com> <1958511501.2412.1554828325809.JavaMail.zimbra@efficios.com> <20190409175549.GG14111@linux.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: Forbid static SRCU use in modules
Thread-Index: eaTU93Z6CPbs7/dhixfg/R5CiWN2qQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 9, 2019, at 1:55 PM, paulmck paulmck@linux.ibm.com wrote:
[...]
> The current state is not horrible, so my thought would be to give it
> some time to see if better thoughts arise.
> 
> Either way, cleanup_srcu_struct() keeps its current checks for callbacks
> still being in flight, which is why I believe that the current state is
> not horrible.  ;-)

In that case, I think the comment above cleanup_srcu_struct_quiesced() in
include/linux/srcu.h needs to be updated to cover situations where API
users statically define a SRCU domain in a module and intend to unload
that module.

Given that we end up doing the allocation/cleanup under the hood, the
API users don't interact with init_srcu_struct() nor cleanup_srcu_struct(),
so it's not obvious that this comment also applies to them.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
