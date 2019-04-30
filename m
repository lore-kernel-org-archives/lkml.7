Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F2EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73572177B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NyNIDopx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfD3Pyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:54:53 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:47044 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbfD3Pyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:54:53 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB323C0039;
        Tue, 30 Apr 2019 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556639694; bh=41EXEwITfkkbVpQOww8Wh+pmfeyi9sINjyuMxudAhdM=;
        h=From:To:CC:Subject:Date:References:From;
        b=NyNIDopxUJ64Y4K4Kj0xA+908dHtBQZiqKANb8r0oov0Gx9OuKQQ8aNUclCLCaFof
         5Xh7IPVPqEcvXu228CgoVE8BHfa89un35k1BJw0AnVq6UaYi+vth6cDGXQRwjZTeEl
         YsgECfMlEX08eYRZOQMR9OtP9+eZNOGOaorfdvBu2y1QKThD03ae/hVXjFdpIvPsHA
         O6LkuvcmhPbi9edZLF5LBx26d64RchnU2FrEj7ltQZzvAJzZ1B7cPiReNkCl5T/rdM
         PrxEX4/Md3s4JiGXI611x5FFHpMXsxo1xJnU4nAuxrLvXbadc9kYZcfqykNkvriie0
         NVzyPZ1xPGF9w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 26259A006B;
        Tue, 30 Apr 2019 15:54:48 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 30 Apr 2019 08:53:19 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "devel@uclibc-ng.org" <devel@uclibc-ng.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rich Felker <dalias@libc.org>
Subject: Detecting libc in perf (was Re: perf tools build broken after
 v5.1-rc1)
Thread-Topic: Detecting libc in perf (was Re: perf tools build broken after
 v5.1-rc1)
Thread-Index: AQHU/2zU3RcD8vNEuk6uLp1+qNlGpA==
Date:   Tue, 30 Apr 2019 15:53:18 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A250601B@us01wembx1.internal.synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org> <20190425214800.GC21829@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
 <20190430011818.GE7857@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/19 6:18 PM, Arnaldo Carvalho de Melo wrote:=0A=
>>> Auto-detecting system features:=0A=
>>> ...                         dwarf: [ OFF ]=0A=
>>> ...            dwarf_getlocations: [ OFF ]=0A=
>>> ...                         glibc: [ on  ]=0A=
>> Not related to current issue, this run uses a uClibc toolchain and yet i=
t is=0A=
>> detecting glibc - doesn't seem right to me.=0A=
> Ok, I'll improve that, I think it just tries to detect a libc, yeah,=0A=
> see:=0A=
>=0A=
> [acme@quaco linux]$ cat tools/build/feature/test-glibc.c=0A=
> // SPDX-License-Identifier: GPL-2.0=0A=
> #include <stdlib.h>=0A=
>=0A=
> #if !defined(__UCLIBC__)=0A=
> #include <gnu/libc-version.h>=0A=
> #else=0A=
> #define XSTR(s) STR(s)=0A=
> #define STR(s) #s=0A=
> #endif=0A=
>=0A=
> int main(void)=0A=
> {=0A=
> #if !defined(__UCLIBC__)=0A=
> 	const char *version =3D gnu_get_libc_version();=0A=
> #else=0A=
> 	const char *version =3D XSTR(__GLIBC__) "." XSTR(__GLIBC_MINOR__);=0A=
> #endif=0A=
>=0A=
> 	return (long)version;=0A=
> }=0A=
> [acme@quaco linux]$=0A=
>=0A=
> [perfbuilder@59ca4b424ded /]$ grep __GLIBC__ /arc_gnu_2017.09-rc2_prebuil=
t_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/=
*.h=0A=
> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-lin=
ux-uclibc/sysroot/usr/include/features.h:   The macros `__GNU_LIBRARY__', `=
__GLIBC__', and `__GLIBC_MINOR__' are=0A=
> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-lin=
ux-uclibc/sysroot/usr/include/features.h:#define	__GLIBC__	2=0A=
> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-lin=
ux-uclibc/sysroot/usr/include/features.h:	((__GLIBC__ << 16) + __GLIBC_MINO=
R__ >=3D ((maj) << 16) + (min))=0A=
> [perfbuilder@59ca4b424ded /]$=0A=
>=0A=
> Isn't that part of uClibc?=0A=
=0A=
Right you are. Per the big fat comment right above that code, this gross ha=
ck in=0A=
uclibc is unavoidable as applications tend to rely on that define.=0A=
So a better fix would be to check for various !GLIBC libs explicitly.=0A=
=0A=
#ifdef __UCLIBC__=0A=
=0A=
#elseif defined __MUSL__=0A=
=0A=
...=0A=
=0A=
Not pretty from app usage pov, but that seems to be the only sane way of do=
ing it.=0A=
=0A=
-Vineet=0A=
