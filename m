Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF918C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A5C21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbchELzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406542AbfJWPKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:10:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406533AbfJWPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571843419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlaewf16ukXOc2N6dF0rd3mLZ8BjJkXYbd4jVtG8Wwg=;
        b=LbchELzQpdSI/qQruRz2IQcO66fu1MXxBjv6wNQDsxmCm1ZlmBY+mPLttE4jx/4V2XXRso
        d3QA6A8FhK6S4iwM80y53hCmIyjzNaO7vnCl6SQlnH3XPhn3e6DZVqJ5NkO/2SGtlx569F
        nj8xVAgi/KuE9MnISEO7yaBFlCTqWpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-9FH-jAAlMq6rZptRE9Q6BQ-1; Wed, 23 Oct 2019 11:10:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CCBD1800D6B;
        Wed, 23 Oct 2019 15:10:13 +0000 (UTC)
Received: from optiplex-lnx (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F2265C241;
        Wed, 23 Oct 2019 15:10:08 +0000 (UTC)
Date:   Wed, 23 Oct 2019 11:10:05 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/2] mm, vmstat: hide /proc/pagetypeinfo from normal
 users
Message-ID: <20191023151005.GE22601@optiplex-lnx>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-2-mhocko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191023102737.32274-2-mhocko@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 9FH-jAAlMq6rZptRE9Q6BQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:27:36PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>=20
> /proc/pagetypeinfo is a debugging tool to examine internal page
> allocator state wrt to fragmentation. It is not very useful for
> any other use so normal users really do not need to read this file.
>=20
> Waiman Long has noticed that reading this file can have negative side
> effects because zone->lock is necessary for gathering data and that
> a) interferes with the page allocator and its users and b) can lead to
> hard lockups on large machines which have very long free_list.
>=20
> Reduce both issues by simply not exporting the file to regular users.
>=20
> Reported-by: Waiman Long <longman@redhat.com>
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmstat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
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
> --=20
> 2.20.1
>
=20
Acked-by: Rafael Aquini <aquini@redhat.com>

