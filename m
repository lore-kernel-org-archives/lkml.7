Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E89DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D832084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YoTDLpmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfDASB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:01:59 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:55172 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbfDASB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:01:58 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 8EC2E24E2A84;
        Mon,  1 Apr 2019 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554141717; bh=FgqPjPpDhqbG5l/VJZh6afGVq3rpqo7KWFSeI8Ptj0s=;
        h=From:To:CC:Subject:Date:References:From;
        b=YoTDLpmGmrCQjVP058/3XGBm1mQDyEBxMSuIKB7BMjzaFMWK5T/UpEL3eBs6+AM6/
         lwM4MXqFVDYMvwIbnl2mXdk64+ZlMhgtWYUkUTM4SmlR+2gAgT4hCBBOdfbdXc9dNh
         5Ta3xLONrvGKtziBPclvaBjzyi3jCjTF70XAOaXkCH8je/UcVdbc77158VG7wYok4l
         IvEauSohdT9WS+AZk+XZ8H3GiQIzn65f1b3HhD00FEEJ7VmPrLILaFUztc1baoYlcs
         ErqzitFudAmKWMTq+4UUeFnLmdjj9ZZ4RJg9+6RnKtxKXxi91LTvY58vRCd8eCrzeP
         +7nVCtnOcHYeg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 44043A005A;
        Mon,  1 Apr 2019 18:01:52 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Mon, 1 Apr 2019 11:01:51 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Andrey Abramov <st5pub@yandex.ru>
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
        "vgupta@synopsys.com" <vineet.gupta1@synopsys.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Thread-Topic: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Thread-Index: AQHU6JnBsi9jfaw2oEibJh5UEx7dnA==
Date:   Mon, 1 Apr 2019 18:01:51 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014643F9DF@US01WEMBX2.internal.synopsys.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
 <20190330183826.GB21828@kroah.com> <201903302015.x2UKFnSL003850@sdf.org>
 <20434561554015618@myt1-cd60b8ae9bb9.qloud-c.yandex.net>
 <20190331105412.GA9393@kroah.com>
 <cd57af9a2c1e494cbc8631a0347831dc@AcuMS.aculab.com>
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

On 4/1/19 7:46 AM, David Laight wrote:=0A=
> From: gregkh@linuxfoundation.org=0A=
>> Sent: 31 March 2019 11:54=0A=
> ...=0A=
>> Yes, "int" is a very nice variable for "size", you need to explain why=
=0A=
>> it is better to use size_t here please.=0A=
> Actually, on x86_64 you probably want 'unsigned int' to avoid the=0A=
> compiler having to generate a sign-extending register move if the=0A=
> value is ever used in a 64bit expression (eg an address calculation).=0A=
=0A=
Thats likely true for non x86 arches too (for certain on ARC). That is also=
 the=0A=
reason I dislike "bool", despite its "software engineering" benefits. Per A=
RC ABI=0A=
(and likely others too) it is signed 8 bits and any use thereof, requires t=
he=0A=
compiler to generate an additional EXTB instruction to promote to 32-bit in=
t with=0A=
sign extension before using the value.=0A=
=0A=
-Vineet=0A=
