Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6116CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECAD2245C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHIripZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfKDJLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:11:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfKDJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572858670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkKIjmFEfI3jHRHZqRaPjyw7auVklDO0V0Dmlzn5QbA=;
        b=QHIripZbMnBkjbr70wxyWtoYPNXD67JDC2br6GWLOBNoB7o2W52cwsDRaKLY5UYyI2rvto
        bL7EyamVn8QdmGRdNHeYOuoKIEIN8Guy6M+L/lFaDNCwwaTkDgHQr9os7GYh0qWBRgVDcW
        U+cROxNtCtUEf4o0NPcKkMVXC2XzjzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-1JnuG7BfOpmD2ZoVWhP-lw-1; Mon, 04 Nov 2019 04:11:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A9FA1005500;
        Mon,  4 Nov 2019 09:11:05 +0000 (UTC)
Received: from [10.36.118.62] (unknown [10.36.118.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F45F1001DD7;
        Mon,  4 Nov 2019 09:11:02 +0000 (UTC)
Subject: Re: [RFC v3] mm: add page preemption
To:     Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Jan Kara <jack@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20191103115727.9884-1-hdanton@sina.com>
 <20191104030144.7092-1-hdanton@sina.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4c43dab4-eeb2-7294-a9da-2bf2967f011e@redhat.com>
Date:   Mon, 4 Nov 2019 10:11:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104030144.7092-1-hdanton@sina.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 1JnuG7BfOpmD2ZoVWhP-lw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.19 04:01, Hillf Danton wrote:
>=20
> On Sun, 3 Nov 2019 09:06:49 -0800 Matthew Wilcox wrote:
>> On Sun, Nov 03, 2019 at 07:57:27PM +0800, Hillf Danton wrote:
>>> The cpu preemption feature makes a task able to preempt other tasks
>>> of lower priorities for cpu. It has been around for a while.
>>>
>>> This work introduces task prio into page reclaiming in order to add
>>> the page preemption feature that makes a task able to preempt other
>>> tasks of lower priorities for page.
>>>
>>> No page will be reclaimed on behalf of tasks of lower priorities
>>> under pp, a two-edge feature that functions only under memory
>>> pressure, laying a barrier to pages flowing to lower prio, and the
>>> nice syscall is what users need to fiddle with it for instance if
>>> they have a bunch of workloads to run in datacenter, and some
>>> difficulty predicting the runtime working set size for every
>>> individual workload which is sensitive to jitters in lru pages.
>>>
>>> Currently pages are reclaimed without prio taken into account; pages
>>> can be reclaimed from tasks of lower priorities on behalf of
>>> higher-prio tasks and vice versa.
>>>
>>> s/and vice versa/only/ is what we need to make pp by definition, but
>>> it could not make a sense without prio introduced; otherwise we can
>>> simply skip deactivating the lru pages based on prio comprison, and
>>> work is done.
>>>
>>> The introduction consists of two parts. On the page side, we have to
>>> store the page owner task's prio in page, which needs an extra room the
>>> size of the int type in the page struct. That room sounds impossible
>>> without inflating the page struct size, and is walked around by making
>>> pp depend on CONFIG_64BIT.
>>
>> ... and !MEMCG.  Which means that your work is uninteresting because all
>> the distros turn on CONFIG_MEMCG.
>=20
> I have no idea which one they turn on by default, ext4, btrfs or xfs,
> and why, but I think they feel free to do the right, or the left.
> So do users to configure and build the kernel they need to power their
> machines, a 4-socket server or a TV-top box.
>=20
>> You still haven't given us any numbers.  Or a workload which actually
>> benefits from this patch.
>=20
> Though I do not know why it is turned on by distros and for what
> workloads, I would like to try to run a couple of the workloads you
> may have interest in.
>=20

Why do you keep posting RFC if you don't care about feedback? That's not=20
how upstream work works, really.

Please finally fix your mail client for good as already noted in:
https://www.spinics.net/lists/linux-mm/msg194683.html

--=20

Thanks,

David / dhildenb

