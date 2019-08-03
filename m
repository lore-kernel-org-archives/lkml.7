Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B878C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4EA2166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 09:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sbb11uLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbfHCJob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 05:44:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37218 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388147AbfHCJob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 05:44:31 -0400
Received: from zn.tnic (p200300EC2F2082007166E282E47B3C81.dip0.t-ipconnect.de [IPv6:2003:ec:2f20:8200:7166:e282:e47b:3c81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6725E1EC04CD;
        Sat,  3 Aug 2019 11:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564825469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q8Fv9xgkEaQfyQKWs3/3wqI65VtLqsRNLIS2J1EpyAA=;
        b=Sbb11uLUeM0gHZVUfVdd4kIL3hRYhAvevdXNTkf5SegfdlIx6D6MgWPhC4d/xwKuc4Dpm5
        QnLkKp64BQA4QTugrZ9QCWG5me8/1f4SWU6lxbu8X2FMqL/h4ngxZVXWBQeXhB51tN8uV3
        1syMmh1BxEac0mmqLRXU1Z67kr4yITU=
Date:   Sat, 3 Aug 2019 11:44:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190803094423.GA2100@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
 <20190802180352.GE30661@zn.tnic>
 <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 01:11:13PM -0700, Reinette Chatre wrote:
> Will do. Do you prefer a new prepare patch that does the renaming before
> this patch or will you be ok with the renaming done within this patch?

Nah, within this patch is ok.

> This patch only makes it possible to determine whether cache is
> inclusive for some x86 platforms while all platforms of all
> architectures are given visibility into this new "inclusive" cache
> information field within the global "struct cacheinfo".

And this begs the question: do the other architectures even need that
thing exposed? As it is now, this is x86-only so I'm wondering whether
adding all that machinery to the generic struct cacheinfo is even needed
at this point.

TBH, I'd do it differently: read CPUID at init time and cache the
information whether the cache is inclusive locally and be done with it.
It is going to be a single system-wide bit anyway as I'd strongly assume
cache settings like inclusivity should be the same across the whole
system.

When the other arches do need it, we can extract that info "up" into the
generic layer.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
