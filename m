Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1234C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9928F2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfDELJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:09:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfDELJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:09:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21BB489C47;
        Fri,  5 Apr 2019 11:09:02 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9999A5D707;
        Fri,  5 Apr 2019 11:09:00 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] sched/core: expand sched_getaffinity(2) to return number of CPUs
References: <20190403200809.GA13876@avx2>
        <20190404084249.GS4038@hirez.programming.kicks-ass.net>
        <87wok83gfs.fsf@oldenburg2.str.redhat.com>
        <20190405110415.GP12232@hirez.programming.kicks-ass.net>
Date:   Fri, 05 Apr 2019 13:08:58 +0200
In-Reply-To: <20190405110415.GP12232@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 5 Apr 2019 13:04:15 +0200")
Message-ID: <87ftqw3e0l.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 05 Apr 2019 11:09:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> On Fri, Apr 05, 2019 at 12:16:39PM +0200, Florian Weimer wrote:
>
>> > True; but I suppose glibc already does lots of that anyway, right? It
>> > does contain the right information.
>> 
>> If I recall correctly my last investigation,
>> /sys/devices/system/cpu/possible does not reflect the size of the
>> affinity mask, either.
>
> Strictly speaking correct; the bitmap can be longer than the highest
> possible cpu number, however the remainder would be 0-padding and could
> thus be stripped without issue.

Doesn't the kernel still enforce the larget bitmap in sched_getaffinity,
even if the bits are always zero?

Thanks,
Florian
