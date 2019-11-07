Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43234C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057BE206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTEIqAix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfKGVG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:06:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39594 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfKGVGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573160814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h877o6Ni/SlJBBVQj+VUyT0bhIicQJLBgZDWVWapS4I=;
        b=iTEIqAixIw4sIj3h/NeSoyy8Ve2yktdK+StzzVUGyroDS1PdmEAL31KHK85M5MbxoE/ml4
        8cCf+8geGzLhJSxIViWEVDbFFZqw4Im4DzyJggI2VtYKLe56hm3895mD6AG4c27RKnCQY2
        24TLaa3FcGrgTo9bG8DaB/0i5JlO3fM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-wt8G7STeMIyXmDYd7WgxKA-1; Thu, 07 Nov 2019 16:06:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2ED21005500;
        Thu,  7 Nov 2019 21:06:48 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F14125D6B7;
        Thu,  7 Nov 2019 21:06:47 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <20191107190628.22667-1-longman@redhat.com>
 <20191107194225.GE11823@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2d4b12a7-ea30-fe33-f59d-342346dfdec9@redhat.com>
Date:   Thu, 7 Nov 2019 16:06:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191107194225.GE11823@bombadil.infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: wt8G7STeMIyXmDYd7WgxKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 2:42 PM, Matthew Wilcox wrote:
> On Thu, Nov 07, 2019 at 02:06:28PM -0500, Waiman Long wrote:
>> -=09i_mmap_lock_write(mapping);
>> +=09/*
>> +=09 * PMD sharing does not require changes to i_mmap. So a read lock
>> +=09 * is enuogh.
>> +=09 */
>> +=09i_mmap_lock_read(mapping);
> We don't have comments before any of the other calls to i_mmap_lock_read(=
)
> justifying why we don't need the write lock.  I don't understand why this
> situation is different.  Just delete the comment and make this a two-line
> patch.
>
I am fine with that.

I will send a v2 patch.

Cheers,
Longman

