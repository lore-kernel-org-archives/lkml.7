Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB489ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B404A20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfIKHbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:31:16 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:50491 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfIKHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:31:16 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46Stqj3tk1z1rK4j;
        Wed, 11 Sep 2019 09:31:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46Stqj3D8Tz1qql7;
        Wed, 11 Sep 2019 09:31:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id xRIqnYOA4FUS; Wed, 11 Sep 2019 09:31:10 +0200 (CEST)
X-Auth-Info: U6SyK0E1DuQmAjUTozdtMNhDojHd+GCgFHh13ie95CNffFO2Fb02CkWE4XhUsWNF
Received: from hawking (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 11 Sep 2019 09:31:10 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        vincent.chen@sifive.com, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] riscv: Make __fstate_clean() work correctly.
References: <alpine.DEB.2.21.9999.1908141328440.18249@viisi.sifive.com>
        <mhng-4eded486-d381-4822-abc5-4023bf7ba591@palmer-si-x1c4>
        <87mugbv1ch.fsf@igel.home>
        <CAMuHMdX9tDqN4jMwMrUc-0zhYBo5gAHTbjwORCwB=3zVi6kvgQ@mail.gmail.com>
X-Yow:  Is this "BIKINI BEACH"?
Date:   Wed, 11 Sep 2019 09:31:10 +0200
In-Reply-To: <CAMuHMdX9tDqN4jMwMrUc-0zhYBo5gAHTbjwORCwB=3zVi6kvgQ@mail.gmail.com>
        (Geert Uytterhoeven's message of "Wed, 11 Sep 2019 09:22:43 +0200")
Message-ID: <mvmtv9ji91d.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 11 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andreas,
>
> On Thu, Aug 15, 2019 at 12:37 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Aug 14 2019, Palmer Dabbelt <palmer@sifive.com> wrote:
>> > On Wed, 14 Aug 2019 13:32:50 PDT (-0700), Paul Walmsley wrote:
>> >> On Wed, 14 Aug 2019, Vincent Chen wrote:
>> >>> Make the __fstate_clean() function correctly set the
>> >>> state of sstatus.FS in pt_regs to SR_FS_CLEAN.
>> >>>
>> >>> Fixes: 7db91e5 ("RISC-V: Task implementation")
>> >>> Cc: linux-stable <stable@vger.kernel.org>
>> >>> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
>> >>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> >>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> >>
>> >> Thanks, I extended the "Fixes" commit ID to 12 digits, as is the usual
>> >> practice here, and have queued the following for v5.3-rc.
>> >
>> > For reference, something like "git config core.abbrev=12" (or whatever you
>> > write to get this in your .gitconfig)
>> >
>> >    https://github.com/palmer-dabbelt/home/blob/master/.gitconfig.in#L23
>> >
>> > causes git to do the right thing.
>>
>> Actually, the right setting is core.abbrev=auto (or leaving it unset).
>> It lets git chose the appropriate length depending on the repository
>> contents.  For the linux repository it will chose 13 right now.
>
> Does that depend on the git version?
> For me (git version 2.17.1), it still uses 12 when using the auto setting.

No, 12 is the correct number.  I was miscounting.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
