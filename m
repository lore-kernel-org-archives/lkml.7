Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E28BC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FD6215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfJAWyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:54:21 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35958 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfJAWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:54:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFR24-00043h-FL; Tue, 01 Oct 2019 16:54:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFR1y-00061d-Ku; Tue, 01 Oct 2019 16:54:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Apelete Seketeli <apelete@seketeli.net>,
        Arnd Bergmann <arnd@arndb.de>,
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
Date:   Tue, 01 Oct 2019 17:53:27 -0500
In-Reply-To: <201910011140.EA0181F13@keescook> (Kees Cook's message of "Tue, 1
        Oct 2019 11:46:45 -0700")
Message-ID: <87imp8hyc8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iFR1y-00061d-Ku;;;mid=<87imp8hyc8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1890sJnTfB2radGtM5zpN9fbLEpYr3LK/s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Oct 01, 2019 at 01:36:32PM -0500, Eric W. Biederman wrote:
>> 
>> This system call has been deprecated almost since it was introduced, and
>> in a survey of the linux distributions I can no longer find any of them
>> that enable CONFIG_SYSCTL_SYSCALL.  The only indication that I can find
>> that anyone might care is that a few of the defconfigs in the kernel
>> enable CONFIG_SYSCTL_SYSCALL.  However this appears in only 31 of 414
>> defconfigs in the kernel, so I suspect this symbols presence is simply
>> because it is harmless to include rather than because it is necessary.
>> 
>> As there appear to be no users of the sysctl system call, remove the
>> code.  As this removes one of the few uses of the internal kernel mount
>> of proc I hope this allows for even more simplifications of the proc
>> filesystem.
>
> I'm for it. :) I tripped over this being deprecated over a decade ago. :P
>
> I think you can actually take this further and remove (or at least
> empty) the uapi/linux/sysctl.h file too.

I copied everyone who had put this into a defconfig and I will wait a
little more to see if anyone screams.  I think it is a safe guess that
several of the affected configurations are dead (or at least
unmaintained) as I received 17 bounces when copying everyone.

I would make it a followup that removes uapi/linux/sysctl.h.  I don't
see anything in it that isn't about the sysctl system call.  I will keep
it a separate patch as I can imagine something silly that needs the
header file to compile.  A separate patch would make a revert easier
if we find something like that.

Eric
