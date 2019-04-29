Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C37C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76F220675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TyBhTrfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfD2RO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:14:57 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:47870 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728769AbfD2RO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:14:56 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 11F41C00A0;
        Mon, 29 Apr 2019 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556558097; bh=KiymCE0SEjFh+yxlLj/PIdQ6Vg47QwbSiN8/7YvmW/E=;
        h=From:To:CC:Subject:Date:References:From;
        b=TyBhTrfrv5ATDBT+TOcsUvEPyeYxUckG4dUgJgQqNiWR2PukgVsWPvvkpx5VSAf/d
         sTn8S0dg9ReMItRmlndG8IRnBts0IjpSmoEbLIbwIU/npUVv1o+4NRbTh++4cmYvG3
         eD49na40rtQBgHRPQhWN5AI68MovdwOkec2221UO9lQuabK4df+7b69miLpnfdxXP1
         6xlQOKtfkCIUx1xf/siKcvwxfll0KVPIIZOidvbf27srTs9Ru64fbJAKatBfJNO8px
         ssLHT0CICERo05dWpirW9eIqoeoWl7xbKlQWzZ7mrmEuKP1PwBxDz1P7gnbFAjiDYO
         prUwuqTB5ef+A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8338FA0072;
        Mon, 29 Apr 2019 17:14:54 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 29 Apr 2019 10:14:54 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf tools build broken after v5.1-rc1
Thread-Topic: perf tools build broken after v5.1-rc1
Thread-Index: AQHU9whSYuAYlq2eD0OAivz0M0d5Nw==
Date:   Mon, 29 Apr 2019 17:14:54 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org> <20190425214800.GC21829@kernel.org>
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

On 4/25/19 2:48 PM, Arnaldo Carvalho de Melo wrote:=0A=
> Em Mon, Apr 22, 2019 at 12:20:27PM -0300, Arnaldo Carvalho de Melo escrev=
eu:=0A=
>> Em Fri, Apr 19, 2019 at 04:32:58PM -0700, Vineet Gupta escreveu:=0A=
>>> When building perf for ARC (v5.1-rc2) I get the following=0A=
>>  =0A=
>>> | In file included from bench/futex-hash.c:26:=0A=
>>> | bench/futex.h: In function 'futex_wait':=0A=
>>> | bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in this=
 function);=0A=
