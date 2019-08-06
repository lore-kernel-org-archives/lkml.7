Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED6C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4E2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="diAo47i3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbfHFRdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:33:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52028 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732766AbfHFRdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:33:07 -0400
Received: from zn.tnic (p200300EC2F0DA000B4A7A08B15BB062F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a000:b4a7:a08b:15bb:62f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C2551EC0503;
        Tue,  6 Aug 2019 19:33:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565112785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FKZI2PcBJJFaT1IedoSFeF9nyvnxtJDYz+LJDsDLETI=;
        b=diAo47i3aYgYZacnO/XMTk+hGRNE5E4/oWfjLv2N4/UeMHpUR7UvvwGLBW8oyrJazkOUXL
        pIrDG6Fs8otJ+/inmai0n7uz+EOjwhQffWZaZ4dNn8yAa6qQvbc9INHFH3fMEwWN9/xdFw
        PJeqgc4IyYlj7rfrR1wT3dsnIxD2N0o=
Date:   Tue, 6 Aug 2019 19:33:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190806173300.GF25897@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
 <20190802180352.GE30661@zn.tnic>
 <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
 <20190803094423.GA2100@zn.tnic>
 <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
 <20190806155716.GE25897@zn.tnic>
 <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:55:56AM -0700, Reinette Chatre wrote:
> I am a bit cautious about this. When I started this work I initially
> added a helper function to resctrl that calls CPUID to determine if the
> cache is inclusive. At that time I became aware of a discussion
> motivating against scattered CPUID calls and motivating for one instance
> of CPUID information:
> http://lkml.kernel.org/r/alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de

Ah, there's that. That's still somewhat a work/discussion in progress
thing. Let me discuss it with tglx.

> To answer your question about checking any cache: this seems to be

I meant the CPUID on any CPU and thus any cache - i.e., all L3s on the
system should be inclusive and identical in that respect. Can't work
otherwise, I'd strongly presume.

> different between L2 and L3. On the Atom systems where L2 pseudo-locking
> works well the L2 cache is not inclusive. We are also working on
> supporting cache pseudo-locking on L3 cache that is not inclusive.

Hmm, so why are you enforcing the inclusivity now:

+       if (p->r->cache_level == 3 &&
+           !get_cache_inclusive(plr->cpu, p->r->cache_level)) {
+               rdt_last_cmd_puts("L3 cache not inclusive\n");

but then will remove this requirement in the future? Why are we even
looking at cache inclusivity then and not make pseudo-locking work
regardless of that cache property?

Because if we're going to go and model this cache inclusivity property
properly in struct cpuinfo_x86 or struct cacheinfo or wherever, and do
that for all cache levels because apparently we're going to need that;
but then later it turns out we won't need it after all, why are we even
bothering?

Or am I missing some aspect?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
