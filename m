Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB314C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 14:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13EF206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 14:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XCVBsyzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKPOYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 09:24:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59528 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfKPOYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 09:24:18 -0500
Received: from zn.tnic (p200300EC2F1E69009CF23ABF0AA6C103.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:6900:9cf2:3abf:aa6:c103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D40991EC0C5C;
        Sat, 16 Nov 2019 15:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573914257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mVHxODPQpxGa+buj2UWjBl+JSGZIf7irvuA/EnFq9zM=;
        b=XCVBsyzX7X5lK77Hyqm92qJVAs3AqabuY6Y9oC9Rj3ta1xbQ4wR5j0O0Cv2fk+myzOu+M4
        l3aMoIo70TmXXElpEsV/iq63zr3jsL40FtkMU8tQJXrXwVnW6Tg1Z5hFzCMst+kXPtc10k
        Rl2coDD/oKKMfGcrByfsRNB7533hO/0=
Date:   Sat, 16 Nov 2019 15:24:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/pti] x86/speculation: Fix redundant MDS mitigation
 message
Message-ID: <20191116142411.GA23231@zn.tnic>
References: <20191115161445.30809-3-longman@redhat.com>
 <157390711921.12247.3084878540998345444.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157390711921.12247.3084878540998345444.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 12:25:19PM -0000, tip-bot2 for Waiman Long wrote:
> +static void __init mds_print_mitigation(void)
> +{
>  	pr_info("%s\n", mds_strings[mds_mitigation]);
>  }

Almost. This causes

MDS: Vulnerable

to be printed on an in-order 32-bit Atom here, which is wrong. I've
fixed it up to:

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cb2fbd93ef4d..8bf64899f56a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -256,6 +256,9 @@ static void __init mds_select_mitigation(void)
 
 static void __init mds_print_mitigation(void)
 {
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
+		return;
+
 	pr_info("%s\n", mds_strings[mds_mitigation]);
 }
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
