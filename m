Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A036C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF9321911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfGVHxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:53:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:18416 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfGVHxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:53:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 00:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,294,1559545200"; 
   d="scan'208";a="180323256"
Received: from unknown (HELO yhuang-dev) ([10.239.159.29])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2019 00:53:02 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: kernel BUG at mm/swap_state.c:170!
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
        <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
        <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com>
Date:   Mon, 22 Jul 2019 15:52:53 +0800
In-Reply-To: <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com>
        (Mikhail Gavrilov's message of "Mon, 22 Jul 2019 12:31:36 +0500")
Message-ID: <878ssqbj56.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> writes:

> On Mon, 22 Jul 2019 at 06:37, huang ying <huang.ying.caritas@gmail.com> wrote:
>>
>> I am trying to reproduce this bug.  Can you give me some information
>> about your test case?
>
> It not easy, but I try to explain:
>
> 1. I have the system with 32Gb RAM, 64GB swap and after boot, I always
> launch follow applications:
>     a. Google Chrome dev channel
>         Note: here you should have 3 windows full of tabs on my
> monitor 118 tabs in each window.
>         Don't worry modern Chrome browser is wise and load tabs only on demand.
>         We will use this feature later (on the last step).
>     b. Firefox Nightly ASAN this build with enabled address sanitizer.
>     c. Virtual Machine Manager (virt-manager) and start a virtual
> machine with Windows 10 (2048 MiB RAM allocated)
>     d. Evolution
>     e. Steam client
>     f. Telegram client
>     g. DeadBeef music player
>
> After all launched applications 15GB RAM should be allocated.
>
> 2. This step the most difficult, because we should by using Firefox
> allocated 27-28GB RAM.
>     I use the infinite scroll on sites Facebook, VK, Pinterest, Tumblr
> and open many tabs in Firefox as I could.
>     Note: our goal is 27-28GB allocated RAM in the system.
>
> 3. When we hit our goal in the second step now go to Google Chrome and
> click as fast as you can on all unloaded tabs.
>     As usual, after 60 tabs this issue usually happens. 100%
> reproducible for me.
>
> Of course, I tried to simplify my workflow case by using stress-ng but
> without success.
>
> I hope it will help to make autotests.

Yes.  This is quite complex.  Is the transparent huge page enabled in
your system?  You can check the output of

$ cat /sys/kernel/mm/transparent_hugepage/enabled

And, whether is the swap device you use a SSD or NVMe disk (not HDD)?

Best Regards,
Huang, Ying

> --
> Best Regards,
> Mike Gavrilov.
