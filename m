Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2607FC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AD020707
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNyPwTex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgAFPyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:54:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbgAFPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578326070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HB4F5E1mhEQnhENa8mtuGlwFRB8KZ+1clG/PrYxTKyU=;
        b=YNyPwTexqBUrAp1t0F8dZmSHdg8uaVIxEsszAIo2/2g4BFuJ964Btfixk5bf0xvWpYJIpM
        b2fi5HvwEC7s7Gk/Pxn2D+fkmbt1D6IsO0UCgikeO+fCOlQJsnkQne17rlfU6TJTPjkWsA
        Dwzt9YXoT+ZSfW1Vb12HjjYp+1G5HCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-MIwYmISvNpeEeb4fZFp1kg-1; Mon, 06 Jan 2020 10:54:27 -0500
X-MC-Unique: MIwYmISvNpeEeb4fZFp1kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9AD88E26ED;
        Mon,  6 Jan 2020 15:54:25 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 163B45C1B0;
        Mon,  6 Jan 2020 15:54:25 +0000 (UTC)
Subject: Re: [PATCH v2 0/6] locking/lockdep: Reuse zapped chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <dfcfc267-1a2f-8070-c08b-662e9fe4798c@redhat.com>
Date:   Mon, 6 Jan 2020 10:54:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191216151517.7060-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 10:15 AM, Waiman Long wrote:
>  v2:
>   - Revamp the chain_hlocks reuse patch to store the freed chain_hlocks
>     information in the chain_hlocks entries themselves avoiding the
>     need of a separate set of tracking structures. This, however,
>     requires a minimum allocation size of at least 2. Thanks to PeterZ
>     for his review and inspiring this change.
>   - Remove the leakage counter as it is no longer applicable.
>   - Add patch 6 to make the output of /proc/lockdep_chains more readable.
>
> It was found that when running a workload that kept on adding lock
> classes and then zapping them repetitively, the system will eventually
> run out of chain_hlocks[] entries even though there were still plenty
> of other lockdep data buffers available.
>
>   [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>   [ 4318.444809] turning off the locking correctness validator.
>
> In order to fix this problem, we have to make chain_hlocks[] entries
> reusable just like other lockdep arrays. Besides that, the patchset
> also adds some zapped class and chain_hlocks counters to be tracked by
> /proc/lockdep_stats. It also fixes leakage in the irq context counters
> and makes the output of /proc/lockdep_chains more readable.
>
> Waiman Long (6):
>   locking/lockdep: Track number of zapped classes
>   locking/lockdep: Throw away all lock chains with zapped class
>   locking/lockdep: Track number of zapped lock chains
>   locking/lockdep: Reuse freed chain_hlocks entries
>   locking/lockdep: Decrement irq context counters when removing lock
>     chain
>   locking/lockdep: Display irq_context names in /proc/lockdep_chains
>
>  kernel/locking/lockdep.c           | 307 +++++++++++++++++++++++------
>  kernel/locking/lockdep_internals.h |  14 +-
>  kernel/locking/lockdep_proc.c      |  26 ++-
>  3 files changed, 282 insertions(+), 65 deletions(-)
>
Ping! Any comments or suggestion for further improvement?

Cheers,
Longman

