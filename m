Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F159CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B867F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SgNJtyKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfCVRvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:51:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42142 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfCVRvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:51:12 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECACC1EC0AD6;
        Fri, 22 Mar 2019 18:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553277071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+Zc4iEX42Wgi+oE7pga3td7LN4fnuyUi77Ol0cNI2qs=;
        b=SgNJtyKq6WuTw09wR85V4ALhzBrRZ8XZynuczmwIdW8FnRI1CGDPewSXbkyAStxL3lnkcb
        s6k9ayiUz8Ad9zVwusHpULU0em/3c+VYGWEawX8hwTWgV+ZHcGMKdDnoKEqdeb4cY2yBf1
        hfN4j3xTVJZvy+Ip7CMsnLqcgIy1DRg=
Date:   Fri, 22 Mar 2019 18:51:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
Message-ID: <20190322175114.GL12472@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321103309.27883-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 06:33:07PM +0800, Lianbo Jiang wrote:
> Following the commit <0e4c12b45aa8> ("x86/mm, resource: Use
> PAGE_KERNEL protection for ioremap of memory pages"),

The proper commit quotation format is done by adding this to your
.gitconfig:

[core]
        abbrev = 12
[alias]
        one = show -s --pretty='format:%h (\"%s\")'

and then doing:

$ git one <commit id>

which will give you

0e4c12b45aa8 ("x86/mm, resource: Use PAGE_KERNEL protection for ioremap of memory pages")

> here it is really checking for the 'IORES_DESC_ACPI_*' values.

Well, it is not really checking that.

> Therefore, it is necessary to change the examination condition
> to avoid confusion.

What confusion?

The justification for that change sounds really fishy.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
