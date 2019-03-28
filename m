Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4023C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FC62075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TSPB1kbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfC1N2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:28:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfC1N2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:28:54 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B38C91EC0943;
        Thu, 28 Mar 2019 14:28:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553779733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q1dDKiskd4sNuzhYNCvSo4ITVCLrOSFr+QG8h/3HY4c=;
        b=TSPB1kbvHsN57wjNOhVZsrUsMWKprEXzQSsctI0Bh1Ch9N/8J5aBtxSf62OZ95l4EMzCY2
        OGUsHPQ8EalYgMum6gOLTffKK+/B1qRS0w7OLNCuZunZp+eE60a97DvYbGLl4O9ZiZ35YM
        P2FL4F8r8QiY9noNt91JVzkSmfvQu4s=
Date:   Thu, 28 Mar 2019 14:28:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] x86/boot: Introduce helpers for serial I/O
Message-ID: <20190328132855.GH22720@zn.tnic>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-3-andriy.shevchenko@linux.intel.com>
 <20190328123250.GE22720@zn.tnic>
 <20190328131140.GX9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328131140.GX9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:11:40PM +0200, Andy Shevchenko wrote:
> Any idea how it can be done?

Like this?

static u8 serial_inb(unsigned long addr, int offset)
{
	if (early_serial_do_mmio) {
		asm volatile("movb %1,%0" : "=q" (v) : "m" (*(volatile u8 __force *)addr));

		return v;
	} else {
		 return inb(addr + offset);
	}
}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
