Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB66C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FCF20885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKsUYA7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfKTPQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:16:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30161 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726771AbfKTPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574262991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4piZeHXh2vQrSJuyApu6KjdQRH+Y2uRbdZotE0ABqcc=;
        b=dKsUYA7zBQ1gMBk45kZIe0CpH3XStd2fqAsVz5affO2mpoJ1TCS63EsdsP18wUkmJMGKP4
        JrLOrpM1rdT3+F7+mHIXuEE1LNYD8WIbSKHTvfEhPIFyTFc4AddMjCd7lqvhKKFsjFnm0R
        aIvHNvywjjEQvDQsdQhy+1+4LCMUdaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-KXJGfSn8PX-ftAkfmAoMcg-1; Wed, 20 Nov 2019 10:16:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 670F5107ACC4;
        Wed, 20 Nov 2019 15:16:27 +0000 (UTC)
Received: from krava (unknown [10.40.205.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DF362AA8A;
        Wed, 20 Nov 2019 15:16:26 +0000 (UTC)
Date:   Wed, 20 Nov 2019 16:16:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Optimize perf stat for large number of events/cpus
Message-ID: <20191120151625.GG4007@krava>
References: <20191116055229.62002-1-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191116055229.62002-1-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: KXJGfSn8PX-ftAkfmAoMcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:52:17PM -0800, Andi Kleen wrote:
> [v7: Address review feedback. Fix python script problem
> reported by 0day. Drop merged patches.]
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
le-10
>=20
> v1: Initial post.
> v2: Rebase. Fix some minor issues.
> v3: Rebase. Address review feedback. Fix one minor issue
> v4: Modified based on review feedback. Now it maintains
> all_cpus per evlist. There is still a need for cpu_index iteration
> to get the correct index for indexing the file descriptors.
> Fix bug with unsorted cpu maps, now they are always sorted.
> Some cleanups and refactoring.
> v5: Split patches. Redo loop iteration again. Fix cpu map
> merging for uncore. Remove duplicates from cpumaps. Add unit
> tests.
> v6: Address review feedback. Fix some bugs. Add more comments.
> Merge one invalid patch split.
> v7: Address review feedback. Fix python scripting (thanks 0day)
> Minor updates.

I posted another 2 comments, but other than that I think it's ok

I don't like it, but can't see a better way ;-) and the speedup
is really impressive

thanks,
jirka

