Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0CBC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F552343A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JEE1bJ9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfH3Ubd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:31:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39646 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfH3Ubc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G81S00ak0iTh6ncTJpTj7KNc/WBOF1FWlEXXOPN/t0w=; b=JEE1bJ9lA/X9HwwUO/pEriXmr
        vrUzeFcjyw7bUtJIXrLLQFNRv0mzvcGkOgor6R2/9wfw8+nr95J+9d3ug803jjdw8mDrfNfhEzlL0
        iRZ6JkzEi0LvVfQvV8cQLGI3yuV3z62dlrWpSIE5DpQmKFkECFTBptVwjt2Do3DmsxntmSVNpH4fO
        Jqa1LdTsAU3NRxMpKhMNBRyCji8EjHXIVcUGkUAASygDEDSTICrQhJ/q2vQagFEK7qHFKTo5pi2d/
        B3+wc7gaRNEXQDlcMNCPS4aBGeFd+H0WCOzXEvh0qph5UJcMw7G6Yzz30upmJdKiJXzUxzTgaUf2w
        w27uGAcpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39462)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i3nXv-0000XF-2k; Fri, 30 Aug 2019 21:30:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i3nXo-0000Q9-M8; Fri, 30 Aug 2019 21:30:52 +0100
Date:   Fri, 30 Aug 2019 21:30:52 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, bhelgaas@google.com, tglx@linutronix.de,
        sakari.ailus@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm: fix page faults in do_alignment
Message-ID: <20190830203052.GG13294@shell.armlinux.org.uk>
References: <1567171877-101949-1-git-send-email-jingxiangfeng@huawei.com>
 <20190830133522.GZ13294@shell.armlinux.org.uk>
 <87d0gmwi73.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0gmwi73.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:45:36PM -0500, Eric W. Biederman wrote:
> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
> 
> > On Fri, Aug 30, 2019 at 09:31:17PM +0800, Jing Xiangfeng wrote:
> >> The function do_alignment can handle misaligned address for user and
> >> kernel space. If it is a userspace access, do_alignment may fail on
> >> a low-memory situation, because page faults are disabled in
> >> probe_kernel_address.
> >> 
> >> Fix this by using __copy_from_user stead of probe_kernel_address.
> >> 
> >> Fixes: b255188 ("ARM: fix scheduling while atomic warning in alignment handling code")
> >> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> >
> > NAK.
> >
> > The "scheduling while atomic warning in alignment handling code" is
> > caused by fixing up the page fault while trying to handle the
> > mis-alignment fault generated from an instruction in atomic context.
> >
> > Your patch re-introduces that bug.
> 
> And the patch that fixed scheduling while atomic apparently introduced a
> regression.  Admittedly a regression that took 6 years to track down but
> still.

Right, and given the number of years, we are trading one regression for
a different regression.  If we revert to the original code where we
fix up, we will end up with people complaining about a "new" regression
caused by reverting the previous fix.  Follow this policy and we just
end up constantly reverting the previous revert.

The window is very small - the page in question will have had to have
instructions read from it immediately prior to the handler being entered,
and would have had to be made "old" before subsequently being unmapped.

Rather than excessively complicating the code and making it even more
inefficient (as in your patch), we could instead retry executing the
instruction when we discover that the page is unavailable, which should
cause the page to be paged back in.

If the page really is unavailable, the prefetch abort should cause a
SEGV to be raised, otherwise the re-execution should replace the page.

The danger to that approach is we page it back in, and it gets paged
back out before we're able to read the instruction indefinitely.

However, as it's impossible for me to contact the submitter, anything
I do will be poking about in the dark and without any way to validate
that it does fix the problem, so I think apart from reviewing of any
patches, there's not much I can do.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
