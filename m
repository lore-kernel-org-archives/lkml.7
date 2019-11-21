Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59910C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB4C20659
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LuUMK8z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKUT4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:56:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUT4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ERsW0Ec/9CwlIdkx+SUdsqC89v+sCvHHndKM+e+JZ0A=; b=LuUMK8z+PevXS6cF+os4NkDlC
        506kjmh4SjZUrlkWZm7qP9BB6eWjB/YCZ6KaMlwSpfYvnGcGwb44g6NY4p6za+w/EFoCIPXrq/aYQ
        pnBZ+y30Jj1bZUOfWtTPTvrQ+5H0oP+edq5C8ze/Ic8iIjdXp8ntx7zGaWQa7MDKTKVzaj6ennpOA
        D703KJ4frxgEKkXBX/qg76YSML5Cwn71rTntlmbryRfvHEt/qzypVWwQKpwkxNIde/ZuZvlXHvKnS
        XfWA0nbnUqczJ1bClAXo0kvC1TLyFnZ6eNHTHz9vJXQzItXnNMhZ0WdvZCh5sRa5JXJetlFz+y3wn
        mq2wtRjcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXsZA-0000kZ-KF; Thu, 21 Nov 2019 19:56:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81FF2300606;
        Thu, 21 Nov 2019 20:55:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 795AD2022FCFB; Thu, 21 Nov 2019 20:56:34 +0100 (CET)
Date:   Thu, 21 Nov 2019 20:56:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121195634.GV4097@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:51:03AM -0800, Andy Lutomirski wrote:

> Can we really not just change the lock asm to use 32-bit accesses for
> set_bit(), etc?  Sure, it will fail if the bit index is greater than
> 2^32, but that seems nuts.

There are 64bit architectures that do exactly that: Alpha, IA64.

And because of the byte 'optimization' from x86 we already could not
rely on word atomicity (we actually play games with multi-bit atomicity
for PG_waiters and clear_bit_unlock_is_negative_byte).

Also, there's a fun paper on the properties of mixed size atomic
operations for when you want to hurt your brain real bad:

  https://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf

_If_ we're going to change the bitops interface, I would propose we
change it to u32 and mandate every operation is indeed 32bit wide.
