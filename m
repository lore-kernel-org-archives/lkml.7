Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7EBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C12B206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfDHSEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:04:08 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:54530 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:04:08 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E2F1D72CCAC;
        Mon,  8 Apr 2019 21:04:04 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D4E917CCE4F; Mon,  8 Apr 2019 21:04:04 +0300 (MSK)
Date:   Mon, 8 Apr 2019 21:04:04 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v9 7/7] selftests/ptrace: add a test case for
 PTRACE_GET_SYSCALL_INFO
Message-ID: <20190408180404.GB11964@altlinux.org>
References: <20190408174036.GA11889@altlinux.org>
 <20190408174236.GH11889@altlinux.org>
 <f2f015da-35d4-7207-cd57-e6589cd9d2c4@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <f2f015da-35d4-7207-cd57-e6589cd9d2c4@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 11:51:45AM -0600, shuah wrote:
> On 4/8/19 11:42 AM, Dmitry V. Levin wrote:
> > Check whether PTRACE_GET_SYSCALL_INFO semantics implemented in the kern=
el
> > matches userspace expectations.
> >=20
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >=20
> > Notes:
> >      v9: unchanged
> >      v8: unchanged
> >      v7: unchanged
> >      v6: made PTRACE_GET_SYSCALL_INFO return value checks strict
> >      v5: initial revision
> >=20
> >   tools/testing/selftests/ptrace/.gitignore     |   1 +
> >   tools/testing/selftests/ptrace/Makefile       |   2 +-
> >   .../selftests/ptrace/get_syscall_info.c       | 271 ++++++++++++++++++
> >   3 files changed, 273 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/testing/selftests/ptrace/get_syscall_info.c
> >=20
> > diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/=
selftests/ptrace/.gitignore
> > index b3e59d41fd82..cfcc49a7def7 100644
> > --- a/tools/testing/selftests/ptrace/.gitignore
> > +++ b/tools/testing/selftests/ptrace/.gitignore
> > @@ -1 +1,2 @@
> > +get_syscall_info
> >   peeksiginfo
> > diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/se=
lftests/ptrace/Makefile
> > index 8a2bc5562179..4bc550b6b845 100644
> > --- a/tools/testing/selftests/ptrace/Makefile
> > +++ b/tools/testing/selftests/ptrace/Makefile
> > @@ -1,5 +1,5 @@
> >   CFLAGS +=3D -iquote../../../../include/uapi -Wall
> >  =20
> > -TEST_GEN_PROGS :=3D peeksiginfo
> > +TEST_GEN_PROGS :=3D get_syscall_info peeksiginfo
> >  =20
> >   include ../lib.mk
> > diff --git a/tools/testing/selftests/ptrace/get_syscall_info.c b/tools/=
testing/selftests/ptrace/get_syscall_info.c
> > new file mode 100644
> > index 000000000000..28e972825b74
> > --- /dev/null
> > +++ b/tools/testing/selftests/ptrace/get_syscall_info.c
> > @@ -0,0 +1,271 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later
> > + *
>=20
> This should be just GPL-2.0+

LICENSES/preferred/GPL-2.0 says these variants are equivalent:
"
[...]
Valid-License-Identifier: GPL-2.0+
Valid-License-Identifier: GPL-2.0-or-later
[...]
  For 'GNU General Public License (GPL) version 2 or any later version' use:
    SPDX-License-Identifier: GPL-2.0+
  or
    SPDX-License-Identifier: GPL-2.0-or-later
"

The usage statistics shows that GPL-2.0+ is more popular in the kernel
tree than GPL-2.0-or-later, though.

> The rest looks good to me. Assuming this patch has dependency on the
> rest of the patches in this series and once the above change is made:

No problem, I'm fine with either variant of the license identifier.

> Acked-by: Shuah Khan <shuah@kernel.org>

Thanks,

--=20
ldv

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcq40UAAoJEAVFT+BVnCUIac8P/1dxAaP4oYBpBKLqT/ExVvSz
qBkiXYEZNuovISrutWO4ryTHTmvi2LDBsVJjjC2eSsQn/NJpdTE/ORqmMnUdD1la
yyOqHKMqBbzxz2uIRuDP0k1ctaAcoHnFUVrN8J84/mS1E5/9T2CTJ4TloYKaQb7k
uHliqoleSpwg8VedCf/dFsmWWi60hK1rcRWUsqE9HxqUKNAGpRc9X+7UhsF1jfGn
hfkIxATCcDp3TNJP5EyZ4FIgdKYDAUWZXH8u7zqVmZS5nVNUOli5DO0jg34EGBc4
PQ5aWoSOdt/mmsYoVWAPfJiTfTlx+4CgBtwxM1gNccv++YFI9N6vZ9lcgw0VDrVg
tkCxpL8XCHsRqRq2rUUILAg31S8sMX/kM1YwIXrEphbPJ8Bft3eC2ioQ5bd85pgK
tJeueeCnHjQgwq8MwwHcGuLWJlPjXQjsNIXjodHK7qEYATONfVhG5pwboQ+aU3+B
QzK5d8F91/9ziPFAsYLyB8xq2Z5fo0nrvNBJ5+8EPxA+BgATkYvIt6OmAVmaMAez
xHso5BBnw0RKeO4/enm6YaT2T2B3GC7/Kw6YCczogJDF0QVHs2RDDvRqIie3dGmu
y24hP1+QJxDICv/6QA3/dSaYcz+eI2RnbWucy20eGacjPCxPJnY9XIa6Qvx+D1RP
YyBHhT0O7bkQiH545OqX
=5M+a
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
