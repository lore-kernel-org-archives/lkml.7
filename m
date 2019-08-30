Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84011C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C4523407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pXtUORsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfH3Pkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:40:42 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36194 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3Pkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nWeznoNOHC7eIO8idSq6ZsE2oyJk7EYgheduVj5P/f4=; b=pXtUORslal1YVkihVrcQfATE4
        SelbnkDdJPT/EYiYQrkKfDkCnZ24KOq6J8o0W+DCH6H1/G91tsVk0a1+DxRF4UmeVoxh/n3s6fkxy
        mbwGmhTQzVf/G6Y8kHo2Wx25TNCglnLNp980PWVCiztYhHhq2ai2oJkeumNz56lo477pAzs8FNtHb
        4+l0FhF1gWqCoABv2Tv82qDiSm5yTiHsCyPWu7JSjRMhPQavWVL9eCn2pKsPCdDOLYgU0GkTMkUjK
        Nd5X8hQfUmYMSAHWHghQdEJd/L9ju2a91IiJ1eFU4jnD0TvJpw9CNsS2tY7gO5EEjsKJWHyS9REZR
        F8IydN1kA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56034)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i3j0k-0007hK-6j; Fri, 30 Aug 2019 16:40:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i3j0h-0000Fk-5q; Fri, 30 Aug 2019 16:40:23 +0100
Date:   Fri, 30 Aug 2019 16:40:23 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov@parallels.com>,
        Kirill Tkhai <ktkhai@parallels.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
Message-ID: <20190830154023.GF13294@shell.armlinux.org.uk>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
 <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 08:30:00AM -0700, Linus Torvalds wrote:
> On Fri, Aug 30, 2019 at 7:08 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > which means that when probe_kernel_address() returns -EFAULT, the
> > destination is left uninitialised.  In the case of
> > task_rcu_dereference(), this means that "siginfo" can be used without
> > having been initialised, resulting in this function returning an
> > indeterminant result (based on the value of an uninitialised variable
> > on the stack.)
> 
> Do you actually see that behavior?

No, it was an observation of the code.

> Because the foillowing lines:
> 
>         smp_rmb();
>         if (unlikely(task != READ_ONCE(*ptask)))
>                 goto retry;
> 
> are what is supposed to protect it - yes, it could have faulted, but
> only if 'task' isn't valid any more, and we just re-checked it.

Ah, ok.  Might be worth some comments - I find the comments in that
function particularly unhelpful (even after Oleg mentions this is
case 2.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
