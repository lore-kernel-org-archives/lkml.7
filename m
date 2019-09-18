Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62364C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DB1208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t0sHHbkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfIRNki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:40:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfIRNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1vgoCsT0xO+Rn0pklazhNMvrKBUV1W3s56aPAfmOcsg=; b=t0sHHbkPpIo/HUcrOE6fruK/7
        4FJLr13BgWmHp/DVqbXnyy1jTgfoGRtLlhx85IH69rVWow/hNGOgPhAsgys/vfYYlZN+P7d7dpIqQ
        c8HyieCSr2f/y6XLy/ZPU74g8IgR0vI5WeqmHrRItXMqhCm1i74hG3TZ5UMjupSPg/PNWtBSbKOVc
        waYDmgdd8unQsSezDki4aUVdRJtuYnTPmnG41y0PgQ33IiHPua8AhJZFQdziQRy3DDvwHYebFHg3V
        dXABWys0mZMPAofRKgUXPGLK5rMJsIqSiR5SA1sU2JsLUSjhVu28FcbwSIKcIw6qsxxI0hV63g82j
        8AipFOU/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAaBt-0006wS-Re; Wed, 18 Sep 2019 13:40:17 +0000
Date:   Wed, 18 Sep 2019 06:40:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 0/4] powerpc: Add support for GENERIC_EARLY_IOREMAP
Message-ID: <20190918134017.GA22027@infradead.org>
References: <cover.1568295907.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568295907.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 01:49:40PM +0000, Christophe Leroy wrote:
> This series adds support for GENERIC_EARLY_IOREMAP on powerpc.
> 
> It also adds a warning in the standard ioremap() when it's called
> before vmalloc is available in order to help locate those users.
> 
> Next step will be to incrementaly migrate all early users of
> ioremap() to using early_ioremap() or other method.
> 
> Once they are all converted we can drop all the logic
> behind ioremap_bot.

Thanks, this looks pretty nice!
