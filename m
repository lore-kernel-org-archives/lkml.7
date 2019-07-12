Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B57AC742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106E32084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aJduaZyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGLJfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:35:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8945 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfGLJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562924125; x=1594460125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TpCBTkzFGzmQdCiPVFXm16wdE64U9MBTIXWyfpTXNJQ=;
  b=aJduaZyHxXXOVC4LqS1Pmd9E9MZnRGuZvbwVnKwjRHGZKqNVjBCYP8OY
   TWjQ3ljT6VMoM6vEfTF0MidWmMVXXfS5q0X6/P6QPspSIavV5vY8r84Wv
   //arUlCFV5YVBepcsyKmdgVQl2+lmoeBogrXN4ySEUwlkdmPxhK2EaHiW
   2K/bIrgbI0g1OEVtE6Ul9MoGklnPG6Xhs9hvA36HNJmVKz/ow//7Xlzs2
   gnOdjRWXIRNMhodbMXBuY5wdUl08FDVDlzq1uxMGbQqDLy3/rB0uCThBZ
   AICIymtbd5UNjBN68+hXo4ttZmptSljD6kD3z78fo6+EsBoeT3vLmpUg1
   Q==;
IronPort-SDR: TeG7auP9sFsJPFp1pxB9gWDyX+6q+Ss1B/7wr1NRI/Z+kuoNb466yQUNhcemPNxPkFAqGm9kDk
 r30Sh9v9r/KVaTZtEmj2QRGoQioCZc/0pBLi8SnwNCTJS/d7ecPArcSisUn+M1y4Z+iRJxLczm
 lVTij3XxC+8oju6/mggGFzVS2WlXl/se/ccgPncLEvIAgK0i3tJfDimE2gvfGnOTfsMXAg9WZx
 0X0vhoRCEHLAMAqmvaTk3g1BZ4EEZlwMPsj1VB/NeJiSRa2FtDuB9BLzA3PVLqkKkNdmRFc0On
 +sg=
X-IronPort-AV: E=Sophos;i="5.63,482,1557158400"; 
   d="scan'208";a="117663056"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 17:35:25 +0800
IronPort-SDR: RvtNavXf7NxtySZGVpMU2tDaCzLr3Z4sF0ZIObRRDbNNUk00CU9IloWfyWVusGTZzw/EOjTKvx
 FsyU3VrIbsrZRl/c5G5qpZ9acUZnLfmlmslcqkSmIllNSaTXcj3FzG1F0o/+jpaENzvgRPCRFJ
 LzpPLdMyY5Yj8DQ2sx731wy673CKuNI6dCNBbNPDhhHV8VOO1/f8OGeIJVUbIxILKJ9+9HU9y9
 l+bUjLBwennfaRdkt2sef8NjNceffY6UV5KHYpARL3dhDrmSAEHS2tH2qdIV09tB0bmYy7X1uK
 D8gjgHQX6MKEluvssT3DDGlw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Jul 2019 02:34:01 -0700
IronPort-SDR: Icv6ySvSJspDmYJ5vbSAtuCW4bxsSUes4iqARdvgdhnCMoedSytzQ0lJmsNDg51Eu49eCh97oi
 XF2CGoJ6d0r7aqKbsipaEOZJY3ZCOmQefwz411JSCccrGLemVz0m2ie1YZdwlwIdaBKilSqfzj
 ywZv1xJ8teZSUiP0nomRAl7yYLmpKWaBI6XGYfkhYoAdHTjtSPfaUyJLdmCfIUVI36IjGu0VWd
 Gi942Tv19xRa5QGhxgsUThZyq/IeT8lPwDQduGduJQhX16+8/jQis/J1J7BuEOyUQYjfTQK+lp
 Ek4=
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 12 Jul 2019 02:35:23 -0700
Received: (nullmailer pid 25039 invoked by uid 1000);
        Fri, 12 Jul 2019 09:35:22 -0000
Date:   Fri, 12 Jul 2019 18:35:22 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH] x86/vdso, arm64/vdso: fix flip/flop vdso build bug
Message-ID: <20190712093522.yhkxv2cq2rhqjncg@naota.dhcp.fujisawa.hgst.com>
References: <20190712054350.12300-1-naohiro.aota@wdc.com>
 <CAK7LNATFRqRMbJb3d4JoMyCdHDQWxmx05wJ2yBXyukcj05Au-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNATFRqRMbJb3d4JoMyCdHDQWxmx05wJ2yBXyukcj05Au-g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 03:24:01PM +0900, Masahiro Yamada wrote:
>On Fri, Jul 12, 2019 at 2:46 PM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>>
>> Two consecutive "make" on an already compiled kernel tree will show
>> different behavior:
>>
>> $ make
>>   CALL    scripts/checksyscalls.sh
>>   CALL    scripts/atomic/check-atomics.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>>   VDSOCHK arch/x86/entry/vdso/vdso64.so.dbg
>>   VDSOCHK arch/x86/entry/vdso/vdso32.so.dbg
>> Kernel: arch/x86/boot/bzImage is ready  (#3)
>>   Building modules, stage 2.
>>   MODPOST 12 modules
>>
>> $ make
>>   CALL    scripts/checksyscalls.sh
>>   CALL    scripts/atomic/check-atomics.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>>   VDSO    arch/x86/entry/vdso/vdso64.so.dbg
>>   OBJCOPY arch/x86/entry/vdso/vdso64.so
>>   VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
>>   CC      arch/x86/entry/vdso/vdso-image-64.o
>>   VDSO    arch/x86/entry/vdso/vdso32.so.dbg
>>   OBJCOPY arch/x86/entry/vdso/vdso32.so
>>   VDSO2C  arch/x86/entry/vdso/vdso-image-32.c
>>   CC      arch/x86/entry/vdso/vdso-image-32.o
>>   AR      arch/x86/entry/vdso/built-in.a
>>   AR      arch/x86/entry/built-in.a
>>   AR      arch/x86/built-in.a
>>   GEN     .version
>>   CHK     include/generated/compile.h
>>   UPD     include/generated/compile.h
>>   CC      init/version.o
>>   AR      init/built-in.a
>>   LD      vmlinux.o
>> <snip>
>>
>> This is causing "LD vmlinux" once every two times even without any
>> modifications. This is the same bug fixed in commit 92a4728608a8
>> ("x86/boot: Fix if_changed build flip/flop bug").  We cannot use two
>> "if_changed" in one target. Fix this build bug by merging two commands
>> into one function.
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>
>The code looks OK, but you should split this
>into two patches, for arm64 and x86,
>and then add Fixes: for each of them.

Thanks, I'll split and add the tags.

>
>
>-- 
>Best Regards
>Masahiro Yamada
