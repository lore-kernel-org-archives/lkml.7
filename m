Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D9EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428F02082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lpGKhP55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfFLD7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:59:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53932 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfFLD7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:59:15 -0400
Received: from zn.tnic (p200300EC2F0A680098854F45E2A0A47F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:9885:4f45:e2a0:a47f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB9451EC0467;
        Wed, 12 Jun 2019 05:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560311954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ikFC7uLb35HFXWIlG2Hhv6pd2xXTkrLRX2yjuvtuaig=;
        b=lpGKhP550gWmjUJuEPlIap5yRl+eJeeOcbPwdPt42/X9t66YMAGVQu4bewvxYucPPs7pWO
        CgjSoQjFaEOYMG6apm143PaOj1vFaohHZ21oOjY7SAhZuiz2TzFwvoiTdAF6GocurdI8mc
        tyUqOptBgZK/12TPicCJP34IidHM2ME=
Date:   Wed, 12 Jun 2019 05:59:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190612035908.GB32652@zn.tnic>
References: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
 <20190610192026.GI5488@zn.tnic>
 <20190611181920.GC180343@romley-ivt3.sc.intel.com>
 <20190611194701.GJ31772@zn.tnic>
 <20190611222822.GD180343@romley-ivt3.sc.intel.com>
 <3E5A0FA7E9CA944F9D5414FEC6C712209D8F4253@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C712209D8F4253@ORSMSX106.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:29:57AM +0000, Yu, Fenghua wrote:
> My bad. I studied a bit more and found the patch #1 is not needed.

Why, I think you were spot-on:

"And the two variables are ONLY used in resctrl monitoring
configuration. There is no need to store them in cpuinfo_x86 on each
CPU."

That was a real overkill to put them in cpuinfo_x86. The information
needed should simply be read out in rdt_get_mon_l3_config() and that's
it - no need to global values to store them.

Now removing them should be in a separate patch so that review is easy.

Or am I missing an aspect?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
