Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C67BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C68D218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LFIKpZmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbfB1TYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:24:44 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:49418 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfB1TYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:24:44 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id C717924E0DE9;
        Thu, 28 Feb 2019 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551381883; bh=UilihWv8L5KlZr9SlMcPyXKk8MT3Erb3FWYGJDoFHiU=;
        h=From:To:CC:Subject:Date:References:From;
        b=LFIKpZmDLH/aDtpePRs+nsrNNMihUSUWNDXMySZHVYv9y+u4jCTyrbrfMdaJ59yaN
         qME9bfuc8IQNysayza7t9K0V6CGBGXIOCJH75EZ0d+5RiaYNN6B5yTk4Q7dyTM8+MV
         W9D3QCWcld/oTPI0bJ35qU4KlpLOZwjL4rVwjC9J8ujzxwstnNO1xbldx2sDbv2nl7
         bU+LJXZ6y/MlNUU6gENOiApx+hB6EJHBQ1MpFBt4GsWKumcWhCt7Z6onC1gcGH0nJP
         Dq2zTxd9I9AFoJwqXHm2JOR9zo6FGwFyzt1F6rsxxzqC7CuRlZ+IIbR6NnmX0npxjI
         8OkBlwzQgMkng==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A8C2CA007B;
        Thu, 28 Feb 2019 19:24:43 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 28 Feb 2019 11:24:43 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Claudiu Zissulescu <claudiu.zissulescu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCv2: Add explcit unaligned access support (and
 ability to disable too)
Thread-Topic: [PATCH] ARCv2: Add explcit unaligned access support (and
 ability to disable too)
Thread-Index: AQHUz422b40bhmdW702O6EC/CP0bNQ==
Date:   Thu, 28 Feb 2019 19:24:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464381EE@US01WEMBX2.internal.synopsys.com>
References: <20190228174742.GA18868@roeck-us.net>
 <C2D7FE5348E1B147BCA15975FBA2307501464380DE@US01WEMBX2.internal.synopsys.com>
 <20190228185929.GA9842@roeck-us.net>
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

On 2/28/19 10:59 AM, Guenter Roeck wrote:=0A=
>> Once the patch hits mainline you could use that. In the mean time I'll b=
ack out=0A=
>> the "detector" as it might trip other people too.=0A=
>>=0A=
> Can you possibly use $(cc-option,-mno-unaligned-access), or would that=0A=
> defeat the purpose ?=0A=
>=0A=
=0A=
Indeed I was looking into Kconfig documentation and found something similar=
.=0A=
However there's an anti-dependency. It is enabled by default and can only b=
e=0A=
disabled with $(cc-option,-mno-unaligned-access)=0A=
So guess we will have to change  ARC_USE_UNALIGNED_MEM_ACCESS to=0A=
ARC_*LACKS*_UNALIGNED_MEM_ACCESS=0A=
=0A=
I'll tinker a bit and post an update soon.=0A=
=0A=
-Vineet=0A=
