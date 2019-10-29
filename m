Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB47CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F2E21734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572348508;
	bh=gUKSWXcfLp8N08IRMS8CZHuXSpvN/MYddgCzXmwoF9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GPdtYFoaL5geY3jjs3iqGBrqgJct1sCWhIX9/NrGuTgU7xsLG4PKJcCG9+NCOG/zq
	 TtpBek40TfojqRo2JtXQ+qQJ6GGZeq/8b4BOaRDg+PfIwhfiUjJsNtyU11NSdGQFs6
	 ZNG3Ht4u1LUO/8rOZzkJCNHq6PBwRoeVzOUW0RoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfJ2L2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730928AbfJ2L2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:28:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8125720663;
        Tue, 29 Oct 2019 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572348492;
        bh=gUKSWXcfLp8N08IRMS8CZHuXSpvN/MYddgCzXmwoF9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxj8AS+8cI/vcQNfxyl1kIVwj3qJo1XrsnWZH/ctVDmfFv3wClysaq7Qv16Ahnqbn
         BE9/4th5Hmp6Zh3JuiO+lah/XUd9501j1WSLEhIfkHn9tJ4okP+yaDh2ET0jvhJkrG
         wBSCsuH9JzWJbcapYM0Yaci8LSvaKrU1P/KePTMw=
Date:   Tue, 29 Oct 2019 11:28:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 00/17] entry: Provide generic implementation for host
 and guest entry/exit work
Message-ID: <20191029112806.GA12103@willie-the-truck>
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023122705.198339581@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Oct 23, 2019 at 02:27:05PM +0200, Thomas Gleixner wrote:
> When working on a way to move out the posix cpu timer expiry out of the
> timer interrupt context, I noticed that KVM is not handling pending task
> work before entering a guest. A quick hack was to add that to the x86 KVM
> handling loop. The discussion ended with a request to make this a generic
> infrastructure possible with also moving the per arch implementations of
> the enter from and return to user space handling generic.
> 
>   https://lore.kernel.org/r/89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net
> 
> The series implements the syscall enter/exit and the general exit to
> userspace work handling along with the pre guest enter functionality.
> 
> Changes vs. RFC version:
> 
>   - Dropped ARM64 conversion as requested by ARM64 folks

If you fancy another crack at arm64 on your way back from Lyon, we've now
got more of the asm->C conversion queued up here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/entry-s-to-c

No worries if not, but figured it was worth letting you know anyway.

Will
