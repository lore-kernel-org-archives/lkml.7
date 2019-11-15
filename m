Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F493C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AEC2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKeDwDyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKONex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:34:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727314AbfKONex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573824892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPqtDIpYvkWABIOghDIbiLGDdC840M0oC0MtBbGDARU=;
        b=fKeDwDypN8KlGc0crVnBbBHEjtTzxqSw8nobUZVA/BoS5nvgoSQKQFIeTxp9JXZuNpZoGF
        nR4MeiF5sGnGGgQ1qyy96D7ESB8lSDc21IMBYpoTaRFqoo0feHkRYJ9kZmYT7fql8MsIKm
        b20y8GI7cCHhk9050KgT537EP0d8inM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-uvkWbrRdOC6kBcK15Uq8Mw-1; Fri, 15 Nov 2019 08:34:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7B9D801FD2;
        Fri, 15 Nov 2019 13:34:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC9296293B;
        Fri, 15 Nov 2019 13:34:45 +0000 (UTC)
Date:   Fri, 15 Nov 2019 14:34:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 2/2] perf report: Jump to symbol source view from
 total cycles view
Message-ID: <20191115133445.GB25491@krava>
References: <20191113004852.21265-1-yao.jin@linux.intel.com>
 <20191113004852.21265-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191113004852.21265-2-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: uvkWbrRdOC6kBcK15Uq8Mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 08:48:52AM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index e8b3122a30a7..5bf122042c01 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -478,7 +478,8 @@ int res_sample_browse(struct res_sample *res_samples,=
 int num_res,
>  void res_sample_init(void);
> =20
>  int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
> -=09=09=09   float min_percent);
> +=09=09=09   float min_percent, struct perf_env *env,
> +=09=09=09   struct annotation_options *annotation_opts);
>  #else
>  static inline
>  int perf_evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
> @@ -525,7 +526,9 @@ static inline void res_sample_init(void) {}
> =20
>  int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
>  =09=09=09   struct evsel *evsel __maybe_unused,
> -=09=09=09   float min_percent __maybe_unused)
> +=09=09=09   float min_percent __maybe_unused,
> +=09=09=09   struct perf_env *env __maybe_unused,
> +=09=09=09   struct annotation_options *annotation_opts)

missing __maybe_unused, this breaks no-tui build 'make NO_SLANG=3D1'

jirka

