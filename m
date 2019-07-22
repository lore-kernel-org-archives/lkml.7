Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DEBC76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 00:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B642147A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 00:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563755958;
	bh=60TYNH0hwVxrMOKDBgoWalRZn/KY6XzLLZo86nHK+LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sFx3dBU4QX5MARzGhCP5WHqD5ovmVfEK78LwUOua5dEQ9cqsMpCR4wKzdaRgoUhlT
	 5z5TuWmIpim+uydk1Oq9s8olLa6EExa7AehowTIYlMgFfM7MO5l7TU81uDqRY6LCUz
	 A+jcEXdkLvoIw3ehn8lANvdkTw05bbM5M7qPKoq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfGVAjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 20:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfGVAjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 20:39:17 -0400
Received: from localhost (unknown [216.243.17.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDFF206BF;
        Mon, 22 Jul 2019 00:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563755956;
        bh=60TYNH0hwVxrMOKDBgoWalRZn/KY6XzLLZo86nHK+LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lfo6EjXKW20c9vdPwQ/x+i/OsajsnIlxT+hvZhHcp1MKfFvwz35oJ0dNXe1d21t0S
         wcAWQs09moHV8rCicrYM7YclAYr144eTJFpweoYi9MOYnIbe1GgI7hfApJ7aTm9LUu
         OAcEG4TRq3uVgRwmfM6BoxXsOrXWRJw1ZdsIyNNQ=
Date:   Sun, 21 Jul 2019 20:39:15 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.1 013/219] x86/tsc: Use CPUID.0x16 to calculate
 missing crystal frequency
Message-ID: <20190722003915.GB1607@sasha-vm>
References: <20190715133811.2441-1-sashal@kernel.org>
 <20190715133811.2441-13-sashal@kernel.org>
 <CAD8Lp47XuF26FP0XEPz6KFMg=UGDvZx5bejjF6NZ2qSRdZSR_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD8Lp47XuF26FP0XEPz6KFMg=UGDvZx5bejjF6NZ2qSRdZSR_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:56:59AM +0800, Daniel Drake wrote:
>Hi,
>
>On Mon, Jul 15, 2019 at 9:38 PM Sasha Levin <sashal@kernel.org> wrote:
>> From: Daniel Drake <drake@endlessm.com>
>>
>> [ Upstream commit 604dc9170f2435d27da5039a3efd757dceadc684 ]
>
>In my opinion this is not stable kernel material.
>
>It alone does not solve a particular bug. It's part of a larger effort
>to decrease usage of the 8254 PIT on modern platforms, which solves a
>real problem (see "x86: skip PIT initialization on modern chipsets"),
>but I'd conservatively recommend just leaving these patches out of the
>stable tree. The problem has existed for a while without a
>particularly wide impact, and there is a somewhat documented
>workaround of changing BIOS settings.

I've dropped it, thanks!

--
Thanks,
Sasha
