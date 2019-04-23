Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F922C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C92020685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="h/ObYFov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfDWPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:17:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37506 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfDWPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:17:17 -0400
Received: from zn.tnic (p200300EC2F10CC00CD06C04685BA476A.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:cc00:cd06:c046:85ba:476a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2C861EC0235;
        Tue, 23 Apr 2019 17:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556032635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9NzLcfSHSS/3ogtXynEkRKANWR2hzLUSLxb8iO5GjgM=;
        b=h/ObYFov6jviIy/8ww7p/VbBOhkfr3P9JnYsIK8Lk/fHlY6TrPOL7WP0aFmus7g/8aLvFb
        hb56kalrOqxZo0wI7iE5UW4aP5LRNU1wVWaLSckIaNVc236iIsHUdSnQloOTnjjPDoEXM3
        UpqChh57Il3UpDRx2X4xIqbf6gX0BLg=
Date:   Tue, 23 Apr 2019 17:17:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <cai@lca.pw>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Message-ID: <20190423151708.GB16353@zn.tnic>
References: <20190409040502.55361-1-cai@lca.pw>
 <20190416171104.GI31772@zn.tnic>
 <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
 <20190418074510.GB27160@zn.tnic>
 <20190418095015.GB18646@arrakis.emea.arm.com>
 <20190423132518.GA16353@zn.tnic>
 <20190423140256.GA51985@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423140256.GA51985@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:02:56PM +0100, Catalin Marinas wrote:
> The .bss/.data used to be root until recently when commit 298a32b13208
> ("kmemleak: powerpc: skip scanning holes in the .bss section") changed
> this to accommodate a similar problem on powerpc. With this commit,
> .bss/.data are traced objects but painted "grey" by default so that they
> will be always scanned, pretty much like the root (and they can't
> "leak").

I see.

> In Qian's splat, the unmapped area was actually in the .bss which is now
> a traced object (no longer a root one).

Right, makes sense.

> Object freeing is tracked in general via the corresponding kfree(),
> vfree() etc. and don't need special handling. The .bss doesn't have this
> alloc/free symmetry and not freeing it all either, hence this
> workaround to register it as a traced object and allow partial freeing.
> 
> Anyway, I agree with you. As I mentioned in the previous email,
> kmemleak_free_part() is tolerant to unknown objects (not tracked by
> kmemleak), so I'm fine with calling it from free_init_pages() even if
> not all address ranges passed to this function are known to kmemleak.

Cool.

> I took a note to improve this when I get some time.

Thanks. That would be helpful, I think, for people like me who'd like to
get a short intro on kmemleak in order to understand what is being fixed
when a patch lands in their mbox. :)

> There are probably some academic papers published somewhere ;). But
> wikipedia makes things much easier (and free).

Yap :-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
