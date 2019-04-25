Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB43AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6966F214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RiSE9xoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfDYLAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:00:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58734 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfDYLAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:00:34 -0400
Received: from zn.tnic (p200300EC2F0E430060E979F7C497EAD3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4300:60e9:79f7:c497:ead3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28ECE1EC0104;
        Thu, 25 Apr 2019 13:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556190032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h4vJV92cjPhuBbrkXWH6sxAbEZLDW9YxPad+hPvCa+o=;
        b=RiSE9xoGBNEl7nXdHpiIa74sgTrhS8MxK1dMV6zuutHt4cl3yEo0kKv8CaNQiG7Y+8W6S9
        Pvco5SCiWEkG2sscs+LbPezeuwyfxmtG8vMTcQCWdRktdbhmMp/Dz45S92wgAKiZ+jMCAg
        a+RZ6xLbrKK2H7pXt/kdjIlH9Wz+8gc=
Date:   Thu, 25 Apr 2019 13:00:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
Message-ID: <20190425110025.GA16164@zn.tnic>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
 <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 06:16:02PM +0800, Zhao, Yakui wrote:
> The parameter register for the VMCALL is predefined in ACRN hypervisor. Now
> the R8 is used to pass the hcall_id.
> It seems that there is no special constraint for R8~R15.
> So the explicit register variable is used so that the R8 can be passed.

If you're going to use the constraint "D" for param1, you can just as
well do

	"=a" (result)

everywhere since you have the letter constraint for %rax instead of
declaring it with "register".

Also, you can completely get rid of those "register" declarations
and let gcc have all the freedom to pass in hcall_id and the other
parameters:

	unsigned long result;

        asm volatile("mov %[hcall_id], %%r8\n\t"
                     "vmcall\n\t"
                     : "=a" (result)
                     : [hcall_id] "g" (hcall_id)
                     : "r8");

        return result;

and %r8 will be in the clobber list so gcc will reload it if needed.

gcc turns it into

0000000000001040 <main>:
    1040:       4c 8b 05 e1 2f 00 00    mov    0x2fe1(%rip),%r8        # 4028 <hcall_id>
    1047:       0f 01 c1                vmcall
    104a:       c3                      retq 
    104b:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)

here.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
