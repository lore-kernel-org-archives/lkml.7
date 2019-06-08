Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BCC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193DE2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="URdomBe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFHJKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:10:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfFHJKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:10:32 -0400
Received: from zn.tnic (p200300EC2F288A00DCF654BEDE068B01.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:8a00:dcf6:54be:de06:8b01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D7BF1EC0235;
        Sat,  8 Jun 2019 11:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559985031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=agc6qWSU+tH8yyKDxQhV32Xjr+GidM+gMCD2W3Xjjy8=;
        b=URdomBe1ERBxGlufupOX27J5DZgEIDbAr5wx8/GGH5LLLEeYN0IUm/2o+y/aoQahA3dTGu
        LL1uAfkVOn2reWaQBnK5dSv7jmz4oo6GkwDbWygu4IFFJCbydP7VCN6LXFLkSJT9caO7yh
        lJgNkzoukgNEvmehXJRPQsCqHxaAGw0=
Date:   Sat, 8 Jun 2019 11:10:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190608091030.GB32464@zn.tnic>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190608035451.GB26148@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 11:54:51AM +0800, Baoquan He wrote:
> Is it a UEFI box?

Yes.

> If it's uefi machine, it should relate to below issue. Because kexec
> always fails to randomly choose a new position for kernel.

The kernel succeeds in selecting a position for the kernel - the kexec
kernel doesn't load when a panic happens. Rather, the box panics and
nothing more.

> The current kexec code fills boot_params->efi_info->efi_loader_signature,
> but doesn't contruct efi_memmap table. The kexec/kdump kernel will always
> fail to find available slot for KASLR in process_efi_entries.

Kernel has

# CONFIG_RANDOMIZE_BASE is not set

so no KASLR.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
