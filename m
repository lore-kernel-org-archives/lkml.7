Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ABAC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A439E2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="F7NfYjT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLXKEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:04:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39508 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfLXKEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:04:31 -0500
Received: from zn.tnic (p200300EC2F0ED600E4E5C00CE9FEB53D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d600:e4e5:c00c:e9fe:b53d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47AE31EC0273;
        Tue, 24 Dec 2019 11:04:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577181868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lZBp7WJCTDYPOomy6Za4skPEqciE2e9sbtVlgHLZuQw=;
        b=F7NfYjT8T7RuQTVZZX4JYza98gxXNuJUZSmRdHlZ12yiRY3KZJgYpmHVLQEFgOXjwQ5QCy
        1MFaouSTNo2iWf5/mbdUyCgmtdmVAYiNH0Ulj8Ci2/PlEXzNg8dFZvEBKlzjSehTG9UuR6
        3QEBi6606+OQuFC3xIJ5Ft4HG7Fk0eY=
Date:   Tue, 24 Dec 2019 11:04:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/11] x86/paravirt: Adapt assembly for PIE support
Message-ID: <20191224100423.GC21017@zn.tnic>
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191205000957.112719-11-thgarnie@chromium.org>
 <20191223172350.GH16710@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191223172350.GH16710@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 06:23:50PM +0100, Borislav Petkov wrote:
> On Wed, Dec 04, 2019 at 04:09:47PM -0800, Thomas Garnier wrote:
> > If PIE is enabled, switch the paravirt assembly constraints to be
> > compatible. The %c/i constrains generate smaller code so is kept by
> > default.
> > 
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range below 0xffffffff80000000.
> > 
> > Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> > Acked-by: Juergen Gross <jgross@suse.com>
> > ---
> >  arch/x86/include/asm/paravirt_types.h | 32 +++++++++++++++++++++++----
> >  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> More missed feedback:
> 
> https://lkml.kernel.org/r/CAJcbSZG-JhBC9b1JMv1zq2r5uRQipYLtkNjM67sd7=eqy_iOaA@mail.gmail.com

Whoops, it is in the comment above PARAVIRT_CALL_POST. I must've been
blind yesterday. Forget what I said and sorry.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
