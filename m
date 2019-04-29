Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C290C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EC020675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j9vr3RNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfD2RRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:17:54 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:45676 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728829AbfD2RRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:17:54 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4B5F9C009B;
        Mon, 29 Apr 2019 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556558271; bh=rx21fwalFzJuwLlEFvldeNsp0iEkfMYCHIUJGt12hfY=;
        h=From:To:CC:Subject:Date:References:From;
        b=j9vr3RNo7bxDoJ3ou1UiEVj4zkM4uS3kpvE6nJh3tGICOpGKubVQDEWb5sKe9r14m
         rROXe9L4PqDyh+9gDEbeeszLO950QSAUY+4OylAVQehPboAy8WNmMlSgZ/SHl6VVtL
         0fBhz4xVENQhJEDcAaUMS/deHBfNPRRXVSIi0wNQqGXFGB9pThb1kojWzYJmNz0FiL
         F8rOPdaaxFpOwpwYiIQo5CrPOvzokiwQ8XqlTXWZZQZwedVBig0ZcX+JPLhQMEH9sf
         /Ag+ZHDFnZj3unGASH6n2jRuOO0VbDudMIEWtz2zrCqQUwfZp3YNTSlx+It3ZFupt0
         vPdLqg1cJjikg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EDD0FA007A;
        Mon, 29 Apr 2019 17:17:50 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 29
 Apr 2019 10:17:51 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: perf tools build broken after v5.1-rc1
Thread-Topic: perf tools build broken after v5.1-rc1
Thread-Index: AQHU9whSYuAYlq2eD0OAivz0M0d5Nw==
Date:   Mon, 29 Apr 2019 17:17:50 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/19 8:31 AM, Arnaldo Carvalho de Melo wrote:=0A=
>> A quick fix for ARC will be to create our own version but I presume all =
existing=0A=
>> arches using generic syscall abi are affected. Thoughts ? In lack of ide=
as I'll=0A=
>> send out a patch for ARC.=0A=
>>=0A=
>> P.S. Why do we need the unistd.h duplication in tools directory, given i=
t could=0A=
>> have used the in-tree unistd headers directly ?=0A=
> I have to write down the explanation and have it in a file, but we can't=
=0A=
> use anything in the kernel from outside tools/ to avoid adding a burden=
=0A=
> to kernel developers that would then have to make sure that the changes=
=0A=
> that they make outside tools/ don't break things living there.=0A=
=0A=
That is a sound guiding principle in general but I don't agree here. unistd=
 is=0A=
backbone of kernel user interface it has to work and can't possibly be brok=
en even=0A=
when kernel devs add a new syscall is added or condition-alize existing one=
. So=0A=
adding a copy - and deferring the propagation of in-kernel unistd to usersa=
pce=0A=
won't necessarily help with anything and it just adds the burden of keeping=
 them=0A=
in sync. Granted we won't necessarily need all the bleeding edge (new sysca=
ll=0A=
updates) into that header, its still more work.=0A=
