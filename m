Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2DAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CBD222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="o3sRL7Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfIZOJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:09:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfIZOJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:09:37 -0400
Received: from zn.tnic (p200300EC2F0C9800AD9F87A1CF14B2BF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9800:ad9f:87a1:cf14:b2bf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDBF81EC064F;
        Thu, 26 Sep 2019 16:09:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569506976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0x1L+mtUKfNF+MbQXnQ84f4FJRp3i2cGFR/A3i416MY=;
        b=o3sRL7PfeyiYU1eWE9AgnPjR5KQl9uGF1WjQlvvkv7l49ga89XVNvMPy7A/2l+1WX6i1kH
        5TtrldV7UNoF+2yD+Py3z7IwM37MrD3kFblRAq98vimkA9Btf5rZbI9aM48eNYXgcfVhro
        sWdrd0Zbz0BqQCBVNJXnxsveMO9z+LM=
Date:   Thu, 26 Sep 2019 16:09:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arthur Gautier <baloo@gandi.net>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20190926140939.GD18383@zn.tnic>
References: <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
 <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
 <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany>
 <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
 <20190218215150.xklqbfckwmbtdm3t@khany>
 <20190926095825.zkdpya55yjusvv4g@khany>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926095825.zkdpya55yjusvv4g@khany>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 09:58:25AM +0000, Arthur Gautier wrote:
> I think Andy submitted a patch Feb 25 2019, but I was not copied on it
> (I believe it was sent to x86@kernel.org) and I don't know which fate it
> had.

I guess we're still waiting for Andy to do v2 with feedback incorporated
and proper commit message. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
