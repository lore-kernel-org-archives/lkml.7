Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E400C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BA421D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="feMhg1+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLTOHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:07:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfLTOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=srmu36watHtwo/Ix7kyaxDlauHh4Ta8GCTLUGNooItA=; b=feMhg1+KIpswvyXGH+AssiHvr
        TU7whlsxtBck2xgW+ykcgGnsKVSZBc1MP0fIcVlr7g3iv7wsqJ9lVyX8seHxdNAOvW79D9pfGUtY+
        lTH0n2EVymEVir4WhI4wQZbBZW3EXkNeOmUQkkRAkAs2bOVDefmUOmngEKC5SRHf6gLQzCqAVxUaW
        RfoARvSVLDhp9uysm0V5RJ8m5r4YJnQtanGk+psNH1XuZOcI5er6JDZnUfIA892XgP+9jz8OcXIUg
        IY/vK9ILRIvtvxQx/LHa7YPbiSZg3v0N/NW/aUY4o2q/RF1zSN7xqqdO21Ssew1R77G6qLAfUvKAW
        4iqRUQK8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiIvh-00013n-Ll; Fri, 20 Dec 2019 14:06:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31F7130073C;
        Fri, 20 Dec 2019 15:05:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23A21203A8993; Fri, 20 Dec 2019 15:06:55 +0100 (CET)
Date:   Fri, 20 Dec 2019 15:06:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <20191220140655.GN2827@hirez.programming.kicks-ass.net>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:19:27AM +0100, Marc Gonzalez wrote:
> Would anyone else have any suggestions, comments, insights, recommendations,
> improvements, guidance, or wisdom? :-)

Flip devres upside down!

**WARNING, wear protective glasses when reading the below**


struct devres {
	struct devres_node	node;
	void			*data;
};

/*
 * We place struct devres at the tail of the memory allocation
 * such that data retains the ARCH_KMALLOC_MINALIGN alignment.
 * struct devres itself is just 4 pointers and should therefore
 * only require trivial alignment.
 */
static inline struct devres *data2devres(void *data)
{
	return (struct devres *)(data + ksize(data) - sizeof(struct devres));
}

void *alloc_dr(...)
{
	struct devres *dr;
	void *data;

	data = kmalloc(size + sizeof(struct devres), GFP_KERNEL);
	dr = data2devres(data);
	WARN_ON((unsigned long)dr & __alignof(*dr)-1);
	INIT_LIST_HEAD(&dr->node.entry);
	dr->node.release = release;
	dr->data = data;

	return dr;
}

void devres_free(void *data)
{
	if (data) {
		struct devres *dr = data2devres(data);
		BUG_ON(!list_empty(dr->node.entry));
		kfree(data);
	}
}

static int release_nodes(...)
{
	...
	list_for_each_entry_safe_reverse(dr, ...) {
		...
		kfree(dr->data);
	}
}

