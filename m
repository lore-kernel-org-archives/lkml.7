Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BBECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0471120873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViMLsw9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfJ1T3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:29:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730396AbfJ1T3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572290958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHdfyKuL2l12ILhMSzFqfHrz78VdODcHNr4fpbKG+Vc=;
        b=ViMLsw9HP3F0idrLUctSSxRG7OQ/ia1J10bf0CBO2b0eNPkSLks9VC9lEpzvWV6nRiJSzK
        4oRn/x+QIz5gmWlrtzMpsxQvY4a72INc2q7e5z+5E1tlAlp2VclKu/2BPei2OWgER8krQ+
        btIi4s2piw/rG/ZNC3wFK5YWAXqQg1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-6bQKFF1vMbiXZZ95VKYQag-1; Mon, 28 Oct 2019 15:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03F055E4;
        Mon, 28 Oct 2019 19:29:13 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4EE7960BF7;
        Mon, 28 Oct 2019 19:29:10 +0000 (UTC)
Date:   Mon, 28 Oct 2019 20:29:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf annotate: fix heap overflow
Message-ID: <20191028192908.GA28772@krava>
References: <20191026035644.217548-1-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191026035644.217548-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6bQKFF1vMbiXZZ95VKYQag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:56:44PM -0700, Ian Rogers wrote:
> Fix expand_tabs that copies the source lines '\0' and then appends
> another '\0' at a potentially out of bounds address.

not sure it could get out of bounds, but i think
the change is right, it matches the memcpy before
and I dont see reason to add +1

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ef1866a902c4..bee0fee122f8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1892,7 +1892,7 @@ static char *expand_tabs(char *line, char **storage=
, size_t *storage_len)
>  =09}
> =20
>  =09/* Expand the last region. */
> -=09len =3D line_len + 1 - src;
> +=09len =3D line_len - src;
>  =09memcpy(&new_line[dst], &line[src], len);
>  =09dst +=3D len;
>  =09new_line[dst] =3D '\0';
> --=20
> 2.24.0.rc0.303.g954a862665-goog
>=20

