Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF0C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FCE20843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B23Q+gu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfHNFhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:37:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfHNFhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tbs+sFILsmF3FgHiG3KTpCBNIgzSXc15Dc691qgzyxE=; b=B23Q+gu+wx2zk/qfYzyE1l/dP
        g4kYOCi6IbxrSIPYsvhFjLeX2hhEExE00N2JC/kdPNVFxJdsZ/FuMJCwwSo7d5qWebA9L8Xq5/gXO
        N7SyUcLdT8dYgrzQDAosT71DXH7ZM7kJcF9bQNiPV0/yvtd3tc3SVZCQtlbW9zQVULASRJvmbTMi8
        7P05el30TX2tKBlFEvA31zbsDbjmvvkwhV/rZ3JvkT0qAvsVq/YLxPBEhY0SfA+HLrUtwqOm9/J4R
        BEmqzshoFkDqBm+eRXEC2Rce1yOSz6IkanzuhCXtKTYFW13nI5n9IRNi6aTrkDQQVrJhe4vMFnWqY
        timLaOAig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxlyW-0007AM-Ul; Wed, 14 Aug 2019 05:37:32 +0000
Date:   Tue, 13 Aug 2019 22:37:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: fix boot failure with DEBUG_PAGEALLOC
 without KASAN.
Message-ID: <20190814053732.GA27497@infradead.org>
References: <8c83a4e1237658ed1acfb9a9891048a15f9ca36b.1565760495.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c83a4e1237658ed1acfb9a9891048a15f9ca36b.1565760495.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:28:35AM +0000, Christophe Leroy wrote:
> When KASAN is selected, the definitive hash table has to be
> set up later, but there is already an early temporary one.
> 
> When KASAN is not selected, there is no early hash table,
> so the setup of the definitive hash table cannot be delayed.

I think you also want to add this information to the code itself
as comments..
