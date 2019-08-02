Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8395DC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7F12171F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z809DAZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfHBSw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:52:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfHBSw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FEoF7HPX5801AkPdWKrTSUM+vgn0HDV36YntU6kvfqs=; b=Z809DAZzn8fVTzHuxwNQ4CqJV
        NgWJPho6Bo3Y+bhD9C3VezkNqwcP90zJYnK5gnCE2f1nO+EW6jZDn0kfTpfwHfGNQrnNms+TEHEjj
        cLzxEYFrwnUFAVfncGH8QjtbjuBn+tg7ADlRx1VkMW78AC1a+f8brKu3xM8aIGUP1h2z63Nq5aSeq
        MxJV/EcblcYqVyEa4DxY1YMVpuygABofo8DcUjwmACYceZv3IkV+nSgY1ajTYKJeqx7iMFg670gdc
        XK831sHH61FB2Ab+bk5gH/PZC3PbHBCh6W37o3DCyu+lpJt9pKi7p8RMhrM/FYWkaq0e99jD1O5jA
        tKvLa19ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htcfA-0004Lg-Av; Fri, 02 Aug 2019 18:52:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6330120293161; Fri,  2 Aug 2019 20:52:22 +0200 (CEST)
Date:   Fri, 2 Aug 2019 20:52:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH 4/6] lib/refcount: Move bulk of REFCOUNT_FULL
 implementation into header
Message-ID: <20190802185222.GD2349@hirez.programming.kicks-ass.net>
References: <20190802101000.12958-1-will@kernel.org>
 <20190802101000.12958-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802101000.12958-5-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:09:58AM +0100, Will Deacon wrote:
> In an effort to improve performance of the REFCOUNT_FULL implementation,
> move the bulk of its functions into linux/refcount.h. This allows them
> to be inlined in the same way as if they had been provided via
> CONFIG_ARCH_HAS_REFCOUNT.

Hehe, they started out this way, then Linus said to stuff them in a C
file :-)
