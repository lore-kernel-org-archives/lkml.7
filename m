Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D34C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D3F206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FRIop9xV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfCEJTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:19:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCEJTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:19:04 -0500
Received: from zn.tnic (p200300EC2BCD6B00647FB0CB76B3F976.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:6b00:647f:b0cb:76b3:f976])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94AC21EC05DE;
        Tue,  5 Mar 2019 10:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551777542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yrBNuRiFJ/dcOxYhLM9Q6U4D3zQpUu5gq8sNNzfnbac=;
        b=FRIop9xVyWlnKoejKsnB2B8PlZZ6qC66VHgQyjOQPsWt2J3Eyl0AZrpmS7KWJi5nzFMKg4
        1oh2niRuuAPuJT86i+lvbZ4eWcFZqKG7bTdPuxYejmDzHxYnGBp+rUvYJeeJaT5VDU0Czm
        VObminnxRbdU+kPXLz4XE85HJr43pOM=
Date:   Tue, 5 Mar 2019 10:19:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: a.out coredumping: fix or delete?
Message-ID: <20190305091904.GB8256@zn.tnic>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 12:57:30AM +0100, Jann Horn wrote:
> In theory, Linux can dump cores for a.out binaries. In practice, that
> code is pretty bitrotten and buggy. Does anyone want that code so much
> that they'd like to fix it, or can we just delete it?

I was asking myself the same question while doing

  10970e1b4be9 ("x86/a.out: Clear the dump structure initially")

especially since it is kinda hard to get the toolchain to even create an
a.out executable - your script to create one case-in-point.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
