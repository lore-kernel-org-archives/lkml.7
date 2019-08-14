Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4FCC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F4620843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PakH2jaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfHNFiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:38:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfHNFix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SlVqJKDhHhOV65ho42xhKFAezVWVkPicox2Ec3tGxgk=; b=PakH2jaXbBToCfuos4t+CAubT
        lwx/wRgTpVs9alNcOCtl8VsIzzS5fl6E+TxQWxiS+iNy2NehAm1OUonV55GXj4rxxGY3Q3YpZcw48
        qiEr3JyqLHobUgzDpC0ed+RLOkOUf/Njyg8q7o1fixpxsAAK/kDkij4TVOL7Mh9F4JEOHws06O99F
        nSNgA1gaW0bE04qxe7mj+XreHnHfGTqBJgH1LtISXjFlGVsENnC9n/8IR5YO1g3DbuE0O2Z0W7xlu
        5BekPF04RbiJY2dlIvnotC7vUgpmOuhtWaLRixG/ov1LsbQpe4ec4Fj08zrXQN9ygD/jKrd6MBo5h
        MitR12Z7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxlzf-0007CA-DV; Wed, 14 Aug 2019 05:38:43 +0000
Date:   Tue, 13 Aug 2019 22:38:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] powerpc/mm: rework io-workaround invocation.
Message-ID: <20190814053843.GB27497@infradead.org>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <d6049aee232029c01c7569975d49455058c945fe.1565726867.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6049aee232029c01c7569975d49455058c945fe.1565726867.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:11:34PM +0000, Christophe Leroy wrote:
> ppc_md.ioremap() is only used for I/O workaround on CELL platform,
> so indirect function call can be avoided.
> 
> This patch reworks the io-workaround and ioremap() functions to
> use static keys for the activation of io-workaround.
> 
> When CONFIG_PPC_IO_WORKAROUNDS or CONFIG_PPC_INDIRECT_MMIO are not
> selected, the I/O workaround ioremap() voids and the static key is
> not used at all.

Why bother with the complex static key?  ioremap isn't exactly a fast
path.  Just make it a normal branch if enabled, with the option to
compile it out entirely as in your patch.
