Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB58CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CE120836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576104491;
	bh=DD8INVkwJpJv2xxhwnzPfUefx+mhqGh0qSR5+lmYjHM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=s/iR9Elfb/KCRB/nsXPtmiX/clFM7B37zODESav98Lbw85DWGgAECg3Mf8MRV8+0A
	 ev/qu8d0WfhfJu+RBqoJ96Beic97OV6fvALn3MWCub96n9J3/58bysOCHxqK9V8CDf
	 Wu44vxMf+po4mEMjL5Fud7K87szYUdnaCWCcIwyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfLKWsK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:48:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60255 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbfLKWsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:48:10 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-t2roI4FlNrGiHTuRxO7f_A-1; Wed, 11 Dec 2019 17:48:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5190A8CA9E9;
        Wed, 11 Dec 2019 22:48:04 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C503E60BF3;
        Wed, 11 Dec 2019 22:48:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC 0/3] perf tools: Add support for used defined metric
Date:   Wed, 11 Dec 2019 23:47:57 +0100
Message-Id: <20191211224800.9066-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: t2roI4FlNrGiHTuRxO7f_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Joe asked for possibility to add user defined metrics. Given that
we already have metrics support, I added --metric option that allows
to specify metric on the command line, like:

  # perf stat  --metric 'DECODED_ICACHE_UOPS% = 100 * (idq.dsb_uops / \
    (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops))' ...

The code facilitates the current metric code, and I was surprised
how easy it was, so I'm not sure I omitted something ;-)

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric

thoughts?
jirka

---
Jiri Olsa (3):
      perf tools: Factor metric addition into add_metric function
      perf tools: Factor metric setup code into metricgroup__setup function
      perf stat: Add --metric option

 tools/perf/Documentation/perf-stat.txt |  16 ++++++++++
 tools/perf/builtin-stat.c              |  21 +++++++++++++
 tools/perf/util/metricgroup.c          | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
 tools/perf/util/metricgroup.h          |   2 ++
 4 files changed, 168 insertions(+), 60 deletions(-)

