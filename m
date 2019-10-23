Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52400CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F8A21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEm10kwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406416AbfJWPBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:01:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20779 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391753AbfJWPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571842872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdptM1wjryYnQhJm9RmuX5FaBmrJ2EY+9SJ+YV4u0fQ=;
        b=UEm10kwh/Gl+wyW634T5RyoDn0MZNkGl6QXiPnJTq67e2nRucJWzy7+Vk7bzmz9YfuzvZx
        osVKyGYUCkAhh+kFfcMclZAbeS9g5KOL1xx1q5cZdt9SrXCr9MkkIDCmze+VW1D9uaUXUy
        n9A/C396JBXuWa1xXYKHGEE5DsY/6uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-Y09mMa8JNFO1Wvt2DH_ATQ-1; Wed, 23 Oct 2019 11:01:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 281081005500;
        Wed, 23 Oct 2019 15:01:06 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8AA919C77;
        Wed, 23 Oct 2019 15:01:04 +0000 (UTC)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
To:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
 <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
 <1571842093.5937.84.camel@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a4398f60-c07e-8fa9-c26d-3b8f688e65a1@redhat.com>
Date:   Wed, 23 Oct 2019 11:01:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1571842093.5937.84.camel@lca.pw>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Y09mMa8JNFO1Wvt2DH_ATQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 10:48 AM, Qian Cai wrote:
>>> this still isn't a bulletproof fix.  Maybe just terminate the list
>>> walk if freecount reaches 1024.  Would anyone really care?
>>>
>>> Sigh.  I wonder if anyone really uses this thing for anything
>>> important.  Can we just remove it all?
>>>
>> Removing it will be a breakage of kernel API.
> Who cares about breaking this part of the API that essentially nobody wil=
l use
> this file?
>
There are certainly tools that use /proc/pagetypeinfo and this is how
the problem is found. I am not against removing it, but we have to be
careful and deprecate it in way that minimize user impact.

Cheers,
Longman

