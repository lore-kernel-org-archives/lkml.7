Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB45C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EB8206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5CIuaOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfJIRw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:52:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIRw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PSn13oxF1UKczQrMvsfZpMiSrhunC9qsLBVGsQ7Tqig=; b=k5CIuaOdffDt+qOqubPEs3YjO
        04Lm9Op0nHnYX2SLaNFPReScjyHgiAA/mQLYIA4gCDv/LwArZ0GcJDNvFtd+btvyj1kPscQR/LXE3
        fgcRigi0bM+f3rxFyvzjsWL4lc1kHP9zmzzkSeSJyQ6u/NfqrCnspNu9O/wlEeZG25StjbklYoz5O
        Kouz/QfmWHmeSlh3RKHp6oqK2wFUgoIz9PrL5/kY84aFqzIh8hWfstrji680e1n4CXBWRK+PGumrK
        IyCU+5cfFBMYjWCJH4Ldgb0HzlbErtSy3r11IroMj4iWTTT5teAIt/sNT9SFbiDvudNZwe1Vu8EfO
        aaL1rAfHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIG7p-0000JD-TI; Wed, 09 Oct 2019 17:51:49 +0000
Date:   Wed, 9 Oct 2019 10:51:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] proc: centralise declaration of cpuinfo_op
Message-ID: <20191009175149.GA28540@infradead.org>
References: <20191009113930.13236-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009113930.13236-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:39:30PM +0100, Ben Dooks wrote:
> When building for arm, cpuinfo_op generates a warning due
> to no declaration. Since this is used in fs/proc/cpuinfo.c
> and inconsitently declared across archiectures move the
> declaration info <linux/seq_file.h>. This means that the
> cpuinfo_op will have a declaration any place it is used.
> 
> Removes the following sparse warning:
> 
> arch/arm/kernel/setup.c:1320:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?

I like the consolidation, but I don't think seq_file.h is the right
place.  A procfs or cpu topology related header seems like the better
choice.
