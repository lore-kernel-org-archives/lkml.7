Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD304C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6620692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3GBkOhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgAHWWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:22:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbgAHWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578522126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFgWeK11XCYWDQjlF9XC3VqlDhhZtHK2pS8IpXWNa9M=;
        b=F3GBkOhd94htkUPL1/1XO1+LV26FvdEAcEvwRVNyAHkAaYvMBI/LWW8O/mTgifKUk+yPvE
        xQ5NSx1v0sTtQJO7x6n1ADZpmOVsxJgcCdFn5LS7aToh5e61aWGjVi2bAj2q+OKEO5Rzba
        i4ra8xduhIsy4aCLCvYEgl5ljGlEhek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-nl0AHG0LPZWsVohSJpqLgA-1; Wed, 08 Jan 2020 17:22:03 -0500
X-MC-Unique: nl0AHG0LPZWsVohSJpqLgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23E06800D4E;
        Wed,  8 Jan 2020 22:22:01 +0000 (UTC)
Received: from krava (ovpn-204-121.brq.redhat.com [10.40.204.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2D1760F82;
        Wed,  8 Jan 2020 22:21:58 +0000 (UTC)
Date:   Wed, 8 Jan 2020 23:21:56 +0100
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
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Message-ID: <20200108222156.GE12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-7-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-7-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:

SNIP

> +	closedir(d);
> +	return ret;
> +}
> +
> +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> +				   perf_event__handler_t process,
> +				   struct machine *machine)
> +{
> +	union perf_event event;
> +	char *cgrp_root;
> +	size_t mount_len;  /* length of mount point in the path */
> +	int ret = -1;
> +
> +	cgrp_root = malloc(PATH_MAX);
> +	if (cgrp_root == NULL)
> +		return -1;
> +

hum, we normally use bufs with PATH_MAX size on stack..
is there some reason to use heap in here?

jirka


> +	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX) < 0) {
> +		pr_debug("cannot find cgroup mount point\n");
> +		goto out;
> +	}
> +
> +	mount_len = strlen(cgrp_root);
> +	/* make sure the path starts with a slash (after mount point) */
> +	strcat(cgrp_root, "/");
> +
> +	if (perf_event__walk_cgroup_tree(tool, &event, cgrp_root, mount_len,
> +					 process, machine) < 0)
> +		goto out;
> +
> +	ret = 0;
> +
> +out:
> +	free(cgrp_root);
> +
> +	return ret;
> +}
> +

SNIP

