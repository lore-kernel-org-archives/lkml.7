Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28256C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EC12070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cdJmMbKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfK0JnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:43:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK0JnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V23rkTkin1c7zTfEuGjtB9skoVvrhOmzur8foUlLMFA=; b=cdJmMbKMq+6OdoqhmMoN9Vvcq
        kQ9AMkd7iYn8pFO2djNXBBs6E6PiLzipr69oVywUwjc8eHxIMDnkJBCTdTrzxS3WiTg/IeLWwCdhL
        2iA32ZYWu5f20LwrTjl7BXUr5We6FkMLc3XnnlY8muMK1pj0E6GHbRcUmDdmHSLZJhhg8NQOUOkPx
        zx3bQXfYiFB3cAsgxF0EIb6em3vVzUgo9IJUnx9wOnpMjE7BqAJMn8v4g0/vp9iOg+rau62A/5If1
        e4mD88IU2d/RVD4IMHIeOuw14j9yFc3W2xSB5TqtyuQPCCCtnz3MF0f0C7828fH14uvJXcs9Egsff
        s0t0YXSRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZtqr-0005QK-S8; Wed, 27 Nov 2019 09:43:13 +0000
Date:   Wed, 27 Nov 2019 01:43:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, mark.rutland@arm.com,
        huawei.libin@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wcohen@redhat.com, linux-kernel@vger.kernel.org,
        mtk.manpages@gmail.com, wezhang@redhat.com
Subject: Re: [PATCH] sys_personality: Streamline code in sys_personality()
Message-ID: <20191127094313.GA11668@infradead.org>
References: <20191126094045.134654-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126094045.134654-1-bobo.shaobowang@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 05:40:45PM +0800, Wang ShaoBo wrote:
> SYSCALL_DEFINE1 in kernel/exec_domain.c looks like verbose,
> ksys_personality() can make it more concise.

What do you try to say with this sentence?  I can't really parse it.

> --- a/kernel/exec_domain.c
> +++ b/kernel/exec_domain.c
> @@ -37,10 +37,5 @@ module_init(proc_execdomains_init);
>  
>  SYSCALL_DEFINE1(personality, unsigned int, personality)
>  {
> -	unsigned int old = current->personality;
> -
> -	if (personality != 0xffffffff)
> -		set_personality(personality);
> -
> -	return old;
> +	return ksys_personality(personality);

This looks ok, but I'd much rather just kill ksys_personality and add
an optional arch hook to reject personality settings for the arm64
special case.
