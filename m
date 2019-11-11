Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DCFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7209A2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClXUZ8PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKMCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:02:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34325 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbfKKMCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573473761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asuKFrmfRkgz31jPShyl4Uq8GY2UyMyCxsRRtK4N75o=;
        b=ClXUZ8PGn11ZqlYr3/2DfzKeT70NlGnqyrVGyPXHki2yFPRJSGwB4GaBgggmZ4pfz7/5b+
        dR9HzzUIjWFslJ6c9QkgmgHa8CjvkJUibCi2vp28yczAoSKXsScTBf0UXXzGO4hCsDEVG8
        otW8HqJxJ8K1le1jnAkQ5dAhouejH/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-oDGmOIugO7uT3CWU4KMMNw-1; Mon, 11 Nov 2019 07:02:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7DC21854E76;
        Mon, 11 Nov 2019 12:02:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7C32D608FD;
        Mon, 11 Nov 2019 12:02:31 +0000 (UTC)
Date:   Mon, 11 Nov 2019 13:02:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: report initial event parsing error
Message-ID: <20191111120230.GD9791@krava>
References: <20191107222315.GA7261@kernel.org>
 <20191108181533.222053-1-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191108181533.222053-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: oDGmOIugO7uT3CWU4KMMNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 10:15:33AM -0800, Ian Rogers wrote:
> Record the first event parsing error and report. Implementing feedback
> from Jiri Olsa:
> https://lkml.org/lkml/2019/10/28/680
>=20
> An example error is:
>=20
> $ tools/perf/perf stat -e c/c/
> WARNING: multiple event parsing errors
> event syntax error: 'c/c/'
>                        \___ unknown term
>=20
> valid terms: event,filter_rem,filter_opc0,edge,filter_isoc,filter_tid,fil=
ter_loc,filter_nc,inv,umask,filter_opc1,tid_en,thresh,filter_all_op,filter_=
not_nm,filter_state,filter_nm,config,config1,config2,name,period,percore
>=20
> Initial error:
> event syntax error: 'c/c/'
>                     \___ Cannot find PMU `c'. Missing kernel support?

not sure where this got lost or if it was there before,
but the index should point to zero to have the 'arrow' aligned

jirka


---
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index a369bbc289b2..6bae9d6edc12 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1366,7 +1366,7 @@ int parse_events_add_pmu(struct parse_events_state *p=
arse_state,
 =09=09if (asprintf(&err_str,
 =09=09=09=09"Cannot find PMU `%s'. Missing kernel support?",
 =09=09=09=09name) >=3D 0)
-=09=09=09parse_events__handle_error(err, -1, err_str, NULL);
+=09=09=09parse_events__handle_error(err, 0, err_str, NULL);
 =09=09return -EINVAL;
 =09}
=20

