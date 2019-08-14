Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1622084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="neY7O7gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfHNFzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:55:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfHNFzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QO/ujdGHsGus5q5hW+MDp+9hUOaT+2ytDi2HUKE5LUE=; b=neY7O7ghM+TkauICr2aBIQEVT
        OhWhgeM9+QNOWnz/N3uQ9KhxyjDCFYe+nnhq/NrV7vmB7XCTwXhW4Rq8q3+CJU3WVK8q9Ad3T4Vff
        0yYRjWuZEIo4EW7MsE60RxKo3WVvghLh7L6iAjuzGTCFy6qAp09WKl9geyV6o1C+qNW0XyN1DrYXd
        VnkHvk8QMPPbrqqYkJ18Noq6Se5BmAP1grw7LHt/u3rz97P4EQFmChtBG7vs4BkoZwlK5kTYQ7taK
        KOGYcVw+Hh6pCKf8O/NXMUCpA5Zx/C+rWo8md/+1skh5CqaB192d6YCEuNgXM1p+WYq85nxI0UuCa
        NpZ5vBztg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxmFp-0004n3-9c; Wed, 14 Aug 2019 05:55:25 +0000
Date:   Tue, 13 Aug 2019 22:55:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/10] powerpc/mm: Do early ioremaps from top to
 bottom on PPC64 too.
Message-ID: <20190814055525.GA12744@infradead.org>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <019c5d90f7027ccff00e38a3bcd633d290f6af59.1565726867.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019c5d90f7027ccff00e38a3bcd633d290f6af59.1565726867.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:11:38PM +0000, Christophe Leroy wrote:
> Until vmalloc system is up and running, ioremap basically
> allocates addresses at the border of the IOREMAP area.

Note that while a few other architectures have a magic hack like powerpc
to make ioremap work before vmalloc, the normal practice would be
to explicitly use early_ioremap.  I guess your change is fine for now,
but it might make sense convert powerpc to the explicit early_ioremap
scheme as well.
