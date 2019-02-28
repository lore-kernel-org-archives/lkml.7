Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D006BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B844204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UCDX8jbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbfB1SMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:12:37 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:44390 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1SMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:12:37 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 74A7C24E0FDB;
        Thu, 28 Feb 2019 10:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551377556; bh=48CSXN0gUjxLNQ8JuQZftKvsfzeXsep1MP5PlyIFIwI=;
        h=From:To:CC:Subject:Date:References:From;
        b=UCDX8jbhkRlTMw5ufN5sdGl7XNpcDsqOeGTCddpTJuCJZnQdW0Zg5YIHCufQm8Qcc
         exCjAfVZahtkrH/cSSFl6sdNegCO4isKvAXHCs9RKjr4Gt04uctgLii2OrbKh4GxRA
         sk64Djo4Q7Zp5YYrfli1kEXjPbzFuo32BmahQ350459Oqn7Jp3uJfFtf8ryOXUiE2E
         FyD7MK/aYom0lnF2ftW65fyxAA81leM1CZUWnylhlsqFm+TJcFrLtwietj9S039Rkf
         oeU/40yakE8SpcWMaSL+7ypIqqTWsRphAsYXkx9d5fJxisC9/WY6r99xPx7HVoi+LQ
         nz6jxPWsVGNvA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 80B5DA0077;
        Thu, 28 Feb 2019 18:12:34 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 28 Feb 2019 10:12:33 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
CC:     Claudiu Zissulescu <claudiu.zissulescu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCv2: Add explcit unaligned access support (and
 ability to disable too)
Thread-Topic: [PATCH] ARCv2: Add explcit unaligned access support (and
 ability to disable too)
Thread-Index: AQHUz422b40bhmdW702O6EC/CP0bNQ==
Date:   Thu, 28 Feb 2019 18:12:33 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464380DE@US01WEMBX2.internal.synopsys.com>
References: <20190228174742.GA18868@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/19 9:47 AM, Guenter Roeck wrote:=0A=
> On Wed, Jan 30, 2019 at 07:32:41PM +0300, Eugeniy Paltsev wrote:=0A=
>> As of today we enable unaligned access unconditionally on ARCv2.=0A=
>> Do this under a Kconfig option to allow disable it for test, benchmarkin=
g=0A=
>> etc. Also while at it=0A=
>>=0A=
>>   - Select HAVE_EFFICIENT_UNALIGNED_ACCESS=0A=
>>   - Although gcc defaults to unaligned access (since GNU 2018.03), add t=
he=0A=
>>     right toggles for enabling or disabling as appropriate=0A=
>>   - update bootlog to prints both HW feature status (exists, enabled/dis=
abled)=0A=
>>     and SW status (used / not used).=0A=
>>   - wire up the relaxed memcpy for unaligned access=0A=
>>=0A=
>> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>=0A=
>> [vgupta: squashed patches, handle gcc -mno-unaligned-access quick]=0A=
> Hi,=0A=
>=0A=
> with my brand-new gcc-8.3.0, built from upstream gcc, this patch=0A=
> results in=0A=
>=0A=
> arch/arc/kernel/setup.c: In function 'arc_cpu_mumbojumbo.constprop':=0A=
> include/linux/compiler.h:348:38: error:=0A=
> 	call to '__compiletime_assert_326' declared with attribute error: gcc do=
esn't support -mno-unaligned-access=0A=
=0A=
Sorry it broke ur build - but it did catch a deficiency in compiler as inte=
nded -=0A=
yay !=0A=
=0A=
> when trying to build allnoconfig or tinyconfig. I get the same results=0A=
> with gcc-8.2.0.=0A=
=0A=
Unaligned access code gen was enabled by default in 7.x actually, but us OS=
 folks=0A=
were late to find that which led to the recent patch to disable it which wa=
s=0A=
broken in gcc.=0A=
Claudiu fixed gcc promptly but that patch didn't make it to upstream, which=
 I've=0A=
posted now.=0A=
=0A=
http://lists.infradead.org/pipermail/linux-snps-arc/2019-February/005522.ht=
ml=0A=
=0A=
> Do I need some special compiler configuration flag when building the=0A=
> arcv2 toolchain ? Or am I simply out of luck for using upstream gcc ?=0A=
=0A=
Once the patch hits mainline you could use that. In the mean time I'll back=
 out=0A=
the "detector" as it might trip other people too.=0A=
=0A=
Many Thx for your testing service.=0A=
-Vineet=0A=
