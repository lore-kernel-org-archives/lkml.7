Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DED21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y3HtzUk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbfDRMcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:32:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44738 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730682AbfDRMcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:32:19 -0400
Received: from zn.tnic (p200300EC2F112E003868EF36058F9C84.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:3868:ef36:58f:9c84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA3DD1EC0380;
        Thu, 18 Apr 2019 14:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555590738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4rvzXhVII5DOqNioO9bElCvDnQGTxutajqxzUua7Xbk=;
        b=Y3HtzUk7hfgdTOKAs/fcgMIheHvUXIOWSE4YDH9BUbm8S8UwY8VKdOuPC4EIBZpNyn5X/r
        14AeEMa6JQzdBGsCNbbaEMgV6KjK+7t226FjgceQVo8M1Sw+pWQCw2YPfbNGAzQe0oq929
        D3Y59eYIJW0x5y71RfncQOiW1OUHwnM=
Date:   Thu, 18 Apr 2019 14:32:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] x86/boot/KASLR: skip the specified crashkernel
 region
Message-ID: <20190418123216.GG27160@zn.tnic>
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
 <1554703115-15299-3-git-send-email-kernelfans@gmail.com>
 <20190416190128.GL31772@zn.tnic>
 <CAFgQCTuDVk+Zav0v-WfPmEjmuOW-P+n3x9SmZj54ky-FJ82_+Q@mail.gmail.com>
 <20190417160618.GG20492@zn.tnic>
 <CAFgQCTsPGp3vwDYndXR2Qk=t2X9Gqg-82KicoAKLon+TgkkAWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFgQCTsPGp3vwDYndXR2Qk=t2X9Gqg-82KicoAKLon+TgkkAWg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:56:09PM +0800, Pingfan Liu wrote:
> Then in my case, either no @offset or invalid argument will keep
> "*crash_base = 0", and KASLR does not care about either of them.

Ok.

> It is not elegant. Will try a separate patch to fix it firstly.

That's appreciated, thanks. It is about time that whole kexec/kaslr/...
code gets some much needed cleaning up and streamlining.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
