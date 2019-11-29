Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92690C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6399721736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhAZFgn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfK2TJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 14:09:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726970AbfK2TJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575054570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fCtB9CMx04qJznBMfhWf+dMljcILc+IbA1Q6R+vWks=;
        b=DhAZFgn/Wlpx4gplnj16z99xEYpj0ZVOMWKBKpk7p+Ns4X6Nf1WXoQirbG3Zgo4Y6muujJ
        E5mWNaan/8NLkUGQXfOYSpnU7reSzpsrJgyK2e3k3XWqh66PF+ixWDTcibKO62GXxw2y8U
        fFrLcz7UDiABouSjryMheCWCKRCc98Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-ivfxNWiRMgKItK2Qq72pew-1; Fri, 29 Nov 2019 14:09:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE3E2DB20;
        Fri, 29 Nov 2019 19:09:24 +0000 (UTC)
Received: from krava (ovpn-204-101.brq.redhat.com [10.40.204.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id 58DF360BF4;
        Fri, 29 Nov 2019 19:09:22 +0000 (UTC)
Date:   Fri, 29 Nov 2019 20:09:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Message-ID: <20191129190921.GC26903@krava>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
 <20191129134056.GE14169@krava>
 <20191129151733.GC26963@kernel.org>
 <20191129160631.GD26963@kernel.org>
 <20191129180354.GB26903@krava>
 <20191129185914.GE4063@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191129185914.GE4063@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ivfxNWiRMgKItK2Qq72pew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 03:59:14PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 29, 2019 at 07:03:54PM +0100, Jiri Olsa escreveu:
> > On Fri, Nov 29, 2019 at 01:06:31PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > Em Fri, Nov 29, 2019 at 12:17:33PM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > Em Fri, Nov 29, 2019 at 02:40:56PM +0100, Jiri Olsa escreveu:
> > > > > > +++ b/tools/perf/util/callchain.c
> > > > > > @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_locat=
ion *al, struct callchain_cursor_node *
> > > > > >  =09=09=09goto out;
> > > > > >  =09}
> > > > > > =20
> > > > > > -=09if (al->map->groups =3D=3D &al->machine->kmaps) {
> > > > > > -=09=09if (machine__is_host(al->machine)) {
> > > > > > +=09if (al->mg =3D=3D &al->mg->machine->kmaps) {
> > >=20
> > > > > heya, I'm getting segfault because of this change
> > >=20
> > > > > perf record --call-graph dwarf ./ex
> > >=20
> > > > > =09(gdb) r report --stdio
> > > > > =09Program received signal SIGSEGV, Segmentation fault.
> > > > > =09fill_callchain_info (al=3D0x7fffffffa1b0, node=3D0xcd2bd0, hid=
e_unresolved=3Dfalse) at util/callchain.c:1122
> > > > > =091122            if (al->maps =3D=3D &al->maps->machine->kmaps)=
 {
> > > > > =09(gdb) p al->maps
> > > > > =09$1 =3D (struct maps *) 0x0
>=20
> > > > > I wish all those map changes would go through some review,
> > > > > I have no idea how the code works now ;-)
>=20
> > > > ouch, I did tons of tests, obviously some more, and reviewing, woul=
d
> > > > catch these, my bad, will try and fix this...
>=20
> > > > And yeah, I reproduced the problem, working on a fix.
>=20
> > > Can you try with this one-liner?
>=20
> > yep, it fixes the issue for me
>=20
> Thanks, I'm taking that as a Tested-by: you, in addition to the
> Reported-by,
>=20

sure, thanks

jirka

