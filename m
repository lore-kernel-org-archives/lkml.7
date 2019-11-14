Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5A0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A54C20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QU2oLMr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKNSJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:09:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37896 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfKNSJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:09:04 -0500
Received: from zn.tnic (p200300EC2F15E200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:e200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDBE21EC0C7B;
        Thu, 14 Nov 2019 19:09:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573754943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8zyhxwqKTlBkuN/gtzYWICTpVbITCgZCs6VEKV/QQFE=;
        b=QU2oLMr8cFpoUBT2Kcqb+kvKm5298gsL6g/8lLPKHHDTnlL/bdRqfmjJp+ZYdRtqRdwcQv
        6uRRCmVwdj1wQU+PUOrYvQimrbqALUojzF0glybT8t86oSH2b+jJKslP0yarosC4V9FWXu
        VAeplvWrJmhcRvdftp7bg0liGTfj5iU=
Date:   Thu, 14 Nov 2019 19:08:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191114180858.GA8520@zn.tnic>
References: <20191112211002.128278-1-jannh@google.com>
 <20191112211002.128278-2-jannh@google.com>
 <20191114174630.GF24045@linux.intel.com>
 <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:00:35AM -0800, Andy Lutomirski wrote:
> And I think this code should be skipped entirely if error_code != 0.

... or say that the #GP is happening due to a segment descriptor access.
Would make the figuring out why it happens a bit simpler as to where to
look.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
