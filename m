Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13757C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D493620883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i6oJsyOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfDASWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:22:40 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:60806 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfDASWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:22:39 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 5477810C1B85;
        Mon,  1 Apr 2019 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554142959; bh=4CowC1Hdjl591QX/XesyJ4nl8xOerbBk0B2ONZVaw6E=;
        h=From:To:CC:Subject:Date:References:From;
        b=i6oJsyOi9n/sxRivSiEHOiVJeEATmu5fKRN9CweuaSEcnzF+eU6SSWCwf2z2NQd2M
         M2e5hPKTqZ3Gu/oCGEO8jJgg2Xk93j8x6ttKZEpqDySxxPdJy6j+vZMaqW7gvGRlkp
         UqkMAZIDkn5okWgnVFGsSWljOmvDr/szixx2L17pHtsdvFqQOrh8oKwFrSsLBSYGrY
         o0gu1uNM/vjGGo1WzPza4llA5wa7Ne+4HDJwFMZO3O+tDD2koYvCMi3SApPvGnrWeU
         Qlz/R131E4QuvjxArq+BVpCuE7m66BDxn8BKJbDsh3pA9nzdlZIPCx8DdPe/ozM33c
         O0nq1lUg7t5Xg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3128DA0090;
        Mon,  1 Apr 2019 18:22:31 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Mon, 1 Apr 2019 11:22:31 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Andrey Abramov <st5pub@yandex.ru>,
        David Laight <david.laight@aculab.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
CC:     George Spelvin <lkml@sdf.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "richard@nod.at" <richard@nod.at>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Thread-Topic: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Thread-Index: AQHU6JnBsi9jfaw2oEibJh5UEx7dnA==
Date:   Mon, 1 Apr 2019 18:22:29 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014643FA6C@US01WEMBX2.internal.synopsys.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
 <20190330183826.GB21828@kroah.com> <201903302015.x2UKFnSL003850@sdf.org>
 <20434561554015618@myt1-cd60b8ae9bb9.qloud-c.yandex.net>
 <20190331105412.GA9393@kroah.com>
 <cd57af9a2c1e494cbc8631a0347831dc@AcuMS.aculab.com>
 <C2D7FE5348E1B147BCA15975FBA23075014643F9DF@US01WEMBX2.internal.synopsys.com>
 <440631554142479@myt6-23299ba78d64.qloud-c.yandex.net>
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

On 4/1/19 11:14 AM, Andrey Abramov wrote:=0A=
> George Spelvin wrote "So how about *deleting* the parameter instead?=0A=
> That simplifies everything.", and he is right,=0A=
> so I am just going to completely remove it.=0A=
>=0A=
> Any objections?=0A=
=0A=
LGTM.=0A=
