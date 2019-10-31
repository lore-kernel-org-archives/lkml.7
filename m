Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C386CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9327F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hw+AFryl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJaBbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:31:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbfJaBbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572485498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8x/YR60hZnP79WwS5nz3vSbESJNKawCBZZ0QLX/Ly5E=;
        b=hw+AFryllv0WxLbMAnv1xWyuSsm+GBIRF+g8BPTlVmm9BEbxj/Oivcc9vkMEGrW+jFT7E4
        ZuSQzHL4BBCWu/O9e6Rnhbtww0/1sAhKbkemabeuwJOyNubZqptNc50P0m3b+0RbDUA+ww
        bgBzJGsvvmkBgA1Ar4uEBsMd7PBzFz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-GF91RIWAPQe2uSW2E9hAGQ-1; Wed, 30 Oct 2019 21:31:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2926B800EB3;
        Thu, 31 Oct 2019 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA9AB60870;
        Thu, 31 Oct 2019 01:31:16 +0000 (UTC)
Subject: Re: [PATCH 1/2 v7] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
References: <20191029021059.22070-2-lijiang@redhat.com>
 <201910310233.EJRtTMWP%lkp@intel.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <1833dc17-6797-b18d-5265-15d01056ac1c@redhat.com>
Date:   Thu, 31 Oct 2019 09:31:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201910310233.EJRtTMWP%lkp@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: GF91RIWAPQe2uSW2E9hAGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8831=E6=97=A5 02:25, kbuild test robot =E5=
=86=99=E9=81=93:
> Hi Lianbo,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.4-rc5 next-20191030]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>=20
> url:    https://github.com/0day-ci/linux/commits/Lianbo-Jiang/x86-kdump-F=
ix-kmem-s-reported-an-invalid-freepointer-when-SME-was-active/20191031-0019=
03
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 320000e72ec0613e164ce9608d865396fb2da278
> config: i386-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from arch/x86/realmode/init.c:11:0:
>>> arch/x86/include/asm/crash.h:5:32: warning: 'struct kimage' declared in=
side parameter list will not be visible outside of this definition or decla=
ration
>     int crash_load_segments(struct kimage *image);
>                                    ^~~~~~
>    arch/x86/include/asm/crash.h:6:37: warning: 'struct kimage' declared i=
nside parameter list will not be visible outside of this definition or decl=
aration
>     int crash_copy_backup_region(struct kimage *image);
>                                         ^~~~~~
>    arch/x86/include/asm/crash.h:7:39: warning: 'struct kimage' declared i=
nside parameter list will not be visible outside of this definition or decl=
aration
>     int crash_setup_memmap_entries(struct kimage *image,
>                                           ^~~~~~
>=20
Hi,

The above warnings will still occur without my patches.

But i will fix the warnings in my patch series, and resend v8 later.

Thanks.

Lianbo

> vim +5 arch/x86/include/asm/crash.h
>=20
> dd5f726076cc76 Vivek Goyal 2014-08-08   4 =20
> dd5f726076cc76 Vivek Goyal 2014-08-08  @5  int crash_load_segments(struct=
 kimage *image);
> dd5f726076cc76 Vivek Goyal 2014-08-08   6  int crash_copy_backup_region(s=
truct kimage *image);
> dd5f726076cc76 Vivek Goyal 2014-08-08   7  int crash_setup_memmap_entries=
(struct kimage *image,
> dd5f726076cc76 Vivek Goyal 2014-08-08   8  =09=09struct boot_params *para=
ms);
> 89f579ce99f7e0 Yi Wang     2018-11-22   9  void crash_smp_send_stop(void)=
;
> dd5f726076cc76 Vivek Goyal 2014-08-08  10 =20
>=20
> :::::: The code at line 5 was first introduced by commit
> :::::: dd5f726076cc7639d9713b334c8c133f77c6757a kexec: support for kexec =
on panic using new system call
>=20

Exactly.

> :::::: TO: Vivek Goyal <vgoyal@redhat.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
>=20

