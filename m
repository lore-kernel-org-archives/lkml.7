Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B242467F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WhXo7IBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfLLI6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:58:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44112 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbfLLI6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:58:15 -0500
Received: from zn.tnic (p200300EC2F0A5A00984E1B37A4E020FA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:984e:1b37:a4e0:20fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B23B1EC05B0;
        Thu, 12 Dec 2019 09:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576141094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Tj3bITAmYN7r7Pm0GRA/9GRtqZO10fjAWzPg6ZitPo=;
        b=WhXo7IBAfsLuCuDx8hG4X4RJMhG1Ws4+6QeyMdGhhQRbrjMm+oBIDljMYHeCm6oeAVq1NE
        otDkJgl7a1qkzDaz78RFgr8lZAD6rpqwigd/4/nerpo9zvQtWywXeyjxEV1gZ0NYPF4idQ
        koaxGcj6SAk+xF3jLtFQa+nW/EXZ+dY=
Date:   Thu, 12 Dec 2019 09:58:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: make stub function static inline
Message-ID: <20191212085757.GA4991@zn.tnic>
References: <52170.1575603873@turing-police>
 <20191211213819.GG14821@zn.tnic>
 <186227.1576107233@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <186227.1576107233@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:33:53PM -0500, Valdis Klētnieks wrote:
> Were you building with W=1 (so gcc issues extra warnings) and C=1 or 2
> so sparse is run?

[boris@zn: ~/kernel/linux> make W=1 C=1 arch/x86/kernel/cpu/microcode/
...

  LINK     /mnt/kernel/kernel/linux/tools/objtool/objtool
  CHECK   arch/x86/kernel/cpu/microcode/core.c
  CC      arch/x86/kernel/cpu/microcode/core.o
  CHECK   arch/x86/kernel/cpu/microcode/intel.c
  CC      arch/x86/kernel/cpu/microcode/intel.o
  CHECK   arch/x86/kernel/cpu/microcode/amd.c
arch/x86/kernel/cpu/microcode/amd.c:421:35: warning: Using plain integer as NULL pointer
arch/x86/kernel/cpu/microcode/amd.c:546:35: warning: Using plain integer as NULL pointer
  CC      arch/x86/kernel/cpu/microcode/amd.o
  AR      arch/x86/kernel/cpu/microcode/built-in.a

[boris@zn: ~/kernel/linux> git clean -dqfx

...

[boris@zn: ~/kernel/linux> make W=1 C=2 arch/x86/kernel/cpu/microcode/

  LINK     /mnt/kernel/kernel/linux/tools/objtool/objtool
  CHECK   arch/x86/kernel/cpu/microcode/core.c
  CC      arch/x86/kernel/cpu/microcode/core.o
  CHECK   arch/x86/kernel/cpu/microcode/intel.c
  CC      arch/x86/kernel/cpu/microcode/intel.o
  CHECK   arch/x86/kernel/cpu/microcode/amd.c
arch/x86/kernel/cpu/microcode/amd.c:421:35: warning: Using plain integer as NULL pointer
arch/x86/kernel/cpu/microcode/amd.c:546:35: warning: Using plain integer as NULL pointer
  CC      arch/x86/kernel/cpu/microcode/amd.o
  AR      arch/x86/kernel/cpu/microcode/built-in.a


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
