Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B975BC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F104121019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="dGVH7Lpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfEVGCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:02:35 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:13458 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfEVGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1558504952;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=HaM1fLUcrOxJUkby0OQgU1BJd7GEKZONAdYyOG73K3k=;
        b=dGVH7LpbEGdBZMAcnkmuR9YGqghD5N4H8faZzJocCpWp1A6bL7WzqjhyHSUEa9onr0
        7wJ7RuFGLPtsc/k3kLJ05xtoxDCkuzn7clBQvW0MrvzG1d+4y+1tPDLVsG3y4Fuq1M0W
        7He/OKTVIuvOAiI6OYixr05HSMc9Aqj9czp/D1q4Xs8gcBWF+SQ8C3+av+pn7NIw7dzq
        7c2mmQ0C2ap+OrO6Rv1qOZ5hzLkcgOgVdc8xo2tu2WzNj3RKuOFURyfLP+0SloHV00bt
        ubNFzkQ3jCchm2+2iBAyO1gUeXibyONv43sPe0mbdqPh6d5expV5d1/MD7DYmZQeh96t
        ZI9w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmAgw43oE44="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id j04dc1v4M62IKiO
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 22 May 2019 08:02:18 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG v5.2-rc1] ARM build broken
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <201905211331.E0D1EDC0@keescook>
Date:   Wed, 22 May 2019 08:02:17 +0200
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        lkml <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A1D2458-0130-474B-A092-6A6CDFB8CA8B@goldelico.com>
References: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com> <201905200855.391A921AB@keescook> <D8F987B2-8F41-46DE-B298-89541D7A9774@goldelico.com> <201905201142.CF71598A@keescook> <3610cb7ca542479d8eb124e9c9dd6796@svr-chch-ex1.atlnz.lc> <A22646AB-300F-4E0A-95DE-06633C2A2986@goldelico.com> <201905211331.E0D1EDC0@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

> Am 21.05.2019 um 22:36 schrieb Kees Cook <keescook@chromium.org>:
>=20
> On Tue, May 21, 2019 at 01:23:36PM +0200, H. Nikolaus Schaller wrote:
>>>>> HOSTLLD -shared scripts/gcc-plugins/arm_ssp_per_task_plugin.so - =
due to target missing
>>>>> Undefined symbols for architecture x86_64:
>>>>> "gen_reg_rtx(machine_mode)", referenced from:
>>>>>     (anonymous namespace)::arm_pertask_ssp_rtl_pass::execute() in =
arm_ssp_per_task_plugin.o
>=20
> Are you seeing this error still, even after the fix I sent?

Yes.

> Perhaps I
> misunderstood that it solves all of the build issues?

There was a compiler warning and a linker error. The patch only fixes =
the compiler warning.

>=20
>> That seems to be a significant assumption about the build =
infrastructure
>> which now became permanently enabled by the "default y" for =
GCC_PLUGINS.
>>=20
>> I am not sure what the right way forward is. Probably for me it is to =
find
>> out if I can fix my cross-toolchain. Or if the kernel should better =
check
>> if gcc-plugins can really be built, if they are automatically =
enabled.
>> Or keep all gcc-plugins disabled until explicitly configured for?
>=20
> Right, that seems to be the case: it seems that the gcc plugin build
> sanity detection script is not working in your environment. You can
> check it directly.
>=20
> Here's the bits from the Kconfig (though I added --show-error for you,
> in case that's useful):
>=20
> preferred-plugin-hostcc :=3D $(if-success,[ $(gcc-version) -ge 40800 =
],$(HOSTCXX),$(HOSTCC))
>=20
> scripts/gcc-plugin.sh --show-error "$(preferred-plugin-hostcc)" =
"$(HOSTCXX)" "$(CC)"
>=20
> I'm not sure what your kernel build picks for gcc-version, HOSTCXX
> HOSTCC and CC...

It turns out that HOSTCC and HOSTCXX are a gcc-4.9.4 installed through =
MacPorts.
And CC is the self-bootstrapped cross-gcc-4.9.2 toolchain for arm.

The problem is likely that they do not know of each other, i.e. the =
required
include and library search paths. Therefore HOSTCXX can't build plugins =
compatible
with CC because it does not even know its existence. Or the gcc-4.9.4 =
from MacPorts
is missing the gcc-plugin library to link against which would explain =
the HOSTLLD
error message as well.

This seems not to be found by the tests of scripts/gcc-plugin.sh. I have =
to check why...

BR and thanks,
Nikolaus

