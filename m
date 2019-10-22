Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3542064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNFJypj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbfJVICc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:02:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57041 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387692AbfJVICb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571731350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUmCSC+sLU7Zo2ZV+nGJDedwwjTXgkes0+a1E3YaWyM=;
        b=jNFJypj+Vm5tqaLvR2Zp57IX9kDsmeRmPnfqfSiaBvKzqQfG+LUz6+fHutX/wc40tXzLfs
        TxkoWq46sTvJGPhBs2WAwaPnHDBmYphXHA8XSMsGDi7S8cAfww7R2ja2/2/tth2Vfp1rGg
        s2WE0h0XJ62GIlmgqYuDXoKqX6g+Q2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208--dDvj_9EO8KO_b2HBCEXgA-1; Tue, 22 Oct 2019 04:02:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEE0D107AD31;
        Tue, 22 Oct 2019 08:02:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4CD5460C4E;
        Tue, 22 Oct 2019 08:02:24 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:02:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: Optimize perf stat for large number of events/cpus v2
Message-ID: <20191022080223.GC28177@krava>
References: <20191020175202.32456-1-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191020175202.32456-1-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -dDvj_9EO8KO_b2HBCEXgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 10:51:53AM -0700, Andi Kleen wrote:
> [The earlier v1 version had a lot of conflicts against some
> recent libperf changes in tip/perf/core. Resolve that and
> also fix some minor issues.]
>=20
> This patch kit optimizes perf stat for a large number of events=20
> on systems with many CPUs and PMUs.
>=20
> Some profiling shows that the most overhead is doing IPIs to
> all the target CPUs. We can optimize this by using sched_setaffinity
> to set the affinity to a target CPU once and then doing
> the perf operation for all events on that CPU. This requires
> some restructuring, but cuts the set up time quite a bit.
>=20
> In theory we could go further by parallelizing these setups
> too, but that would be much more complicated and for now just batching it
> per CPU seems to be sufficient. At some point with many more cores=20
> parallelization or a better bulk perf setup API might be needed though.
>=20
> In addition perf does a lot of redundant /sys accesses with
> many PMUs, which can be also expensve. This is also optimized.
>=20
> On a large test case (>700 events with many weak groups) on a 94 CPU
> system I go from
>=20
> real=090m8.607s
> user=090m0.550s
> sys=090m8.041s
>=20
> to=20
>=20
> real=090m3.269s
> user=090m0.760s
> sys=090m1.694s
>=20
> so shaving ~6 seconds of system time, at slightly more cost
> in perf stat itself. On a 4 socket system with the savings
> are more dramatic:
>=20
> real=090m15.641s
> user=090m0.873s
> sys=090m14.729s
>=20
> to=20
>=20
> real=090m4.493s
> user=090m1.578s
> sys=090m2.444s
>=20
> so 11s difference in the user visible set up time.
>=20
> Also available in=20
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/stat-sca=
le-4
>=20
> v1: Initial post.
> v2: Rebase. Fix some minor issues.

looks really helpful, I ack-ed 1st 2 patches,
I'll need more time for the rest

thanks,
jirka

