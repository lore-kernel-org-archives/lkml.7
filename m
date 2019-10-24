Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE54CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 23:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79121BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 23:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKMmDj8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbfJXX4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 19:56:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41147 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726713AbfJXX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 19:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571961368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZbVv/eoz3kxY1CN8zY37wwX4BSuQr2pMX8JrPLKB1U=;
        b=EKMmDj8Yc1XTllMGi2Vxbotjx4dj+BWTFFwxhpnPD0BEY8NwfYoxUumUgnFyecZe1gDge9
        eQ3pgCMadDAriApYVW0rZFB1EvQgI+Ig9zcfRRfyJZ9YOCUMULXENojA4ON9FIvGHfCTUj
        9FSakPJsritMyLRojowZOoYyc4z42Xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-BJlz3gQ0NoKtL_0blcrA5g-1; Thu, 24 Oct 2019 19:56:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06F8B107AD31;
        Thu, 24 Oct 2019 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31B471001B20;
        Thu, 24 Oct 2019 23:55:48 +0000 (UTC)
Subject: Re: [PATCH] x86/kdump: always reserve the low 1MiB when the
 crashkernel
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
References: <75648e8d-4ef7-0537-618e-e4a57f0d3b9b@redhat.com>
 <201910250603.En7IO6Xd%lkp@intel.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <3fce1517-2a76-53da-1538-aa75f3427d5b@redhat.com>
Date:   Fri, 25 Oct 2019 07:55:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201910250603.En7IO6Xd%lkp@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BJlz3gQ0NoKtL_0blcrA5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8825=E6=97=A5 06:12, kbuild test robot =E5=
=86=99=E9=81=93:
> Hi lijiang,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on linus/master]
> [cannot apply to v5.4-rc4 next-20191024]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>=20
> url:    https://github.com/0day-ci/linux/commits/lijiang/x86-kdump-always=
-reserve-the-low-1MiB-when-the-crashkernel/20191025-030439
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t f116b96685a046a89c25d4a6ba2da489145c8888
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
>>> WARNING: vmlinux.o(.text+0xe39b7): Section mismatch in reference from t=
he function kexec_reserve_low_1MiB() to the variable .init.data:boot_comman=
d_line
>    The function kexec_reserve_low_1MiB() references
>    the variable __initdata boot_command_line.
>    This is often because kexec_reserve_low_1MiB lacks a __initdata
>    annotation or the annotation of boot_command_line is wrong.
> --
>>> WARNING: vmlinux.o(.text+0xe39d0): Section mismatch in reference from t=
he function kexec_reserve_low_1MiB() to the function .meminit.text:memblock=
_reserve()
>    The function kexec_reserve_low_1MiB() references
>    the function __meminit memblock_reserve().
>    This is often because kexec_reserve_low_1MiB lacks a __meminit
>    annotation or the annotation of memblock_reserve is wrong.
>=20
These warnings have been fixed in patch v5. Please refer to the latest patc=
h v5.

Thanks.
Lianbo

> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
>=20

