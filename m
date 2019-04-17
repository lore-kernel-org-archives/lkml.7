Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B037C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F17E217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="G5pbVkcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfDQIyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:54:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58474 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfDQIyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:54:36 -0400
Received: from zn.tnic (p200300EC2F112E000C2D4197130645E8.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:c2d:4197:1306:45e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61FD31EC04CD;
        Wed, 17 Apr 2019 10:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555491275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wR2+6axEGjnwmnsXoxIn9sKpzP9pltyK+ucxjvJbXZ0=;
        b=G5pbVkcgbroTqGyPvHY2so8qVm83vxBN0SS1cSiIPjcaH0dEq459crdm6CQHClX50N3Uc9
        qT47J2C1bQwXTG7J+dYgZnQiHoC/Hta7jvqqmz3n/IFrn9sPmn3EYoVhrytdhjnZEQ+KOQ
        ZeZHOhHU6Smp1dfANM23ne17tskfMHs=
Date:   Wed, 17 Apr 2019 10:54:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190417085434.GC20492@zn.tnic>
References: <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic>
 <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <34d02ae0-7182-2983-b601-acbdb4085f33@ce.jp.nec.com>
 <20190417070250.GD8411@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417070250.GD8411@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:02:50PM +0800, Dave Young wrote:
> How about move it after console_init,

Sounds ok to me. That's still before KASLR gets setup and should work
for Chao's movable regions too.

> and at the same time skip efi_get_rsdp_addr in case kexec?

If kexec_get_rsdp_addr() gets a correct address, efi_get_rsdp_addr()
will be skipped.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
