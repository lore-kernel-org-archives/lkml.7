Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C515220684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MQSVghb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfDPU7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:59:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34044 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfDPU7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:59:35 -0400
Received: from zn.tnic (p200300EC2F0D69000C2D4197130645E8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:c2d:4197:1306:45e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37E041EC05B8;
        Tue, 16 Apr 2019 22:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555448374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lJ14NnVJGkxm2WIFgxITzQaVRUUkoWzgo4rzlB2szOU=;
        b=MQSVghb0YbFqaTQ3LpGm9cfm0Jvs1/X+kekhUTw9kUkO2o23DC94m51OCE8H2O4gu6n5ll
        2UcIpTxs5viEF34Aujx18PBF76NCBGpBRRoOMrNFKvWFM1PJcmLnOYfYLNxhB7I4o0z+Pt
        8eZ64m9aLBX/D1BmIhx0ck+ei8McYTg=
Date:   Tue, 16 Apr 2019 22:59:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH 2/2] x86/resctrl: Initialize new resource group with
 default MBA values
Message-ID: <20190416205926.GO31772@zn.tnic>
References: <1554839728-5544-1-git-send-email-xiaochen.shen@intel.com>
 <20190415113405.GC29317@zn.tnic>
 <9e99ed5f-d60a-717c-9322-c6f0b8090d6b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e99ed5f-d60a-717c-9322-c6f0b8090d6b@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:51:18AM +0800, Xiaochen Shen wrote:
> In this patch we initialize MBA resource and cache resources in separate
> functions rdtgroup_init_cat() and rdtgroup_init_mba(). If
> __init_one_rdt_domain() is only called by rdtgroup_init_cat(), how about
> using function name "__init_one_rdt_domain_cat()"?

I guess but be conservative when adding too many words to a function's
name - that might get heavy when reading the code later.

For example, there's an argument to not suffix it with "_cat": it is
only called by rdtgroup_init_cat() - rdtgroup_init_mba() will not call
it - so the path will remain unique anyway...

Anyway, something to think about - I personally don't have a strong
preference here.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
