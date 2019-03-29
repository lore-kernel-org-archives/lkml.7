Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F03C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB408218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfC2VcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:32:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:51454 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730051AbfC2VcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:32:11 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h9z6g-0003yf-4p; Fri, 29 Mar 2019 15:32:10 -0600
To:     Jann Horn <jannh@google.com>, Mukesh Ojha <mojha@codeaurora.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        iommu@lists.linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>
References: <20190328225925.241998-1-jannh@google.com>
 <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
 <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com>
 <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3275e86a-5b12-29ff-9b1f-d8eba099ae98@deltatee.com>
Date:   Fri, 29 Mar 2019 15:32:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, x86@kernel.org, hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, jdmason@kudzu.us, mulix@mulix.org, horia.geanta@nxp.com, mojha@codeaurora.org, jannh@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-29 3:19 p.m., Jann Horn wrote:
>>> Can the existing api's not be used here like iowrite64be/ioread64be/ or
>>> similar variant in "include/asm-generic/io.h"
>>
>> Oooh! I didn't realize that those exist. I'll change that and send a v2.
Yes, they are very new! It took me a while to get those patches in as it
is a bit more complicated than it seems.

> Actually, that doesn't work at the moment on x86-64:
> 
> include/asm-generic/io.h only defines these things if
> CONFIG_GENERIC_IOMAP isn't defined; and X86 unconditionally defines
> it. With CONFIG_GENERIC_IOMAP set, these functions are provided by
> include/asm-generic/iomap.h.

For CONFIG_GENERIC_IOMAP, lib/iomap.c provides _lo_hi and _hi_lo
implementations seeing the pio regions must be emulated with 32bit
operations and we have to define the order.

> The definitions for these are in lib/iomap.c, except that there are no
> definitions for ioread64be() and iowrite64be(); if you try to use
> them, you get linker errors.

Some platforms implement these but most do not. If I recall correctly
only powerpc does.

If you want to use 64 bit operations in a portable fashion, you should
include "linux/io-64-nonatomic-hi-lo.h" or
"linux/io-64-nonatomic-lo-hi.h", depending on weather you want the lower
bits or the higher bits to be written or read first in cases where an
atomic operation is not available.

Logan