>>  =0A=
>>> git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools head=
ers uapi:=0A=
>>> Sync copy of asm-generic/unistd.h with the kernel sources")=0A=
>> Humm, I have to check why this:=0A=
>>=0A=
>> [perfbuilder@quaco ~]$ podman images | grep ARC=0A=
>> docker.io/acmel/linux-perf-tools-build-fedora                24-x-ARC-uC=
libc          4c259582a8e6   5 weeks ago      846 MB=0A=
>> [perfbuilder@quaco ~]$=0A=
>>=0A=
>> isn't catching this... :-\=0A=
>>=0A=
>> FROM docker.io/fedora:24=0A=
>> MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>=0A=
>> ENV TOOLCHAIN=3Darc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_inst=
all=0A=
>> ENV CROSS=3Darc-linux-=0A=
>> ENV SOURCEFILE=3D${TOOLCHAIN}.tar.gz=0A=
>> RUN dnf -y install make flex bison binutils gcc wget tar bzip2 bc findut=
ils xz=0A=
>> RUN wget https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.c=
om_foss-2Dfor-2Dsynopsys-2Ddwc-2Darc-2Dprocessors_toolchain_releases_downlo=
ad_arc-2D2017.09-2Drc2_-24-257BSOURCEFILE-257D&d=3DDwIDaQ&c=3DDPL6_X_6JkXFx=
7AXWqB0tg&r=3D7FgpX6o3vAhwMrMhLh-4ZJey5kjdNUwOL2CWsFwR4T8&m=3DHjtufCLozrW47=
pS5C2YH3safLHQE7eEtmHFZsSWrz1M&s=3D29g4oKvGuYcLgheCUvZh3wojhhljivpLd8aj7Ur4=
sKQ&e=3D=0A=
>> <SNIP>=0A=
>> COPY rx_and_build.sh /=0A=
>> ENV EXTRA_MAKE_ARGS=3DNO_LIBBPF=3D1=0A=
>> ENV ARCH=3Darc=0A=
>> ENV CROSS_COMPILE=3D/${TOOLCHAIN}/bin/${CROSS}=0A=
>> ENV EXTRA_CFLAGS=3D-matomic=0A=
> So, now I have a libnuma crossbuilt in this container that allows me to=
=0A=
> build a ARC perf binary linked with zlib and numactl-devel, but only=0A=
> after I applied the fix below.=0A=
>=0A=
> Can you please provide the feature detection header in the build? I.e.=0A=
> what I have with my ARC cross build container right now, after applying=
=0A=
> the patch below is:=0A=
>=0A=
> [perfbuilder@60d5802468f6 perf]$ make $EXTRA_MAKE_ARGS ARCH=3D$ARCH CROSS=
_COMPILE=3D$CROSS_COMPILE EXTRA_CFLAGS=3D"$EXTRA_CFLAGS" -C /git/perf/tools=
/perf O=3D/tmp/build/perf=0A=
> make: Entering directory '/git/perf/tools/perf'=0A=
>   BUILD:   Doing 'make -j8' parallel build=0A=
> sh: line 0: command: -c: invalid option=0A=
> command: usage: command [-pVv] command [arg ...]=0A=
>=0A=
> Auto-detecting system features:=0A=
> ...                         dwarf: [ OFF ]=0A=
> ...            dwarf_getlocations: [ OFF ]=0A=
> ...                         glibc: [ on  ]=0A=
=0A=
Not related to current issue, this run uses a uClibc toolchain and yet it i=
s=0A=
detecting glibc - doesn't seem right to me.=0A=
=0A=
> ...                          gtk2: [ OFF ]=0A=
> ...                      libaudit: [ OFF ]=0A=
> ...                        libbfd: [ OFF ]=0A=
> ...                        libelf: [ OFF ]=0A=
> ...                       libnuma: [ on  ]=0A=
=0A=
Wondering why that is - for me numa is off - even when using a glibc toolch=
ain.=0A=
=0A=
> ...        numa_num_possible_cpus: [ on  ]=0A=
> ...                       libperl: [ OFF ]=0A=
> ...                     libpython: [ OFF ]=0A=
> ...                      libslang: [ OFF ]=0A=
> ...                     libcrypto: [ OFF ]=0A=
> ...                     libunwind: [ OFF ]=0A=
> ...            libdw-dwarf-unwind: [ OFF ]=0A=
> ...                          zlib: [ OFF ]=0A=
> ...                          lzma: [ OFF ]=0A=
> ...                     get_cpuid: [ OFF ]=0A=
> ...                           bpf: [ on  ]=0A=
> ...                        libaio: [ OFF ]=0A=
> ...        disassembler-four-args: [ OFF ]=0A=
>=0A=
>=0A=
=0A=
For my glibc toolchain, here's the feature detection output=0A=
=0A=
Auto-detecting system features:=0A=
...                         dwarf: [ on  ]=0A=
...            dwarf_getlocations: [ OFF ]=0A=
...                         glibc: [ on  ]=0A=
...                          gtk2: [ OFF ]=0A=
...                      libaudit: [ OFF ]=0A=
...                        libbfd: [ OFF ]=0A=
...                        libelf: [ on  ]=0A=
...                       libnuma: [ OFF ]=0A=
...        numa_num_possible_cpus: [ OFF ]=0A=
...                       libperl: [ OFF ]=0A=
...                     libpython: [ OFF ]=0A=
...                      libslang: [ OFF ]=0A=
...                     libcrypto: [ OFF ]=0A=
...                     libunwind: [ OFF ]=0A=
...            libdw-dwarf-unwind: [ OFF ]=0A=
...                          zlib: [ OFF ]=0A=
...                          lzma: [ OFF ]=0A=
...                     get_cpuid: [ OFF ]=0A=
...                           bpf: [ on  ]=0A=
...                        libaio: [ on  ]=0A=
...        disassembler-four-args: [ OFF ]=0A=
=0A=
=0A=
