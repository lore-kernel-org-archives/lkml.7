Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E362C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7DB2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c05pRYML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfLJRIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:08:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51113 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727568AbfLJRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575997730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1LxWoUCCaDfDj41e4N7lik4ufNetyUaON2Dcr5RbTo=;
        b=c05pRYMLnNhA430tl3paEoi9GNuEweaE/cwRNLPEjyGvJ7UQCTBw4ZTrHr6XMfmiHywUoS
        xbeUW5IUmj8vQLCubL1GQczBf3HFtvy/HiykQxEH+wqJDxBWt20eaxwaGNwkFGzjBhX5F+
        JYcQtV3T7fqUXQgATh3VvB+QoSkdmOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69--TvSP2o4Md2hGFjEiTm_iA-1; Tue, 10 Dec 2019 12:08:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E96D800EB8;
        Tue, 10 Dec 2019 17:08:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CE9060BE0;
        Tue, 10 Dec 2019 17:08:43 +0000 (UTC)
Date:   Tue, 10 Dec 2019 18:08:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: perf top for arm64?
Message-ID: <20191210170841.GA23357@krava>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
MIME-Version: 1.0
In-Reply-To: <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -TvSP2o4Md2hGFjEiTm_iA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:52:52PM +0000, John Garry wrote:
> On 10/12/2019 16:36, Jiri Olsa wrote:
> > On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
> > > Hi all,
> > >=20
> > > I find to my surprise that "perf top" does not work for arm64:
> > >=20
> > > root@ubuntu:/home/john/linux# tools/perf/perf top
> > > Couldn't read the cpuid for this machine: No such file or directory
> >=20
>=20
> Hi Jirka,
>=20
> > there was recent change that check on cpuid and quits:
> >    608127f73779 perf top: Initialize perf_env->cpuid, needed by the per=
 arch annotation init routine
> >=20
>=20
> ok, this is new code. I obviously didn't check the git history...
>=20
> But, apart from this, there are many other places where get_cpuid() is
> called. I wonder what else we're missing out on, and whether we should st=
ill
> add it.

right, I was just wondering how come vendor events are working for you,
but realized we have get_cpuid_str being called in there ;-)

I think we should add it as you have it prepared already,
could you post it with bigger changelog that would explain
where it's being used for arm?

jirka

