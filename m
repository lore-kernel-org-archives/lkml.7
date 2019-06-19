Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CAFC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EEC217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="A0yKsaRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfFSRBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:01:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFSRBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:01:37 -0400
Received: from zn.tnic (p200300EC2F109900E125872A2998079C.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:9900:e125:872a:2998:79c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 127441EC066F;
        Wed, 19 Jun 2019 19:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560963696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L6j4/IOrFDpSzrtIdlaNvKNfpxp/c7Xol/Qi84PXfZQ=;
        b=A0yKsaRUrrCvvTKfaUHD4ytyrCi+tYgm4s+FQySXfUkG/GB33zqrZ65N3GIDsd9wEthAJY
        OGElbmrsWukLQbnIHZ8PRyNdBYNX/gTzGKpHRdPAO3W8H5ef7MYmOvtkgCQbn+DHuM0Ynx
        bPavgaWKndYyMX3JIQ4rbA/9gvstdhw=
Date:   Wed, 19 Jun 2019 19:01:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Qian Cai <cai@lca.pw>, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cacheinfo: fix a -Wtype-limits warning
Message-ID: <20190619170127.GF9574@zn.tnic>
References: <1559763654-5155-1-git-send-email-cai@lca.pw>
 <20190605200703.GD26328@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605200703.GD26328@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:07:04PM -0700, Sean Christopherson wrote:
> Might be worth calling out in the changelog that 'c->x86 == 0x17' is true
> if and only if c->x86_model was explicitly set by cpu_detect(), i.e. the
> patch is correct even if the original intent was a misguided attempt to
> check that x86_model has been set.

Are you thinking about some sick virt scenario where base CPUID level is < 1?

In this particular case, there's a guard at the beginning of
cacheinfo_amd_init_llc_id():

        if (!cpuid_edx(0x80000006))
                return;

but if there's CPUs which have CPUID 0x80000006 but base CPUID level is
< 1, then that's their problem.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
