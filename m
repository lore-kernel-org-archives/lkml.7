Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9A3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE222CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cu92urpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfH2GJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:09:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfH2GJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:09:52 -0400
Received: from zn.tnic (p200300EC2F0D0C00C4AC36401DE27C46.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c00:c4ac:3640:1de2:7c46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 716081EC0B6E;
        Thu, 29 Aug 2019 08:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567058991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jj3hmfHkutQGkUAabd2SGodGbh+Q3mOjtDk+Bx2jxgA=;
        b=cu92urpLpwKFnxncJm4XSu8FXQ3eXvrVWuKHqcJ9FEtVBz6+JvFqHcTe7zRYHLMseQI19z
        9f6eamT7a19dM7nu57xqwEAZ55sWzIExYAxveWd+aJ66vQ9AJ1QaWjHKbleW34F4OLEcof
        QfglIoEvi8mr9UjFagS23991FM1UpsU=
Date:   Thu, 29 Aug 2019 08:09:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190829060942.GA1312@zn.tnic>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:33:22PM -0700, Ashok Raj wrote:
> During microcode development, its often required to test different versions
> of microcode. Intel microcode loader enforces loading only if the revision is
> greater than what is currently loaded on the cpu. Overriding this behavior
> allows us to reuse the same revision during development cycles.
> This facilty also allows us to share debug microcode with development
> partners for getting feedback before microcode release.
> 
> Microcode developers should have other ways to check which
> of their internal version is actually loaded. For e.g. checking a
> temporary MSR for instance. In order to reload the same microcode do as
> shown below.
> 
>  # echo 2 > /sys/devices/system/cpu/microcode/reload
> 
>  as root.
> 
> 
> I tested this on top of the parallel ucode load patch
> 
> https://lore.kernel.org/r/1566506627-16536-2-git-send-email-mihai.carabas@oracle.com/
> 
> v2: [Mihai] Address comments from Boris
> 	- Support for AMD
> 	- add taint flag
> 	- removed global force_ucode_load and parameterized it.

As I've said before, I don't like the churn in this version and how it
turns out. I'll have a look at how to do this cleanly when I get some
free cycles.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
