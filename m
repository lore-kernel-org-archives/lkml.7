Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA73C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB0620883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iiSpo5lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfDBMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:43:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbfDBMne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:43:34 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0533C1EC0229;
        Tue,  2 Apr 2019 14:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554209013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lKkbKw9UxcpsB6ntLb62JCOqic9DRcqu7xtvqq+c1T0=;
        b=iiSpo5lfHI9mhIh4eSTSeCmYgluzSKmazpUdxxP5pLs4gvr9VqNol6Pb/kWcVoyNIWPl1f
        eHvJmDRNEmFHd26qiSeKJDZzy5zKHfOI3GQggbBvUS67bFz8OWWew5OJwEoovbl0RRQwqW
        iz6VGfQEw8qKz5c6IPIS4M329HhutDA=
Date:   Tue, 2 Apr 2019 14:43:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190402124328.GG6826@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
 <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:02:04PM +0800, lijiang wrote:
> These regions(E820_TYPE_{RESERVED_KERN,RAM,UNUSABLE}) are still marked as
> IORES_DESC_NONE and should not be mapped encrypted when using ioremap().

Seems to me like we're going in circles. You said here:

https://lkml.kernel.org/r/9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com

that the kernel doesn't pass the e820 reserved ranges to the second
kernel.

I suggested to use a special IORES descriptor for them -
IORES_DES_RESERVED.

Now you say that that is not enough and some of those you want passed,
are still marked as IORES_DESC_NONE.

Sounds to me like you need try again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
