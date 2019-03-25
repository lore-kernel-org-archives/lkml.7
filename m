Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3820FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC5E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="I/aup73m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfCYG5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:57:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbfCYG5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:57:31 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1ACB51EC02AE;
        Mon, 25 Mar 2019 07:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553497050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4wRxjA7GSTQW4GlR0c5nCg9HhQqSZHhaDWN+Jbcsa7s=;
        b=I/aup73msPi+FWxB7oML2Qx9P7iBMaosvxMqpm6cdnobj+OIp9mI1ZwM8gGJHtKDSb7xJg
        ja5gbNcQUreiosV217PhjkRY8ihpSQffDcbzkK+dEyh1h/dKG358xTDYTKLuk2Ept1j4o8
        JxoVT+ogg9OPkXUejOBZKT9yUK96LaY=
Date:   Mon, 25 Mar 2019 07:57:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, mchehab@kernel.org,
        devicetree@vger.kernel.org, sachin.ghadi@sifive.com
Subject: Re: [PATCH 2/2] edac: sifive: Add EDAC driver for SiFive FU540-C000
 chip
Message-ID: <20190325065737.GD12016@zn.tnic>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
 <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
 <alpine.DEB.2.21.9999.1903241558210.8028@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1903241558210.8028@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 05:23:27PM -0700, Paul Walmsley wrote:
> > +	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
> > +		return;
> 
> Can all of these debugfs functions be wrapped with an #if ... #endif such 
> that, if CONFIG_EDAC_DEBUG is not set, they will all be stripped out by 
> the preprocessor?

Why would you make the code more ugly with ifdeffery?

Do you have any serious code size constraints so that you absolutely
need to remove a couple of KBs?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
