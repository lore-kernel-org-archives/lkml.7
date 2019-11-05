Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F2C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBFF217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yvs7Wcio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbfKEMl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:41:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48541 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388159AbfKEMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572957717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GrM7hrBp4W1SX1nzG0Hw0C0O3PeEOnEJs7jd2emyEs=;
        b=Yvs7WciogWRcxb/3COwIR/TI1IwdVnGajbfAkOZAOUASrZrw95WBjnlM5e7dLpBrCucEKw
        8TTJaWVr7s0bsRr7nMUUIUH4amelc75ub4MCbn1/Nzr+SVKwgnBsaxF7nW622CrY13IoMT
        AnXMeyPK4qm9UT+PXNLEVASqkqeAXi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-3A4bySEmO7qU0O7amoN1kw-1; Tue, 05 Nov 2019 07:41:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF93800C73;
        Tue,  5 Nov 2019 12:41:52 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 005725D9C9;
        Tue,  5 Nov 2019 12:41:50 +0000 (UTC)
Date:   Tue, 5 Nov 2019 13:41:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix time sorting
Message-ID: <20191105124150.GD29390@krava>
References: <20191104232711.16055-1-jolsa@kernel.org>
 <20191105004854.GA25308@tassilo.jf.intel.com>
 <20191105114941.GA4218@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191105114941.GA4218@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3A4bySEmO7qU0O7amoN1kw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 08:49:41AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 04, 2019 at 04:48:54PM -0800, Andi Kleen escreveu:
> > On Tue, Nov 05, 2019 at 12:27:11AM +0100, Jiri Olsa wrote:
> > > The final sort might get confused when the comparison
> > > is done over bigger numbers than int like for -s time.
> > >=20
> > > Check following report for longer workloads:
> > >   $ perf report -s time -F time,overhead --stdio
> > >=20
> > > Fixing hist_entry__sort to properly return int64_t and
> > > not possible cut int.
> > >=20
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Link: http://lkml.kernel.org/n/tip-uetl5z1eszpubzqykvdftaq6@git.kerne=
l.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >=20
> > Looks good.
> >=20
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
>=20
> Thanks, applied after adding:
>=20
> Fixes: 043ca389a318 ("perf tools: Use hpp formats to sort final output")
> Cc: stable@vger.kernel.org # v3.16+

I was wondering about putting some commit there,
because it was there for long time.. but that
commit you use seems to be old enough.. ;-)

thanks,
jirka

