Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E7C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 08:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4361D23774
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 08:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FlD7zgMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfHaHz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 03:55:59 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47082 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfHaHz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 03:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9jN5wCUco3ocHvvuYC+PCJTTkhAPUYJE2GF5UyMaJg4=; b=FlD7zgMBL9P4OCVGib9js6n/3
        iMr3BNp4e/fLB+Lwjf0ndFSuTY/cYUEwNeObidlMqAA9lJ1Tw9v1wn2HqcBJRSQcA42CbBLlJpKhq
        WmHHXRLZ8njAHpMuein+20PXRPC7ConXX7v7uslz3MZ6Mhi1oPMMdeQEzkOXEu2khpxDxSqiBpB6O
        l80DF0u16U10OWlY0jJgiNCLOKuZFmjjbxaiRYNQ3bA2Eim0x5GAPbuJK3iFh8o9unCLLO0KcxPgh
        x8iZIh9bT+FOg5dAqs0iM4R2/e/Yl/BpGDsbC0hUIgHZ0B/EMFnjltIZWSTwRKhJ7/+yLlm4y11n+
        AFudPoW2A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56048)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i3yEP-0003Py-U1; Sat, 31 Aug 2019 08:55:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i3yEG-0000pl-D3; Sat, 31 Aug 2019 08:55:24 +0100
Date:   Sat, 31 Aug 2019 08:55:24 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     ebiederm@xmission.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        bhelgaas@google.com, tglx@linutronix.de,
        sakari.ailus@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm: fix page faults in do_alignment
Message-ID: <20190831075524.GI13294@shell.armlinux.org.uk>
References: <1567171877-101949-1-git-send-email-jingxiangfeng@huawei.com>
 <20190830133522.GZ13294@shell.armlinux.org.uk>
 <5D69D239.2080908@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D69D239.2080908@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 09:49:45AM +0800, Jing Xiangfeng wrote:
> On 2019/8/30 21:35, Russell King - ARM Linux admin wrote:
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
> 
> __might_sleep is called in the function  __get_user which lead to that bug.
> And that bug is triggered in a kernel space. Page fault can not be generated.
> Right?

Your email is now fixed?

All of get_user(), __get_user(), copy_from_user() and __copy_from_user()
_can_ cause a page fault, which might need to fetch the page from disk.
All these four functions are equivalent as far as that goes - and indeed
as are their versions that write as well.

If the page needs to come from disk, all of these functions _will_
sleep.  If they are called from an atomic context, and the page fault
handler needs to fetch data from disk, they will attempt to sleep,
which will issue a warning.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
