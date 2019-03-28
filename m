Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF76BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F76A21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KRP9ll8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfC1Mct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:32:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47920 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfC1Mct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:32:49 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E852E1EC038F;
        Thu, 28 Mar 2019 13:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553776368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JTo61gNlf8l5cOY7dzYuVxstA0tiA3GMagLMAOjDo5I=;
        b=KRP9ll8yXxdgNf1ZZDaeJwzuU8CPJ5xaqs7BWdMLEvI77gIaYx3bOL9En4chZRe2hNjE+7
        uiY6vQlrhKwTJXCGwKesQal1Z/pqSleuDHoxBDUHLlhq3fO2rA8ItZhuQkLBKXdhGa1nmd
        xVIMIRmTwhxmzd3U6z9uUxz+VVhJxtU=
Date:   Thu, 28 Mar 2019 13:32:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] x86/boot: Introduce helpers for serial I/O
Message-ID: <20190328123250.GE22720@zn.tnic>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319184325.72807-3-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:43:20PM +0300, Andy Shevchenko wrote:
> As preparatory to enable earlyprintk on non-standard ports on x86,
> introduce serial_in() and serial_out() helpers to perform serial I/O.
> 
> No functional change intended.

...

> +/* Assign serial I/O accessors */
> +static void early_serial_use_io_accessors(void)
> +{
> +	/* These will always be IO based ports */
> +	serial_in = io_serial_in;
> +	serial_out = io_serial_out;
> +}

This and the early_serial_use_mmio_accessors() in a later patch is just
silly because you need to export and forward-declare those serial_in and
serial_out function pointers in a bunch of places.

Just define exactly *two* simple functions serial_in() and serial_out()
which have enough logic to decide whether to do serial IO or MMIO and
put all that logic in those functions. No need for all that function
pointer assignment "fun".

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
