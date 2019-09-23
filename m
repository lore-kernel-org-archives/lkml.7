Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4B3C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA120578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BzbdOk5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440150AbfIWOze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:55:34 -0400
Received: from mail.efficios.com ([167.114.142.138]:59826 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfIWOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:55:34 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D71D224C023;
        Mon, 23 Sep 2019 10:55:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id qgDHClAprNC9; Mon, 23 Sep 2019 10:55:32 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7C33C24C020;
        Mon, 23 Sep 2019 10:55:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7C33C24C020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1569250532;
        bh=3pilhXfhstK3I0y0oTTPZ24Mv3cAWOmhYyowV2AGW80=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BzbdOk5YimKiaL6tFJA3tQqN8Z+dDx719ZQ6Hmla9F8SqDzbR96hSQ2gs5BozAmXV
         TNrZ5nIkKbeFUH3MrbZkVe+tnriML7WeAWvdfqsawlw4lUhHrXqFijb8p3sJofNtuC
         KX+M2TDbjPz3n4PK4mhREUMVoAITu4pgluQQUlyHAmFL+CI5ZOsldJDuuGHDZIQzze
         yBddZx8H0a5vo1N1lhhu0dNMgp/XYW7YzDn7qWO1wO3V359h0xtQMm0MzlLqPREeVm
         qXJGZkRf2y3eG7j8skIlZV59LZHVnly3meROUpJD0xqYNFxzj7QDwerR6HkaUybbrr
         +qXqKCTW8eTrg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id A5b1ERhSmWWP; Mon, 23 Sep 2019 10:55:32 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 65BB724C014;
        Mon, 23 Sep 2019 10:55:32 -0400 (EDT)
Date:   Mon, 23 Sep 2019 10:55:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <485879119.4072.1569250532294.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190923090636.GH2349@hirez.programming.kicks-ass.net>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com> <20190923090636.GH2349@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 5.4 0/7] Membarrier fixes and cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: Membarrier fixes and cleanups
Thread-Index: LbUKojQuby/Rl4A+CY7x4S3KDIsbJQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 23, 2019, at 5:06 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Sep 19, 2019 at 01:36:58PM -0400, Mathieu Desnoyers wrote:
>> Hi,
>> 
>> Those series of fixes and cleanups are initially motivated by the report
>> of race in membarrier, which can load p->mm->membarrier_state after mm
>> has been freed (use-after-free).
>> 
> 
> The lot looks good to me; what do you want done with them (them being
> RFC and all) ?

I can either re-send them without the RFC tag, or you can pick them directly
through the scheduler tree.

As you prefer,

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
