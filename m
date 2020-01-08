Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114DC20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdwQtX4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgAHWBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:01:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726390AbgAHWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578520875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3om6/ZEtoiw5p37bGSlTimAGm5vcDqv1hyo/tkJYBLw=;
        b=EdwQtX4aEZ89KdkI6R9MYlWPVZCmA4H7Z5NAcKgKIdyvB9izNwx3vEoZO2o+C+G8e5Ko/p
        F94Zcz3X+j0dpY+3fNwn7RrMxomGBDEgrQjVtTrlfanA9ZlAketdyU/P2l4kmOX5pufBGg
        m1DoD5hewyDw3BKWb6cJXtpEj46QHSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-qbAPNPGDOlG8ecjljneGxA-1; Wed, 08 Jan 2020 17:01:11 -0500
X-MC-Unique: qbAPNPGDOlG8ecjljneGxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 042C2911E8;
        Wed,  8 Jan 2020 22:01:10 +0000 (UTC)
Received: from krava (ovpn-204-121.brq.redhat.com [10.40.204.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 744D186C56;
        Wed,  8 Jan 2020 22:01:07 +0000 (UTC)
Date:   Wed, 8 Jan 2020 23:01:03 +0100
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
Message-ID: <20200108220103.GB12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-5-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:

SNIP

> +	while (*p != NULL) {
> +		parent = *p;
> +		cgrp = rb_entry(parent, struct cgroup, node);
> +
> +		if (cgrp->id == id)
> +			return cgrp;
> +
> +		if (cgrp->id < id)
> +			p = &(*p)->rb_left;
> +		else
> +			p = &(*p)->rb_right;
> +	}
> +
> +	cgrp = malloc(sizeof(*cgrp));
> +	if (cgrp == NULL)
> +		return NULL;
> +
> +	cgrp->name = strdup(path);
> +	if (cgrp->name == NULL) {
> +		free(cgrp);
> +		return NULL;
> +	}
> +
> +	cgrp->fd = -1;
> +	cgrp->id = id;
> +	refcount_set(&cgrp->refcnt, 1);
> +
> +	rb_link_node(&cgrp->node, parent, p);
> +	rb_insert_color(&cgrp->node, &cgroup_tree);
> +
> +	return cgrp;
> +}
> +
> +struct cgroup *cgroup__find_by_path(const char *path)
> +{
> +	struct rb_node *node;
> +
> +	node = rb_first(&cgroup_tree);
> +	while (node) {
> +		struct cgroup *cgrp = rb_entry(node, struct cgroup, node);
> +
> +		if (!strcmp(cgrp->name, path))
> +			return cgrp;

you have it sorted on ids, but only search by path,
why don't we sort it on path right away?

jirka

