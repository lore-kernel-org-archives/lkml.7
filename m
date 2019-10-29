Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA53CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F02421734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYRzzOXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfJ2U7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:59:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27536 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727545AbfJ2U7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572382743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1UD13lunqkCUm4GY9cPRpg96TpPCTqtU0JUYdMep3E=;
        b=eYRzzOXfClwXI7484IpGHhZ6quNLBApV0ADtWPop/rUoDvFfyMPCgQ9Xd04m4+tOmyUS2W
        W/zGmuAzYO50ifqSY1M7WvF8Lc+SC9USauaitjuvsHV8d3rvsFXREm0n+9Q2tR1mzzkaNa
        rj7kpwBGoHUvje1jyXZYljISA/UemXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-05YHT3TWMtGZ6h4GPNF9Aw-1; Tue, 29 Oct 2019 16:59:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88AFC8017DD;
        Tue, 29 Oct 2019 20:58:58 +0000 (UTC)
Received: from krava (ovpn-204-88.brq.redhat.com [10.40.204.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id E5ED019C69;
        Tue, 29 Oct 2019 20:58:55 +0000 (UTC)
Date:   Tue, 29 Oct 2019 21:58:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCHv2 0/2] perf tools: Share struct map after clone
Message-ID: <20191029205855.GA20826@krava>
References: <20191016082226.10325-1-jolsa@kernel.org>
 <20191023075517.GA22919@krava>
MIME-Version: 1.0
In-Reply-To: <20191023075517.GA22919@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 05YHT3TWMtGZ6h4GPNF9Aw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 09:55:17AM +0200, Jiri Olsa wrote:
> On Wed, Oct 16, 2019 at 10:22:24AM +0200, Jiri Olsa wrote:
> > hi,
> > Andi reported that maps cloning is eating lot of memory and
> > it's probably unnecessary, because they keep the same data.
> >=20
> > This 'maps sharing' seems to save lot of heap for reports with
> > many forks/cloned mmaps (over 60% in example below).
> >=20
> > Profile kernel build:
> >=20
> >   $ perf record make -j 40
> >=20
> > Get heap profile (tools/perf directory):
> >=20
> >   $ <install gperftools>
> >   $ make TCMALLOC=3D1
> >   $ HEAPPROFILE=3D/tmp/heapprof ./perf report -i perf.data --stdio > ou=
t
> >   $ pprof ./perf /tmp/heapprof.000*
> >=20
> > Before:
> >=20
> >   (pprof) top
> >   Total: 2335.5 MB
> >     1735.1  74.3%  74.3%   1735.1  74.3% memdup
> >      402.0  17.2%  91.5%    402.0  17.2% zalloc
> >      140.2   6.0%  97.5%    145.8   6.2% map__new
> >       33.6   1.4%  98.9%     33.6   1.4% symbol__new
> >       12.4   0.5%  99.5%     12.4   0.5% alloc_event
> >        6.2   0.3%  99.7%      6.2   0.3% nsinfo__new
> >        5.5   0.2% 100.0%      5.5   0.2% nsinfo__copy
> >        0.3   0.0% 100.0%      0.3   0.0% dso__new
> >        0.1   0.0% 100.0%      0.1   0.0% do_read_string
> >        0.0   0.0% 100.0%      0.0   0.0% __GI__IO_file_doallocate
> >=20
> > After:
> >=20
> >   (pprof) top
> >   Total: 784.5 MB
> >      385.8  49.2%  49.2%    385.8  49.2% memdup
> >      285.8  36.4%  85.6%    285.8  36.4% zalloc
> >       80.4  10.3%  95.9%     83.7  10.7% map__new
> >       19.1   2.4%  98.3%     19.1   2.4% symbol__new
> >        6.2   0.8%  99.1%      6.2   0.8% alloc_event
> >        3.6   0.5%  99.6%      3.6   0.5% nsinfo__new
> >        3.2   0.4% 100.0%      3.2   0.4% nsinfo__copy
> >        0.2   0.0% 100.0%      0.2   0.0% dso__new
> >        0.0   0.0% 100.0%      0.0   0.0% do_read_string
> >        0.0   0.0% 100.0%      0.0   0.0% elf_fill
> >=20
> > v2 changes:
> >   - rebased to Arnaldo's perf/core
> >   - patch 1 already taken
> >=20
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/map_shared
>=20
> I rebased to latest perf/core and pushed the branch out

rebased and pushed out

jirka

