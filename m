Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C236C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D0D217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="r9rHG6Rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFNRrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:47:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfFNRrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:47:11 -0400
Received: from zn.tnic (p200300EC2F097F008D9D08C27DC27982.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:8d9d:8c2:7dc2:7982])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BACAF1EC0B6E;
        Fri, 14 Jun 2019 19:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560534428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ny5uXi+D11x4wg4N9BTzzGjOf7IycKTwhq86Tx30fY8=;
        b=r9rHG6RnU2klpKMIz9pSnPWufgUg1LYMd918w5p60zh5iCKLpgp/Bj6/qdq9gGZ6/BukA2
        vIbNl1S6CcJ6oOh3UomW7UCKJaOgFTL2F6A7JVyXZqwrOQ95Oxcd2Jd6HhQpX69tn9gEA6
        ArILW7FIta9egK6mn1Ge4KC3mT4/Pvw=
Date:   Fri, 14 Jun 2019 19:47:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190614174701.GN2586@zn.tnic>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-2-git-send-email-fenghua.yu@intel.com>
 <20190614111633.GC2586@zn.tnic>
 <20190614165528.GE198207@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614165528.GE198207@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 09:55:28AM -0700, Fenghua Yu wrote:
> When this function is called, X86_FEATURE_CQM_LLC must be supported and
> one of X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_LOCAL, and
> X86_FEATURE_CQM_MBM_TOTAL must be supported. Otherwise,
> get_rdt_mon_resource() is returned before calling rdt_get_mon_l3_config().
> 
> So CPUID.f.0 and CPUID.f.1 must be readable and return meaningful
> data without testing the features.

How's that?

static void __init get_cqm_info(struct rdt_resource *r)
{
        u32 eax, ebx, ecx, edx;

        /*
         * At this point, CQM LLC and one of occupancy, MBM total, and
         * MBM local monitoring features must be supported.
         */
        cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);

        if (rdt_mon_features & QOS_L3_OCCUP_EVENT_ID)
                r->num_rmid = ecx + 1;
        else
                /*
                 * Fallback maximum range (zero-based) of RMID within
                 * this physical processor of all types, in subleaf 0,
                 * EBX.
                 */
                r->num_rmid = cpuid_ebx(0xf) + 1;

        if (rdt_mon_features & (QOS_L3_MBM_TOTAL_EVENT_ID |
                                QOS_L3_MBM_LOCAL_EVENT_ID))
                r->mon_scale = ebx;
	else
                r->mon_scale = -1;
}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
