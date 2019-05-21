Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6517C18E7C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792C42183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bab7/Ako"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfEUU2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:28:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfEUU2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:28:33 -0400
Received: from cz.tnic (unknown [165.204.77.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB3441EC0513;
        Tue, 21 May 2019 22:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558470511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nWtU54S/AlDT7qsEIiPBtbUXaUC/TQ5AZRXgMuRXRY0=;
        b=bab7/AkoSjJQEgR3rABmbMdDtzPvBurqhLi2+Tc0eUhxqIwlT4oE8T2WsndzhrrnTJ/+kI
        wVQaC7zAdmWBgt8D5hf6EJK4PbBWKAfqnX1QNZIfiwapmuIu8Hd+fACXZw/5KcR7d26BcG
        eJYxuh7AKx/93AEX+xH5GpNZy0VzSiU=
Date:   Tue, 21 May 2019 22:29:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 4/6] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190521202902.GC7793@cz.tnic>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-5-Yazen.Ghannam@amd.com>
 <20190518112530.GA26276@zn.tnic>
 <SN6PR12MB2639571E33EBC7342A0607F8F8070@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639571E33EBC7342A0607F8F8070@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 05:52:42PM +0000, Ghannam, Yazen wrote:
> This message comes from ___might_sleep() which checks the
> system_state.
>
> On CPU0, system_state=SYSTEM_BOOTING.
>
> On every other CPU, system_state=SYSTEM_SCHEDULING, and that's the
> only system_state where the message is shown.

Right, the check in ___might_sleep().

> Changing GFP_KERNEL to GFP_ATOMIC seems to be a fix. Is this
> appropriate? Or do you think there's something else we could try?

From: Documentation/core-api/memory-allocation.rst

  * If you think that accessing memory reserves is justified and the kernel
    will be stressed unless allocation succeeds, you may use ``GFP_ATOMIC``.


I don't think the MCA banks representation justifies accessing memory
reserves.

Can we do instead:

-static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank *, mce_banks_array);
+static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank, mce_banks_array[MAX_NR_BANKS]);

which should be something like 9*32 = 288 bytes per CPU.

Unless you have a better idea...

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
