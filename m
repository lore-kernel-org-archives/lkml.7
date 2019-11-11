Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0578C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7587222CB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiF6oFBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKKNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:31:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47335 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726897AbfKKNbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573479073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKHcRoF7prIMnwnvQYPeH2Xko5af8fJGBlM20TjEI64=;
        b=RiF6oFBKVqbB6f3DgeshmAoK/3B1JBQtPoc7tOE+yXXnqwLniVjpMdRUxklq5ekWBl6/Bq
        v520t2rW2tsWaFD/Lo0caV/o8YgxDLwntgpnu1CiAO0zakaijfabV9q+hHvaiEGS80qH2p
        eUnnktoQz/Z7ov5iv98w2O1J0IjCoww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-kd1QToK1OuK8ryWcLMcDew-1; Mon, 11 Nov 2019 08:31:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CAB2107ACC4;
        Mon, 11 Nov 2019 13:31:09 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id E120026FBA;
        Mon, 11 Nov 2019 13:31:07 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:31:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 10/13] perf stat: Use affinity for opening events
Message-ID: <20191111133107.GG12923@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-11-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-11-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kd1QToK1OuK8ryWcLMcDew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:16:43AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 2fb83aabbef5..9f8a9393ce4a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -776,7 +776,7 @@ static int record__open(struct record *rec)
>  =09=09=09if ((errno =3D=3D EINVAL || errno =3D=3D EBADF) &&
>  =09=09=09    pos->leader !=3D pos &&
>  =09=09=09    pos->weak_group) {
> -=09=09=09        pos =3D perf_evlist__reset_weak_group(evlist, pos);
> +=09=09=09        pos =3D perf_evlist__reset_weak_group(evlist, pos, true=
);
>  =09=09=09=09goto try_again;
>  =09=09=09}
>  =09=09=09rc =3D -errno;
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 1a586009e5a7..7f9ec41d8f62 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -65,6 +65,7 @@
>  #include "util/target.h"
>  #include "util/time-utils.h"
>  #include "util/top.h"
> +#include "util/affinity.h"
>  #include "asm/bug.h"
> =20
>  #include <linux/time64.h>
> @@ -440,6 +441,7 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
>  =09=09=09ui__warning("%s event is not supported by the kernel.\n",
>  =09=09=09=09    perf_evsel__name(counter));
>  =09=09counter->supported =3D false;
> +=09=09counter->errored =3D true;

how is errored different from supported?
why can't you use it?

jirka

