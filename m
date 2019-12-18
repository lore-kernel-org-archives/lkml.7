Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B92AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECCC20717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3DFFM4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLRJHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:07:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbfLRJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576660040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rbEHPbD9OTETU2vGaoV0FkTbQSkehWHjxnSN6W6W+90=;
        b=Q3DFFM4qV7dcPz3DaJdQj4BjefoFy8ddJoCse6mEKcWiI6E/vIaDIEsH2QHhH57dPLIifv
        B/+F1ZfW72c0DK3hF+ICPUVzbtL/iNoGJ9Hvo44ZiPI/lnJaPYJRS+3QF/7tUB+tPxxrPx
        rSxmR15iBjKNc58yhtov1Wivf5zQPNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-6fVtQonJPQuoyNQ1k_TqOw-1; Wed, 18 Dec 2019 04:07:15 -0500
X-MC-Unique: 6fVtQonJPQuoyNQ1k_TqOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F13C801E70;
        Wed, 18 Dec 2019 09:07:13 +0000 (UTC)
Received: from krava (ovpn-204-177.brq.redhat.com [10.40.204.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BED860C18;
        Wed, 18 Dec 2019 09:07:10 +0000 (UTC)
Date:   Wed, 18 Dec 2019 10:07:07 +0100
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
Message-ID: <20191218090707.GF19062@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217144828.2460-13-acme@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:48:28AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

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

hum, how about map__new? kernel maps could go throught that as well, right?

jirka

