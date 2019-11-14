Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E53C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9AB20706
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bimbSoD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKNOVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:21:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28604 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbfKNOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573741261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFtzaw5LIVkMmAtq7/jfIOHBlZTiY/lff0QrVR0Mkqs=;
        b=bimbSoD+oBE06X/hlXI5IUwWW0TFc/wd5eSFpZuLq5bUmyewvaKUbvplNMi4l9WTo3L7tz
        Wt/wvg4vs61ChNkvvoe1gaJwkaF+bCBuAtDwKklcm5xIT2AhHfcg+HLyAcC4Lp6VsPljGp
        kCn7thvNfgaHt62Z7jnYbARB5DfI5VM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-ntacfLsrMyuJS8Oe8XRaFQ-1; Thu, 14 Nov 2019 09:20:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B040107B7D5;
        Thu, 14 Nov 2019 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 106E7610E5;
        Thu, 14 Nov 2019 14:20:45 +0000 (UTC)
Subject: Re: [PATCH 3/3 v9] kexec: Fix i386 build warnings that missed
 declaration of struct kimage
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
References: <20191108090027.11082-1-lijiang@redhat.com>
 <20191108090027.11082-4-lijiang@redhat.com> <20191114123920.GA7222@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <59fbd119-495a-4d00-9738-98c22b276c1f@redhat.com>
Date:   Thu, 14 Nov 2019 22:20:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191114123920.GA7222@zn.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ntacfLsrMyuJS8Oe8XRaFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B411=E6=9C=8814=E6=97=A5 20:39, Borislav Petkov =E5=86=
=99=E9=81=93:
> On Fri, Nov 08, 2019 at 05:00:27PM +0800, Lianbo Jiang wrote:
>> Kbuild test robot reported some build warnings as follow:
>>
>> arch/x86/include/asm/crash.h:5:32: warning: 'struct kimage' declared
>> inside parameter list will not be visible outside of this definition
>> or declaration
>>     int crash_load_segments(struct kimage *image);
>>                                    ^~~~~~
>>     int crash_copy_backup_region(struct kimage *image);
>>                                         ^~~~~~
>>     int crash_setup_memmap_entries(struct kimage *image,
>>                                           ^~~~~~
>> The 'struct kimage' is defined in the header file include/linux/kexec.h,
>> before using it, need to include its header file or make a declaration.
>> Otherwise the above warnings may be triggered.
>>
>> Add a declaration of struct kimage to the file arch/x86/include/asm/
>> crash.h, that will solve these compile warnings.
>>
>> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system=
 call")
>=20
> This is, of course, wrong. Your *first* patch is introducing those
> warnings and I'm wondering how did you not see them during building?
>=20

I really saw my building result, but kbuild reported the following messages=
:

vim +5 arch/x86/include/asm/crash.h

dd5f726076cc76 Vivek Goyal 2014-08-08   4 =20
dd5f726076cc76 Vivek Goyal 2014-08-08  @5  int crash_load_segments(struct k=
image *image);
dd5f726076cc76 Vivek Goyal 2014-08-08   6  int crash_copy_backup_region(str=
uct kimage *image);
dd5f726076cc76 Vivek Goyal 2014-08-08   7  int crash_setup_memmap_entries(s=
truct kimage *image,
dd5f726076cc76 Vivek Goyal 2014-08-08   8  =09=09struct boot_params *params=
);
89f579ce99f7e0 Yi Wang     2018-11-22   9  void crash_smp_send_stop(void);
dd5f726076cc76 Vivek Goyal 2014-08-08  10 =20

:::::: The code at line 5 was first introduced by commit=20
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
:::::: dd5f726076cc7639d9713b334c8c133f77c6757a kexec: support for kexec on=
 panic using new system call
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Would you mind giving me any suggestions about this?

> In file included from arch/x86/realmode/init.c:11:
> ./arch/x86/include/asm/crash.h:5:32: warning: =E2=80=98struct kimage=E2=
=80=99 declared inside parameter list will not be visible outside of this d=
efinition or declaration
>     5 | int crash_load_segments(struct kimage *image);
>       |                                ^~~~~~
> ./arch/x86/include/asm/crash.h:6:37: warning: =E2=80=98struct kimage=E2=
=80=99 declared inside parameter list will not be visible outside of this d=
efinition or declaration
>     6 | int crash_copy_backup_region(struct kimage *image);
>       |                                     ^~~~~~
> ./arch/x86/include/asm/crash.h:7:39: warning: =E2=80=98struct kimage=E2=
=80=99 declared inside parameter list will not be visible outside of this d=
efinition or declaration
>     7 | int crash_setup_memmap_entries(struct kimage *image,
>       |
>=20
>=20
> And that happens because you've included asm/crash.h in
> arch/x86/realmode/init.c and it of course complains because it hasn't
> seen that struct yet.
>=20

Exactly. Last time, i fixed the warnings in my first patch, please refer to=
 the patch v8(resend).

Link: https://lkml.kernel.org/r/20191031033517.11282-2-lijiang@redhat.com
      -[PATCH 1/2 RESEND v8] x86/kdump: always reserve the low 1M when the =
crashkernel option is specified


And kbuild said that need to add the reported-by, please refer to the follo=
wing Link.

Link: https://lkml.kernel.org/r/201910310233.EJRtTMWP%25lkp@intel.com

> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Any idea about this? Any suggestions will be appreciated.

Thanks.
Lianbo

