Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245FC20707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdpLtI8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVKDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:03:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28152 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbfKVKDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574417020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZxSBnToU8Q+4liQ4absw6sZ2OBAyuvw5i8iX6n4XC4=;
        b=FdpLtI8raAPZqHD/7rt6JwytG4uObC+jOGIZ9je2lAgBGKe9e5bEV0526qvxXMRZtJ77O5
        ZbBp4Z53zxgwKMF9UnDJUsGcAplYYT6zysLrfJEjzvzGlTKnhQPJNtL4/dY1Pm82F1N3jV
        BQ7tUYdhjy2wHwvyVhZd2Df2Qj0kOG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-NFZgtFxTMoCPeqWMEtUm5Q-1; Fri, 22 Nov 2019 05:03:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70EC2801E5D;
        Fri, 22 Nov 2019 10:03:34 +0000 (UTC)
Received: from [10.36.118.121] (unknown [10.36.118.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10CF110372C0;
        Fri, 22 Nov 2019 10:03:30 +0000 (UTC)
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
To:     Pengfei Li <fly@kernel.page>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20191121151811.49742-1-fly@kernel.page>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1bb37491-72a7-feaa-722d-a5825813a409@redhat.com>
Date:   Fri, 22 Nov 2019 11:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NFZgtFxTMoCPeqWMEtUm5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.19 16:17, Pengfei Li wrote:
> Motivation
> ----------
> Currently if we want to iterate through all the nodes we have to
> traverse all the zones from the zonelist.
>=20
> So in order to reduce the number of loops required to traverse node,
> this series of patches modified the zonelist to nodelist.
>=20
> Two new macros have been introduced:
> 1) for_each_node_nlist
> 2) for_each_node_nlist_nodemask
>=20
>=20
> Benefit
> -------
> 1. For a NUMA system with N nodes, each node has M zones, the number
>     of loops is reduced from N*M times to N times when traversing node.
>=20
> 2. The size of pg_data_t is much reduced.
>=20
>=20
> Test Result
> -----------
> Currently I have only performed a simple page allocation benchmark
> test on my laptop, and the results show that the performance of a
> system with only one node is almost unaffected.
>=20

So you are seeing no performance changes. I am wondering why do we need=20
this, then - because your motivation sounds like a performance=20
improvement? (not completely against this, just trying to understand the=20
value of this :) )


--=20

Thanks,

David / dhildenb

