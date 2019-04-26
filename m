Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE20C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222AA20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="txQofMPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfDZGVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:21:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZGVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0LwYefVsKWI1t7eo6Xuii0VTIBtmVw2TLE6B4mPZvpk=; b=txQofMPn+JMo22X91UjkWsuZN
        HJIsNxmhmaHv1oVEKXsYzg74TVhqtSGNvzbF7qmTSfuOKa+y8mli9hNfy59npKXYsLTOpEwoqeZzr
        z0UVH1B60xVgg0RtfnIZFB3Ly1zhANdKddcyuZccc6H8+FdesiJa9lmO+8yK78OKr0BfV92C4+Tbv
        wx9sGizfk7bMd+zgIWMGJ2EFPyphKPeCTSLvwub2KVk1kWmC1FjOG9D1OPVHHAyjzaiBaU6g+XsaT
        pbqBD/ApVHXP+T8bEialVyV9kMtxYD4uznsoVwp8+Fy9h8iFtTjxjn9Qldi29gUESwnLkIqDPHDIQ
        0dMGBFM/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJuEn-0000CS-8B; Fri, 26 Apr 2019 06:21:33 +0000
Date:   Thu, 25 Apr 2019 23:21:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] tty: Don't force RISCV SBI console as preferred console
Message-ID: <20190426062133.GA28529@infradead.org>
References: <20190425133435.56065-1-anup.patel@wdc.com>
 <9a8be7ef-e62e-2a93-9170-e3dc70dfb25f@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8be7ef-e62e-2a93-9170-e3dc70dfb25f@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 09:41:21PM -0700, Atish Patra wrote:
> Do we even need HVC_SBI console to be enabled by default? Disabling
> CONFIG_HVC_RISCV_SBI seems to be fine while running in QEMU.
> 
> If we don't need it, I suggest we should remove the config option from
> defconfig in addition to this patch.

I think the whole concept of the SBI console is a little dangerous.
It means that for one piece of physical hardware (usually the uart)
we have two entiries (the M-mode firmware and the OS) in control,
which tends to rarely end well.
