Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D6CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CDD21920
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgKrqEu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbfJ1VG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46006 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391119AbfJ1VGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572296813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qs80qKEjJqjb3JocGFXcxF2DSxYMQR2JCI+aYDkOum0=;
        b=IgKrqEu3RKNjQbJU0uluW8jV0rX4BnUreYU3m9dwHAHb5DcrZ/vfLWxemHmKI+8TFM9xBk
        zgH7k766iXHeSwgTMOSEkJwpHRzPgqkc/m6ucp0GXXs2rckMqYqo9Gij0C5UVcHX9GJolh
        2fdSFq9P5d0UnOKk9kvjsIYCyH8psuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-CHxv1kvuMsm_hdpji176SQ-1; Mon, 28 Oct 2019 17:06:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C8185B6EE;
        Mon, 28 Oct 2019 21:06:43 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id A5D621C92C;
        Mon, 28 Oct 2019 21:06:38 +0000 (UTC)
Date:   Mon, 28 Oct 2019 22:06:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 2/9] perf tools: splice events onto evlist even on
 error
Message-ID: <20191028210637.GA6158@krava>
References: <20191023005337.196160-1-irogers@google.com>
 <20191024190202.109403-1-irogers@google.com>
 <20191024190202.109403-3-irogers@google.com>
 <20191025080142.GF31679@krava>
 <CAP-5=fWoHN9wqWasZyyu8mB99-1SOP3NhTT9XX6d99aTG6-AOA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWoHN9wqWasZyyu8mB99-1SOP3NhTT9XX6d99aTG6-AOA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CHxv1kvuMsm_hdpji176SQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:47:12AM -0700, Ian Rogers wrote:

SNIP

> event_pmu: PE_NAME opt_event_config
> {
> ...
> ALLOC_LIST(list);  // <--- where list gets allocated
> ...
> https://github.com/torvalds/linux/blob/master/tools/perf/util/parse-event=
s.y#L229
>=20
> opt_event_config:
> https://github.com/torvalds/linux/blob/master/tools/perf/util/parse-event=
s.y#L510
>=20
> So the parse_state is ending up with a list, however, parsing is
> failing. If the list isn't adding to the evlist then it becomes a
> leak. Splicing it onto the evlist allows the caller to clean this up
> and avoids the leak. An alternate approach is to free the failed list
> and not get the caller to clean up. A way to do this is to create an
> evlist, splice the failed list onto it and then free it - which winds
> up being fairly identical to this approach, and this approach is a
> smaller change.

agreed, thanks for the all the details

jirka

