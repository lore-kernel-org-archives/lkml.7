Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F0AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B112190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NejELK8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKKMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:02:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35497 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbfKKMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573473752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZX77dlGVfs5zLCgF16lmUTyr3KZ7aqDcwM5gBK/oIvQ=;
        b=NejELK8ax2PWlhi3azBMq0MvT7UyLbMdkaDR1vmmwvumQbs4l23dczTptdX6k57Xu9n5s2
        YL5fKAZM4imTsyHfoHqLIiChl3bb5q+kJ9LPmWdZ+uIA6vZsZF7304pRFqgZS9EYk6WaIk
        p93bsoGNherPdku3QuOTMPQm6PIZsXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-FX5Taea7OpKScG0ACy2yfg-1; Mon, 11 Nov 2019 07:02:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27EA2108FB95;
        Mon, 11 Nov 2019 12:02:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 58DFE4B4;
        Mon, 11 Nov 2019 12:02:21 +0000 (UTC)
Date:   Mon, 11 Nov 2019 13:02:20 +0100
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
Message-ID: <20191111120220.GC9791@krava>
References: <20191107222315.GA7261@kernel.org>
 <20191108181533.222053-1-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191108181533.222053-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FX5Taea7OpKScG0ACy2yfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 10:15:33AM -0800, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 43c05eae1768..46a72ecac427 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3016,11 +3016,18 @@ static bool evlist__add_vfs_getname(struct evlist=
 *evlist)
>  {
>  =09bool found =3D false;
>  =09struct evsel *evsel, *tmp;
> -=09struct parse_events_error err =3D { .idx =3D 0, };
> -=09int ret =3D parse_events(evlist, "probe:vfs_getname*", &err);
> +=09struct parse_events_error err;
> +=09int ret;
> =20
> -=09if (ret)
> +=09bzero(&err, sizeof(err));

hum, what's the problem with the zero init above?

jirka

