Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF6820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Dqc7VWRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCDWcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:32:03 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:56786 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:32:02 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 63DAB10C0EDB;
        Mon,  4 Mar 2019 14:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551738722; bh=7JizSrW/jRvd9L3r2CzSGU9EhGig1VKzumWrBmUXwQc=;
        h=From:To:CC:Subject:Date:References:From;
        b=Dqc7VWRPPWwFci/JWRLosvmTHzLaB4ld/i3U6h7z+AkExOcHU9gO/cV1ilL9Z1IVw
         VCXaMESFaNkSkqnJpv/aSHnvsM0fbJQc+LgCoCKbwOUDdVRPP7LbNd75s7MBGK8Y4n
         O+PCvKt7kRpQje9fnonsi8WSv1s/3bi7clSHyPEe/hZMHLB8BgkcbGboSWPEPBAXkI
         s6dW8wKiqUtxH3ZYR4cxc56x4KopAVxmikDdjfIi96McNW4dGetNmMMsrEbskcInWM
         iM+R4t2wiAmvAiHuROGKJauZLUfKH2FVkSQkcBUl4Uw/+E30v90UsNB4BcMPUYWqus
         XqYSgeH+WYJVA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2BDECA005D;
        Mon,  4 Mar 2019 22:32:01 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Mon, 4 Mar 2019 14:32:01 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Claudiu Zissulescu" <claudiu.zissulescu@synopsys.com>
Subject: Re: [PATCH] ARCv2: Add explcit unaligned access support (and
 ability to disable too)
Thread-Topic: [PATCH] ARCv2: Add explcit unaligned access support (and
 ability to disable too)
Thread-Index: AQHUz422b40bhmdW702O6EC/CP0bNQ==
Date:   Mon, 4 Mar 2019 22:32:00 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146438D04@US01WEMBX2.internal.synopsys.com>
References: <20190228174742.GA18868@roeck-us.net>
 <C2D7FE5348E1B147BCA15975FBA2307501464380DE@US01WEMBX2.internal.synopsys.com>
 <20190228185929.GA9842@roeck-us.net>
 <C2D7FE5348E1B147BCA15975FBA2307501464381EE@US01WEMBX2.internal.synopsys.com>
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

On 2/28/19 11:24 AM, Vineet Gupta wrote:=0A=
> On 2/28/19 10:59 AM, Guenter Roeck wrote:=0A=
>>> Once the patch hits mainline you could use that. In the mean time I'll =
back out=0A=
>>> the "detector" as it might trip other people too.=0A=
>>>=0A=
>> Can you possibly use $(cc-option,-mno-unaligned-access), or would that=
=0A=
>> defeat the purpose ?=0A=
>>=0A=
> Indeed I was looking into Kconfig documentation and found something simil=
ar.=0A=
> However there's an anti-dependency. It is enabled by default and can only=
 be=0A=
> disabled with $(cc-option,-mno-unaligned-access)=0A=
> So guess we will have to change  ARC_USE_UNALIGNED_MEM_ACCESS to=0A=
> ARC_*LACKS*_UNALIGNED_MEM_ACCESS=0A=
>=0A=
> I'll tinker a bit and post an update soon.=0A=
=0A=
I got around to testing a patch with inverted option, unaligned access is d=
efault=0A=
and ARC_UNALIGNED_ACCESS_NONE disables it. This option can depend on=0A=
$(cc-option,-mno-unaligned-access). The issue however is "broken" gcc silen=
tly=0A=
ignoring -mno-unaligned-access. So this option can't be auto disable with a=
ffected=0A=
gcc. So this approach won't work. The only way out is remove the stringent =
check=0A=
and just wait for upstream gcc to be fixed.=0A=
=0A=
