Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BF0C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D5A21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfJBOlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:41:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53200 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfJBOlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:41:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFfoy-0000co-LJ; Wed, 02 Oct 2019 08:41:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFfox-0000M4-PV; Wed, 02 Oct 2019 08:41:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Apelete Seketeli <apelete@seketeli.net>,
        Chee Nouk Phoon <cnphoon@altera.com>,
        Chris Zankel <chris@zankel.net>,
        Christian Ruppert <christian.ruppert@abilis.com>,
        Greg Ungerer <gerg@uclinux.org>, Helge Deller <deller@gmx.de>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Josh Boyer <jwboyer@gmail.com>, Jun Nie <jun.nie@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Paul Burton <paul.burton@mips.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Pierrick Hascoet <pierrick.hascoet@abilis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roland Stigge <stigge@antcom.de>,
        Vineet Gupta <vgupta@synopsys.com>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
        <201910011140.EA0181F13@keescook>
        <87imp8hyc8.fsf@x220.int.ebiederm.org>
        <CAK8P3a1zLATC7rzYxSpAK-z=NJ1rw7-3ZgHqCOJUUf6b9HwK1A@mail.gmail.com>
Date:   Wed, 02 Oct 2019 09:41:00 -0500
In-Reply-To: <CAK8P3a1zLATC7rzYxSpAK-z=NJ1rw7-3ZgHqCOJUUf6b9HwK1A@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 2 Oct 2019 09:31:01 +0200")
Message-ID: <87a7aji51f.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iFfox-0000M4-PV;;;mid=<87a7aji51f.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19IHDVGlAbdPU8dF8uFaTBUUrSZFrNIEnY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Oct 2, 2019 at 12:54 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> > On Tue, Oct 01, 2019 at 01:36:32PM -0500, Eric W. Biederman wrote:
>> >
>> > I think you can actually take this further and remove (or at least
>> > empty) the uapi/linux/sysctl.h file too.
>>
>> I copied everyone who had put this into a defconfig and I will wait a
>> little more to see if anyone screams.  I think it is a safe guess that
>> several of the affected configurations are dead (or at least
>> unmaintained) as I received 17 bounces when copying everyone.
>
> Looking at the arm defconfigs:
>
>> arch/arm/configs/axm55xx_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> No notable work on this platform since it got sold to Intel in 2014.
> I think they still use it but not with mainline kernels that lack support
> for most drivers and the later chips.
>
>> arch/arm/configs/keystone_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> Not that old either, but this hardware is mostly obsoleted by newer variants
> that we support with the arm64 defconfig.
>
>> arch/arm/configs/lpc32xx_defconfig:CONFIG_SYSCTL_SYSCALL=y
>> arch/arm/configs/moxart_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> Ancient hardware, but still in active use. These tend to have very little
> RAM, but they both enable CONFIG_PROC_FS.
>
>> arch/arm/configs/qcom_defconfig:CONFIG_SYSCTL_SYSCALL=y
>> arch/arm/configs/zx_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> These are for older Qualcomm and LG chips that tend to be used
> with Android rather than the defconfig here. Maybe double-check
> if the official android-common tree enables SYSCTL_SYSCALL.

I just looked quickly at:
https://android.googlesource.com/kernel/configs/

I don't see the string SYSCTL mentioned anywhere.  Much less
SYSCTL_SYSCALL.

Eric
