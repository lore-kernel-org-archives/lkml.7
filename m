Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D66C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408902070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMDE9kQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfKVKO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:14:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbfKVKO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574417665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T42/pXgZB3vn3EGD0jhf0dBoC1Q7FFJ7xvZPD2Z1Aeo=;
        b=QMDE9kQyHAZFiHYcbdjVskgMDJz2YKL9qe9xhqd4ecrtOfE9YhXYVpGQ6J5z300/+P3MMp
        s0qVh/JBFU4nArrWB5whHMlZTpr2F4nCo2k3eWzq469u8BJMhiNas9kzfwN8qoPZs8xK1Q
        hmbG6NUx4COAhdL54k2jmEB6ax1XIzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-_iaOcnaFNzOiy5VohVwcSw-1; Fri, 22 Nov 2019 05:14:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6CAE1883521;
        Fri, 22 Nov 2019 10:14:19 +0000 (UTC)
Received: from [10.36.118.121] (unknown [10.36.118.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9B086E717;
        Fri, 22 Nov 2019 10:14:16 +0000 (UTC)
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
To:     "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>,
        Pengfei Li <fly@kernel.page>, akpm <akpm@linux-foundation.org>
Cc:     mgorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, cl <cl@linux.com>,
        "iamjoonsoo.kim" <iamjoonsoo.kim@lge.com>, guro <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20191121151811.49742-1-fly@kernel.page>
 <2019112215245905276118@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7dbec505-ce53-e1f0-6ed4-8cb0328dfc79@redhat.com>
Date:   Fri, 22 Nov 2019 11:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2019112215245905276118@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _iaOcnaFNzOiy5VohVwcSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.19 08:25, lixinhai.lxh@gmail.com wrote:
> On 2019-11-21=C2=A0at 23:17=C2=A0Pengfei Li=C2=A0wrote:
>> Motivation
>> ----------
>> Currently if we want to iterate through all the nodes we have to
>> traverse all the zones from the zonelist.
>>
>> So in order to reduce the number of loops required to traverse node,
>> this series of patches modified the zonelist to nodelist.
>>
>> Two new macros have been introduced:
>> 1) for_each_node_nlist
>> 2) for_each_node_nlist_nodemask
>>
>>
>> Benefit
>> -------
>> 1. For a NUMA system with N nodes, each node has M zones, the number
>>  =C2=A0=C2=A0 of loops is reduced from N*M times to N times when travers=
ing node.
>>
>=20
> It looks to me that we don't really have system which has N nodes and
> each node with=C2=A0M zones in its address range.
> We may have systems which has several nodes, but only the first node has
> all zone types, other nodes only have NORMAL zone. (Evenly distribute the
> !NORMAL zones on all nodes is not reasonable, as those zones have limited
> size)
> So iterate over zones to reach nodes should at N level, not M*N level.

I guess NORMAL/MOVABLE/DEVICE would be common for most nodes, while I do=20
agree that usually we will only have 1 or 2 zones per node (when we have=20
many nodes). So it would be something like c*N, whereby c is most=20
probably on average 2.

--=20

Thanks,

David / dhildenb

