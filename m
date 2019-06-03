Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5404DC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7A927CF5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="pJQUzNku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfFCHqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:46:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:11666 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfFCHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559547963;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=X95JVgTxMcfy0APeBSV8OTFn6fsX31RbNCXxHMsZvpI=;
        b=pJQUzNkuLokz11lkLriauhTm7LfZCv/KN4OUc5swnJe2s9wRjWkKEEPPlsW1C1W0qq
        RN1ZpwaSxdWTzXk5itVslaHxh11PG936PaWGo9sioiK/PNG/2KD5Hw1pvcK/M+xf7rmq
        wgxwXSg8mGUaqZQl13AShzNOJV6i6Di8sqY8MvitNHHkW9COJkkHp++ydQFCTzH83v5R
        0DbdmXIZw+S+pJqBA2ZlFGinOk9c/Rfzz4JEijdYqJSLO4bWstVY1q7ng2ChhaoKqMC5
        OnWMPqwRppPJgBrLBxO4Wv+DAsnOqWV084DNFhJcjGZgs0ekFMET9XczHEcUeE9Lx/Uz
        1rqw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCyhrHcWveo6dYddJLwU7zfP8dEA8ZeyIBhBhmPt"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:2643:ce00:3513:fe32:ce68:90d3]
        by smtp.strato.de (RZmta 44.18 AUTH)
        with ESMTPSA id j04dc1v537jsCkO
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 3 Jun 2019 09:45:54 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [BUG v5.2-rc1] ARM build broken
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <2A1D2458-0130-474B-A092-6A6CDFB8CA8B@goldelico.com>
Date:   Mon, 3 Jun 2019 09:46:03 +0200
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        lkml <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9390B37E-5FFC-4528-A8FE-3D1784C3C2E9@goldelico.com>
References: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com> <201905200855.391A921AB@keescook> <D8F987B2-8F41-46DE-B298-89541D7A9774@goldelico.com> <201905201142.CF71598A@keescook> <3610cb7ca542479d8eb124e9c9dd6796@svr-chch-ex1.atlnz.lc> <A22646AB-300F-4E0A-95DE-06633C2A2986@goldelico.com> <201905211331.E0D1EDC0@keescook> <2A1D2458-0130-474B-A092-6A6CDFB8CA8B@goldelico.com>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

> Am 22.05.2019 um 08:02 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> It turns out that HOSTCC and HOSTCXX are a gcc-4.9.4 installed through =
MacPorts.
> And CC is the self-bootstrapped cross-gcc-4.9.2 toolchain for arm.
>=20
> The problem is likely that they do not know of each other, i.e. the =
required
> include and library search paths. Therefore HOSTCXX can't build =
plugins compatible
> with CC because it does not even know its existence. Or the gcc-4.9.4 =
from MacPorts
> is missing the gcc-plugin library to link against which would explain =
the HOSTLLD
> error message as well.
>=20
> This seems not to be found by the tests of scripts/gcc-plugin.sh. I =
have to check why...

Well, here are some findings:
* gcc-plugin.sh does not check if the g++ is really capable of linking a =
gcc-plugin
* it only syntax-checks if g++ supports the designated initializer GNU =
extension
* my gcc from MacPorts passes this test
* but seems not to be able to properly build any gcc-plugin.so
* I also get the similar linker errors when trying this gcc-plugin =
example:
  https://thinkingeek.com/2015/08/16/a-simple-plugin-for-gcc-part-1/
* the step that fails with the MacPorts gcc is linking the gcc-plugin.so =
from the gcc-plugin.o file
* I have not found any hint where this step should get the missing =
symbols from
  There is no lgcc or similar available

So I'd suggest to expand gcc-plugin.sh to not only syntax-check but also =
test if a
plugin.so can be successfully linked.

Maybe something like

	$2 -std=3Dgnu++98 -shared -o /tmp/plugin.so =
-I"${srctree}"/gcc-plugins -I"${gccplugins_dir}"/include 2>&1

Maybe the test source code should reference =
plugin_default_version_check() to trigger
the linker.

BR and thanks,
Nikolaus=
