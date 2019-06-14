Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A35C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7996020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pFOYERj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfFNNlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:41:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39928 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbfFNNlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:41:31 -0400
Received: from zn.tnic (p200300EC2F097F00E4D2751AE9C0507E.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:e4d2:751a:e9c0:507e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 822AD1EC0AB5;
        Fri, 14 Jun 2019 15:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560519690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Auys9/P6LksSlALNVcV52ZgerChpIr1J7r95Cpk0pk4=;
        b=pFOYERj8I9GdxtHTFMs2BGrF4o8buaB9MzoneK52yhcyigoWgwgs+auItQSRqJq4MTtHfo
        l53KGbGwVgAvzlsfYsKtZHPYQGfXf1GM8rFyNOzSX0zwruALrhWTqCvmCW5QSWqSBe7LsL
        Jgqt+CvfQSvQTLgt4YhIoaPfCBIocCo=
Date:   Fri, 14 Jun 2019 15:41:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614134123.GF2586@zn.tnic>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614131701.GA198207@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Radim and Paolo. See upthread for context.

On Fri, Jun 14, 2019 at 06:17:02AM -0700, Fenghua Yu wrote:
> > Alternatively - and what I think is the better solution - would be to
> > remove those BUILD_BUG_ONs in x86_feature_cpuid and filter out the
> > Linux-defined leafs dynamically. This way the array won't have holes in
> > it.
> 
> Maybe adding a dummy slot in cpuid_leafs in patch 0002 to avoid the
> compilation errors?

Maybe you didn't read what you're replying to: "This way the array
won't have holes in it". Ontop of yours:

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index d78a61408243..03d6f3f7b27c 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -47,6 +47,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
 	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
 	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
+	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
 	[CPUID_8000_0008_EBX] = {0x80000008, 0, CPUID_EBX},
 	[CPUID_6_EAX]         = {         6, 0, CPUID_EAX},
 	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
@@ -59,8 +60,9 @@ static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
 {
 	unsigned x86_leaf = x86_feature / 32;
 
-	BUILD_BUG_ON(x86_leaf >= ARRAY_SIZE(reverse_cpuid));
-	BUILD_BUG_ON(reverse_cpuid[x86_leaf].function == 0);
+	if (x86_leaf == CPUID_LNX_1 ||
+	    x86_leaf == CPUID_LNX_4)
+		return NULL;
 
 	return reverse_cpuid[x86_leaf];
 }

That's what I mean with filter out dynamically.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
