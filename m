Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35972C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03F32064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cBD3raBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKZWOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:14:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56598 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfKZWOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:14:01 -0500
Received: from zn.tnic (p200300EC2F0EC2003034EE13CF148829.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c200:3034:ee13:cf14:8829])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FBD11EC0CDC;
        Tue, 26 Nov 2019 23:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574806440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bzV66XmqrkIBUMFTYjntXwun1FRqc6sMmxnkD45b3zs=;
        b=cBD3raBLhPtrbCdVKinqa08lUKDBbYtX+hMdoU3brhQpI/MGLfrKXuqJmNio082Ha7VkXp
        RmYPfZntZCdifHRawggyG/9Zz+BDH3tcgvRjo1Jsxv7kC+y/RU8D1RV7WY/ZQ8qpOeoh10
        emBRZM5CZ05sx4FmFmKwcSJEKP3TPu4=
Date:   Tue, 26 Nov 2019 23:13:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Barret Rhoden <brho@google.com>, austin@google.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: AVX register corruption from signal delivery
Message-ID: <20191126221328.GH31379@zn.tnic>
References: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
 <20191126202026.csrmjre6vn2nxq7c@linutronix.de>
 <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 04:23:40PM -0500, Barret Rhoden wrote:
> Thanks; config attached.  I've been able to recreate it in QEMU with at
> least 2 cores.

Yap, I can too, in my VM.

Btw, would you guys like to submit that reproducer test program

https://bugzilla.kernel.org/attachment.cgi?id=286073

into the kernel selftests pile here:

tools/testing/selftests/x86/

?

It needs proper cleanup to fit kernel coding style but it could be a
good start for collecting interesting FPU test cases...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
