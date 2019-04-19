Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2B3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AAF205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LS4wGnop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfDSSoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:44:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfDSSoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:44:02 -0400
Received: from zn.tnic (p200300EC2F112E006C6C37C052F44BC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:6c6c:37c0:52f4:4bc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A6331EC0AD6;
        Fri, 19 Apr 2019 13:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555673782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Qul4HOAW88aQlnLst2WoypFmSDlJii/hQ15ovrRmTvk=;
        b=LS4wGnopQSSwfSsm/MPJpIJeR8xC2XwXS9JVTIhF8me4Fbvnm4RREplHb8NEyRrvq6esqs
        6EF1fY+oV5kmChvTsIFATSiqr5dbyco79n1uIiwIWrj7j+UNSjnIXvU5xcpPq5zu2JIaZD
        VJAIuG3QHa6Ztal8PMInWmJPc5+YfIE=
Date:   Fri, 19 Apr 2019 13:36:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419113621.GD10324@zn.tnic>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <20190419112801.GB10324@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419112801.GB10324@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 01:28:01PM +0200, Borislav Petkov wrote:
> Read again what I said: "should all be passed through boot_params".
> Which means, boot_params should be extended with a field of a flag to
> say: "this is a kexec'ed kernel".

And by that I mean similar to the XLF_EFI_KEXEC mechanism. The first
kernel or kexec(1) should prepare the info needed by the kexec'ed
kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
