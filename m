Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB1120721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RjBRNAol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgAISlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:41:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbgAISlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:41:04 -0500
Received: from zn.tnic (p200300EC2F0C57006CF2F48412A1B0A5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5700:6cf2:f484:12a1:b0a5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 16FA01EC0CAD;
        Thu,  9 Jan 2020 19:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578595263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/Da1LXmG9Rom+rkwYXrTYiveOt2VrOuzw0dbtS2GOg=;
        b=RjBRNAolBnbfMVsEV6l7vUZmtVVo1RWuN4mpvm3TK+0WiSDK19Xx7v7I8HpHy0835TdMd9
        Q4eo/jWm7/siRKDxooCMa1Dl2Mb9jYZYgUGXMs0fKPezFaoaWBxfHKqyRO4JMxSLMXPtox
        rm51YBzTyGnITh7+om1awxussrhY63s=
Date:   Thu, 9 Jan 2020 19:40:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20200109184055.GI5603@zn.tnic>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:39:29AM +0800, Zhenzhong Duan wrote:
> Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
> CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
> If any of the two macros is undefined, below warning triggers during
> build, fix it by moving 'i' in the guard.
> 
> arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable ‘i’ [-Wunused-variable]

How do you trigger this?

I have:

$  grep -E "(CONFIG_MEMORY_HOTREMOVE|CONFIG_ACPI)" .config
# CONFIG_ACPI is not set

but no warning. Neither with gcc 8 nor with gcc 9.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
