Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87CC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6658E2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy0OQ3oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFOem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:34:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726195AbfLFOem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575642881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKCGK3c2hrW8VTxOV/U7+PqjCXy11yQ76vuS6HAcuQ8=;
        b=fy0OQ3oAzHK4SWvjmD37SwVp1kvKNHLLNOJmUjOUuihijxF4OfTjhjNAfhx11YR8Yzgall
        tBlFBpeOztYbeLcMJtPxQfMwOdneMYaeT2bRBKyklwALeCBmbZhLZ/Fe8lpvvktIOke0DI
        Jn1fXv2aFi9QqOv1WUor+L+Dr3SLPcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-2G6g2vfjNaazQSPyWw1r4Q-1; Fri, 06 Dec 2019 09:34:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EB36593A3;
        Fri,  6 Dec 2019 14:34:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 864E63B5;
        Fri,  6 Dec 2019 14:34:34 +0000 (UTC)
Date:   Fri, 6 Dec 2019 15:34:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 0/3] perf/libperf move
Message-ID: <20191206143432.GB31721@krava>
References: <20191206135513.31586-1-jolsa@kernel.org>
 <20191206142154.GA30698@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191206142154.GA30698@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2G6g2vfjNaazQSPyWw1r4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 11:21:54AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 06, 2019 at 02:55:10PM +0100, Jiri Olsa escreveu:
> > NOTE 'make perf-targz-src-pkg' works nicely with this change,
> > but is currently failing because of recent bpf changes, I have
> > a fix for that and will send it shortly
>=20
> By any means it is one of:
>=20
> "libbpf: Fix up generation of bpf_helper_defs.h"
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=
=3D1fd450f99272

yep, I ended up wit hthe same patch.. great ;-)

thanks,
jirka

>=20
> And:
>=20
> "libbpf: Fix sym->st_value print on 32-bit arches"
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=
=3D7c3977d1e804
>=20
> ?
>=20
> I've been cherry-picking this to have my build-test and container builds
> for some time waiting for those to get upstream.
>=20
> - Arnaldo
>=20

