Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD45C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D4D2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HMmIcA1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfD0I6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:58:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfD0I6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:58:21 -0400
Received: from zn.tnic (p200300EC2F1D42004591EACC18991034.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:4200:4591:eacc:1899:1034])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77F561EC027B;
        Sat, 27 Apr 2019 10:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556355500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kqxj+Mb+avwOQkG2QpygoX7fctHS9uCBxZi/TSKRP+M=;
        b=HMmIcA1/wBf8K64aGvoCsy+3a8Ez+f4/9wUVP8diYjy00VTiHdNTFCSCaCQvqmacwgLN/8
        0smEMop76TOlb63HOhdvVAAlcU6BB1Uu0+98PXTBq3bbZ1g32G6Wi/UdODmSnfcdgIYh7q
        La1vB8W0n5qxUFQ2t2cI+fHrOuPiVJY=
Date:   Sat, 27 Apr 2019 10:58:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
Message-ID: <20190427085816.GB12360@zn.tnic>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
 <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
 <20190425110025.GA16164@zn.tnic>
 <473d145c-4bfd-4ec8-34c3-8a26a78fe40d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <473d145c-4bfd-4ec8-34c3-8a26a78fe40d@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:18:48AM +0800, Zhao, Yakui wrote:
> It seems that it is seldom used in kernel although the explicit register
> variable is supported by GCC and makes the code look simpler. And it seems
> that the explicit register variable is not suppoorted by CLAG.

The more reason not to do it this way. Also, the "register" variable
specification is not very widespread in x86 when you look at

$ git grep -E "register\s.*asm" arch/x86/

output.

> So the explicit register variable will be removed. I will follow the asm
> code from Borislav. Of course one minor change is that the "movq" is used
> instead of "mov".

Does that matter if your destination register is 64-bit?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
