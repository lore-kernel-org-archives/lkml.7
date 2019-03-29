Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F69C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CAB2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfC2VnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:43:25 -0400
Received: from ale.deltatee.com ([207.54.116.67]:51546 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbfC2VnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:43:25 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h9zHY-00046G-Cj; Fri, 29 Mar 2019 15:43:25 -0600
To:     Jann Horn <jannh@google.com>
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Muli Ben-Yehuda <mulix@mulix.org>,
        Jon Mason <jdmason@kudzu.us>,
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
 <3275e86a-5b12-29ff-9b1f-d8eba099ae98@deltatee.com>
 <CAG48ez1e=vHZqRp7=rQCvOjJnHjQtR5wQKZ69jOAZChto7RDCA@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6a41d1f8-4be6-40d6-e30d-71abf70f4468@deltatee.com>
Date:   Fri, 29 Mar 2019 15:43:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez1e=vHZqRp7=rQCvOjJnHjQtR5wQKZ69jOAZChto7RDCA@mail.gmail.com>
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



On 2019-03-29 3:40 p.m., Jann Horn wrote:
> So what is the right thing to do in the context of
> arch/x86/kernel/pci-calgary_64.c? That code wants to perform MMIO with
> endianness conversion, and these accesses are always performed as
> MMIO. Using the non-atomic 64-bit I/O helpers for this would be kind
> of awkward, since the accesses would never actually be split...

Well, if you know you're only ever doing MMIO, you'd probably just want
to use readq() directly.

Logan

