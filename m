Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0B9C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6182084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfFNNxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbfFNNxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAA9181F2F;
        Fri, 14 Jun 2019 13:53:23 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F6D60BE0;
        Fri, 14 Jun 2019 13:53:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v10)
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
        <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com>
        <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com>
        <87d0jguxdk.fsf@oldenburg2.str.redhat.com>
        <1779359826.3226.1560518318701.JavaMail.zimbra@efficios.com>
        <87wohoti47.fsf@oldenburg2.str.redhat.com>
        <189377747.3315.1560519247118.JavaMail.zimbra@efficios.com>
        <87imt8tha5.fsf@oldenburg2.str.redhat.com>
        <26171199.3391.1560520033825.JavaMail.zimbra@efficios.com>
Date:   Fri, 14 Jun 2019 15:53:15 +0200
In-Reply-To: <26171199.3391.1560520033825.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 14 Jun 2019 09:47:13 -0400
        (EDT)")
Message-ID: <87ef3wtgs4.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 14 Jun 2019 13:53:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jun 14, 2019, at 3:42 PM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> +  /* Publicize rseq registration ownership.  This must be performed
>>> +     after rtld re-relocation, before invoking constructors of
>>> +     preloaded libraries.  */
>>> +  rseq_init ();
>> 
>> Please add a comment that IFUNC resolvers do not see the initialized
>> value.  I think this is okay because we currently do not support access
>> to extern variables in IFUNC resolvers.
>
> Do IFUNC resolvers happen to observe the __rseq_handled address that
> was internal to ld.so ?

They should observe the correct address, but they can access the
variable before initialization.  An initializer in ld.so will not have
an effect if an interposed definition initalized the variable to
something else.

> If so, we could simply initialize __rseq_handled twice: early before calling
> IFUNC resolvers, and after ld.so re-relocation.

No, I don't think this will make a difference.

Thanks,
Florian
