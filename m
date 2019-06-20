Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA22DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849B72064A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bERY2+/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbfFTQ3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:29:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfFTQ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:29:37 -0400
Received: from zn.tnic (p200300EC2F07DE00C82F01C813A74C20.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:de00:c82f:1c8:13a7:4c20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB0981EC046E;
        Thu, 20 Jun 2019 18:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1561048176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/5ZkYhVm0/Rrq/jZTK7MzkxlXcLjZuKLc+a1YaxvTrE=;
        b=bERY2+/foRdt3LAVDZ5Bn2hqRaSSL1uQ88ngMZx5vJKi2HGYA4ozXfpsjezM3cwt0KYulw
        O8U8uwyqNzftEBu0yc9ElPN8lMoJogwIvczV1g0jAcew8N3vNeHu3GYniaLgubGBQWtkzy
        qI14k2UquMN3JpBv+whXn4xvooYdyvk=
Date:   Thu, 20 Jun 2019 18:29:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v2 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Message-ID: <20190620162927.GE28032@zn.tnic>
References: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 08:37:05AM +0000, Tony W Wang-oc wrote:
> Add x86 architecture support for new Zhaoxin processors.
> Carve out initialization code needed by Zhaoxin processors into
> a separate compilation unit.
> 
> To identify Zhaoxin CPU, add a new vendor type X86_VENDOR_ZHAOXIN
> for system recognition.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  MAINTAINERS                      |   6 ++
>  arch/x86/Kconfig.cpu             |  13 ++++
>  arch/x86/include/asm/processor.h |   3 +-
>  arch/x86/kernel/cpu/Makefile     |   1 +
>  arch/x86/kernel/cpu/zhaoxin.c    | 164 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 186 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kernel/cpu/zhaoxin.c

Looks ok to me.

Rafael, can you ACK the other two so that they all go through the tip
tree?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
