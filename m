Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38705C751D2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE842479D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJNQ/wp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfLMQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:05:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728049AbfLMQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576253117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cc7ICVZb+s4e7ChsQ+cDBzumwFBBlF0+3dl2VlDWCJs=;
        b=RJNQ/wp8f1ctg/kUjfASoIYXkEeoJGHVe+GlK+i45wk6tIu5MEC2HLO1u1ygPAQTGtKGVr
        +xPlNjzxBcbbvIrt+SlakwkcPUe9wXOGRHMw3nfg2GzeNNbsH88ADfwgI50mOuidUVYFnG
        onzJEPH0gKgrTe1icXiQ4EsYGm/f19k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-UHE-uBOXM8uEy4Qkn4d-ug-1; Fri, 13 Dec 2019 11:05:14 -0500
X-MC-Unique: UHE-uBOXM8uEy4Qkn4d-ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79D27DB65;
        Fri, 13 Dec 2019 16:05:13 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-140.rdu2.redhat.com [10.10.122.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E823060569;
        Fri, 13 Dec 2019 16:05:12 +0000 (UTC)
Subject: Re: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191212223525.1652-1-longman@redhat.com>
 <20191212223525.1652-5-longman@redhat.com>
 <20191213102525.GA2844@hirez.programming.kicks-ass.net>
 <20191213105042.GJ2871@hirez.programming.kicks-ass.net>
 <9a79ef1a-96e0-1fd7-97e8-ef854b08524d@redhat.com>
Organization: Red Hat
Message-ID: <dab58211-8d31-3b16-c1f1-51badfa8e210@redhat.com>
Date:   Fri, 13 Dec 2019 11:05:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9a79ef1a-96e0-1fd7-97e8-ef854b08524d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 11:02 AM, Waiman Long wrote:
> That is an interesting idea. It will eliminate the need of a separate
> array to track the free chain_hlocks. However, if there are n chains
> available, it will waste about 3n bytes of storage, on average.
>
> I have a slightly different idea. I will enforce a minimum allocation
> size of 2. For a free block, the first 2 hlocks for each allocation
> block will store a 32-bit integer (hlock[0] << 16)|hlock[1]:
>
> Bit 31: always 1
> Bits 24-30: block size
> Bits 0-23: index to the next free block.
>
> In this way, the wasted space will be k bytes where k is the number of
The wasted space should be 2k bytes. My mistake.
> 1-entry chains. I don't think merging adjacent blocks will be that
> useful at this point. We can always add this capability later on if it
> is found to be useful.

Cheers,
Longman

