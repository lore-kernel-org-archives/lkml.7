Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE11A21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qZRSNs7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCUVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:44:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCUVoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i7m++E+Xib+uDsp7WuM+xF5x1nfGX9p80KlO1ZOhiz8=; b=qZRSNs7dCUzn/FgvE+RBp5GcE
        PyFCIgy9sr+dhqNHb55IbM6O7+1jai0tmbHue06hJi1edHn1UxaaRKm4DFMYlL8CpYyYeysf5KeUn
        B4vUDi80+/c0e370T4+Ulq24ijI2SUc4O+ZJDXmVnL60LUBPr+8tKW4pgkUbMv2pF1nHIBgDJkeel
        +x2ngxtknSWuHspHItqADpzmtfxqjHz6LByUJd4+/TRSpI5BKRQHS3eHFhQ/rPj1nL3/+wjOUUG3S
        e7i8rOk++iorCbY3nYIjGRlsHLrYTPoOtmvHjWT7xQXsJpOa3PUK8lw23o+BU6XEzyeijCOp9NV+u
        jxcQYknxQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h75Tm-0002fY-4W; Thu, 21 Mar 2019 21:44:02 +0000
Date:   Thu, 21 Mar 2019 14:44:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        mhocko@suse.com, rppt@linux.ibm.com,
        linux-amlogic@lists.infradead.org, liang.yang@amlogic.com,
        linux@armlinux.org.uk, linux-mtd@lists.infradead.org
Subject: Re: 32-bit Amlogic (ARM) SoC: kernel BUG in kfree()
Message-ID: <20190321214401.GC19508@bombadil.infradead.org>
References: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:17:34PM +0100, Martin Blumenstingl wrote:
> Hello,
> 
> I am experiencing the following crash:
>   ------------[ cut here ]------------
>   kernel BUG at mm/slub.c:3950!

        if (unlikely(!PageSlab(page))) {
                BUG_ON(!PageCompound(page));

You called kfree() on the address of a page which wasn't allocated by slab.

> I have traced this crash to the kfree() in meson_nfc_read_buf().
> my observation is as follows:
> - meson_nfc_read_buf() is called 7 times without any crash, the
> kzalloc() call returns 0xe9e6c600 (virtual address) / 0x29e6c600
> (physical address)
> - the eight time meson_nfc_read_buf() is called kzalloc() call returns
> 0xee39a38b (virtual address) / 0x2e39a38b (physical address) and the
> final kfree() crashes
> - changing the size in the kzalloc() call from PER_INFO_BYTE (= 8) to
> PAGE_SIZE works around that crash

I suspect you're doing something which corrupts memory.  Overrunning
the end of your allocation or something similar.  Have you tried KASAN
or even the various slab debugging (eg redzones)?

