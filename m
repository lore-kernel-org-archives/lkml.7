Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86AF2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sl6Gqtc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfFTQjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:39:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37176 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732272AbfFTQjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:39:05 -0400
Received: from zn.tnic (p200300EC2F07DE00C82F01C813A74C20.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:de00:c82f:1c8:13a7:4c20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFEAF1EC09A3;
        Thu, 20 Jun 2019 18:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1561048744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhzN/904+DissAXfAPIPmhA/Mh2DITjAUhB/4TMIhDo=;
        b=Sl6Gqtc/DbQNz3Ib/nch+fSewV0P17RpQqqP2iYeBI3OuYAPnE3ygT+kiyjy8QaJ0xezVu
        2KLJr4dVRmlwn/lYy2XCPTIL6MmMXrS7gkBa3BaNE9jzW+4mmWrGeIT5vdcB/iZv6Dx/2W
        HG45Q8D69UI0WvCg5tKGFfSkGPL99Pk=
Date:   Thu, 20 Jun 2019 18:39:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tiezhu Yang <kernelpatch@126.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com
Subject: Re: [PATCH] kexec: fix warnig of crash_zero_bytes in crash.c
Message-ID: <20190620163900.GF28032@zn.tnic>
References: <fa5d08.1fe.16b5848e5f7.Coremail.kernelpatch@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa5d08.1fe.16b5848e5f7.Coremail.kernelpatch@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 07:18:20AM +0800, Tiezhu Yang wrote:
> This patch fixes the following sparse warning:

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> arch/x86/kernel/crash.c:59:15:
> warning: symbol 'crash_zero_bytes' was not declared. Should it be static?
> 
> In addition, crash_zero_bytes is used when CONFIG_KEXEC_FILE is
> set, so make it only available under CONFIG_KEXEC_FILE. Otherwise,
> if CONFIG_KEXEC_FILE is not set, the following warning will appear:
> 
> arch/x86/kernel/crash.c:59:22:
> warning: ‘crash_zero_bytes’ defined but not used [-Wunused-variable]

That happens only when you make it static, so please state that in the
commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
