Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EFFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3D8206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVf8IRDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLFPia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:38:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26938 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbfLFPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575646709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcq+ahWkE8D1mPELgGr5ivyccQK+91C1JOIZlrY6pMs=;
        b=gVf8IRDfSM9apd4Z5AAUDHWdH/WY8M574PyYgO03krfA+HYKCNBh4nVZVNvvjIkO6qsWaf
        j6AJ9pMYtokqwRjkzBVjETGZPNI3qbtwOB1l2t5qvvO3w7a7griLFqq+HJr9/FR9wMw82v
        cae6ZJCpeHWfzxm6TyNdFpzLoXgzx1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-wE0EOF_1MVGLVLKStCm4vw-1; Fri, 06 Dec 2019 10:38:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D9688024D2;
        Fri,  6 Dec 2019 15:38:24 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6AC96B8F0;
        Fri,  6 Dec 2019 15:38:22 +0000 (UTC)
Date:   Fri, 6 Dec 2019 16:38:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/3] libperf: Move libperf under tools/lib/perf
Message-ID: <20191206153821.GE31721@krava>
References: <20191206135513.31586-1-jolsa@kernel.org>
 <20191206135513.31586-2-jolsa@kernel.org>
 <20191206142754.GC30698@kernel.org>
 <20191206150706.GD31721@krava>
 <20191206153351.GA13965@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191206153351.GA13965@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wE0EOF_1MVGLVLKStCm4vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 12:33:51PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 06, 2019 at 04:07:06PM +0100, Jiri Olsa escreveu:
> > On Fri, Dec 06, 2019 at 11:27:54AM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > Em Fri, Dec 06, 2019 at 02:55:11PM +0100, Jiri Olsa escreveu:
> > > > Moving libperf from its current location under perf
> > > > to separate directory under tools/lib.
> > >=20
> > > Breaks the build/bisection:
> >=20
> > yes, I noted that in the cover email, the 2nd patch repairs paths,
> > but those changes would get lost in the move.. I can squash it
> > if you want, but I thought this is more transparent despite the
> > one-commit-long broken bisect ;-)
>=20
> It may well be, but bisection for me is of primary importance, so please
> avoid breaking it,

ok, will squash it and send new version

thanks,
jirka

