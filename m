Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF66AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E29221775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jt6dXC3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfLQUEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:04:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728146AbfLQUEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576613073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0gPdkIyRZAJvPSTRoX5H5XEW5mX5l3b5f1jVxA8POtI=;
        b=Jt6dXC3hfK/jlF3yvvvNcWAswgI5A+6jMIlCe/MJTREKpvrmOk8qkZt4r+NGRuVQ3szDPa
        M/tuPP7Fv2SL6YiiDlk4MlWo16mcxyJFmp66ovOq/hgTwTlo8k4uQEZVK9DBkX0C1iW/16
        Cm/Lp54smkoLJiGAd+ZxtW+mram6sqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-IGbNvfqiPMGdUhHJ0W6UOQ-1; Tue, 17 Dec 2019 15:04:29 -0500
X-MC-Unique: IGbNvfqiPMGdUhHJ0W6UOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96AD01005512;
        Tue, 17 Dec 2019 20:04:28 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD66468877;
        Tue, 17 Dec 2019 20:04:27 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 95070244; Tue, 17 Dec 2019 17:04:20 -0300 (BRT)
Date:   Tue, 17 Dec 2019 17:04:20 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        stable@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] tools lib: Disable redundant-delcs error for strlcpy
Message-ID: <20191217200420.GD7095@redhat.com>
References: <20191208214607.20679-1-vt@altlinux.org>
 <20191217122331.4g5atx7in6njjlw4@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217122331.4g5atx7in6njjlw4@altlinux.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 17, 2019 at 03:23:32PM +0300, Vitaly Chikunov escreveu:
> Arnaldo,
>=20
> Ping. Can you accept or comment on this patch? There is further
> explanations of it:

Will this work when building with clang

- Arnaldo
=20
> 1. It seems that people putting strlcpy() into the tools was already aw=
are of
> the problems it causes and tried to solve them. Probably, that's why th=
ey put
> `__weak` attribute on it (so it would be linkable in the presence of an=
other
> strlcpy). Then `#ifndef __UCLIBC__`ed and later `#if defined(__GLIBC__)=
 &&
> !defined(__UCLIBC__)` its declaration. But, solution was incomplete and=
 could
> be improved to make kernel buildable on more systems (where libc contai=
ns
> strlcpy).
>=20
> There is not need to make `redundant redeclaration` warning an error in
> this case.
>=20
> 2. `#pragma GCC diagnostic ignored` trick is already used multiple time=
s
> in the kernel:
>=20
>   $ git grep  '#pragma GCC diagnostic ignored'
>   arch/arm/lib/xor-neon.c:#pragma GCC diagnostic ignored "-Wunused-vari=
able"
>   tools/build/feature/test-gtk2-infobar.c:#pragma GCC diagnostic ignore=
d "-Wstrict-prototypes"
>   tools/build/feature/test-gtk2.c:#pragma GCC diagnostic ignored "-Wstr=
ict-prototypes"
>   tools/include/linux/string.h:#pragma GCC diagnostic ignored "-Wredund=
ant-decls"
>   tools/lib/bpf/libbpf.c:#pragma GCC diagnostic ignored "-Wformat-nonli=
teral"
>   tools/perf/ui/gtk/gtk.h:#pragma GCC diagnostic ignored "-Wstrict-prot=
otypes"
>   tools/testing/selftests/kvm/lib/assert.c:#pragma GCC diagnostic ignor=
ed "-Wunused-result"
>   tools/usb/ffs-test.c:#pragma GCC diagnostic ignored "-Wdeprecated-dec=
larations"
>=20
> So the solution does not seem alien in the kernel and should be accepta=
ble.
>=20
> (I also send this to another of your emails in case I used wrong one be=
fore.)
>=20
> Thanks,
>=20
>=20
> On Mon, Dec 09, 2019 at 12:46:07AM +0300, Vitaly Chikunov wrote:
> > Disable `redundant-decls' error for strlcpy declaration and solve bui=
ld
> > error allowing users to compile vanilla kernels.
> >=20
> > When glibc have strlcpy (such as in ALT linux since 2004) objtool and
> > perf build fails with something like:
> >=20
> >   In file included from exec-cmd.c:3:
> >   tools/include/linux/string.h:20:15: error: redundant redeclaration =
of =E2=80=98strlcpy=E2=80=99 [-Werror=3Dredundant-decls]
> >      20 | extern size_t strlcpy(char *dest, const char *src, size_t s=
ize);
> > 	|               ^~~~~~~
> >=20
> > It's very hard to produce a perfect fix for that since it is a header
> > file indirectly pulled from many sources from different Makefile buil=
ds.
> >=20
> > Fixes: ce99091 ("perf tools: Move strlcpy() from perf to tools/lib/st=
ring.c")
> > Fixes: 0215d59 ("tools lib: Reinstate strlcpy() header guard with __U=
CLIBC__")
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > Cc: Dmitry V. Levin <ldv@altlinux.org>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  tools/include/linux/string.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/tools/include/linux/string.h b/tools/include/linux/strin=
g.h
> > index 980cb9266718..99ede7f5dfb8 100644
> > --- a/tools/include/linux/string.h
> > +++ b/tools/include/linux/string.h
> > @@ -17,7 +17,10 @@ int strtobool(const char *s, bool *res);
> >   * However uClibc headers also define __GLIBC__ hence the hack below
> >   */
> >  #if defined(__GLIBC__) && !defined(__UCLIBC__)
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wredundant-decls"
> >  extern size_t strlcpy(char *dest, const char *src, size_t size);
> > +#pragma GCC diagnostic pop
> >  #endif
> > =20
> >  char *str_error_r(int errnum, char *buf, size_t buflen);

