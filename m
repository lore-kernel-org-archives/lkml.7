Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A373FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D7721848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKnbjs0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfKHSoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:44:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbfKHSoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573238675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54brm5rGO/mYSNJW+nP1TupX0Iz3rREdtgTrvEffbAQ=;
        b=gKnbjs0lQvO0s+ic/t+TdtYL+khDntP3tpZcSIaN9Uuk9azcEDV9sP8mWHI39hniqlMHGc
        89wEkgBfXShAYAfm67/NJ+OOqi3qbha56qA7uNDPYRScfu+kxw6JFwmAXRK82zfIEkREIR
        z6L18hGhg6PsLC4221AAgYXt1tVT1m8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-I9VUoG5xOYmly9AOkUWPiw-1; Fri, 08 Nov 2019 13:44:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C0E4477;
        Fri,  8 Nov 2019 18:44:33 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42962600C9;
        Fri,  8 Nov 2019 18:44:32 +0000 (UTC)
Subject: Re: [PATCH v2] hugetlbfs: Take read_lock on i_mmap for PMD sharing
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20191107211809.9539-1-longman@redhat.com>
 <20191108020337.pyf3ry3zsioh2ghz@linux-p48b>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9c114cb4-cd93-41b5-f123-13815871d659@redhat.com>
Date:   Fri, 8 Nov 2019 13:44:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191108020337.pyf3ry3zsioh2ghz@linux-p48b>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: I9VUoG5xOYmly9AOkUWPiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 9:03 PM, Davidlohr Bueso wrote:
> On Thu, 07 Nov 2019, Waiman Long wrote:
>> With this patch applied, the customer is seeing significant performance
>> improvement over the unpatched kernel.
>
> Could you give more details here?=20

Red Hat has a customer that is running a transactional database
workload. In this particular case, about ~500-1500GB of static hugepages
are allocated.=C2=A0 The database then allocates a single large shared memo=
ry
segment in those hugepages to use primarily as a database buffer for 8kB
blocks from disk (there are also other database structures in that
shared memory, but it's mostly for buffer).=C2=A0 Then thousands of separat=
e
processes reference and load data into that buffer. They were seeing
multi-second pauses when starting up the database.

I first gave them a patched kernel that disabled PMD sharing. That fixed
their problem. After that, I gave them another test kernel that
contained this patch. They said there were significant improved compared
with the unpatched kernel. There is still some degradation compared to
the kernel with huge shared pmd disabled entirely, but they're pretty
close in performance.

Cheer,
Longman


