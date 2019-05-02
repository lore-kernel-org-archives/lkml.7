Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155C5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D5C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fpRgyNol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEBQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:09:47 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:35930 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbfEBQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:09:46 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7320EC008E;
        Thu,  2 May 2019 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556813387; bh=ZZLsxdALENIFAq/ZqpCY+bZ9XDVuO0IJPaRJlyuz5qA=;
        h=From:To:CC:Subject:Date:References:From;
        b=fpRgyNolEfVEsyjoHqH27Rg51l3txWxZEnqNXhoE4kcO/6wrKE6tRoQ5EELR6YICB
         Bm1a+Nt6pq2oDTSj2wsglm/HYH5bIqnToDRcFYAMRxsB57ml9fWtL4ERXmCfu4RF8F
         GMrjjEJ9pliBbYOE/tR4Ah2ZClCBUNscy72H9qjQj1anmx5E9JZQJuziOb01wCAiT+
         wFyiZAxkWBfnJBuJUFlgVni7Syn9vtOOn6dC3gdfYseO+5llvxjEP5G5ai5b7fLRsk
         IBjxPovewoCbjKZFhvez2cjDbwQLV9qxB7BZtarBFfc4MmHh9LWNk5jqzeJJTfWzRn
         ajg0aiVTAkEPw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4E8FEA00A5;
        Thu,  2 May 2019 16:09:44 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 2 May 2019 09:09:43 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Jiri Olsa" <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: perf tools build broken after v5.1-rc1
Thread-Topic: perf tools build broken after v5.1-rc1
Thread-Index: AQHU9whSYuAYlq2eD0OAivz0M0d5Nw==
Date:   Thu, 2 May 2019 16:09:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2506D04@us01wembx1.internal.synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
 <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
 <20190501204115.GF21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506BF3@us01wembx1.internal.synopsys.com>
 <20190502143618.GH21436@kernel.org>
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

On 5/2/19 7:36 AM, Arnaldo Carvalho de Melo wrote:=0A=
> Em Wed, May 01, 2019 at 09:17:52PM +0000, Vineet Gupta escreveu:=0A=
>> On 5/1/19 1:41 PM, Arnaldo Carvalho de Melo wrote:=0A=
>>>> The 1a787fc5ba18ac7 commit copied over the changes for arm64, but=0A=
>>>> missed all the other architectures changed in c8ce48f06503 and the=0A=
>>>> related commits.=0A=
>>> Right, I have a patch copying the missing headers, and that fixed the=
=0A=
>>> build with the glibc-based toolchain, but then broke the uCLibc one :-\=
=0A=
>  =0A=
>> tools/perf/util/cloexec.c  #includes <sys/syscall.h> which for glibc inc=
ludes=0A=
>> asm/unistd.h=0A=
>  =0A=
>> uClibc <sys/syscall.h> OTOH #include <bits/sysnum.h> containign#define _=
_NR_*=0A=
>> (generated by parsing kernel's unistd). This header does the right thing=
 by=0A=
>> chekcing for redefs, but in the end we still collide with newly added=0A=
>> tools/arc/arc/*/**/unistd.h which doesn't have conditional definitions. =
I'm sure=0A=
>> this is not an ARC problem, any uClibc build would be affected. Do you h=
ave a arm=0A=
>> uclibc toolchain to test ?=0A=
> This solves it for fedora:29,=0A=
> arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install,=0A=
> arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install and=0A=
> arc_gnu_2019.03-rc1_prebuilt_glibc_le_archs_linux_install.=0A=
>=0A=
> Also ok with:=0A=
>=0A=
>   make -C tools/perf build-test=0A=
>=0A=
> Now build testing with the full set of containers.=0A=
>=0A=
> - Arnaldo=0A=
>=0A=
> commit 1931594a680dba28e98b526192dd065430c850c0=0A=
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>=0A=
> Date:   Thu May 2 09:26:23 2019 -0400=0A=
>=0A=
>     perf tools: Remove needless asm/unistd.h include fixing build in some=
 places=0A=
>     =0A=
>     We were including sys/syscall.h and asm/unistd.h, since sys/syscall.h=
=0A=
>     includes asm/unistd.h, sometimes this leads to the redefinition of=0A=
>     defines, breaking the build.=0A=
>     =0A=
>     Noticed on ARC with uCLibc.=0A=
=0A=
Thx for this Arnaldo.=0A=
=0A=
While this takes care of immediate issues, for the long term, are you open =
to idea=0A=
of removing the header duplicity.=0A=
We could use a "less evil" idiom of copying only the minimal bits (since th=
e sync=0A=
onus remains one way or the other)=0A=
e.g. I spotted below in bpf code and also seen in other ah-hoc multi arch p=
rojects=0A=
=0A=
#ifdef __NR_xx=0A=
# if defined (__arch_y__)=0A=
=0A=
# elif defined (__arch_z__)=0A=
=0A=
# endif=0A=
#endif=0A=
=0A=
=0A=
