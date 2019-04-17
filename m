Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED88FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A131C20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Wo8gp+9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfDQQGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:06:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42588 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732105AbfDQQGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:06:23 -0400
Received: from zn.tnic (p200300EC2F112E0089A16ED5684D695F.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:89a1:6ed5:684d:695f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE39F1EC0235;
        Wed, 17 Apr 2019 18:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555517181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I8yHYlhz3xKw5GFkfxVCm0PJbp1b+m9Syt6c/2syQWw=;
        b=Wo8gp+9A1VkZySocSsLo9kmfAgXeP9LmNkiUUE1CxY+mlN4j6EBp5OIG+WJnG2yssVKDKr
        ibbemnnl/1/INTQhcTUzLjnZmGWeuH28QLfXkALBRkDA1jLG10+BQfUG/PTz07Hh3plx2H
        77x/HsZi6/Up+vjexPbbb/a3r2YmRts=
Date:   Wed, 17 Apr 2019 18:06:18 +0200
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
Message-ID: <20190417160618.GG20492@zn.tnic>
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
 <1554703115-15299-3-git-send-email-kernelfans@gmail.com>
 <20190416190128.GL31772@zn.tnic>
 <CAFgQCTuDVk+Zav0v-WfPmEjmuOW-P+n3x9SmZj54ky-FJ82_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFgQCTuDVk+Zav0v-WfPmEjmuOW-P+n3x9SmZj54ky-FJ82_+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:53:37PM +0800, Pingfan Liu wrote:
> Take __parse_crashkernel()->parse_crashkernel_simple() for example. If
> no offset given, then it still return 0, but crash_base is dangling.

Well, that is bad design. parse_crashkernel_simple() should return a
*separate* distinct value which denotes that @offset hasn't been passed.

Please fix that by having it return 1 or something else positive to
denote that there wasn't an [@offset] given.

And then correct that crap here:

static void __init reserve_crashkernel(void)
{
	...

        ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
        if (ret != 0 || crash_size <= 0) {

where *two*! variables are used as return values from a single function.
That's just sloppy.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
