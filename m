Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C371C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6652073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HP5SfkVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfKOOzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:55:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfKOOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573829742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGfT54RxA7mQzeigRrlaCZiQxpF3K7iNUCarX17p1A0=;
        b=HP5SfkVW2vDsLnoyyw105rrY2zrQ0VpX96y/hR2O6ZxXiyPdtemFiWF+4KMyGzBFe93VUZ
        zcDAnurcWQzieVdQjROiRi3LLyL7UO026wNon6qAYBLLWEMLOvzwB4bnd06l9N4rHbXQJE
        InFmsiJSBFC2ulEw+e8nV1SrjmZsO0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-rX2E02bkN6ywdzMmaQOMyA-1; Fri, 15 Nov 2019 09:55:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9574D1005513;
        Fri, 15 Nov 2019 14:55:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 77CD528DFD;
        Fri, 15 Nov 2019 14:55:36 +0000 (UTC)
Date:   Fri, 15 Nov 2019 15:55:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 10/12] perf stat: Use affinity for reading
Message-ID: <20191115145535.GC4255@krava>
References: <20191112005941.649137-1-andi@firstfloor.org>
 <20191112005941.649137-11-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191112005941.649137-11-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rX2E02bkN6ywdzMmaQOMyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:59:39PM -0800, Andi Kleen wrote:

SNIP

> =20
>  =09evlist__for_each_entry(evsel_list, counter) {
> -=09=09ret =3D read_counter(counter, rs);
> -=09=09if (ret)
> +=09=09if (counter->err)
>  =09=09=09pr_debug("failed to read counter %s\n", counter->name);
> -
> -=09=09if (ret =3D=3D 0 && perf_stat_process_counter(&stat_config, counte=
r))
> +=09=09if (counter->err =3D=3D 0 && perf_stat_process_counter(&stat_confi=
g, counter))
>  =09=09=09pr_warning("failed to process counter %s\n", counter->name);
> +=09=09counter->err =3D 0;
>  =09}
>  }
> =20
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index ca82a93960cd..c8af4bc23f8f 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -86,6 +86,7 @@ struct evsel {
>  =09struct list_head=09config_terms;
>  =09struct bpf_object=09*bpf_obj;
>  =09int=09=09=09bpf_fd;
> +=09int=09=09=09err;

I was wondering what would be the best place for this,
and all the previous variables u added and this one
are stat specific, so I think this all belongs to
 =20
  (struct perf_stat_evsel*) evsel->stat

jirka

