Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3C9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5C2205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pL0J72wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfDSSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:44:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38360 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfDSSoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:44:02 -0400
Received: from zn.tnic (p200300EC2F112E006C6C37C052F44BC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:6c6c:37c0:52f4:4bc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E0391EC0AB0;
        Fri, 19 Apr 2019 13:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555673655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KvkrT7n0lvO37OOK/U/WO0WFm7q8pLZ2+gcOlL+GzuQ=;
        b=pL0J72wHwswtHqQ93OAXCN4pVjPkt6/Gea3yp9Yhp3szy8HeS5KTYYCqLX4/xI8bl+tnBW
        Zm6wAMZW2D2rzkhsFJCM7p+FlKzMaSTPrXBqcJ/Zmta0OV9zM9qflA17Q3B+AUFJi3v+qO
        05BRCkWJrvXluPMPMoRyevg/ZJtytHc=
Date:   Fri, 19 Apr 2019 13:34:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419113413.GC10324@zn.tnic>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <CACPcB9fwvxmVcD4ttP8p9X0=J+Oev9RUrgNzuu6LZFQCZ7AS1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9fwvxmVcD4ttP8p9X0=J+Oev9RUrgNzuu6LZFQCZ7AS1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 07:20:06PM +0800, Kairui Song wrote:
> Thanks for the declaration Bao, I can verify on the machine I have,
> the issue still exist without kaslr. Currently, we read rsdp in early
> code and fill in boot_params unconditional, so it will read from the
> systab anyway.

Yes, and in the future, info required by the kexec'ed kernel - like the
EFI systab address or even whether the kernel has been kexec'ed or comes
from cold boot - should be passed in boot_params. So that we don't have
to do all that ugly dancing in early code.

> Yes, kexec only cover RAM in the ident map it prepared for second
> kernel, but the systab could be in reserved region, so if it didn't
> fall into the 1G padding by accident it will fail when reading from
> it. Fix in early code could make sure 2nd kernel always work. Or
> should we treat it specially in kexec mapping prepare code?

Yes, we should. As I said, this is not early boot code's problem but the
kexec setup code's problem.

If the new kernel cannot get RSDP that early, then it should fail the
same way it failed before. That early RDSP parsing was added for the
movable regions thing working with KASLR.

If it can't get a RDSP for whatever reason, then if KASLR selects
a region overlapping with the movable regions, then it is the old
behavior.

Ok?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
