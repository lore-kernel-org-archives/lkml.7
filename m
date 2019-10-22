Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECC4C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3A7206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRTBW+ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfJVSAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:00:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22526 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727154AbfJVSAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571767246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wmxPMQzg5Z0NpOnkIMNpv95HKCgh3zs+QCe5ccufuw=;
        b=DRTBW+MLJnMOcWEjKCTJyHR4ZmpslqU8YsKkfWWD/YCuFQMvQT47HDBa0Q42tYjRYI06Wk
        hSL+ey1TgTipuLybcHLOWYNfTIB4E206xgCH8ZEKyHd8JuamuHjEVav+iArdsyegbWAHNf
        9vFey+O+KNZcBw+TG1axN9fcASZM0Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-nzN80N6iNbywiAJDeX_jvg-1; Tue, 22 Oct 2019 14:00:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E950800D54;
        Tue, 22 Oct 2019 18:00:40 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D66FF1001E75;
        Tue, 22 Oct 2019 18:00:35 +0000 (UTC)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, Mel Gorman <mgorman@suse.de>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022165745.GT9379@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0b206255-5c62-18f5-d751-a5576a6c0e8f@redhat.com>
Date:   Tue, 22 Oct 2019 14:00:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191022165745.GT9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nzN80N6iNbywiAJDeX_jvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/19 12:57 PM, Michal Hocko wrote:
> [Cc Mel]
>
> On Tue 22-10-19 12:21:56, Waiman Long wrote:
>> The pagetypeinfo_showfree_print() function prints out the number of
>> free blocks for each of the page orders and migrate types. The current
>> code just iterates the each of the free lists to get counts.  There are
>> bug reports about hard lockup panics when reading the /proc/pagetyeinfo
>> file just because it look too long to iterate all the free lists within
>> a zone while holing the zone lock with irq disabled.
>>
>> Given the fact that /proc/pagetypeinfo is readable by all, the possiblit=
y
>> of crashing a system by the simple act of reading /proc/pagetypeinfo
>> by any user is a security problem that needs to be addressed.
> Should we make the file 0400? It is a useful thing when debugging but
> not something regular users would really need for life.
>
I am not against doing that, but it may break existing applications that
somehow need to read pagetypeinfo. That is why I didn't try to advocate
about changing protection.


>> There is a free_area structure associated with each page order. There
>> is also a nr_free count within the free_area for all the different
>> migration types combined. Tracking the number of free list entries
>> for each migration type will probably add some overhead to the fast
>> paths like moving pages from one migration type to another which may
>> not be desirable.
> Have you tried to measure that overhead?

I haven't tried to measure the performance impact yet. I did thought
about tracking nr_free for each of the migration types within a
free_area. That will require auditing the code to make sure that all the
intra-free_area migrations are properly accounted for. I can work on it
if people prefer this alternative.


> =20
>> we can actually skip iterating the list of one of the migration types
>> and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
>> is usually the largest one on large memory systems, this is the one
>> to be skipped. Since the printing order is migration-type =3D> order, we
>> will have to store the counts in an internal 2D array before printing
>> them out.
>>
>> Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
>> zone lock for too long blocking out other zone lock waiters from being
>> run. This can be problematic for systems with large amount of memory.
>> So a check is added to temporarily release the lock and reschedule if
>> more than 64k of list entries have been iterated for each order. With
>> a MAX_ORDER of 11, the worst case will be iterating about 700k of list
>> entries before releasing the lock.
> But you are still iterating through the whole free_list at once so if it
> gets really large then this is still possible. I think it would be
> preferable to use per migratetype nr_free if it doesn't cause any
> regressions.
>
Yes, it is still theoretically possible. I will take a further look at
having per-migrate type nr_free. BTW, there is one more place where the
free lists are being iterated with zone lock held - mark_free_pages().

Cheers,
Longman

