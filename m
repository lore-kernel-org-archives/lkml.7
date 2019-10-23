Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F633CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174F12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/41757P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392351AbfJWOw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:52:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390614AbfJWOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571842375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emR3PoHEO27QDES+p5wODmAC9pYpw/dbeRHOoHO20Ao=;
        b=h/41757PEuwfAGRhaSk9UHSlzvoGPYb+V7l6xUsm8v9MhJWZ3bX5AoWWU5daYa/1qEr4Ib
        VdIc0q29jc6+vBGhQ58X8OSF/sPR7t3Nmqahf6bsA0ItfOegP6FoHOsNFHQJwxMqfeLXkz
        NSJ1ahdgoOW5gqbCo8MG3HIZAJ6sni0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-60Zyz4gRP82yzeX22HESNA-1; Wed, 23 Oct 2019 10:52:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE120476;
        Wed, 23 Oct 2019 14:52:49 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 193ED5C1D4;
        Wed, 23 Oct 2019 14:52:45 +0000 (UTC)
Subject: Re: [RFC PATCH 1/2] mm, vmstat: hide /proc/pagetypeinfo from normal
 users
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-2-mhocko@kernel.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <48c4b79b-d2e6-684c-2d0e-7693985817f1@redhat.com>
Date:   Wed, 23 Oct 2019 10:52:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023102737.32274-2-mhocko@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 60Zyz4gRP82yzeX22HESNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 6:27 AM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> /proc/pagetypeinfo is a debugging tool to examine internal page
> allocator state wrt to fragmentation. It is not very useful for
> any other use so normal users really do not need to read this file.
>
> Waiman Long has noticed that reading this file can have negative side
> effects because zone->lock is necessary for gathering data and that
> a) interferes with the page allocator and its users and b) can lead to
> hard lockups on large machines which have very long free_list.
>
> Reduce both issues by simply not exporting the file to regular users.
>
> Reported-by: Waiman Long <longman@redhat.com>
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmstat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 6afc892a148a..4e885ecd44d1 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1972,7 +1972,7 @@ void __init init_mm_internals(void)
>  #endif
>  #ifdef CONFIG_PROC_FS
>  =09proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
> -=09proc_create_seq("pagetypeinfo", 0444, NULL, &pagetypeinfo_op);
> +=09proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
>  =09proc_create_seq("vmstat", 0444, NULL, &vmstat_op);
>  =09proc_create_seq("zoneinfo", 0444, NULL, &zoneinfo_op);
>  #endif

Acked-by: Waiman Long <longman@redhat.com>

