Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB764C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C422218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bffld3oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfCWI7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 04:59:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56680 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfCWI73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 04:59:29 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE2EE1EC00FF;
        Sat, 23 Mar 2019 09:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553331567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fv/Gc6KFftce6AQ0F5UIVNtAfNvWMEqV8X/90dTF/jg=;
        b=bffld3oaARaEx1vr/kidG4jjUVCLj6OPycAzT5OM5C3CFDjECo/I9U2RAHzAY/+CnXOsYy
        2iusge4eJnI6bv8bH5UUn/t0+HjC4N2OzxKNAknUzRKFFqc91C1DUnL0UaTMcoEaPq0tpt
        C/v8jKk8FsgnCitOoD5ARxr/DKP3FC8=
Date:   Sat, 23 Mar 2019 09:59:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/cpu/hygon: Fix phys_proc_id calculation logic
 for multi-die processor
Message-ID: <20190323085934.GB23698@zn.tnic>
References: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
 <20190322155449.GE12472@zn.tnic>
 <639a5bc6-f821-ee9d-1594-d02701321192@hygon.cn>
 <20190322171632.GI12472@zn.tnic>
 <18e15073-81c2-73a3-abf1-e785d6a5649b@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18e15073-81c2-73a3-abf1-e785d6a5649b@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:13:39AM +0800, Pu Wen wrote:
> Current physical id is computed via "phys_proc_id = initial_apicid >>
> bits". 
> 
> For 4-Die 2 socket system, the physical id of socket 2 is:
> initial_apicid >> bits = 0b1xxxxxx >> 6 = 1.
> The result is true.
> 
> But for 2-Die 2 socket system, the physical id of socket 2 is:
> initial_apicid >> bits = 0b10xxxxx >> 5 = 2,
> and for 1-Die 2 socket system, the physical id of socket 2 is:
> initial_apicid >> bits = 0b100xxxx >> 4 = 4.
> The results are not correct any more.
> 
> So the adjustment for the 1-Die/2-Die 2 socket system is needed.
> And just use ApicId[6], which already defined the right thing, as the
> socket ID.

I understand all that. But let me repeat my question:

So why do you need to do something different than what AMD does?

You said you're programming the initial APIC ID the same as AMD. So why
doesn't this need to be changed in AMD code too but only for hygon?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
