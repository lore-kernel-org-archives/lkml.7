Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3153CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9962821872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvCUxXe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbfJWJBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:01:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732361AbfJWJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571821307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N61mf/IyTSPpFH13u3QL5saI0zqXCL7YT7+aVbI/wNI=;
        b=JvCUxXe4mLWZaOjGviB7jAIzHjAZ4mxJNbqlvEB3+aXnjseeZD5Unz1og30llShXOojJbx
        qyE7n5jgkRWSjJ9SmYuRUS/lGoma15rVihb+Kn/gEiCwiK1SsSCc3+BqoiTjkxIRnE/nCt
        zEaWnsOk6TspwEL4xzZEZvERS1nm/A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-NB-BrnHlPs6FLyJ_rB9LBw-1; Wed, 23 Oct 2019 05:01:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2827F1005509;
        Wed, 23 Oct 2019 09:01:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8185DC1E;
        Wed, 23 Oct 2019 09:01:31 +0000 (UTC)
Date:   Wed, 23 Oct 2019 11:01:31 +0200
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
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 6/9] perf tools: add destructors for parse event terms
Message-ID: <20191023090131.GH22919@krava>
References: <20191017170531.171244-1-irogers@google.com>
 <20191023005337.196160-1-irogers@google.com>
 <20191023005337.196160-7-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191023005337.196160-7-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NB-BrnHlPs6FLyJ_rB9LBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:53:34PM -0700, Ian Rogers wrote:
> If parsing fails then destructors are ran to clean the up the stack.
> Rename the head union member to make the term and evlist use cases more
> distinct, this simplifies matching the correct destructor.

I'm getting compilation fail:

  CC       util/parse-events-bison.o
util/parse-events.y: In function =E2=80=98yydestruct=E2=80=99:
util/parse-events.y:125:45: error: =E2=80=98struct tracepoint_name=E2=80=99=
 has no member named =E2=80=98sys=E2=80=99; did you mean =E2=80=98sys1=E2=
=80=99?
  125 | %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>

jirka

