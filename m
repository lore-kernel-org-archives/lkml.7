Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F14C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16C320665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfHNWRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:17:23 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37135 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfHNWRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:17:23 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4683q45kTYz1rHD6;
        Thu, 15 Aug 2019 00:17:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4683q4522vz1qqkW;
        Thu, 15 Aug 2019 00:17:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id G7ErTnX-oNt5; Thu, 15 Aug 2019 00:17:19 +0200 (CEST)
X-Auth-Info: Iuc9ZYI4BIAaDMS/g3FIEq6VQEfCcaJn66m8Acsgr85k6LCEcGh1Wi2xm4up9MZM
Received: from igel.home (ppp-46-244-165-194.dynamic.mnet-online.de [46.244.165.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 15 Aug 2019 00:17:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id BF7C02C124F; Thu, 15 Aug 2019 00:17:18 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, vincent.chen@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: Make __fstate_clean() work correctly.
References: <alpine.DEB.2.21.9999.1908141328440.18249@viisi.sifive.com>
        <mhng-4eded486-d381-4822-abc5-4023bf7ba591@palmer-si-x1c4>
X-Yow:  Well, I'm a classic ANAL RETENTIVE!!  And I'm looking for a way to
 VICARIOUSLY experience some reason to LIVE!!
Date:   Thu, 15 Aug 2019 00:17:18 +0200
In-Reply-To: <mhng-4eded486-d381-4822-abc5-4023bf7ba591@palmer-si-x1c4>
        (Palmer Dabbelt's message of "Wed, 14 Aug 2019 14:29:24 -0700 (PDT)")
Message-ID: <87mugbv1ch.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 14 2019, Palmer Dabbelt <palmer@sifive.com> wrote:

> On Wed, 14 Aug 2019 13:32:50 PDT (-0700), Paul Walmsley wrote:
>> On Wed, 14 Aug 2019, Vincent Chen wrote:
>>
>>> Make the __fstate_clean() function correctly set the
>>> state of sstatus.FS in pt_regs to SR_FS_CLEAN.
>>>
>>> Fixes: 7db91e5 ("RISC-V: Task implementation")
>>> Cc: linux-stable <stable@vger.kernel.org>
>>> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
>>> Reviewed-by: Anup Patel <anup@brainfault.org>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Thanks, I extended the "Fixes" commit ID to 12 digits, as is the usual
>> practice here, and have queued the following for v5.3-rc.
>
> For reference, something like "git config core.abbrev=12" (or whatever you
> write to get this in your .gitconfig)
>
>    https://github.com/palmer-dabbelt/home/blob/master/.gitconfig.in#L23
>
> causes git to do the right thing.

Actually, the right setting is core.abbrev=auto (or leaving it unset).
It lets git chose the appropriate length depending on the repository
contents.  For the linux repository it will chose 13 right now.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
