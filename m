Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B937C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFE5218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENhSLeiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRJFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:05:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32225 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbfLRJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576659914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65O9mx01ZtHFGH2j1kSt63wBb4bZymABO1dN1DN+xc8=;
        b=ENhSLeiveEuRH0+WfrmgC0YKnQfVXwuBgw4/axa4apgbOv7DRsz1uWjQhJJ8Q7Q6nw++yy
        BZLC7pgGQYoN9NO60BYeES/2KizxUEoj8ze5XED9sV4YUGarJQTwibjoSnskpufh3kOjwX
        /OvsG4wjmKxb046ZKutUzhUIz1zVmIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-MR1msglmPXS9FxlTnXvPNQ-1; Wed, 18 Dec 2019 04:05:11 -0500
X-MC-Unique: MR1msglmPXS9FxlTnXvPNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E1BA1005512;
        Wed, 18 Dec 2019 09:05:09 +0000 (UTC)
Received: from krava (ovpn-204-177.brq.redhat.com [10.40.204.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B94C6137F;
        Wed, 18 Dec 2019 09:05:06 +0000 (UTC)
Date:   Wed, 18 Dec 2019 10:05:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for
 kernel maps
Message-ID: <20191218090504.GE19062@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217144828.2460-13-acme@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:48:28AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> +	machine->vmlinux_map = map__new2(0, kernel, &machine->kmaps);
>  	if (machine->vmlinux_map == NULL)
>  		return -1;
>  
> @@ -1098,7 +1097,6 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
>  	if (!kmap)
>  		return -1;
>  
> -	kmap->kmaps = &machine->kmaps;
>  	maps__insert(&machine->kmaps, map);
>  
>  	return 0;
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index fdd5bddb3075..a2cdfe62df94 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -223,7 +223,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>   * they are loaded) and for vmlinux, where only after we load all the
>   * symbols we'll know where it starts and ends.
>   */
> -struct map *map__new2(u64 start, struct dso *dso)
> +struct map *map__new2(u64 start, struct dso *dso, struct maps *kmaps)
>  {
>  	struct map *map = calloc(1, (sizeof(*map) +
>  				     (dso->kernel ? sizeof(struct kmap) : 0)));
> @@ -232,6 +232,19 @@ struct map *map__new2(u64 start, struct dso *dso)
>  		 * ->end will be filled after we load all the symbols
>  		 */
>  		map__init(map, start, 0, 0, dso);

we are passing NULL for kmaps in some cases,
should we check it in here and warn?

		if (!WARN_ON_ONCE(!kmaps, "too bad..") && dso->kernel)
			

jirka

