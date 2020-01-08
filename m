Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC0BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44B8206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqOSZ6tV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgAHVwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:52:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57642 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726390AbgAHVwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578520366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATP2vPqcVpLIuKKl/JgcXUbEFNu3HdiP5wgB2BoDjio=;
        b=DqOSZ6tVpdAfu9d7KVSUhB/UbCY2jqvpIVmq12Ig/xjhTnMK8+e0nO7H7GXg69Vuj+Aoug
        UyCd2hf38Yo3xn0BUYFGvbCZ+97p0q5FX8vlXVaTX/3SK9WoIHd6JuA68POJyWkQOb6vsV
        kv8JyCbTP+oNHPsMSR75gok4cSBHn4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-dVz8mcY7P3WChBtRpPVmnQ-1; Wed, 08 Jan 2020 16:52:43 -0500
X-MC-Unique: dVz8mcY7P3WChBtRpPVmnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C9A4800D48;
        Wed,  8 Jan 2020 21:52:41 +0000 (UTC)
Received: from krava (ovpn-204-121.brq.redhat.com [10.40.204.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64FFF5C21A;
        Wed,  8 Jan 2020 21:52:38 +0000 (UTC)
Date:   Wed, 8 Jan 2020 22:52:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Message-ID: <20200108215235.GA12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-5-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:
> Each cgroup is kept in the global cgroup_tree sorted by the cgroup id.
> Hist entries have cgroup id can compare it directly and later it can
> be used to find a group name using this tree.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/cgroup.h  | 15 +++++---
>  tools/perf/util/machine.c |  7 ++++
>  tools/perf/util/session.c |  4 +++
>  4 files changed, 94 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index 4881d4af3381..4e8ef1db0c94 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -13,6 +13,8 @@
>  
>  int nr_cgroups;
>  
> +static struct rb_root cgroup_tree = RB_ROOT;

I think we shoud carry that in 'struct perf_env' 

jirka

