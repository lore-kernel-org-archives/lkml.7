Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56B5CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EDC2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bpJgreU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393808AbfJRP4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:56:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJRP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1ARuhXfecDP99+ySPA3Vn371ZS5obRKylXXm1lDIoAk=; b=bpJgreU0n9VuWs8x0vhBOGcVn
        tK+z6ZXZPGZH6efn4KPUv+BvZGb2tHwfIZccqv2WLcBjBg99EWWFZTAqTZc1KtRXAwQPOa7cMEWkc
        oz7lsA6HSPZWMwWZEsS2iFJiCDn4G8Iyv2axtnyB3LQaRb7mB3uyQ2KYRR1q4QBe4qXzF8YAxXOY8
        Dy0VeAgg7GWXCYHfQxy+xmpEZSkXYybaN5H1im9YFq7KwFaxSesj7WxsAxaXtV0xH8fOP0x+FS0l5
        ETK6UUE+LBt213OHbLnyHQ819xgGLD0TXPf8IPLEDbrZ6pgZQ43lQTvhPsI7Rj7Vc84G/9XfTJs6P
        dgas1wkTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUcN-00079R-Og; Fri, 18 Oct 2019 15:56:43 +0000
Date:   Fri, 18 Oct 2019 08:56:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 8/8] riscv: for C functions called only from assembly,
 mark with __visible
Message-ID: <20191018155643.GF25386@infradead.org>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
 <20191018080841.26712-9-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018080841.26712-9-paul.walmsley@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:08:41AM -0700, Paul Walmsley wrote:
> Rather than adding prototypes for C functions called only by assembly
> code, mark them as __visible.  This avoids adding prototypes that will
> never be used by the callers.  Resolves the following sparse warnings:
> 
> arch/riscv/kernel/ptrace.c:151:6: warning: symbol 'do_syscall_trace_enter' was not declared. Should it be static?
> arch/riscv/kernel/ptrace.c:175:6: warning: symbol 'do_syscall_trace_exit' was not declared. Should it be static?
> 
> Based on a suggestion from Luc Van Oostenryck.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
