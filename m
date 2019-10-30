Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6622CA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC01020717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnC5/GZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJ3IOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:14:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31178 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725822AbfJ3IOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572423270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AyFELAijSqcI7vkOjyd21vOAB6Rs2BQWCyD5xG76eKE=;
        b=GnC5/GZwyhGbNbEmUxHThLM1xx8E+ubKtDMuShA/a2QSAuBCidah+I93C9xT6FYo+2z+Hd
        EKZVdCOzcixj7IhSdRR72Osvc2ub9Sz2VgDvodV5DeYhe+32mtRuGTB/K11JkgY+sjndaX
        zwIlsGkS+smMKNgYmD+Jle7A49XYx+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-A6DgzRLdNGCuv80E0D5X9w-1; Wed, 30 Oct 2019 04:14:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF7FA80183D;
        Wed, 30 Oct 2019 08:14:25 +0000 (UTC)
Received: from [10.36.116.222] (ovpn-116-222.ams2.redhat.com [10.36.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 023885D9C3;
        Wed, 30 Oct 2019 08:14:23 +0000 (UTC)
Subject: Re: [PATCH v1] mm/memory_hotplug: Fix updating the node span
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20191027222714.5313-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b572b20f-b7fb-2558-5c79-d0beb65d7f2e@redhat.com>
Date:   Wed, 30 Oct 2019 09:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191027222714.5313-1-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: A6DgzRLdNGCuv80E0D5X9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.19 23:27, David Hildenbrand wrote:
> We recently started updating the node span based on the zone span to
> avoid touching uninitialized memmaps.
>=20
> Currently, we will always detect the node span to start at 0, meaning a
> node can easily span too many pages. pgdat_is_empty() will still work
> correctly if all zones span no pages. We should skip over all zones witho=
ut
> spanned pages and properly handle the first detected zone that spans page=
s.
>=20
> Unfortunately, in contrast to the zone span (/proc/zoneinfo), the node sp=
an
> cannot easily be inspected and tested. The node span gives no real
> guarantees when an architecture supports memory hotplug, meaning it can
> easily contain holes or span pages of different nodes.
>=20
> The node span is not really used after init on architectures that support
> memory hotplug. E.g., we use it in mm/memory_hotplug.c:try_offline_node()
> and in mm/kmemleak.c:kmemleak_scan(). These users seem to be fine.
>=20
> Fixes: 00d6c019b5bc ("mm/memory_hotplug: don't access uninitialized memma=
ps in shrink_pgdat_span()")


@Andrew, can we also give this a churn, we should try to get this into=20
5.4 due to

$ git tag --contains 00d6c019b5bc
[...]
v5.4-rc5

Thanks!

--=20

Thanks,

David / dhildenb

