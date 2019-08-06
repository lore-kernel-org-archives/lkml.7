Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F1C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F671205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Am+wv+jK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfHFTPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:15:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38860 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfHFTPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:15:19 -0400
Received: from zn.tnic (p200300EC2F1369001D2C1334F0CDB20E.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:6900:1d2c:1334:f0cd:b20e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C3AF1EC0C2D;
        Tue,  6 Aug 2019 21:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565118917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=owCwnCpecQSbs/caqA2za7Vs9k9ECThgdFTeVkAl78A=;
        b=Am+wv+jKXZyDH2QYk8i0rbC0iZrXQ5dx4eT5IG6Wupe9Qx9hNgntVLcfhDmR5Ie12QodOL
        Tuko+hxNGgL40s5NFr//n37X7Rya+nuy+JTitghGRj9ynyZH4sfWgP0DSWyuqTEhqbWZ32
        htbNdtKLCjDoACac+6TKaQQ8G45XwHM=
Date:   Tue, 6 Aug 2019 21:16:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190806191559.GB4698@zn.tnic>
References: <20190802180352.GE30661@zn.tnic>
 <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
 <20190803094423.GA2100@zn.tnic>
 <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
 <20190806155716.GE25897@zn.tnic>
 <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
 <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
 <20190806183333.GA4698@zn.tnic>
 <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:53:40AM -0700, Reinette Chatre wrote:
> In get_prefetch_disable_bits() the platforms that support cache
> pseudo-locking are hardcoded as part of configuring the hardware
> prefetch disable bits to use.

Ok, so there is already a way to check pseudo-locking support. Now, why
do we have to look at cache inclusivity too?

Your 0/10 mail says:

"Only systems with L3 inclusive cache is supported at this time because
if the L3 cache is not inclusive then pseudo-locked memory within the L3
cache would be evicted when migrated to L2."

but then a couple of mails earlier you said:

"... this seems to be different between L2 and L3. On the Atom systems
where L2 pseudo-locking works well the L2 cache is not inclusive. We are
also working on supporting cache pseudo-locking on L3 cache that is not
inclusive."

which leads me to still think that we don't really need L3 cache
inclusivity and theoretically, you could do without it.

Or are you saying that cache pseudo-locking on non-inclusive L3 is not
supported yet so no need to enable it yet?

Hmmm?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
