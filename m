Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FAAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D6F208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MKEH/3uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfHLPEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:04:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfHLPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6aCiFlnKco+0K9lO1zC0yDoDsxtxBScYx2o5eR9m57E=; b=MKEH/3uBkNtMCl1v1WQCg8Yve
        WIvj1l1zKBBw6Qx6s2Gf1Oj0kUOjDC1hOvcql7jGmAN9IoMlxQLez8jTOZv2BV8uPvlqN8+oU9jdE
        qm+4Evt3tvu+FoKcMs0blpEDvm8KySvmbfglhZcnciFgskFxcft7uPS6hd9zKV7+B2aAvF1+27j6F
        WW9bkw/+bJWhE6QUvbUsoOnMrK+Jq68EXv/qj26lk1sh7BIG9+0q+8OiOMXMKLtXvGltBqoZYr7Lf
        UkXzALFJCZvrSW0zD2g4AJrwtvfFS7Zxc7zmK5jATxDtf+oLnsTnw6qQ+QAHA11hVsGPVRENnvLXw
        8oMsqq24g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBsN-0006Xf-19; Mon, 12 Aug 2019 15:04:47 +0000
Date:   Mon, 12 Aug 2019 08:04:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Hu <nickhu@andestech.com>
Cc:     alankao@andestech.com, paul.walmsley@sifive.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, green.hu@gmail.com, deanbo422@gmail.com,
        tglx@linutronix.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, Anup.Patel@wdc.com,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        atish.patra@wdc.com, zong@andestech.com, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/2] riscv: Add memmove string operation.
Message-ID: <20190812150446.GI26897@infradead.org>
References: <cover.1565161957.git.nickhu@andestech.com>
 <a6c24ce01dc40da10d58fdd30bc3e1316035c832.1565161957.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c24ce01dc40da10d58fdd30bc3e1316035c832.1565161957.git.nickhu@andestech.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 03:19:14PM +0800, Nick Hu wrote:
> There are some features which need this string operation for compilation,
> like KASAN. So the purpose of this porting is for the features like KASAN
> which cannot be compiled without it.
> 
> KASAN's string operations would replace the original string operations and
> call for the architecture defined string operations. Since we don't have
> this in current kernel, this patch provides the implementation.
> 
> This porting refers to the 'arch/nds32/lib/memmove.S'.

This looks sensible to me, although my stringop asm is rather rusty,
so just an ack and not a real review-by:

Acked-by: Christoph Hellwig <hch@lst.de>
