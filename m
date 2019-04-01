Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A411C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5582120883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="S4GwXOKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfDASOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:14:51 -0400
Received: from forward500o.mail.yandex.net ([37.140.190.195]:40623 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728638AbfDASOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:14:50 -0400
Received: from mxback13g.mail.yandex.net (mxback13g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:92])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 3540A60264;
        Mon,  1 Apr 2019 21:14:45 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback13g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id K52M0V5utU-EdmGh2Iw;
        Mon, 01 Apr 2019 21:14:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1554142484;
        bh=MjHdbX1F4aTQmY4SoorYMmxw7zaWT6f/eOXBazqFaq4=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=S4GwXOKEVuR2oS5fZ39Jenx5TGALVK81KrigS+DZUYiDFnUSEA/+B+e7HaFIq/MIu
         zZy48VecN6tv2yM812BJa4CPrApzNvGEvEBXTJu+xm5K2Jqq5XFLUZZVRnNsaCV2bg
         XY0tcG789unydEDYIPVKO9z1+rO7d7lOwp1gXf/g=
Authentication-Results: mxback13g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-23299ba78d64.qloud-c.yandex.net with HTTP;
        Mon, 01 Apr 2019 21:14:39 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        David Laight <david.laight@aculab.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
Cc:     George Spelvin <lkml@sdf.org>,
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
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014643F9DF@US01WEMBX2.internal.synopsys.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
         <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
         <20190330183826.GB21828@kroah.com> <201903302015.x2UKFnSL003850@sdf.org>
         <20434561554015618@myt1-cd60b8ae9bb9.qloud-c.yandex.net>
         <20190331105412.GA9393@kroah.com>
         <cd57af9a2c1e494cbc8631a0347831dc@AcuMS.aculab.com> <C2D7FE5348E1B147BCA15975FBA23075014643F9DF@US01WEMBX2.internal.synopsys.com>
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in the swap function
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 01 Apr 2019 21:14:39 +0300
Message-Id: <440631554142479@myt6-23299ba78d64.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.04.2019, 21:02, "Vineet Gupta" <vineet.gupta1@synopsys.com>:
> On 4/1/19 7:46 AM, David Laight wrote:
>>  From: gregkh@linuxfoundation.org
>>>  Sent: 31 March 2019 11:54
>>  ...
>>>  Yes, "int" is a very nice variable for "size", you need to explain why
>>>  it is better to use size_t here please.
>>  Actually, on x86_64 you probably want 'unsigned int' to avoid the
>>  compiler having to generate a sign-extending register move if the
>>  value is ever used in a 64bit expression (eg an address calculation).
>
> Thats likely true for non x86 arches too (for certain on ARC). That is also the
> reason I dislike "bool", despite its "software engineering" benefits. Per ARC ABI
> (and likely others too) it is signed 8 bits and any use thereof, requires the
> compiler to generate an additional EXTB instruction to promote to 32-bit int with
> sign extension before using the value.
>
> -Vineet

George Spelvin wrote "So how about *deleting* the parameter instead?
That simplifies everything.", and he is right,
so I am just going to completely remove it.

Any objections?

--
With Best Regards,
Andrey Abramov
