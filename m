Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354D32082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iheBTqAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfDBPfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:35:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBPfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:35:30 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 009021EC023E;
        Tue,  2 Apr 2019 17:35:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554219329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ieVjFeckjXBOmqsPZW4XPAx/TTZtkTXGrwcqGTz35Is=;
        b=iheBTqAC/chqNxSA1uY+LbAwGansJDWG5jKTqWQjlFA3Md/8tKgEgYsQkepMPyW9mjwL9+
        F7iinTAH6ol6aWexRxQAa7hf2WwcNbpT1Gle11MVeTwwHZqB74q/enn7fyY/b/7pUnb4dX
        +4hxuq+KIR/MHDk3Hk/BG9zw8Lm6+E0=
Date:   Tue, 2 Apr 2019 17:35:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH] x86/microcode: Remove useless code after early microcode
 support added
Message-ID: <20190402153524.GH6826@zn.tnic>
References: <1554108412-22229-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554108412-22229-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 04:46:52PM +0800, Zhenzhong Duan wrote:
> After early microcode update was added, microcode couldn't be configured

No, early loading doesn't have anything to do with it - the driver was
made built-in only.

> as a module, microcode update happens at early bootup and cpu hotplug
> stage. This made the microcode update code in module loading stage
> useless.
> 
> This patch

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> remove the useless code.

Well, not useless.

1. Apply your patch, boot kernel without an initrd so that it doesn't
apply early microcode.

2. Load late microcode:

# echo 1 > /sys/devices/system/cpu/microcode/reload
[   66.430052] microcode: CPU0: new patch_level=0x05000029
[   66.430352] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
[   66.430620] microcode: Reload completed, microcode revision: 0x5000029

3.
# grep microcode /proc/cpuinfo
microcode       : 0x5000029
microcode       : 0x5000028	<--- !!!

Whoops. CPU1 didn't get updated.

So I'd suggest leaving this code alone and concentrating on fixing real
bugs. Unless it is causing other issues.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
