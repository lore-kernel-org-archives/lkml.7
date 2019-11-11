Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615CC17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7266206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUcBcBlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKKLdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:33:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24270 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbfKKLdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573471998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LI2CwsVQX5RYYaIpqN0MpmZCFExe3h+UKOjo8EkHCRs=;
        b=CUcBcBlRlDwvRTdmKIIbJIszn/18qnh7j88hFzxjeGet4LwFrJFlWriBSwBM2BP6xeYoH2
        SgnDQB1k/s8qb/HkjjjO9QHU0MuDyKJ/Vjt435Jcbp70aSPEEhir7bAuztjGnoDcM1814C
        MYu3aGviiwDTvTFbbeegeelJIk6D1Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-4mY9sfvKO2ikT0NC-zfiXQ-1; Mon, 11 Nov 2019 06:33:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FC3B107ACC5;
        Mon, 11 Nov 2019 11:33:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64CFA19C4F;
        Mon, 11 Nov 2019 11:33:12 +0000 (UTC)
Date:   Mon, 11 Nov 2019 12:33:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf inject --jit: Remove //anon mmap events
Message-ID: <20191111113311.GA9791@krava>
References: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
 <20191101082740.GB2172@krava>
 <CY4PR21MB063262D81AB2BE5FEE88057EF77A0@CY4PR21MB0632.namprd21.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <CY4PR21MB063262D81AB2BE5FEE88057EF77A0@CY4PR21MB0632.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4mY9sfvKO2ikT0NC-zfiXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2019 at 04:49:25PM +0000, Steve MacLean wrote:
> > > While a JIT is jitting code it will eventually need to commit more=20
> > > pages and change these pages to executable permissions.
> > >=20
> > > Typically the JIT will want these colocated to minimize branch displa=
cements.
> > >=20
> > > The kernel will coalesce these anonymous mapping with identical=20
> > > permissions before sending an MMAP event for the new pages. This mean=
s=20
> > > the mmap event for the new pages will include the older pages.
> > >=20
> > > These anonymous mmap events will obscure the jitdump injected pseudo =
events.
> > > This means that the jitdump generated symbols, machine code, debuggin=
g=20
> > > info, and unwind info will no longer be used.
> > >=20
> > > Observations:
> > >=20
> > > When a process emits a jit dump marker and a jitdump file, the=20
> > > perf-xxx.map file represents inferior information which has been=20
> > > superceded by the jitdump jit-xxx.dump file.
> > >=20
> > > Further the '//anon*' mmap events are only required for the legacy=20
> > > perf-xxx.map mapping.
> > >=20
> > > When attaching to an existing process, the synthetic anon map events=
=20
> > > are given a time stamp of -1. These should not obscure the jitdump=20
> > > events which have an actual time.
> > >=20
> > > Summary:
> > >=20
> > > Use thread->priv to store whether a jitdump file has been processed
> >=20
> > I'm ok wih the implementation but not sure about the described JIT/mmap=
 logic, Stephane?
> >=20
> > jirka
>=20
> The kernel only seems to coalesce the anonymous mappings when the allocat=
ions grow beyond 64K. It may not affect JITs for smaller sets of JITted cod=
e.  I would guess a javascript JIT engine might not hit this type of proble=
m often.
>=20
> @Stephane Eranian could you comment.
>=20
> @Jiri Olsa I am happy to expand the explanation if it would be helpful.

that'd be great, thanks

jirka

