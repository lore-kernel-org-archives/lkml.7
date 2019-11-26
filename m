Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24154C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD362073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqrsA06l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfKZJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:45:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727482AbfKZJpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574761518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRJ710zkAyfJD6QqUIPwoV2ssg6YDFq0ZY1Mig39iiw=;
        b=CqrsA06lMSBUM9S5mgrt9KdPd+4zAd+FiP8GMJ5DRQBa7EjVWuWRw+U2VD39ggtd6vCBm1
        8227pf4BSlLsHXECeCmXcUBbqELAreNhPzB7/Kg7TY3NLduNEw0cPbe+GFkOd9Uq0+66oz
        NpR5ZLEQ+PCmTTBGxlfkZVG4ua6sySM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-NQKwfCZINaGQ3dqQ-tfdJA-1; Tue, 26 Nov 2019 04:45:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE27800C74;
        Tue, 26 Nov 2019 09:45:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id D821819481;
        Tue, 26 Nov 2019 09:45:08 +0000 (UTC)
Date:   Tue, 26 Nov 2019 10:45:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] perf: support multiple debug options separated by
 ','
Message-ID: <20191126094508.GB32367@krava>
References: <20191125151446.10948-1-changbin.du@gmail.com>
 <20191125151446.10948-2-changbin.du@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191125151446.10948-2-changbin.du@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NQKwfCZINaGQ3dqQ-tfdJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:14:45PM +0800, Changbin Du wrote:
> This patch adds support for multiple debug options separated by ',' and
> non-int values.
> =09--debug verbose=3D2,stderr
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf.txt | 13 +++--
>  tools/perf/util/debug.c           | 89 ++++++++++++++++---------------
>  2 files changed, 53 insertions(+), 49 deletions(-)
>=20
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation=
/perf.txt
> index 3f37ded13f8c..fd8d790f68a7 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -19,13 +19,12 @@ OPTIONS
>  =09  --debug verbose=3D2 # sets verbose =3D 2
> =20
>  =09List of debug variables allowed to set:
> -=09  verbose          - general debug messages
> -=09  ordered-events   - ordered events object debug messages
> -=09  data-convert     - data convert command debug messages
> -=09  stderr           - write debug output (option -v) to stderr
> -=09                     in browser mode
> -=09  perf-event-open  - Print perf_event_open() arguments and
> -=09=09=09     return value
> +=09  verbose=3Dlevel=09=09- general debug messages
> +=09  ordered-events=3Dlevel=09- ordered events object debug messages
> +=09  data-convert=3Dlevel=09- data convert command debug messages
> +=09  stderr=09=09- write debug output (option -v) to stderr
> +=09  perf-event-open=09- Print perf_event_open() arguments and
> +=09                          return value in browser mode

it's just the list and the doc says user can use values
there, so no need for the '=3Dlevel' there

also we allow this:
  perf --debug stderr=3D9 record ls

so I thinks we should keep it general in documentation,
eventhough it will always mean just stderr=3Dtrue for any
value

jirka

