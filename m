Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FEBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAA92068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574371348;
	bh=bniu8l82DVZK7Xcjyvbp1Kp51VrBQmOfOA8fDc6KI6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A6WjZxOP1G+JVhkj28eYmTErgOPMAuaSk84hibUHNnJNt/fEvwE1XOTG+0W7k7sF5
	 mizLocCc+1EtSeJjKKRsKZutbVRkS4vmqNmce4+2sLEr5AnclwQXky+h+WnrEXzEth
	 dEoPOF/kv59z/0AFIGx4/8RU7ujcrE21UXXXRxGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfKUVW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:22:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKUVW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:22:27 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E73F2071B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 21:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574371346;
        bh=bniu8l82DVZK7Xcjyvbp1Kp51VrBQmOfOA8fDc6KI6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1W83i/7eltRlSF7Z+DyLIIlHItx8a80Y6f5tU9FdKwcsb2iJufoFbaPfCr76zhjEB
         su3UsLAlY70TDmOycXobjCKUa5stZ0po+I01HnyIj+z1c8jzc4U91BMasKPjRJf0JH
         yZ8B83UABywnlwRrW3HoiepIoC7pWmXjp8KMcVRE=
Received: by mail-wm1-f50.google.com with SMTP id x26so5034306wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:22:26 -0800 (PST)
X-Gm-Message-State: APjAAAUTK4uLV7PijIBFriP/TRC0RBk8PYDY7fWDZMrA38CP1aBXtxNm
        Tw57JTyBrVd9RoJIXqITzlU4eN8rXTDLVb+dqZCCkg==
X-Google-Smtp-Source: APXvYqzNJW/i57/phfnZvYSWRoPwe87prKP6rWecrzMX1DMcuSiTogtFsHYHxhmWXYGQ+SQXUSJc/vJ9aEWgwSo2nZE=
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr13469841wmj.161.1574371344540;
 Thu, 21 Nov 2019 13:22:24 -0800 (PST)
MIME-Version: 1.0
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com> <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net> <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com> <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com> <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Nov 2019 13:22:13 -0800
X-Gmail-Original-Message-ID: <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
Message-ID: <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 21, 2019 at 10:53:03AM -0800, Fenghua Yu wrote:
>
> > 4. Otherwise, re-calculate addr to point the 32-bit address which contains
> >    the bit and operate on the bit. No split lock.
>
> That sounds confused, Even BT{,CRS} have a RmW size. There is no
> 'operate on the bit'.
>
> Specifically I hard rely on BTSL to be a 32bit RmW, see commit:
>
>   7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")
>

Okay, spent a bit of time trying to grok this.  Are you saying that
LOCK BTSL suffices in a case where LOCK BTSB or LOCK XCHG8 would not?
On x86, all the LOCK operations are full barriers, so they should
order with adjacent normal accesses even to unrelated addresses,
right?

I certainly understand that a *non-locked* RMW to a bit might need to
have a certain width to get the right ordering guarantees, but those
aren't affected by split-lock detection regardless.

--Andy
